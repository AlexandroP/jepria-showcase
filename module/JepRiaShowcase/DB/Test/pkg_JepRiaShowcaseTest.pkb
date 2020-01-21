create or replace package body itm.pkg_JepRiaShowcaseTest is
/* package body: pkg_JepRiaShowcaseTest::body */



/* group: ���������� */

/* ivar: logger
  ����� ������.
*/
logger lg_logger_t := lg_logger_t.getLogger(
  moduleName    => pkg_JepRiaShowcase.Module_Name
  , objectName  => 'pkg_JepRiaShowcaseTest'
);



/* group: ������� */

/* iproc: checkFeatureStatusCode
  ��������� ������ ��������� ������� �� ����������.

  ���������:
  featureId                   - id ������� �� ����������
  expectedStatusCode          - ��������� ��� �������
  operatorId                  - id ��������� ��� �������
*/
procedure checkFeatureStatusCode(
  featureId            integer
  , expectedStatusCode varchar2
  , operatorId         integer
)
is
  rc sys_refcursor;
-- getFeatureStatusCode
begin
  rc := pkg_JepRiaShowcase.findFeatureProcess(
    featureId           => featureId
    , featureStatusCode => expectedStatusCode
    , operatorId        => operatorId
  );
  pkg_TestUtility.compareRowCount(
    rc
  , expectedRowCount    => 1
  , failMessageText     => '�������� ������'
  );
exception when others then
  raise_application_error(
    pkg_Error.ErrorStackInfo
    , logger.errorStack(
        '������ ��������� ������� ��������� ������� �� ����������'
      )
    , true
  );
end checkFeatureStatusCode;

/* proc: endTestException
  ��������� ���� � ��������� ����������.

  ���������:
  expectedException           - ��������� ����� ����������
  inExceptionFlag             - ��������� �� ����� � ����� ���������
                                ����������
  exceptionText               - ����� ���������� ( ���������� �� ������ ���
                                ����������� �����)

  ���������:
  - � ������ ���������� ������������� ����������� ����������� �������� �
    TestUtility;
*/
procedure endTestException(
  expectedException             varchar2
  , inExceptionFlag             integer
  , exceptionText               varchar2 := null
)
is
-- checkException
begin
  if expectedException is not null then
    if inExceptionFlag = 1 then
      if expectedException is not null
        and exceptionText not like '%' || expectedException || '%'
      then
        pkg_TestUtility.failTest(
          '��������� ����� ���������� ( '
          || '"' || expectedException || '") �� ���������� � ������ ���������� ���������� ( '
          || '"' || exceptionText || '")'
        );
      end if;
    elsif
      inExceptionFlag = 0
      and expectedException is not null
    then
      pkg_TestUtility.failTest(
        '�������� ����������: '
        || '"' || expectedException || '"'
      );
    end if;
  elsif inExceptionFlag = 1 then
    pkg_TestUtility.failTest(
      '�������� ����������� ���������� ( "' || exceptionText || '")'
    );
  end if;
  pkg_TestUtility.endTest();
end endTestException;

/* proc: testEditFeatureAccess
  �������� ������������� ���� ������� �� �������������� � �������� ������� ��
  ����������.
*/
procedure testEditFeatureAccess
is

  -- ����������� �� ������������ ���������� ��� ��������� ����������
  -- � ������������ ���� � �������� �����

  -- ����������� ������������
  operatorId_A integer;
  operatorId_B integer;
  operatorId_V integer;

  -- ����������� �������
  feature_1    integer;
  feature_2    integer;

  /*
    ���������� ���������: ��������� ������������ � ����� JrsEditFeature:
    ������������� ��, ������������� ��. ��������� ������������ � �����
    JrsEditAllFeature: ������������� ». ������������� �� ������� ������� ��
    ����� ���������� ������� 1� � ������� 2�.
  */
  procedure initTest
  is
  begin
    operatorId_A := pkg_AccessOperatorTest.getTestOperatorId(
      baseName        => 'operator_A'
      , roleSNameList => cmn_string_table_t(
          pkg_JepRiaShowcase.EditFeature_RoleSName
        )
    );
    operatorId_B := pkg_AccessOperatorTest.getTestOperatorId(
      baseName        => 'operator_B'
      , roleSNameList => cmn_string_table_t(
          pkg_JepRiaShowcase.EditFeature_RoleSName
        )
    );
    operatorId_V := pkg_AccessOperatorTest.getTestOperatorId(
      baseName        => 'operator_C'
      , roleSNameList => cmn_string_table_t(
          pkg_JepRiaShowcase.EditAllFeature_RoleSName
        )
    );
    feature_1 := pkg_JepRiaShowcase.createFeature(
      featureName       => '������ 1'
      , featureNameEn   => 'Feature 1'
      , operatorId      => operatorId_A
    );
    feature_2 := pkg_JepRiaShowcase.createFeature(
      featureName       => '������ 2'
      , featureNameEn   => 'Feature 2'
      , operatorId      => operatorId_A
    );
  exception when others then
    raise_application_error(
      pkg_Error.ErrorStackInfo
      , logger.errorStack(
          '������ ���������� ���������'
        )
      , true
    );
  end initTest;

  /*
    ������������ �������������� ������� �����������.

    ���������:
    operatorId                - ��������, �������������/��������� ������
    featureId                 - id �������
    expectedException         - ��������� ����� ����������
    deleteFlag                - ���� ��������
  */
  procedure testFeatureEdit(
    operatorId               integer
    , featureId              integer
    , expectedException      varchar2 := null
    , deleteFlag             integer := null
  )
  is
    rc sys_refcursor;
  begin
    if deleteFlag = 1 then
      delete from
        jrs_feature_process
      where
        feature_id = featureId;
      pkg_JepRiaShowcase.deleteFeature(
        featureId         => featureId
        , operatorId      => operatorId
      );
    else
      pkg_JepRiaShowcase.updateFeature(
        featureId         => featureId
        , featureName     => '����������'
        , featureNameEn   => 'update'
        , operatorId      => operatorId
      );
    end if;
    rc := pkg_JepRiaShowcase.findFeature(
      featureId           => featureId
      , operatorId        => operatorId
    );
    pkg_TestUtility.compareRowCount(
      rc
    , expectedRowCount    =>
        case when
          deleteFlag = 1
        then
          0
        else
          1
        end
    , failMessageText     => '������������ ����� ������� � �������'
    );
    endTestException(
      expectedException   => expectedException
      , inExceptionFlag   => 0
    );
  exception when others then
    endTestException(
      exceptionText       => logger.getErrorStack()
      , expectedException => expectedException
      , inExceptionFlag   => 1
    );
  end testFeatureEdit;

-- testEditFeatureAccess
begin
  initTest();
  pkg_TestUtility.beginTest( '�������� 1: ������� ��������� �� ������ �������');
  testFeatureEdit(
    operatorId          => operatorId_B
    , featureId         => feature_1
    , expectedException => '� ��� ��� ���� �� ��������� ������� �� ����������!'
  );
  pkg_TestUtility.beginTest( '�������� 2: ������� �������� �� ������ �������');
  testFeatureEdit(
    operatorId          => operatorId_B
    , featureId         => feature_1
    , expectedException => '� ��� ��� ���� �� ��������� ������� �� ����������!'
    , deleteFlag        => 1
  );
  pkg_TestUtility.beginTest(
    '�������� 3: ��������� ������� ������������� � ������� ��������������'
    || ' ���� ��������'
  );
  testFeatureEdit(
    operatorId          => operatorId_V
    , featureId         => feature_1
  );
  pkg_TestUtility.beginTest(
    '�������� 4: �������� ������� ������������� � ������� �������������� ����'
    || ' ��������'
  );
  testFeatureEdit(
    operatorId          => operatorId_V
    , featureId         => feature_1
    , deleteFlag        => 1
  );
  pkg_TestUtility.beginTest( '�������� 5: ��������� ������ �������');
  testFeatureEdit(
    operatorId          => operatorId_A
    , featureId         => feature_2
  );
  pkg_TestUtility.beginTest( '�������� 6: �������� ������ �������');
  testFeatureEdit(
    operatorId          => operatorId_A
    , featureId         => feature_2
    , deleteFlag        => 1
  );
exception when others then
  raise_application_error(
    pkg_Error.ErrorStackInfo
    , logger.errorStack(
        '������ �������� ������������� ���� ������� �� �������������� �'
        || ' �������� ������� �����������'
      )
    , true
  );
end testEditFeatureAccess;

/* proc: testFeatureStatus
  �������� ��������� ������� ������� �� ����� ����������.
*/
procedure testFeatureStatus
is

  -- ����������� ������������
  operatorId_A integer;
  operatorId_B integer;
  operatorId_V integer;

  -- ����������� �������
  feature_1    integer;
  feature_2    integer;

  -- Id ������� ��������� ��������
  featureProcessIdInProgress integer;
  featureProcessIdRemarks    integer;

  /*
    �������� ������������� ������.
  */
  procedure checkFeatureProcess(
    featureProcessId   integer
    , expectedRowCount integer
    , operatorId       integer
  )
  is
    rc sys_refcursor;
  begin
    rc := pkg_JepRiaShowcase.findFeatureProcess(
      featureProcessId    => featureProcessId
      , operatorId        => operatorId
    );
    pkg_TestUtility.compareRowCount(
      rc
    , expectedRowCount    => expectedRowCount
    , failMessageText     => '������������ ����� ������� � �������'
    );
  end checkFeatureProcess;

  /*
    ���������� ���������: ��������� ������������ � ����� JrsEditFeature:
    ������������� ��, ������������� ��.  ��������� ������������ � ������
    JrsAssignResponsibleFeature, JrsEditAllFeature: ������������� ».
    ������������� �� ������� ������� 1�.  ������������� » � ��������
    �������������� �� ������� 1� ��������� ������������� ��.
  */
  procedure initTest
  is
  begin
    operatorId_A := pkg_AccessOperatorTest.getTestOperatorId(
      baseName        => 'Operator_A'
      , roleSNameList => cmn_string_table_t(
          pkg_JepRiaShowcase.EditFeature_RoleSName
        )
    );
    operatorId_B := pkg_AccessOperatorTest.getTestOperatorId(
      baseName        => 'Operator_B'
      , roleSNameList => cmn_string_table_t(
          pkg_JepRiaShowcase.EditFeature_RoleSName
        )
    );
    operatorId_V := pkg_AccessOperatorTest.getTestOperatorId(
      baseName        => 'Operator_C'
      , roleSNameList => cmn_string_table_t(
          pkg_JepRiaShowcase.EditAllFeature_RoleSName
          , pkg_JepRiaShowcase.AssignResponsibleFea_RoleSName
        )
    );
    feature_1 := pkg_JepRiaShowcase.createFeature(
      featureName       => '������ 1'
      , featureNameEn   => 'Feature 1'
      , operatorId      => operatorId_A
    );
    feature_2 := pkg_JepRiaShowcase.createFeature(
      featureName       => '������ 2'
      , featureNameEn   => 'Feature 2'
      , operatorId      => operatorId_A
    );
    pkg_JepRiaShowcase.setFeatureResponsible(
      featureId         => feature_1
      , responsibleId   => operatorId_B
      , operatorId      => operatorId_V
    );
  end initTest;

  /*
    ��������� ������� ������� �� ����������.

    ���������:
    operatorId                - ��������, ��������������� ������
    featureId                 - id ������� �� ����������
    featureStatusCode         - ��� ������� �������
    expectedException         - ��������� ����� ����������
    expectedLastStatusCode    - ��������� ������ ��������� ���������

    �������:
    - id ������ ��������� �����������;
  */
  function setFeatureStatus(
    operatorId                integer
    , featureId               integer
    , featureStatusCode       varchar2
    , expectedException       varchar2 := null
    , expectedLastStatusCode  varchar2 := null
  )
  return integer
  is
    featureProcessId integer;
  begin
    featureProcessId := pkg_JepRiaShowcase.createFeatureProcess(
      featureId           => featureId
      , featureStatusCode => featureStatusCode
      , operatorId        => operatorId
    );
    if expectedLastStatusCode is not null then
      checkFeatureStatusCode(
        operatorId           => operatorId
        , featureId          => featureId
        , expectedStatusCode => expectedLastStatusCode
      );
    end if;
    checkFeatureProcess(
      featureProcessId => featureProcessId
    , expectedRowCount => 1
    , operatorId       => operatorId
    );
    endTestException(
      expectedException   => expectedException
      , inExceptionFlag   => 0
    );
    return featureProcessId;
  exception when others then
    endTestException(
      exceptionText       => logger.getErrorStack()
      , expectedException => expectedException
      , inExceptionFlag   => 1
    );
    return null;
  end setFeatureStatus;

  /*
    ��������� ������� ������� �� ����������.

    ���������:
    operatorId                - ��������, ��������������� ������
    featureId                 - id ������� �� ����������
    featureStatusCode         - ��� ������� �������
    expectedException         - ��������� ����� ����������
    expectedLastStatusCode    - ��������� ������ ��������� ���������
  */
  procedure setFeatureStatus(
    operatorId                integer
    , featureId               integer
    , featureStatusCode       varchar2
    , expectedException       varchar2 := null
    , expectedLastStatusCode  varchar2 := null
  )
  is
    featureProcessId integer;
  begin
    featureProcessId := setFeatureStatus(
      operatorId                => operatorId
      , featureId               => featureId
      , featureStatusCode       => featureStatusCode
      , expectedException       => expectedException
      , expectedLastStatusCode  => expectedLastStatusCode
    );
  end setFeatureStatus;

  /*
    �������� ������ ��������� �������.

    ���������:
    featureProcessId          - id ������ ��������� �������
    operatorId                - id ������������ ��� ��������
    expectedException         - ��������� ����� ����������
  */
  procedure deleteFeatureStatus(
    featureProcessId     integer
    , operatorId         integer
    , expectedException varchar2 := null
  )
  is
  -- deleteFeatureStatus
  begin
    pkg_JepRiaShowcase.deleteFeatureProcess(
      featureProcessId    => featureProcessId
      , operatorId        => operatorId
    );
    checkFeatureProcess(
      featureProcessId => featureProcessId
    , expectedRowCount => 0
    , operatorId       => operatorId
    );
    endTestException(
      expectedException   => expectedException
      , inExceptionFlag   => 0
    );
  exception when others then
    endTestException(
      exceptionText       => logger.getErrorStack()
      , expectedException => expectedException
      , inExceptionFlag   => 1
    );
  end deleteFeatureStatus;

-- testFeatureStatus
begin
  initTest();
  pkg_TestUtility.beginTest(
    '�������� 11: ��������� ������� ������������� ��'
    || ' ������ �������������'
  );
  -- ������������ � ��� ������� 1� ��������� ������ �� ������
  featureProcessIdInProgress := setFeatureStatus(
    operatorId                => operatorId_B
    , featureId               => feature_1
    , featureStatusCode       => pkg_JepRiaShowcase.InProgress_FeatureStatusCode
  );
  pkg_TestUtility.beginTest(
    '�������� 12: ��������� ������� ������� ������������� � �������'
    || ' �������������� ���� ��������'
  );
  -- ������������� » ��� ������� 1� ��������� ������ ������� ��� ���������
  featureProcessIdRemarks := setFeatureStatus(
    operatorId                => operatorId_V
    , featureId               => feature_1
    , featureStatusCode       => pkg_JepRiaShowcase.Remarks_FeatureStatusCode
    , expectedLastStatusCode  => pkg_JepRiaShowcase.Remarks_FeatureStatusCode
  );
  pkg_TestUtility.beginTest(
    '�������� 13: ������� ��������� ������� ���������� �������'
  );
  -- ������������� �� ��� ������� 1� ��������� ������ ���������
  setFeatureStatus(
    operatorId                => operatorId_A
    , featureId               => feature_1
    , featureStatusCode       => pkg_JepRiaShowcase.Cancelled_FeatureStatusCode
    , expectedException       =>
    '� ��� ��� ���� �� ��������� ������� ������� �� ����������!'
  );
  pkg_TestUtility.beginTest(
    '�������� 14: ������� �������� ������������ ������� �������'
  );
  -- ������������� » � ������� 1� ������� ����������� ������ (������ ��
  -- ������).
  deleteFeatureStatus(
    operatorId                => operatorId_V
    , featureProcessId        => featureProcessIdInProgress
    , expectedException       =>
    '������� ����� ������ ������ �� ��������� ���������!'
  );
  pkg_TestUtility.beginTest(
    '�������� 15: �������� ���������� ������� �������'
  );
  -- ������������� » � ������� 1� ������� ��������� ������ (������ �������
  -- ��� ���������)
  deleteFeatureStatus(
    operatorId                => operatorId_V
    , featureProcessId        => featureProcessIdRemarks
  );
exception when others then
  raise_application_error(
    pkg_Error.ErrorStackInfo
    , logger.errorStack(
        '������ �������� ��������� ������� ������� �� ����� ����������'
      )
    , true
  );
end testFeatureStatus;

/* proc: testUserApi
  ������������ API ��� ����������������� ����������.
*/
procedure testUserApi
is

  -- ��������� ���������� �������
  rc sys_refcursor;

  -- �������� ��� ������ API-�������
  operatorId integer := pkg_Operator.getCurrentUserId();

  -- �������� ������
  supplierId integer;
  supplierId2 integer;

  goodsId integer;
  goodsId2 integer;

  requestId integer;



  /*
    ��������� ����� ������� � �������.
  */
  procedure checkCursor(
    functionName varchar2
    , expectedRowCount integer := null
  )
  is
  begin
    pkg_TestUtility.compareRowCount(
      rc
      , expectedRowCount => coalesce( expectedRowCount, 0)
      , failMessageText  =>
          functionName || ': ������������ ����� ������� � �������'
    );
  end checkCursor;



  /*
    ��������� ����� ������� � ������� �� ����� ������� � �������.
  */
  procedure checkCursor(
    functionName varchar2
    , tableName varchar2
    , whereSql varchar2 := null
    , filterCondition varchar2 := null
  )
  is

    expectedRowCount integer;

  begin
    execute immediate
'select
  count(*)
from
  ' || tableName || ' t'
|| case when whereSql is not null then
'
where
  ' || whereSql
end
    into
      expectedRowCount
    ;
    pkg_TestUtility.compareRowCount(
      rc
      , expectedRowCount => expectedRowCount
      , filterCondition  => filterCondition
      , failMessageText  =>
          functionName || ': ������������ ����� ������� � �������'
    );
  exception when others then
    raise_application_error(
      pkg_Error.ErrorStackInfo
      , logger.errorStack(
          '������ ��� ��������� ����� ������� � ������� � ������� ('
          || ' tableName="' || tableName || '"'
          || ', whereSql="' || whereSql || '"'
          || ').'
        )
      , true
    );
  end checkCursor;



  /*
    ���� ������� %Supplier.
  */
  procedure testSupplierApi
  is
  begin
    supplierId := pkg_JepRiaShowcase.createSupplier(
      supplierName            => '$TEST-Supplier 1'
      , contractFinishDate    => DATE '4099-05-14'
      , exclusiveSupplierFlag => 1
      , privilegeSupplierFlag => 1
      , phoneNumber           => '98-01-01'
      , faxNumber             => '98-02-01'
      , bankBic               => '044585187'
      , recipientName         => 'Test recipient 1'
      , settlementAccount     => '000001'
      , operatorId            => operatorId
    );
    pkg_TestUtility.compareRowCount(
      tableName           => 'jrs_supplier'
      , filterCondition   => '
supplier_id = ''' || supplierId || '''
and supplier_name = ''$TEST-Supplier 1''
and contract_finish_date = DATE ''4099-05-14''
and exclusive_supplier_flag = 1
and privilege_supplier_flag = 1
and phone_number = ''98-01-01''
and fax_number = ''98-02-01''
and bank_bic = ''044585187''
and recipient_name = ''Test recipient 1''
and settlement_account = ''000001''
'
      , expectedRowCount  => 1
      , failMessageText   =>
          'createSupplier: ������ �� ������� ��� �����������'
    );

    pkg_JepRiaShowcase.updateSupplier(
      supplierId              => supplierId
      , supplierName          => '$TEST-Supplier 2'
      , contractFinishDate    => DATE '4099-05-15'
      , exclusiveSupplierFlag => 0
      , privilegeSupplierFlag => 0
      , phoneNumber           => '98-01-02'
      , faxNumber             => '98-02-02'
      , bankBic               => '044525448'
      , recipientName         => 'Test recipient 2'
      , settlementAccount     => '000002'
      , operatorId            => operatorId
    );
    pkg_TestUtility.compareRowCount(
      tableName           => 'jrs_supplier'
      , filterCondition   => '
supplier_id = ''' || supplierId || '''
and supplier_name = ''$TEST-Supplier 2''
and contract_finish_date = DATE ''4099-05-15''
and exclusive_supplier_flag = 0
and privilege_supplier_flag = 0
and phone_number = ''98-01-02''
and fax_number = ''98-02-02''
and bank_bic = ''044525448''
and recipient_name = ''Test recipient 2''
and settlement_account = ''000002''
'
      , expectedRowCount  => 1
      , failMessageText   =>
          'updateSupplier: ������ �� �������� ��� �����������'
    );

    rc := pkg_JepRiaShowcase.findSupplier(
      supplierName            => '$TEST-Supplier 1'
      , maxRowCount           => 5
      , operatorId            => operatorId
    );
    checkCursor( 'findSupplier: absent name', 0);

    rc := pkg_JepRiaShowcase.findSupplier(
      supplierId              => supplierId
      , operatorId            => operatorId
    );
    checkCursor( 'findSupplier: id', 1);

    rc := pkg_JepRiaShowcase.findSupplier(
      supplierId              => supplierId
      , supplierName          => '$test-SUPP%2'
      , contractFinishDateFrom  => DATE '4099-05-01'
      , contractFinishDateTo    => DATE '4099-05-28'
      , exclusiveSupplierFlag => 0
      , privilegeSupplierFlag => 0
      , maxRowCount           => 5
      , operatorId            => operatorId
    );
    checkCursor( 'findSupplier: all args', 1);

    rc := pkg_JepRiaShowcase.findSupplier(
      supplierName            => '$TEST-SUPP%'
      , contractFinishDateTo  => DATE '4099-05-15'
      , maxRowCount           => 5
      , operatorId            => operatorId
    );
    checkCursor( 'findSupplier: name/dateTo', 1);

    rc := pkg_JepRiaShowcase.findSupplier(
      contractFinishDateFrom  => DATE '4099-05-14'
      , exclusiveSupplierFlag => 0
      , privilegeSupplierFlag => 0
      , operatorId            => operatorId
    );
    checkCursor( 'findSupplier: dateFrom/exlFlag', 1);

    pkg_JepRiaShowcase.deleteSupplier(
      supplierId              => supplierId
      , operatorId            => operatorId
    );
    pkg_TestUtility.compareRowCount(
      tableName           => 'jrs_supplier'
      , filterCondition   => '
supplier_id = ''' || supplierId || '''
'
      , expectedRowCount  => 0
      , failMessageText   =>
          'deleteSupplier: ������ �� ���� �������'
    );

    -- ������� ������ ��� ����������� ������
    supplierId := pkg_JepRiaShowcase.createSupplier(
      supplierName            => '$TEST-Supplier 1'
      , contractFinishDate    => DATE '4099-05-14'
      , exclusiveSupplierFlag => 1
      , privilegeSupplierFlag => 1
      , operatorId            => operatorId
    );
    pkg_TestUtility.compareRowCount(
      tableName           => 'jrs_supplier'
      , filterCondition   => 'supplier_id = ''' || supplierId || ''''
      , expectedRowCount  => 1
      , failMessageText   =>
          'createSupplier: T1: ������ �� �������'
    );
    supplierId2 := pkg_JepRiaShowcase.createSupplier(
      supplierName            => '$TEST-Supplier 2'
      , contractFinishDate    => DATE '4099-05-01'
      , exclusiveSupplierFlag => 1
      , privilegeSupplierFlag => 1
      , operatorId            => operatorId
    );
    pkg_TestUtility.compareRowCount(
      tableName           => 'jrs_supplier'
      , filterCondition   => 'supplier_id = ''' || supplierId2 || ''''
      , expectedRowCount  => 1
      , failMessageText   =>
          'createSupplier: T2: ������ �� �������'
    );
  exception when others then
    raise_application_error(
      pkg_Error.ErrorStackInfo
      , logger.errorStack(
          '������ ��� ������������ ������� %Supplier.'
        )
      , true
    );
  end testSupplierApi;



  /*
    ���� ������� %Goods.
  */
  procedure testGoodsApi
  is

    parentGoodsCatalogId integer;
    goodsCatalogId integer;
    maxGoodsCatalogId integer;
    otherGoodsCatalogId integer;

  begin
    goodsId := pkg_JepRiaShowcase.createGoods(
      supplierId                => supplierId2
      , goodsName               => '$TEST-������, 1 �.'
      , goodsTypeCode           => 'FOOD'
      , unitCode                => 'L'
      , purchasingPrice         => 20.75
      , motivationTypeCode      => 'MONTH'
      , goodsPhotoMimeType      => 'jpeg'
      , goodsPhotoExtension     => 'jpg'
      , goodsPortfolioMimeType  => 'text-rtf'
      , goodsPortfolioExtension => 'rtf'
      , operatorId              => operatorId
    );
    pkg_TestUtility.compareRowCount(
      tableName           => 'jrs_goods'
      , filterCondition   => '
goods_id = ''' || goodsId || '''
and goods_name = ''$TEST-������, 1 �.''
and goods_type_code = ''FOOD''
and unit_code = ''L''
and purchasing_price = 20.75
and motivation_type_code = ''MONTH''
and goods_photo_mime_type = ''jpeg''
and goods_photo_extension = ''jpg''
and goods_portfolio_mime_type = ''text-rtf''
and goods_portfolio_extension = ''rtf''
'
      , expectedRowCount  => 1
      , failMessageText   =>
          'createGoods: all args: ������ �� ������� ��� �����������'
    );

    pkg_JepRiaShowcase.updateGoods(
      goodsId                   => goodsId
      , supplierId              => supplierId
      , goodsName               => '$TEST-���� �������'
      , goodsTypeCode           => 'INDUSTRIAL'
      , unitCode                => 'ITEM'
      , purchasingPrice         => 18.00
      , motivationTypeCode      => 'QUARTER'
      , goodsPhotoMimeType      => 'image-png'
      , goodsPhotoExtension     => 'png'
      , goodsPortfolioMimeType  => 'text-plain'
      , goodsPortfolioExtension => 'txt'
      , operatorId              => operatorId
    );
    pkg_TestUtility.compareRowCount(
      tableName           => 'jrs_goods'
      , filterCondition   => '
goods_id = ''' || goodsId || '''
and goods_name = ''$TEST-���� �������''
and goods_type_code = ''INDUSTRIAL''
and unit_code = ''ITEM''
and purchasing_price = 18.00
and motivation_type_code = ''QUARTER''
and goods_photo_mime_type = ''image-png''
and goods_photo_extension = ''png''
and goods_portfolio_mime_type = ''text-plain''
and goods_portfolio_extension = ''txt''
'
      , expectedRowCount  => 1
      , failMessageText   =>
          'updateGoods: ������ �� �������� ��� �����������'
    );

    -- %GoodsSegmentLink
    pkg_JepRiaShowcase.createGoodsSegmentLink(
      goodsId                 => goodsId
      , goodsSegmentCode      => 'EVERYDAY'
      , operatorId            => operatorId
    );
    pkg_JepRiaShowcase.createGoodsSegmentLink(
      goodsId                 => goodsId
      , goodsSegmentCode      => 'HOME'
      , operatorId            => operatorId
    );
    pkg_JepRiaShowcase.createGoodsSegmentLink(
      goodsId                 => goodsId
      , goodsSegmentCode      => 'TOY'
      , operatorId            => operatorId
    );
    pkg_TestUtility.compareRowCount(
      tableName           => 'jrs_goods_segment_link'
      , filterCondition   => '
goods_id = ''' || goodsId || '''
and goods_segment_code in ( ''EVERYDAY'', ''HOME'',  ''TOY'')
'
      , expectedRowCount  => 3
      , failMessageText   =>
          'createGoodsSegmentLink: ������ �� ��������� ��� �����������'
    );
    pkg_JepRiaShowcase.deleteGoodsSegmentLink(
      goodsId                 => goodsId
      , goodsSegmentCode      => 'TOY'
      , operatorId            => operatorId
    );
    pkg_TestUtility.compareRowCount(
      tableName           => 'jrs_goods_segment_link'
      , filterCondition   => '
goods_id = ''' || goodsId || '''
and goods_segment_code in ( ''EVERYDAY'', ''HOME'',  ''TOY'')
'
      , expectedRowCount  => 2
      , failMessageText   =>
          'deleteGoodsSegmentLink: ������ �� �������'
    );
    rc := pkg_JepRiaShowcase.getGoodsSegmentLink(
      goodsId                 => goodsId
      , operatorId            => operatorId
    );
    checkCursor( 'getGoodsSegmentLink', 2);

    -- %GoodsCatalogLink
    select
      min( gc.parent_goods_catalog_id)
        keep( dense_rank first order by gc.goods_catalog_id)
      , min( gc.goods_catalog_id)
        keep( dense_rank first order by gc.goods_catalog_id)
      , max( gc.goods_catalog_id)
    into parentGoodsCatalogId, goodsCatalogId, maxGoodsCatalogId
    from
      jrs_goods_catalog gc
    where
      gc.parent_goods_catalog_id is not null
    ;
    select
      min( gc.goods_catalog_id)
    into otherGoodsCatalogId
    from
      jrs_goods_catalog gc
    where
      gc.goods_catalog_id not in (
        parentGoodsCatalogId
        , goodsCatalogId
        , maxGoodsCatalogId
      )
    ;
    pkg_JepRiaShowcase.setGoodsCatalogLink(
      goodsId                 => goodsId
      , goodsCatalogIdList    =>
          parentGoodsCatalogId
          || ',' || otherGoodsCatalogId
          || ', ,, '
      , operatorId            => operatorId
    );
    pkg_TestUtility.compareRowCount(
      tableName           => 'jrs_goods_catalog_link'
      , filterCondition   => 'goods_id = ''' || goodsId || ''''
      , expectedRowCount  => 2
      , failMessageText   =>
          'setGoodsCatalogLink: ������������ ����� �������'
    );
    pkg_TestUtility.compareRowCount(
      tableName           => 'jrs_goods_catalog_link'
      , filterCondition   => '
goods_id = ''' || goodsId || '''
and goods_catalog_id in (
  ''' || parentGoodsCatalogId || '''
  , ''' || otherGoodsCatalogId || '''
)
'
      , expectedRowCount  => 2
      , failMessageText   =>
          'setGoodsCatalogLink: ������ �����������'
    );

    pkg_JepRiaShowcase.setGoodsCatalogLink(
      goodsId                 => goodsId
      , goodsCatalogIdList    =>
          parentGoodsCatalogId
          || ',' || goodsCatalogId
          || ',' || maxGoodsCatalogId
          || ', ,, '
      , operatorId            => operatorId
    );
    pkg_TestUtility.compareRowCount(
      tableName           => 'jrs_goods_catalog_link'
      , filterCondition   => 'goods_id = ''' || goodsId || ''''
      , expectedRowCount  => 3
      , failMessageText   =>
          'setGoodsCatalogLink(2): ������������ ����� �������'
    );
    pkg_TestUtility.compareRowCount(
      tableName           => 'jrs_goods_catalog_link'
      , filterCondition   => '
goods_id = ''' || goodsId || '''
and goods_catalog_id in (
  ''' || parentGoodsCatalogId || '''
  , ''' || goodsCatalogId || '''
  , ''' || maxGoodsCatalogId || '''
)
'
      , expectedRowCount  => 3
      , failMessageText   =>
          'setGoodsCatalogLink(2): ������ �����������'
    );

    -- getGoodsCatalog
    rc := pkg_JepRiaShowcase.getGoodsCatalog();
    checkCursor(
      'getGoodsCatalog( no args)'
      , 'jrs_goods_catalog'
      , 'parent_goods_catalog_id is null'
      ,
-- ����� � ���� �� ��������� ������� �� descendant_goods_link_flag ��-��
-- ������ � pkg_TestUtility
'has_child_flag = 1
and goods_link_flag is null
--and descendant_goods_link_flag is null
'
    );

    rc := pkg_JepRiaShowcase.getGoodsCatalog(
      parentGoodsCatalogId  => null
      , goodsId             => goodsId
    );
    checkCursor(
      'getGoodsCatalog( goodsId)'
      , 'jrs_goods_catalog'
      , 'parent_goods_catalog_id is null'
      ,
'has_child_flag = 1
and goods_link_flag in ( 0, 1)
--and descendant_goods_link_flag in ( 0, 1)
'
    );

    select
      gc.parent_goods_catalog_id
    into otherGoodsCatalogId
    from
      jrs_goods_catalog gc
    where
      gc.goods_catalog_id = parentGoodsCatalogId
    ;
    rc := pkg_JepRiaShowcase.getGoodsCatalog(
      parentGoodsCatalogId  => otherGoodsCatalogId
      , goodsId             => goodsId
    );
    pkg_TestUtility.compareRowCount(
      rc
      , expectedRowCount  => 1
      , filterCondition   =>
'goods_catalog_id = ' || parentGoodsCatalogId || '
and has_child_flag = 1
and goods_link_flag = 1
--and descendant_goods_link_flag = 1
'
      , failMessageText   =>
          'getGoodsCatalog( parent): ������������ ������ ������'
    );


    -- findGoods
    rc := pkg_JepRiaShowcase.findGoods(
      maxRowCount             => 1
      , operatorId            => operatorId
    );
    checkCursor( 'findGoods: maxRowCount', 1);

    rc := pkg_JepRiaShowcase.findGoods(
      goodsName               => '$TEST-???'
      , operatorId            => operatorId
    );
    checkCursor( 'findGoods: absent name', 0);

    rc := pkg_JepRiaShowcase.findGoods(
      goodsIdList             => to_char( goodsId)
      , operatorId            => operatorId
    );
    checkCursor( 'findGoods: id', 1);

    rc := pkg_JepRiaShowcase.findGoods(
      goodsIdList               => ',' || to_char( goodsId) || ',,,'
      , supplierId              => supplierId
      , goodsName               => '$test-%����%'
      , goodsTypeCode           => 'INDUSTRIAL'
      , goodsSegmentCodeList    => 'TOY,HOME'
      , goodsCatalogIdList      => to_char( parentGoodsCatalogId) || ',-1'
      , maxRowCount             => 5
      , operatorId              => operatorId
    );
    checkCursor( 'findGoods: all args', 1);

    rc := pkg_JepRiaShowcase.findGoods(
      supplierId              => supplierId
      , goodsName             => '$test-%'
      , maxRowCount           => 5
      , operatorId            => operatorId
    );
    checkCursor( 'findGoods: supplier/name', 1);

    rc := pkg_JepRiaShowcase.findGoods(
      goodsName               => '$test-%'
      , goodsCatalogIdList    => '-5,' || to_char( maxGoodsCatalogId)
      , operatorId            => operatorId
    );
    checkCursor( 'findGoods: name/catalog', 1);

    rc := pkg_JepRiaShowcase.getGoods(
      goodsName               => '$test-%'
    );
    checkCursor( 'getGoods: name', 1);

    rc := pkg_JepRiaShowcase.getGoods(
      maxRowCount             => 1
    );
    checkCursor( 'getGoods: maxRowCount', 1);

    pkg_JepRiaShowcase.deleteGoods(
      goodsId                 => goodsId
      , operatorId            => operatorId
    );
    pkg_TestUtility.compareRowCount(
      tableName           => 'jrs_goods'
      , filterCondition   => '
goods_id = ''' || goodsId || '''
'
      , expectedRowCount  => 0
      , failMessageText   =>
          'deleteGoods: ������ �� ���� �������'
    );

    -- ������� ������ ��� ����������� ������
    goodsId := pkg_JepRiaShowcase.createGoods(
      supplierId                => supplierId
      , goodsName               => '$TEST-������, 1 �.'
      , goodsTypeCode           => 'FOOD'
      , unitCode                => 'L'
      , purchasingPrice         => 20.75
      , motivationTypeCode      => 'MONTH'
      , goodsPhotoMimeType      => 'jpeg'
      , goodsPhotoExtension     => 'jpg'
      , goodsPortfolioMimeType  => 'text-rtf'
      , goodsPortfolioExtension => 'rtf'
      , operatorId              => operatorId
    );
    pkg_TestUtility.compareRowCount(
      tableName           => 'jrs_goods'
      , filterCondition   => '
goods_id = ''' || goodsId || '''
'
      , expectedRowCount  => 1
      , failMessageText   =>
          'createGoods: test1: ������ �� ������� ��� �����������'
    );
    goodsId2 := pkg_JepRiaShowcase.createGoods(
      supplierId                => supplierId
      , goodsName               => '$TEST-���� �������'
      , goodsTypeCode           => 'INDUSTRIAL'
      , unitCode                => 'ITEM'
      , purchasingPrice         => 18.00
      , operatorId              => operatorId
    );
    pkg_TestUtility.compareRowCount(
      tableName           => 'jrs_goods'
      , filterCondition   => '
goods_id = ''' || goodsId2 || '''
and motivation_type_code = ''USUAL''
'
      , expectedRowCount  => 1
      , failMessageText   =>
          'createGoods: test2: ������ �� ������� ��� �����������'
    );

    -- findGoods ��� ���������� �������
    rc := pkg_JepRiaShowcase.findGoods(
      goodsIdList             => goodsId2 || ',,' || goodsId2 || ',' || goodsId
      , operatorId            => operatorId
    );
    checkCursor( 'findGoods: few id', 2);
  exception when others then
    raise_application_error(
      pkg_Error.ErrorStackInfo
      , logger.errorStack(
          '������ ��� ������������ ������� %Goods.'
        )
      , true
    );
  end testGoodsApi;



  /*
    ���� ������� %ShopGoods.
  */
  procedure testShopGoodsApi
  is

    shopId integer;
    shopGoodsId integer;

  begin
    select
      min( t.shop_id)
    into shopId
    from
      jrs_shop t
    ;
    shopGoodsId := pkg_JepRiaShowcase.createShopGoods(
      shopId                  => shopId
      , goodsId               => goodsId
      , goodsQuantity         => 5.0001
      , sellPrice             => 85.88
      , operatorId            => operatorId
    );
    pkg_TestUtility.compareRowCount(
      tableName           => 'jrs_shop_goods'
      , filterCondition   => '
shop_goods_id = ''' || shopGoodsId || '''
and shop_id = ''' || shopId || '''
and goods_id = ''' || goodsId || '''
and goods_quantity = 5.0001
and sell_price = 85.88
'
      , expectedRowCount  => 1
      , failMessageText   =>
          'createShopGoods: ������ �� ������� ��� �����������'
    );

    pkg_JepRiaShowcase.updateShopGoods(
      shopGoodsId             => shopGoodsId
      , goodsQuantity         => 3
      , sellPrice             => 60
      , operatorId            => operatorId
    );
    pkg_TestUtility.compareRowCount(
      tableName           => 'jrs_shop_goods'
      , filterCondition   => '
shop_goods_id = ''' || shopGoodsId || '''
and goods_quantity = 3
and sell_price = 60
'
      , expectedRowCount  => 1
      , failMessageText   =>
          'updateShopGoods: ������ �� �������� ��� �����������'
    );

    rc := pkg_JepRiaShowcase.findShopGoods(
      maxRowCount             => 1
      , operatorId            => operatorId
    );
    checkCursor( 'findShopGoods: maxRowCount', 1);

    rc := pkg_JepRiaShowcase.findShopGoods(
      shopGoodsId             => shopGoodsId
      , operatorId            => operatorId
    );
    checkCursor( 'findShopGoods: id', 1);

    rc := pkg_JepRiaShowcase.findShopGoods(
      shopGoodsId             => shopGoodsId
      , shopId                => shopId
      , goodsId               => goodsId
      , maxRowCount           => 5
      , operatorId            => operatorId
    );
    checkCursor( 'findShopGoods: all args', 1);

    rc := pkg_JepRiaShowcase.findShopGoods(
      goodsId                 => goodsId
      , operatorId            => operatorId
    );
    checkCursor( 'findShopGoods: goods', 1);

    rc := pkg_JepRiaShowcase.getShop(
      maxRowCount             => 1
    );
    checkCursor( 'getShop: maxRowCount', 1);

    pkg_JepRiaShowcase.deleteShopGoods(
      shopGoodsId             => shopGoodsId
      , operatorId            => operatorId
    );
    pkg_TestUtility.compareRowCount(
      tableName           => 'jrs_shop_goods'
      , filterCondition   => '
shop_goods_id = ''' || shopGoodsId || '''
'
      , expectedRowCount  => 0
      , failMessageText   =>
          'deleteShopGoods: ������ �� ���� �������'
    );
  exception when others then
    raise_application_error(
      pkg_Error.ErrorStackInfo
      , logger.errorStack(
          '������ ��� ������������ ������� %ShopGoods.'
        )
      , true
    );
  end testShopGoodsApi;



  /*
    ���� ������� %Request.
  */
  procedure testRequestApi
  is

    shopId integer;

  begin
    select
      min( t.shop_id)
    into shopId
    from
      jrs_shop t
    ;
    requestId := pkg_JepRiaShowcase.createRequest(
      shopId                  => shopId
      , goodsId               => goodsId2
      , goodsQuantity         => 5.0001
      , operatorId            => operatorId
    );
    pkg_TestUtility.compareRowCount(
      tableName           => 'jrs_request'
      , filterCondition   => '
request_id = ''' || requestId || '''
and shop_id = ''' || shopId || '''
and goods_id = ''' || goodsId2 || '''
and goods_quantity = 5.0001
and request_status_code = ''NEW''
'
      , expectedRowCount  => 1
      , failMessageText   =>
          'createRequest: ������ �� ������� ��� �����������'
    );

    pkg_JepRiaShowcase.updateRequest(
      requestId               => requestId
      , requestStatusCode     => 'REJECTED'
      , goodsId               => goodsId
      , goodsQuantity         => 3
      , operatorId            => operatorId
    );
    pkg_TestUtility.compareRowCount(
      tableName           => 'jrs_request'
      , filterCondition   => '
request_id = ''' || requestId || '''
and request_status_code = ''REJECTED''
and goods_id = ''' || goodsId || '''
and goods_quantity = 3
'
      , expectedRowCount  => 1
      , failMessageText   =>
          'updateRequest: ������ �� �������� ��� �����������'
    );

    rc := pkg_JepRiaShowcase.findRequest(
      maxRowCount             => 1
      , operatorId            => operatorId
    );
    checkCursor( 'findRequest: maxRowCount', 1);

    rc := pkg_JepRiaShowcase.findRequest(
      requestId               => requestId
      , operatorId            => operatorId
    );
    checkCursor( 'findRequest: id', 1);

    rc := pkg_JepRiaShowcase.findRequest(
      requestId               => requestId
      , shopId                => shopId
      , requestDateFrom       => trunc( sysdate)
      , requestDateTo         => trunc( sysdate)
      , requestStatusCode     => 'REJECTED'
      , goodsId               => goodsId
      , maxRowCount           => 5
      , operatorId            => operatorId
    );
    checkCursor( 'findRequest: all args', 1);

    rc := pkg_JepRiaShowcase.findRequest(
      goodsId                 => goodsId
      , operatorId            => operatorId
    );
    checkCursor( 'findRequest: goods', 1);

    pkg_JepRiaShowcase.deleteRequest(
      requestId               => requestId
      , operatorId            => operatorId
    );
    pkg_TestUtility.compareRowCount(
      tableName           => 'jrs_request'
      , filterCondition   => '
request_id = ''' || requestId || '''
'
      , expectedRowCount  => 0
      , failMessageText   =>
          'deleteRequest: ������ �� ���� �������'
    );

    -- ������� ������ ��� ����������� ������
    requestId := pkg_JepRiaShowcase.createRequest(
      shopId                  => shopId
      , goodsId               => goodsId
      , goodsQuantity         => 4
      , operatorId            => operatorId
    );
    pkg_TestUtility.compareRowCount(
      tableName           => 'jrs_request'
      , filterCondition   => '
request_id = ''' || requestId || '''
'
      , expectedRowCount  => 1
      , failMessageText   =>
          'createRequest: test1: ������ �� ������� ��� �����������'
    );
  exception when others then
    raise_application_error(
      pkg_Error.ErrorStackInfo
      , logger.errorStack(
          '������ ��� ������������ ������� %Request.'
        )
      , true
    );
  end testRequestApi;



  /*
    ���� ������� %RequestProcess.
  */
  procedure testRequestProcessApi
  is

    requestProcessId integer;

  begin
    requestProcessId := pkg_JepRiaShowcase.createRequestProcess(
      requestId               => requestId
      , operatorId            => operatorId
    );
    pkg_TestUtility.compareRowCount(
      tableName           => 'jrs_request_process'
      , filterCondition   => '
request_process_id = ''' || requestProcessId || '''
and request_id = ''' || requestId || '''
'
      , expectedRowCount  => 1
      , failMessageText   =>
          'createRequestProcess: ������ �� ������� ��� �����������'
    );

    rc := pkg_JepRiaShowcase.findRequestProcess(
      maxRowCount             => 1
      , operatorId            => operatorId
    );
    checkCursor( 'findRequestProcess: maxRowCount', 1);

    rc := pkg_JepRiaShowcase.findRequestProcess(
      requestProcessId        => requestProcessId
      , operatorId            => operatorId
    );
    checkCursor( 'findRequestProcess: id', 1);

    rc := pkg_JepRiaShowcase.findRequestProcess(
      requestProcessId        => requestProcessId
      , requestId             => requestId
      , dateInsFrom           => trunc( sysdate)
      , dateInsTo             => trunc( sysdate)
      , insertOperatorId      => operatorId
      , maxRowCount           => 5
      , operatorId            => operatorId
    );
    checkCursor( 'findRequestProcess: all args', 1);

    rc := pkg_JepRiaShowcase.findRequestProcess(
      requestId               => requestId
      , operatorId            => operatorId
    );
    checkCursor( 'findRequestProcess: requestId', 1);

    pkg_JepRiaShowcase.deleteRequestProcess(
      requestProcessId        => requestProcessId
      , operatorId            => operatorId
    );
    pkg_TestUtility.compareRowCount(
      tableName           => 'jrs_request_process'
      , filterCondition   => '
request_process_id = ''' || requestProcessId || '''
'
      , expectedRowCount  => 0
      , failMessageText   =>
          'deleteRequestProcess: ������ �� ���� �������'
    );
  exception when others then
    raise_application_error(
      pkg_Error.ErrorStackInfo
      , logger.errorStack(
          '������ ��� ������������ ������� %RequestProcess.'
        )
      , true
    );
  end testRequestProcessApi;



  /*
    ���� ������� ���������� ������� get%
  */
  procedure testGetFunction
  is

    bankBic varchar2(100);

  begin
    rc := pkg_JepRiaShowcase.getBank(
      bankBic => '$'
    );
    checkCursor( 'getBank[ bad bic]', 0);

    select
      t.bic
    into bankBic
    from
      v_bic_bank t
    where
      rownum <= 1
    ;
    rc := pkg_JepRiaShowcase.getBank(
      bankBic => bankBic
    );
    checkCursor( 'getBank[ ok bic]', 1);

    rc := pkg_JepRiaShowcase.getBank(
      bankBic         => '%'
      , maxRowCount   => 3
    );
    checkCursor( 'getBank[ all params]', 3);

    rc := pkg_JepRiaShowcase.getBank();
    checkCursor( 'getBank[ all]', 'v_bic_bank');
  exception when others then
    raise_application_error(
      pkg_Error.ErrorStackInfo
      , logger.errorStack(
          '������ ��� ������������ ������� get%.'
        )
      , true
    );
  end testGetFunction;



  /*
    ���� ������� %Feature.
  */
  procedure testFeature
  is

     featureId integer;

     featureId3 integer;


  begin
    featureId := pkg_JepRiaShowcase.createFeature(
      featureName     => '$TEST-������'
      , featureNameEn => '$TEST-Request-en'
      , operatorId    => operatorId
    );
    pkg_TestUtility.compareRowCount(
      tableName           => 'jrs_feature'
      , filterCondition   => '
feature_id = ' || coalesce( to_char( featureId), 'null') || '
and feature_name = ''$TEST-������''
and feature_name_en = ''$TEST-Request-en'''
       , expectedRowCount  => 1
       , failMessageText   =>
'createFeature: ������ �� ������� ��� �����������'
    );
    pkg_TestUtility.compareRowCount(
      tableName           => 'v_jrs_feature_lob'
      , filterCondition   =>
        'feature_id = ' || coalesce( to_char( featureId), 'null')
      , expectedRowCount  => 1
      , failMessageText   =>
        'v_jrs_feature_lob: �� ������� ������'
    );
    pkg_JepRiaShowcase.updateFeature(
      featureId        => featureId
      , featureName    => '$TEST-������2'
      , featureNameEn  => '$TEST-Request2-en'
      , operatorId     => operatorId
    );
    pkg_TestUtility.compareRowCount(
      tableName           => 'jrs_feature'
      , filterCondition   => '
feature_id = ' || coalesce( to_char( featureId), 'null') || '
and feature_name = ''$TEST-������2''
and feature_name_en = ''$TEST-Request2-en'''
       , expectedRowCount  => 1
       , failMessageText   =>
'updateFeature: ������ �� �������� ��� �����������'
    );
    featureId3 := pkg_JepRiaShowcase.createFeature(
      featureName     => '$TEST-������3'
      , featureNameEn => '$TEST-Request3-en'
      , operatorId    => operatorId
    );

    -- ����� �� id
    rc := pkg_JepRiaShowcase.findFeature(
      featureId           => featureId
    );
    checkCursor( 'findFeature: featureId', 1);
    -- ����� �� ������������ �� ���������� ( �������� ������� "���")
    rc := pkg_JepRiaShowcase.findFeature(
      featureName         => '$%$%$%$%$%$'
      , featureNameEn     => '$TEST-Request2-en'
      , dateInsFrom       => sysdate - 1
      , dateInsTo         => sysdate + 1
      , operatorId        => operatorId
    );
    checkCursor( 'findFeature: featureNameEn: OR', 1);
    -- ����� �� ������������ ( �������� ������� "�")
    rc := pkg_JepRiaShowcase.findFeature(
      featureId           => featureId
      , featureName       => '$%$%$%$%$%$'
      , operatorId        => operatorId
    );
    checkCursor( 'findFeature: featureName: AND', 0);
    -- ����� �� date_ins
    rc := pkg_JepRiaShowcase.findFeature(
      dateInsFrom         => sysdate + 1
      , featureName       => ''
      , operatorId        => operatorId
    );
    checkCursor( 'findFeature: fromDateIns', 0);
    -- ����� �� date_ins
    rc := pkg_JepRiaShowcase.findFeature(
      dateInsTo           => sysdate - 1
      , featureName       => '$TEST-������2'
      , operatorId        => operatorId
    );
    checkCursor( 'findFeature: toDateIns', 0);
    -- ����� �� date_ins � featureName
    rc := pkg_JepRiaShowcase.findFeature(
      dateInsTo           => sysdate + 1
      , featureName       => '$TEST-������2'
      , operatorId        => operatorId
    );
    checkCursor( 'findFeature: toDateIns', 1);
    rc := pkg_JepRiaShowcase.findFeature(
      dateInsTo           => sysdate + 1
      , featureName       => '$TEST-������2'
      , operatorId        => operatorId
    );
    checkCursor( 'findFeature: toDateIns', 1);
    rc := pkg_JepRiaShowcase.findFeature(
      maxRowCount         => 1
    );
    checkCursor( 'findFeature: rowCount', 1);
    pkg_JepRiaShowcase.deleteFeature(
      featureId           => featureId
      , operatorId        => operatorId
    );
    pkg_JepRiaShowcase.deleteFeature(
      featureId           => featureId3
      , operatorId        => operatorId
    );
    pkg_TestUtility.compareRowCount(
      tableName           => 'jrs_feature'
      , filterCondition   => '
feature_id = ' || coalesce( to_char( featureId), 'null') || '
or feature_id = ' || coalesce( to_char( featureId3), 'null')
      , expectedRowCount  => 0
      , failMessageText   =>
'updateFeature: ������ �� �������'
    );
    for i in 1..1000 loop
      featureId := pkg_JepRiaShowcase.createFeature(
        featureName     => '$TEST-������' || to_char( i)
        , featureNameEn => '$TEST-Request-en' || to_char( i)
        , operatorId    => operatorId
      );
    end loop;
    rc := pkg_JepRiaShowcase.findFeature(
      featureName => '$TEST-������1'
    );
    checkCursor( 'findFeature: find performance: count', 1);
    for testFeature in (
    select
      feature_id
    from
      jrs_feature
    where
      feature_name like '$TEST-������%'
    )
    loop
      pkg_JepRiaShowcase.deleteFeature(
        featureId    => testFeature.feature_id
        , operatorId => operatorId
      );
    end loop;
    -- ���� ������� �� ��� �����
    if pkg_TestUtility.getTestTimeSecond() > 1 then
      pkg_TestUtility.failTest(
        failMessageText =>
          'find performance test : '
          || to_char( pkg_TestUtility.getTestTimeSecond(), 'FM9990.000') || ' ���.'
      );
    end if;
  exception when others then
    raise_application_error(
      pkg_Error.ErrorStackInfo
      , logger.errorStack(
          '������ ��� ������������ ������� %Feature.'
        )
      , true
    );
  end testFeature;


-- testUserApi
begin
  pkg_TestUtility.beginTest(
    'user API'
  );
  testSupplierApi();
  testGoodsApi();
  testShopGoodsApi();
  testRequestApi();
  testRequestProcessApi();
  testGetFunction();
  testFeature();
  pkg_TestUtility.endTest();
  rollback;
exception when others then
  raise_application_error(
    pkg_Error.ErrorStackInfo
    , logger.errorStack(
        '������ ��� ������������ API ��� ����������������� ����������.'
      )
    , true
  );
end testUserApi;

/* proc: testFeatureOperator
  ���� ������������� �������� �� ����������.
*/
procedure testFeatureOperator
is

  rc sys_refcursor;

  featureOperatorId integer;

  /*
    ������� ������������.
  */
  procedure clearFeatureOperator
  is
  begin
    pkg_JepRiaShowcase.deleteFeatureOperator(
      featureOperatorId => pkg_Operator.getCurrentUserId()
      , operatorId      => pkg_Operator.getCurrentUserId()
    );
  end clearFeatureOperator;

-- testFeatureOperator
begin
  pkg_TestUtility.beginTest( '�������� 18: ���� �������� ������ ������������ ��������');
  clearFeatureOperator();
  featureOperatorId := pkg_JepRiaShowcase.createFeatureOperator(
    featureOperatorId => pkg_Operator.getCurrentUserId()
    , operatorId      => pkg_Operator.getCurrentUserId()
  );
  rc := pkg_JepRiaShowcase.findFeatureOperator(
    featureOperatorId => featureOperatorId
    , operatorId      => pkg_Operator.getCurrentUserId()
  );
  pkg_TestUtility.compareRowCount(
    rc
    , expectedRowCount => 1
    -- ������� ����� ������ �����
    , filterCondition => 'date_ins >= sysdate - 1/24/60'
    , failMessageText  =>
        '����� ������ �� �������'
  );
  pkg_TestUtility.endTest();
end testFeatureOperator;

/* proc: testFindFeature
  ���� ������ �������� �� ����������.
*/
procedure testFindFeature
is

  -- ����������� ������������
  operatorId_A integer;
  operatorId_B integer;

  -- ����������� �������
  feature_1    integer;
  feature_2    integer;
  feature_3    integer;

  -- ��������� ���������� �������
  rc           sys_refcursor;

  /*
    ���������� ���������: ��������� ������������ � ����� JrsEditFeature:
    ������������� ��, ������������� ��.
    ������������� �� ������� ������� 1� � ������� 2�.
    ������������� �� ������� ������� 3�.
  */
  procedure initTest
  is
    featureProcessId integer;
  begin
    operatorId_A := pkg_AccessOperatorTest.getTestOperatorId(
      baseName        => 'Operator_A'
      , roleSNameList => cmn_string_table_t(
          pkg_JepRiaShowcase.EditFeature_RoleSName
          , pkg_JepRiaShowcase.EditAllFeature_RoleSName
        )
    );
    operatorId_B := pkg_AccessOperatorTest.getTestOperatorId(
      baseName        => 'Operator_B'
      , roleSNameList => cmn_string_table_t(
          pkg_JepRiaShowcase.EditFeature_RoleSName
        )
    );
    feature_1 := pkg_JepRiaShowcase.createFeature(
      featureName       => '������ 1'
      , featureNameEn   => 'Test_feature_1'
      , operatorId      => operatorId_A
    );
    feature_2 := pkg_JepRiaShowcase.createFeature(
      featureName       => '������ 2'
      , featureNameEn   => 'Test_feature_2'
      , operatorId      => operatorId_A
    );
    feature_3 := pkg_JepRiaShowcase.createFeature(
      featureName       => '������ 3'
      , featureNameEn   => 'Test_feature_3'
      , operatorId      => operatorId_B
    );
    featureProcessId := pkg_JepRiaShowcase.createFeatureProcess(
      featureId           => feature_1
      , featureStatusCode => pkg_JepRiaShowcase.Assigned_FeatureStatusCode
      , operatorId        => operatorId_A
    );
    featureProcessId := pkg_JepRiaShowcase.createFeatureProcess(
      featureId           => feature_3
      , featureStatusCode => pkg_JepRiaShowcase.InProgress_FeatureStatusCode
      , operatorId        => operatorId_A
    );
  end initTest;

  /*
    ��������� ����� ������� � �������.
  */
  procedure checkCursor(
    functionName varchar2
    , expectedRowCount integer := null
  )
  is
  begin
    pkg_TestUtility.compareRowCount(
      rc                 => rc
      , expectedRowCount => coalesce( expectedRowCount, 0)
      , failMessageText  =>
          functionName
          || ': ������������ ����� ������� � �������'
    );
  end checkCursor;


  /*
    ���� ������� findFeature �� ������.
  */
  procedure findFeatureByAuthor
  is
  -- findFeatureByAuthor
  begin
    pkg_TestUtility.beginTest(
      '�������� 19: ����� �� ������ �������� �������'
    );

    -- feature_1
    rc := pkg_JepRiaShowcase.findFeature(
      featureId       => feature_1
      , authorId      => operatorId_A
      , operatorId    => operatorId_B
    );
    checkCursor( 'findFeatureByAuthor: rowCount', 1);

    -- feature_2
    rc := pkg_JepRiaShowcase.findFeature(
      featureId       => feature_2
      , authorId      => operatorId_A
      , operatorId    => operatorId_B
    );
    checkCursor( 'findFeatureByAuthor: rowCount', 1);

    -- feature_3
    rc := pkg_JepRiaShowcase.findFeature(
      featureId       => feature_3
      , authorId      => operatorId_A
      , operatorId    => operatorId_B
    );
    checkCursor( 'findFeatureByAuthor: rowCount', 0);

    endTestException(
      expectedException   => null
      , inExceptionFlag   => 0
    );
  end findFeatureByAuthor;

  /*
    ���� ������� findFeature �� �������� �������.
  */
  procedure findFeatureByStatusCode
  is
    featureStatusCodeList varchar2(1000) :=
      pkg_JepRiaShowcase.Assigned_FeatureStatusCode || ';'
      || pkg_JepRiaShowcase.InProgress_FeatureStatusCode;
  -- findFeatureByStatusCode
  begin
    pkg_TestUtility.beginTest(
      '�������� 20: ����� �� ���������� �������� �������'
    );

    -- feature_1
    rc := pkg_JepRiaShowcase.findFeature(
      featureId               => feature_1
      , featureStatusCodeList => featureStatusCodeList
      , operatorId            => operatorId_B
    );
    checkCursor( 'findFeatureByAuthor: rowCount', 1);

    -- feature_2
    rc := pkg_JepRiaShowcase.findFeature(
      featureId               => feature_2
      , featureStatusCodeList => featureStatusCodeList
      , operatorId            => operatorId_B
    );
    checkCursor( 'findFeatureByAuthor: rowCount', 0);

    -- feature_3
    rc := pkg_JepRiaShowcase.findFeature(
      featureId               => feature_3
      , featureStatusCodeList => featureStatusCodeList
      , operatorId            => operatorId_B
    );
    checkCursor( 'findFeatureByAuthor: rowCount', 1);

    endTestException(
      expectedException   => null
      , inExceptionFlag   => 0
    );
  end findFeatureByStatusCode;

-- testFindFeature
begin

  -- ���������� ���������
  initTest();

  -- �������� 19
  findFeatureByAuthor();

  -- �������� 20
  findFeatureByStatusCode();

exception when others then
  raise_application_error(
    pkg_Error.ErrorStackInfo
    , logger.errorStack(
        '������ ��� ������������ ������ �������� �� ����������.'
      )
    , true
  );
end testFindFeature;

/* proc: testSetFeatureWorkSequence
  ���� ��������� ������� ���������� �������� �� ����������.
*/
procedure testSetFeatureWorkSequence
is

  -- ����������� ������������
  operatorId_A integer;
  operatorId_B integer;
  operatorId_C integer;

  -- ����������� �������
  feature_1    integer;
  feature_2    integer;
  feature_3    integer;

  -- ��������� ���������� �������
  rc           sys_refcursor;

  /*
    ���������� ���������:
    ��������� ������������ � ����� JrsEditFeature: ������������� ��, ������������� ��.
    ��������� ������������ � ����� JrsAssignWorkSequenceFeature: ������������� ».
    ������������� �� ������� ������� �� ����� ���������� ������� 1� � ������� 2�.
    ������������� �� ������� ������� �� ����� ���������� ������� 3�.
  */
  procedure initTest
  is
    featureProcessId integer;
  begin
    operatorId_A := pkg_AccessOperatorTest.getTestOperatorId(
      baseName        => 'Operator_A'
      , roleSNameList => cmn_string_table_t(
          pkg_JepRiaShowcase.EditFeature_RoleSName
        )
    );
    operatorId_B := pkg_AccessOperatorTest.getTestOperatorId(
      baseName        => 'Operator_B'
      , roleSNameList => cmn_string_table_t(
          pkg_JepRiaShowcase.EditFeature_RoleSName
          , pkg_JepRiaShowcase.EditAllFeature_RoleSName
        )
    );
    operatorId_C := pkg_AccessOperatorTest.getTestOperatorId(
      baseName        => 'Operator_C'
      , roleSNameList => cmn_string_table_t(
          pkg_JepRiaShowcase.AssignWrkSequenceFea_RoleSName
        )
    );
    feature_1 := pkg_JepRiaShowcase.createFeature(
      featureName       => '������ 1'
      , featureNameEn   => 'Test_feature_1'
      , operatorId      => operatorId_A
    );
    feature_2 := pkg_JepRiaShowcase.createFeature(
      featureName       => '������ 2'
      , featureNameEn   => 'Test_feature_2'
      , operatorId      => operatorId_A
    );
    feature_3 := pkg_JepRiaShowcase.createFeature(
      featureName       => '������ 3'
      , featureNameEn   => 'Test_feature_3'
      , operatorId      => operatorId_B
    );
  end initTest;

  /*
    ��������� ����� ������� � �������.
  */
  procedure checkCursor(
    functionName varchar2
    , expectedRowCount integer := null
  )
  is
  begin
    pkg_TestUtility.compareRowCount(
      rc                 => rc
      , expectedRowCount => coalesce( expectedRowCount, 0)
      , failMessageText  =>
          functionName
          || ': ������������ ����� ������� � �������'
    );
  end checkCursor;

  /*
    ���� ��������� setFeatureWorkSequence ��� ��������������� ����.
  */
  procedure setWorkSequenceWithoutAccess
  is

    expectedException varchar2(100) := '��� ���� �� ���������� ������ ��������';

  -- setWorkSequenceWithoutAccess
  begin
    pkg_TestUtility.beginTest(
      '�������� 24: ������� ��������� ������� ���������� ��� ��������������� ����'
    );

    pkg_JepRiaShowcase.setFeatureWorkSequence(
      featureId => feature_1
      , workSequence => 1
      , operatorId => operatorId_A
    );

    endTestException(
      expectedException   => expectedException
      , inExceptionFlag   => 0
    );
  exception
    when others then
      endTestException(
        expectedException   => expectedException
        , inExceptionFlag   => 1
      );
  end setWorkSequenceWithoutAccess;

  /*
    ���� ��������� setFeatureWorkSequence ��� ��������� ������� ���������� �������
  */
  procedure setWorkSequenceLessOne
  is

  -- setWorkSequenceLessOne
  begin
    pkg_TestUtility.beginTest(
      '�������� 25. ��������� ������� ���������� ������ 1'
    );

    pkg_JepRiaShowcase.setFeatureWorkSequence(
      featureId => feature_1
      , workSequence => 0
      , operatorId => operatorId_C
    );

    -- feature_1
    rc := pkg_JepRiaShowcase.findFeature(
      featureId          => feature_1
      , workSequenceFrom => 1
      , workSequenceTo   => 1
      , operatorId       => operatorId_B
    );
    checkCursor( 'setWorkSequenceLessOne: rowCount', 1);

    -- �������� �������
    rc := pkg_JepRiaShowcase.findFeatureProcess(
      featureId          => feature_1
      , featureStatusCode => pkg_JepRiaShowcase.Sequenced_FeatureStatusCode
      , operatorId       => operatorId_B
    );
    checkCursor( 'setWorkSequenceLessOne: process SEQUENCED rowCount', 1);

    endTestException(
      expectedException   => null
      , inExceptionFlag   => 0
    );

    -- ���������� �������� ��������
    -- ��� ��������� ����������� �����������
    -- ������
    pkg_JepRiaShowcase.setFeatureWorkSequence(
      featureId => feature_1
      , workSequence => null
      , operatorId => operatorId_C
    );
    --

  end setWorkSequenceLessOne;

  /*
    ���� ��������� setFeatureWorkSequence ��� ��������������� ����.
  */
  procedure setWorkSequenceMax
  is

    maxWorkSequence integer;

  -- setWorkSequenceMax
  begin
    pkg_TestUtility.beginTest(
      '�������� 26: ��������� ������� ���������� ������, ��� ������������ ������������ ������� + 1'
    );

    select
      nvl( max( f.work_sequence), 0)
    into
      maxWorkSequence
    from
      jrs_feature f
    ;

    pkg_JepRiaShowcase.setFeatureWorkSequence(
      featureId      => feature_1
      , workSequence => maxWorkSequence + 10
      , operatorId   => operatorId_C
    );

    -- feature_1
    rc := pkg_JepRiaShowcase.findFeature(
      featureId          => feature_1
      , workSequenceFrom => maxWorkSequence + 1
      , workSequenceTo   => maxWorkSequence + 1
      , operatorId       => operatorId_B
    );
    checkCursor( 'setWorkSequenceMax: rowCount', 1);

    endTestException(
      expectedException   => null
      , inExceptionFlag   => 0
    );

    -- ���������� �������� ��������
    -- ��� ��������� ����������� �����������
    -- ������
    pkg_JepRiaShowcase.setFeatureWorkSequence(
      featureId => feature_1
      , workSequence => null
      , operatorId => operatorId_C
    );
    --

  end setWorkSequenceMax;

  /*
    ���� ��������� setFeatureWorkSequence ��� ��������������� ����.
  */
  procedure setWorkSequenceOrder
  is
  -- setWorkSequenceOrder
  begin
    pkg_TestUtility.beginTest(
      '�������� 27: ��������� ������� ���������� ������� ������������� ������� ����������'
    );

    pkg_JepRiaShowcase.setFeatureWorkSequence(
      featureId      => feature_1
      , workSequence => 1
      , operatorId   => operatorId_C
    );

    pkg_JepRiaShowcase.setFeatureWorkSequence(
      featureId      => feature_2
      , workSequence => 2
      , operatorId   => operatorId_C
    );

    pkg_JepRiaShowcase.setFeatureWorkSequence(
      featureId      => feature_3
      , workSequence => 1
      , operatorId   => operatorId_C
    );

    -- feature_1
    rc := pkg_JepRiaShowcase.findFeature(
      featureId          => feature_1
      , workSequenceFrom => 2
      , workSequenceTo   => 2
      , operatorId       => operatorId_B
    );
    checkCursor( 'setWorkSequenceOrder: rowCount', 1);

    -- feature_2
    rc := pkg_JepRiaShowcase.findFeature(
      featureId          => feature_2
      , workSequenceFrom => 3
      , workSequenceTo   => 3
      , operatorId       => operatorId_B
    );
    checkCursor( 'setWorkSequenceOrder: rowCount', 1);

    -- feature_3
    rc := pkg_JepRiaShowcase.findFeature(
      featureId          => feature_3
      , workSequenceFrom => 1
      , workSequenceTo   => 1
      , operatorId       => operatorId_B
    );
    checkCursor( 'setWorkSequenceOrder: rowCount', 1);

    endTestException(
      expectedException   => null
      , inExceptionFlag   => 0
    );
  end setWorkSequenceOrder;

  /*
    ���� �� ������� ������������� ������������������
    ��� �������� ������� �� ����������.
  */
  procedure checkWorkSequenceOnFeatureDel
  is

    workSequenceCount pls_integer;
    workSequenceMax   pls_integer;

  -- checkWorkSequenceOnFeatureDel
  begin
    pkg_TestUtility.beginTest(
      '�������� 33: �������� �� ������� ������������� ������������������ ��� �������� ������� �� ����������'
    );

    -- �������������� ������������������
    pkg_JepRiaShowcase.setFeatureWorkSequence(
      featureId      => feature_1
      , workSequence => 1
      , operatorId   => operatorId_C
    );
    pkg_JepRiaShowcase.setFeatureWorkSequence(
      featureId      => feature_2
      , workSequence => 2
      , operatorId   => operatorId_C
    );
    pkg_JepRiaShowcase.setFeatureWorkSequence(
      featureId      => feature_3
      , workSequence => 3
      , operatorId   => operatorId_C
    );
    --

    -- ������� ������ ������� ������������������
    delete from
      jrs_feature_process
    where
      feature_id = feature_2
    ;
    pkg_JepRiaShowcase.deleteFeature(
      featureId    => feature_2
      , operatorId => operatorId_B
    );

    -- feature_3
    rc := pkg_JepRiaShowcase.findFeature(
      featureId          => feature_3
      , workSequenceFrom => 2
      , workSequenceTo   => 2
      , operatorId       => operatorId_B
    );
    checkCursor( 'checkWorkSequenceOnFeatureDel: rowCount', 1);

    endTestException(
      expectedException   => null
      , inExceptionFlag   => 0
    );
  end checkWorkSequenceOnFeatureDel;

-- testSetFeatureWorkSequence
begin

  -- ���������� ���������
  initTest();

  -- �������� 24
  setWorkSequenceWithoutAccess();

  -- �������� 25
  setWorkSequenceLessOne();

  -- �������� 26
  setWorkSequenceMax();

  -- �������� 27
  setWorkSequenceOrder();

  -- �������� 33
  checkWorkSequenceOnFeatureDel();

exception when others then
  raise_application_error(
    pkg_Error.ErrorStackInfo
    , logger.errorStack(
        '������ ��� ������������ ��������� ������� '
        || '���������� �������� �� ����������.'
      )
    , true
  );
end testSetFeatureWorkSequence;

/* proc: testSetFeatureResponsible
  ���� ��������� �������������� �� ������ �� ����� ����������
*/
procedure testSetFeatureResponsible
is

  -- ����������� ������������
  operatorId_A integer;
  operatorId_B integer;

  -- ����������� �������
  feature_1    integer;

  -- ��������� ���������� �������
  rc           sys_refcursor;

  /*
    ���������� ���������:
    ��������� ������������ � ����� JrsEditFeature: ������������� ��.
    ��������� ������������ � ����� JrsAssignResponsibleFeature: ������������� ».
    ������������� �� ������� ������ �� ����� ���������� ������� 1�.
  */
  procedure initTest
  is
  begin
    operatorId_A := pkg_AccessOperatorTest.getTestOperatorId(
      baseName        => 'Operator_A'
      , roleSNameList => cmn_string_table_t(
          pkg_JepRiaShowcase.EditFeature_RoleSName
        )
    );
    operatorId_B := pkg_AccessOperatorTest.getTestOperatorId(
      baseName        => 'Operator_B'
      , roleSNameList => cmn_string_table_t(
          pkg_JepRiaShowcase.EditAllFeature_RoleSName
          , pkg_JepRiaShowcase.AssignResponsibleFea_RoleSName
        )
    );
    feature_1 := pkg_JepRiaShowcase.createFeature(
      featureName       => '������ 1'
      , featureNameEn   => 'Test_feature_1'
      , operatorId      => operatorId_A
    );
  end initTest;

  /*
    ��������� ����� ������� � �������.
  */
  procedure checkCursor(
    functionName varchar2
    , expectedRowCount integer := null
  )
  is
  begin
    pkg_TestUtility.compareRowCount(
      rc                 => rc
      , expectedRowCount => coalesce( expectedRowCount, 0)
      , failMessageText  =>
          functionName
          || ': ������������ ����� ������� � �������'
    );
  end checkCursor;

  /*
    ���� ��������� setFeatureResponsible � ���������� ������� �� ASSIGNED
  */
  procedure setFeatureChangeResponsible
  is

  -- setFeatureChangeResponsible
  begin
    pkg_TestUtility.beginTest(
      '�������� 34. ��������� �������������� �� ������'
    );

    pkg_JepRiaShowcase.setFeatureResponsible(
      featureId => feature_1
      , responsibleId  => operatorId_A
      , operatorId => operatorId_B
    );

    -- feature_1
    rc := pkg_JepRiaShowcase.findFeature(
      featureId          => feature_1
      , responsibleId    => operatorId_A
      , operatorId       => operatorId_B
    );
    checkCursor( 'setFeatureChangeResponsible: rowCount', 1);

    -- �������� �������
    rc := pkg_JepRiaShowcase.findFeatureProcess(
      featureId          => feature_1
      , featureStatusCode => pkg_JepRiaShowcase.Assigned_FeatureStatusCode
      , operatorId       => operatorId_B
    );
    checkCursor( 'setFeatureChangeResponsible: process ASSIGNED rowCount', 1);

    endTestException(
      expectedException   => null
      , inExceptionFlag   => 0
    );
  end setFeatureChangeResponsible;

-- testSetFeatureResponsible
begin

  -- ���������� ���������
  initTest();

  -- �������� 34
  setFeatureChangeResponsible();

exception when others then
  raise_application_error(
    pkg_Error.ErrorStackInfo
    , logger.errorStack(
        '������ ��� ������������ ��������� ��������������'
        || ' �� ������ �� ����� ���������� .'
      )
    , true
  );
end testSetFeatureResponsible;

end pkg_JepRiaShowcaseTest;
/
