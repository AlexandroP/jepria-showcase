create or replace package pkg_JepRiaShowcase is
/* package: pkg_JepRiaShowcase
  ������������ ����� ������ JepRiaShowcase.

  SVN root: JEP/Module/JepRiaShowcase
*/



/* group: ��������� */

/* const: Module_Name
  �������� ������, � �������� ��������� �����.
*/
Module_Name constant varchar2(30) := 'JepRiaShowcase';



/* group: ���� */

/* const: EditFeature_RoleSName
  �������� �������� ���� "���������� ������ ��������� �� ����� ����������".
*/
EditFeature_RoleSName          constant varchar2(50) := 'JrsEditFeature';

/* const: EditAllFeature_RoleSName
  �������� �������� ���� "���������� ������ ��������� �� ����� ����������".
*/
EditAllFeature_RoleSName       constant varchar2(50) := 'JrsEditAllFeature';

/* const: AssignResponsibleFea_RoleSName
  �������� �������� ���� "���������� ������ ��������� �� ����� ����������".
*/
AssignResponsibleFea_RoleSName constant varchar2(50) := 'JrsAssignResponsibleFeature';

/* const: AssignWrkSequenceFea_RoleSName
  �������� �������� ���� "���������� ������� ���������� ������ �� ����� ����������".
*/
AssignWrkSequenceFea_RoleSName constant varchar2(50) := 'JrsAssignWorkSequenceFeature';

/* const: OperatorFeature_RoleSName
  �������� �������� ���� "�������� ������������� �������� �� ����� ����������".
*/
OperatorFeature_RoleSName      constant varchar2(50) := 'JrsOperatorFeature';

/* const: Goods_RoleSName
  �������� �������� ���� "�������������� ������ �� �������".
*/
Goods_RoleSName                constant varchar2(50) := 'JrsEditGoods';

/* const: Request_RoleSName
  �������� �������� ���� "�������������� ������ �� �������� �� �������".
*/
Request_RoleSName              constant varchar2(50) := 'JrsEditRequest';

/* const: RequestProcess_RoleSName
  �������� �������� ���� "�������������� ������ �� ��������� �������� ��
  �������".
*/
RequestProcess_RoleSName       constant varchar2(50) := 'JrsEditRequestProcess';

/* const: ShopGoods_RoleSName
  �������� �������� ���� "�������������� ������ �� ������� � ���������".
*/
ShopGoods_RoleSName            constant varchar2(50) := 'JrsEditShopGoods';

/* const: Supplier_RoleSName
  �������� �������� ���� "�������������� ������ �� �����������".
*/
Supplier_RoleSName             constant varchar2(50) := 'JrsEditSupplier';



/* group: ������� �������� �� ���������� */

/* const: Assigned_FeatureStatusCode
  ��� ������� ������� �� ���������� "��������".
*/
Assigned_FeatureStatusCode   constant varchar2(10) := 'ASSIGNED';

/* const: InProgress_FeatureStatusCode
  ��� ������� ������� �� ���������� "� ������".
*/
InProgress_FeatureStatusCode constant varchar2(10) := 'INPROGRESS';

/* const: Remarks_FeatureStatusCode
  ��� ������� ������� �� ���������� "������ ��� ���������".
*/
Remarks_FeatureStatusCode    constant varchar2(10) := 'REMARKS';

/* const: Done_FeatureStatusCode
  ��� ������� ������� �� ���������� "����������".
*/
Done_FeatureStatusCode       constant varchar2(10) := 'DONE';

/* const: Cancelled_FeatureStatusCode
  ��� ������� ������� �� ���������� "������".
*/
Cancelled_FeatureStatusCode  constant varchar2(10) := 'CANCELLED';



/* group: ������� */



/* group: ��������� */

/* pfunc: createSupplier
  ������� ����������.

  ���������:
  supplierName                - ������������ ����������
  contractFinishDate          - ���� �� ������� ��������� �������
                                ( � ��������� �� ���, ������������)
  exclusiveSupplierFlag       - ����������������� ��������� ( 1 ��, 0 ���)
                                ( �� ��������� 0)
  privilegeSupplierFlag       - ����������������� ��������� ( 1 ��, 0 ���)
                                ( �� ��������� 0)
  phoneNumber                 - �������
                                ( �� ��������� �����������)
  faxNumber                   - ����
                                ( �� ��������� �����������)
  bankBic                     - ����
                                ( �� ��������� �����������)
  recipientName               - ����������
                                ( �� ��������� �����������)
  settlementAccount           - ��������� ����
                                ( �� ��������� �����������)
  operatorId                  - ������������� ������������, ������������
                                �������� ( �� ��������� �������)

  �������:
  Id ��������� ������.

  ( <body::createSupplier>)
*/
function createSupplier(
  supplierName varchar2
  , contractFinishDate date
  , exclusiveSupplierFlag integer := null
  , privilegeSupplierFlag integer := null
  , phoneNumber varchar2 := null
  , faxNumber varchar2 := null
  , bankBic varchar2 := null
  , recipientName varchar2 := null
  , settlementAccount varchar2 := null
  , operatorId integer := null
)
return integer;

/* pproc: updateSupplier
  �������� ������ ����������.

  ���������:
  supplierId                  - Id ����������
  supplierName                - ������������ ����������
  contractFinishDate          - ���� �� ������� ��������� �������
                                ( � ��������� �� ���, ������������)
  exclusiveSupplierFlag       - ����������������� ��������� ( 1 ��, 0 ���)
  privilegeSupplierFlag       - ����������������� ��������� ( 1 ��, 0 ���)
  phoneNumber                 - �������
  faxNumber                   - ����
  bankBic                     - ����
  recipientName               - ����������
  settlementAccount           - ��������� ����
  operatorId                  - ������������� ������������, ������������
                                �������� ( �� ��������� �������)

  ( <body::updateSupplier>)
*/
procedure updateSupplier(
  supplierId integer
  , supplierName varchar2
  , contractFinishDate date
  , exclusiveSupplierFlag integer
  , privilegeSupplierFlag integer
  , phoneNumber varchar2
  , faxNumber varchar2
  , bankBic varchar2
  , recipientName varchar2
  , settlementAccount varchar2
  , operatorId integer := null
);

/* pproc: deleteSupplier
  ������� ����������.

  ���������:
  supplierId                  - Id ����������
  operatorId                  - ������������� ������������, ������������
                                �������� ( �� ��������� �������)

  ( <body::deleteSupplier>)
*/
procedure deleteSupplier(
  supplierId integer
  , operatorId integer := null
);

/* pfunc: findSupplier
  ����� ����������.

  ���������:
  supplierId                  - Id ����������
                                ( �� ��������� ��� �����������)
  supplierName                - ������������ ����������
                                ( ����� �� like ��� ����� ��������)
                                ( �� ��������� ��� �����������)
  contractFinishDateFrom      - ���� �� ������� ��������� �������, ��
                                ( � ��������� �� ���, ������������)
                                ( �� ��������� ��� �����������)
  contractFinishDateTo        - ���� �� ������� ��������� �������, ��
                                ( � ��������� �� ���, ������������)
                                ( �� ��������� ��� �����������)
  exclusiveSupplierFlag       - ����������������� ��������� ( 1 ��, 0 ���)
                                ( �� ��������� ��� �����������)
  privilegeSupplierFlag       - ����������������� ��������� ( 1 ��, 0 ���)
                                ( �� ��������� ��� �����������)
  maxRowCount                 - ������������ ����� ������������ �������
                                ( �� ��������� ��� �����������)
  operatorId                  - ������������� ������������, ������������
                                �������� ( �� ��������� �������)

  ������� ( ������):
  supplier_id                 - Id ����������
  supplier_name               - ������������ ����������
  contract_finish_date        - ���� �� ������� ��������� �������
  exclusive_supplier_flag     - ����������������� ��������� ( 1 ��, 0 ���)
  privilege_supplier_flag     - ����������������� ��������� ( 1 ��, 0 ���)
  supplier_description        - �������� ����������
  phone_number                - �������
  fax_number                  - ����
  bank_bic                    - ����
  bankname                    - ������������ �����
  ks                          - �������
  recipient_name              - ����������
  settlement_account          - ��������� ����

  ���������:
  - ������������ ������ ������������� �� supplier_name;

  ( <body::findSupplier>)
*/
function findSupplier(
  supplierId integer := null
  , supplierName varchar2 := null
  , contractFinishDateFrom date := null
  , contractFinishDateTo date := null
  , exclusiveSupplierFlag integer := null
  , privilegeSupplierFlag integer := null
  , maxRowCount integer := null
  , operatorId integer := null
)
return sys_refcursor;



/* group: ����� */

/* pfunc: createGoods
  ������� �����.

  ���������:
  supplierId                  - Id ����������
  goodsName                   - ������������ ������
  goodsTypeCode               - ��� ���� ������
  unitCode                    - ��� ������� ���������
  purchasingPrice             - ���������� ����
  motivationTypeCode          - ��� ���� ���������
                                ( �� ��������� ��� ��� "������� ���������")
  goodsPhotoMimeType          - MIME-��� ����� � ����������� ������
  goodsPhotoExtension         - ���������� ����� � ����������� ������
  goodsPortfolioMimeType      - MIME-��� ����� �� ������������� ������
  goodsPortfolioExtension     - ���������� ����� �� ������������� ������
  operatorId                  - ������������� ������������, ������������
                                �������� ( �� ��������� �������)

  �������:
  Id ��������� ������.

  ( <body::createGoods>)
*/
function createGoods(
  supplierId integer
  , goodsName varchar2
  , goodsTypeCode varchar2
  , unitCode varchar2
  , purchasingPrice number
  , motivationTypeCode varchar2 := null
  , goodsPhotoMimeType varchar2 := null
  , goodsPhotoExtension varchar2 := null
  , goodsPortfolioMimeType varchar2 := null
  , goodsPortfolioExtension varchar2 := null
  , operatorId integer := null
)
return integer;

/* pproc: updateGoods
  �������� ������ ������.

  ���������:
  goodsId                     - Id ������
  supplierId                  - Id ����������
  goodsName                   - ������������ ������
  goodsTypeCode               - ��� ���� ������
  unitCode                    - ��� ������� ���������
  purchasingPrice             - ���������� ����
  motivationTypeCode          - ��� ���� ���������
  goodsPhotoMimeType          - MIME-��� ����� � ����������� ������
  goodsPhotoExtension         - ���������� ����� � ����������� ������
  goodsPortfolioMimeType      - MIME-��� ����� �� ������������� ������
  goodsPortfolioExtension     - ���������� ����� �� ������������� ������
  operatorId                  - ������������� ������������, ������������
                                �������� ( �� ��������� �������)

  ( <body::updateGoods>)
*/
procedure updateGoods(
  goodsId integer
  , supplierId integer
  , goodsName varchar2
  , goodsTypeCode varchar2
  , unitCode varchar2
  , purchasingPrice number
  , motivationTypeCode varchar2
  , goodsPhotoMimeType varchar2
  , goodsPhotoExtension varchar2
  , goodsPortfolioMimeType varchar2
  , goodsPortfolioExtension varchar2
  , operatorId integer := null
);

/* pproc: deleteGoods
  ������� �����.

  ���������:
  goodsId                     - Id ������
  operatorId                  - ������������� ������������, ������������
                                �������� ( �� ��������� �������)

  ( <body::deleteGoods>)
*/
procedure deleteGoods(
  goodsId integer
  , operatorId integer := null
);

/* pfunc: findGoods
  ����� ������.

  ���������:
  goodsIdList                 - Id ������ ( ������ ����� �������)
                                ( �� ��������� ��� �����������)
  supplierId                  - Id ����������
                                ( �� ��������� ��� �����������)
  goodsName                   - ������������ ������
                                ( ����� �� like ��� ����� ��������)
                                ( �� ��������� ��� �����������)
  goodsTypeCode               - ��� ���� ������
                                ( �� ��������� ��� �����������)
  goodsSegmentCodeList        - ��� �������� ������ ( ������ ����� �������)
                                ( �� ��������� ��� �����������)
  goodsCatalogIdList          - Id ������� �������� ( ������ ����� �������)
                                ( ��� ���� ����� ����������� ������,
                                  ����������� � ����������� �������� ��������)
                                ( �� ��������� ��� �����������)
  maxRowCount                 - ������������ ����� ������������ �������
                                ( �� ��������� ��� �����������)
  operatorId                  - ������������� ������������, ������������
                                �������� ( �� ��������� �������)

  ������� ( ������):
  goods_id                    - Id ������
  supplier_id                 - Id ����������
  supplier_name               - ������������ ����������
  goods_name                  - ������������ ������
  goods_type_code             - ��� ���� ������
  goods_type_name             - ������������ ���� ������
  unit_code                   - ��� ������� ���������
  unit_name                   - ������������ ������� ���������
  purchasing_price            - ���������� ����
  motivation_type_code        - ��� ���� ���������
  motivation_type_name        - ������������ ���� ���������
  goods_photo                 - ���������� ������
  goods_photo_mime_type       - MIME-��� ����� � ����������� ������
  goods_photo_extension       - ���������� ����� � ����������� ������
  goods_portfolio             - ������������ ������
  goods_portfolio_mime_type   - MIME-��� ����� �� ������������� ������
  goods_portfolio_extension   - ���������� ����� �� ������������� ������

  ���������:
  - ������������ ������ ������������� �� goods_name;

  ( <body::findGoods>)
*/
function findGoods(
  goodsIdList varchar2 := null
  , supplierId integer := null
  , goodsName varchar2 := null
  , goodsTypeCode varchar2 := null
  , goodsSegmentCodeList varchar2 := null
  , goodsCatalogIdList varchar2 := null
  , maxRowCount integer := null
  , operatorId integer := null
)
return sys_refcursor;

/* pfunc: getGoods
  ��������� ������ �������.

  ���������:
  goodsName                   - ������������ ������
                                ( ����� �� like ��� ����� ��������)
                                ( �� ��������� ��� �����������)
  maxRowCount                 - ������������ ����� ������������ �������
                                ( �� ��������� ��� �����������)

  ������� ( ������):
  goods_id                    - Id ������
  goods_name                  - ������������ ������

  ���������:
  - ������������ ������ ������������� �� goods_name;

  ( <body::getGoods>)
*/
function getGoods(
  goodsName varchar2 := null
  , maxRowCount integer := null
)
return sys_refcursor;



/* group: �������� ��� ������ */

/* pproc: createGoodsSegmentLink
  ��������� ������� ��� ������.

  ���������:
  goodsId                     - Id ������
  goodsSegmentCode            - ��� �������� ������
  operatorId                  - ������������� ������������, ������������
                                �������� ( �� ��������� �������)

  ( <body::createGoodsSegmentLink>)
*/
procedure createGoodsSegmentLink(
  goodsId integer
  , goodsSegmentCode varchar2
  , operatorId integer := null
);

/* pproc: deleteGoodsSegmentLink
  ������� ������� ��� ������.

  ���������:
  goodsId                     - Id ������
  goodsSegmentCode            - ��� �������� ������
  operatorId                  - ������������� ������������, ������������
                                �������� ( �� ��������� �������)

  ( <body::deleteGoodsSegmentLink>)
*/
procedure deleteGoodsSegmentLink(
  goodsId integer
  , goodsSegmentCode varchar2
  , operatorId integer := null
);

/* pfunc: getGoodsSegmentLink
  ���������� �������� ��� ������.

  ���������:
  goodsId                     - Id ������
  operatorId                  - ������������� ������������, ������������
                                �������� ( �� ��������� �������)

  ������� ( ������):
  goods_id                    - Id ������
  goods_segment_code          - ��� �������� ������
  goods_segment_name          - ������������ �������� ������

  ���������:
  - ������������ ������ ������������� �� goods_segment_name;

  ( <body::getGoodsSegmentLink>)
*/
function getGoodsSegmentLink(
  goodsId integer
  , operatorId integer := null
)
return sys_refcursor;



/* group: ������� �������� ��� ������ */

/* pproc: setGoodsCatalogLink
  ������������� ������� ��������, � ������� ��������� �����.

  ���������:
  goodsId                     - Id ������
  goodsCatalogIdList          - Id �������� ��������, � ������� ���������
                                ����� ( ������ ����� �������, null ���
                                ���������� ��������)
  operatorId                  - ������������� ������������, ������������
                                �������� ( �� ��������� �������)

  ( <body::setGoodsCatalogLink>)
*/
procedure setGoodsCatalogLink(
  goodsId integer
  , goodsCatalogIdList varchar2
  , operatorId integer := null
);

/* pfunc: getGoodsCatalog
  ���������� ������� �������� �������.

  ���������:
  parentGoodsCatalogId        - Id ������������� ������� ��������
                                 ( null ��� ��������� �������� �������� ������)
                                 ( �� ��������� null)
  goodsId                     - Id ������, ��� �������� ������������ ����������
                                �� ��������� � ��� �������� �������� �
                                ����� goods_link_flag �
                                descendant_goods_link_flag
                                ( null ���� ��� ���� �� �����������
                                  ( �� ��������� null))

  ������� ( ������):
  goods_catalog_id            - Id ������� ��������
  goods_catalog_name          - ������������ ������� ��������
  has_child_flag              - ���� ������� �������� �������� ��������
                                ( 1 ��, 0 ���)
  goods_link_flag             - ���� �������������� ���������� ������ �
                                ������� ��������
                                ( 1 ��, 0 ���, null ���� �� ������ goodsId)
  descendant_goods_link_flag  - ���� �������������� ���������� ������ �
                                ���������� ( �������) ������� ��������
                                ( 1 ��, 0 ���, null ���� �� ������ goodsId)

  ���������:
  - ������������ ������ ������������� �� goods_catalog_name;

  ( <body::getGoodsCatalog>)
*/
function getGoodsCatalog(
  parentGoodsCatalogId integer := null
  , goodsId integer := null
)
return sys_refcursor;



/* group: ����� � �������� */

/* pfunc: createShopGoods
  ������� ������ ��� ������ � ��������.

  ���������:
  shopId                      - Id ��������
  goodsId                     - Id ������
  goodsQuantity               - ���������� ������
  sellPrice                   - ��������� ����
  operatorId                  - ������������� ������������, ������������
                                �������� ( �� ��������� �������)

  �������:
  Id ��������� ������.

  ( <body::createShopGoods>)
*/
function createShopGoods(
  shopId integer
  , goodsId integer
  , goodsQuantity number
  , sellPrice number
  , operatorId integer := null
)
return integer;

/* pproc: updateShopGoods
  �������� ������ � ������ � ��������.

  ���������:
  shopGoodsId                 - Id ������ � ��������
  goodsQuantity               - ���������� ������
  sellPrice                   - ��������� ����
  operatorId                  - ������������� ������������, ������������
                                �������� ( �� ��������� �������)

  ( <body::updateShopGoods>)
*/
procedure updateShopGoods(
  shopGoodsId integer
  , goodsQuantity number
  , sellPrice number
  , operatorId integer := null
);

/* pproc: deleteShopGoods
  ������� ������ � ������ � ��������.

  ���������:
  shopGoodsId                 - Id ������ � ��������
  operatorId                  - ������������� ������������, ������������
                                �������� ( �� ��������� �������)

  ( <body::deleteShopGoods>)
*/
procedure deleteShopGoods(
  shopGoodsId integer
  , operatorId integer := null
);

/* pfunc: findShopGoods
  ����� ������ � ��������.

  ���������:
  shopGoodsId                 - Id ������ � ��������
                                ( �� ��������� ��� �����������)
  shopId                      - Id ��������
                                ( �� ��������� ��� �����������)
  goodsId                     - Id ������
                                ( �� ��������� ��� �����������)
  maxRowCount                 - ������������ ����� ������������ �������
                                ( �� ��������� ��� �����������)
  operatorId                  - ������������� ������������, ������������
                                �������� ( �� ��������� �������)

  ������� ( ������):
  shop_goods_id               - Id ������ � ��������
  shop_id                     - Id ��������
  shop_name                   - ������������ ��������
  goods_id                    - Id ������
  goods_name                  - ������������ ������
  goods_quantity              - ���������� ������
  sell_price                  - ��������� ����

  ���������:
  - ������������ ������ ������������� �� shop_name, goods_name;

  ( <body::findShopGoods>)
*/
function findShopGoods(
  shopGoodsId integer := null
  , shopId integer := null
  , goodsId integer := null
  , maxRowCount integer := null
  , operatorId integer := null
)
return sys_refcursor;



/* group: ������ �� ������� */

/* pfunc: createRequest
  ������� ������ �� �������.

  ���������:
  shopId                      - Id ��������
  goodsId                     - Id ������
  goodsQuantity               - ���������� ������
  operatorId                  - ������������� ������������, ������������
                                �������� ( �� ��������� �������)

  �������:
  Id ��������� ������.

  ( <body::createRequest>)
*/
function createRequest(
  shopId integer
  , goodsId integer
  , goodsQuantity number
  , operatorId integer := null
)
return integer;

/* pproc: updateRequest
  �������� ������ �� �������.

  ���������:
  requestId                   - Id �������
  requestStatusCode           - ��� ������� �������
  goodsId                     - Id ������
  goodsQuantity               - ���������� ������
  operatorId                  - ������������� ������������, ������������
                                �������� ( �� ��������� �������)

  ( <body::updateRequest>)
*/
procedure updateRequest(
  requestId integer
  , requestStatusCode varchar2
  , goodsId integer
  , goodsQuantity number
  , operatorId integer := null
);

/* pproc: deleteRequest
  ������� ������ �� �������.

  ���������:
  requestId                   - Id �������
  operatorId                  - ������������� ������������, ������������
                                �������� ( �� ��������� �������)

  ( <body::deleteRequest>)
*/
procedure deleteRequest(
  requestId integer
  , operatorId integer := null
);

/* pfunc: findRequest
  ����� ������� �� �������.

  ���������:
  requestId                   - Id �������
                                ( �� ��������� ��� �����������)
  shopId                      - Id ��������
                                ( �� ��������� ��� �����������)
  requestDateFrom             - ���� �������� �������, ��
                                ( � ��������� �� ���, ������������)
                                ( �� ��������� ��� �����������)
  requestDateTo               - ���� �������� �������, ��
                                ( � ��������� �� ���, ������������)
                                ( �� ��������� ��� �����������)
  requestStatusCode           - ��� ������� �������
                                ( �� ��������� ��� �����������)
  goodsId                     - Id ������
                                ( �� ��������� ��� �����������)
  maxRowCount                 - ������������ ����� ������������ �������
                                ( �� ��������� ��� �����������)
  operatorId                  - ������������� ������������, ������������
                                �������� ( �� ��������� �������)

  ������� ( ������):
  request_id                  - Id �������
  shop_id                     - Id ��������
  shop_name                   - ������������ ��������
  request_date                - ���� �������� �������
  request_status_code         - ��� ������� �������
  request_status_name         - ������������ ������� �������
  goods_id                    - Id ������
  goods_name                  - ������������ ������
  goods_quantity              - ���������� ������

  ���������:
  - ������������ ������ ������������� �� shop_name, request_id;

  ( <body::findRequest>)
*/
function findRequest(
  requestId integer := null
  , shopId integer := null
  , requestDateFrom date := null
  , requestDateTo date := null
  , requestStatusCode varchar2 := null
  , goodsId integer := null
  , maxRowCount integer := null
  , operatorId integer := null
)
return sys_refcursor;



/* group: ��������� ������� */

/* pfunc: createRequestProcess
  ������� ������ �� ��������� ������� �� �������.

  ���������:
  requestId                   - Id �������
  operatorId                  - ������������� ������������, ������������
                                �������� ( �� ��������� �������)

  �������:
  Id ��������� ������.

  ( <body::createRequestProcess>)
*/
function createRequestProcess(
  requestId integer
  , operatorId integer := null
)
return integer;

/* pproc: deleteRequestProcess
  ������� ������ �� ��������� ������� �� �������.

  ���������:
  requestProcessId            - Id ������ �� ��������� �������
  operatorId                  - ������������� ������������, ������������
                                �������� ( �� ��������� �������)

  ( <body::deleteRequestProcess>)
*/
procedure deleteRequestProcess(
  requestProcessId integer
  , operatorId integer := null
);

/* pfunc: findRequestProcess
  ����� ������� �� ��������� ������� �� �������.

  ���������:
  requestProcessId            - Id ������ �� ��������� �������
  requestId                    - Id �������
                                ( �� ��������� ��� �����������)
  dateInsFrom                 - ���� ���������� ������, ��
                                ( � ��������� �� ���, ������������)
                                ( �� ��������� ��� �����������)
  dateInsTo                   - ���� ���������� ������, ��
                                ( � ��������� �� ���, ������������)
                                ( �� ��������� ��� �����������)
  insertOperatorId            - ������������� ������������, ����������� ������
                                ( �� ��������� ��� �����������)
  maxRowCount                 - ������������ ����� ������������ �������
                                ( �� ��������� ��� �����������)
  operatorId                  - ������������� ������������, ������������ ��������
                                ( �� ��������� �������)

  ������� ( ������):
  request_process_id          - Id ������ �� ��������� �������
  process_comment             - ����������� � ��������� �������
  date_ins                    - ���� ���������� ������
  operator_id                 - ������������� ������������, ����������� ������
  operator_name               - ��� ������������, ����������� ������

  ���������:
  - ������������ ������ ������������� �� request_process_id;

  ( <body::findRequestProcess>)
*/
function findRequestProcess(
  requestProcessId integer := null
  , requestId integer := null
  , dateInsFrom date := null
  , dateInsTo date := null
  , insertOperatorId integer := null
  , maxRowCount integer := null
  , operatorId integer := null
)
return sys_refcursor;



/* group: ������ ����������� */

/* pproc: setFeatureWorkSequence
  ��������� ������� ���������� �������.

  ���������:
    featureId                 - ������������� ������� ����������
    workSequence              - ������� ���������� �������
    operatorId                - ������������� ������������, ������������
                                �������� ( �� ��������� �������)

  ( <body::setFeatureWorkSequence>)
*/
procedure setFeatureWorkSequence(
  featureId         integer
  , workSequence    integer
  , operatorId      integer
);

/* pfunc: createFeature
  ������ ������ ������� �����������.

  ���������:
  featureName                 - ������������ ������� ����������� �� �����
                                ��-���������
  featureNameEn               - ������������ ������� ����������� �� ����������
                                �����
  operatorId                  - ������������� ������������, ������������ ��������
                                ( �� ��������� �������)

  �������:
  - ������������� ��������� ������;

  ( <body::createFeature>)
*/
function createFeature(
  featureName     varchar2
  , featureNameEn varchar2
  , operatorId    integer
)
return integer;

/* pproc: updateFeature
  ��������� ������ ������� �����������.

  ���������:
  featureId                   - ������������� ������ ������� �����������
  featureName                 - ������������ ������� ����������� �� �����
                                ��-���������
  featureNameEn               - ������������ ������� ����������� �� ����������
                                �����
  operatorId                  - ������������� ������������, ������������
                                �������� ( �� ��������� �������)

  ( <body::updateFeature>)
*/
procedure updateFeature(
  featureId integer
  , featureName varchar2
  , featureNameEn varchar2
  , operatorId integer
);

/* pproc: deleteFeature
  ������� ������ ������� �����������.

  ���������:
  featureId                   - ������������� ������� ����������
  operatorId                  - ������������� ������������, ������������
                                �������� ( �� ��������� �������)

  ( <body::deleteFeature>)
*/
procedure deleteFeature(
  featureId    integer
  , operatorId integer
);

/* pproc: setFeatureResponsible
  ��������� �������������� �� ������.

  ���������:
  featureId                   - ������������� ������� ����������
  responsibleId               - ������������� ������������
  operatorId                  - ������������� ������������, ������������
                                �������� ( �� ��������� �������)

  ( <body::setFeatureResponsible>)
*/
procedure setFeatureResponsible(
  featureId         integer
  , responsibleId   integer
  , operatorId      integer
);

/* pfunc: findFeature
  ����� ������� ������� �����������.

  ���������:
  featureId                   - ������������� ������ ������� �����������
                                ( �� ��������� ��� �����������)
  featureName                 - ������������ ������� ����������� �� �����
                                ��-��������� ( �� ��������� ��� �����������)
  featureNameEn               - ������������ ������� ����������� �� ����������
                                ����� ( �� ��������� ��� �����������, ���
                                ������������� ������� ��������� featureName
                                ������������ ������� "���")
  workSequenceFrom            - ������� ���������� ������� ���
  workSequenceTo              - ������� ���������� ������� ���
  dateInsFrom                 - ���� ���������� ������, ��
                                ( � ��������� �� ���, ������������)
                                ( �� ��������� ��� �����������)
  dateInsTo                   - ���� ���������� ������, ��
                                ( � ��������� �� ���, ������������)
                                ( �� ��������� ��� �����������)
  authorId                    - ����� ������� (������������ ��������� ������)
  responsibleId               - id �������������� ������������
                                ( �� ��������� �������)
  featureStatusCodeList       - ������� �������� �� ���������� ����� �;� 
  maxRowCount                 - ������������ ���������� ������������ �������
                                ( �� ��������� ��� �����������)
  operatorId                  - ������������� ������������, ������������ ��������
                                ( �� ��������� �������)

  ������� ( ������):
  feature_id                  - ������������� ������� �����������
  work_sequence               - ������� ���������� �������
  feature_name                - ������������ ������� ����������� �� �����
                                ��-���������
  feature_name_en             - ������������ ������� ����������� �� ����������
                                �����
  feature_status_code         - ��� ������� ������� �� ����������
  feature_status_name         - ������������ ������� �������
  feature_status_name_en      - ������������ ������� ������� �� ����������
  responsible_id              - id �������������� ������������
  responsible_name            - ��� �������������� ������������
  responsible_name_en         - ��� �������������� ������������ �� ����������
                                �����
  description                 - �������� �������
  date_ins                    - ���� ���������� ������
  operator_id                 - ������������� ������������, ����������� ������
  operator_name               - ��� ������������, ����������� ������
  operator_name_en            - ��� ������������, ����������� ������ ��
                                ���������� �����

  ( <body::findFeature>)
*/
function findFeature(
  featureId                integer  := null
  , featureName            varchar2 := null
  , featureNameEn          varchar2 := null
  , workSequenceFrom       integer  := null
  , workSequenceTo         integer  := null
  , dateInsFrom            date     := null
  , dateInsTo              date     := null
  , authorId               integer  := null
  , responsibleId          integer  := null
  , featureStatusCodeList  varchar2 := null
  , maxRowCount            integer  := null
  , operatorId             integer  := null
)
return sys_refcursor;



/* group: ��������� ������� ����������� */

/* pproc: normalizeFeatureProcess
  ���������� ����� is_last ��� <jrs_feature_process>.

  ���������:
  featureId                   - ������������� ������ ������� ����������� (
                                ��-��������� ��� ���� �������)

  ( <body::normalizeFeatureProcess>)
*/
procedure normalizeFeatureProcess(
  featureId integer := null
);

/* pfunc: createFeatureProcess
  �������� ������ ��������� ������� �� ����������.

  ���������:
  featureId                   - id ������� �� ����������
  featureStatusCode           - ��� ������� ������� �� ����������
  operatorId                  - id ������������, ���������� ������

  ������������ ��������:
  - id ��������� ������ ��������� ������� �� ����������;

  ( <body::createFeatureProcess>)
*/
function createFeatureProcess(
  featureId         integer
, featureStatusCode varchar2
, operatorId        integer
)
return integer;

/* pproc: deleteFeatureProcess
  �������� ������ ��������� ������� �� ����������.

  ���������:
  featureProcessId            - id ������ ��������� ������� �� ����������
  operatorId                  - id ������������, ���������� ������

  ( <body::deleteFeatureProcess>)
*/
procedure deleteFeatureProcess(
  featureProcessId   integer
  , operatorId       integer
);

/* pfunc: findFeatureProcess
  ����� ������� ��������� ��������.

  ���������:
  featureProcessId            - id ������ ��������� �������
  featureStatusCode           - ������ ������� �� ����������
  featureId                   - id ������ �������
  maxRowCount                 - ������������ ���������� ��������� �������
  operatorId                  - ������������� ������������, ������������ ��������
                                ( �� ��������� �������)

  ������� ( ������):
  feature_process_id          - ������������� ������ ��������� �������
  feature_id                  - ������������� ������� �����������
  feature_status_code         - ��� ������� ������� �� ����������
  feature_status_name         - ������������ ������� �������
  feature_status_name_en      - ������������ ������� ������� �� ����������
  date_ins                    - ���� ���������� ������
  operator_id                 - ������������� ������������, ����������� ������
  operator_name               - ��� ������������, ����������� ������
  operator_name_en            - ��� ������������, ����������� ������ ��
                                ���������� �����

  ( <body::findFeatureProcess>)
*/
function findFeatureProcess(
  featureProcessId    integer  := null
  , featureStatusCode varchar2 := null
  , featureId         integer  := null
  , maxRowCount       integer  := null
  , operatorId        integer
)
return sys_refcursor;



/* group: ������������ �������� �� ���������� */

/* pfunc: createFeatureOperator
  �������� ������������ �������.

  ���������:
  featureOperatorId           - id ������������ �������� �� ����������
  operatorId                  - id ������������, ���������� ������

  �������:
  - id ������ ������������ ������� ( featureOperatorId);

  ( <body::createFeatureOperator>)
*/
function createFeatureOperator(
  featureOperatorId integer
, operatorId        integer
)
return integer;

/* pproc: deleteFeatureOperator
  �������� ������������ ������� �� ����������.

  ���������:
  featureOperatorId           - id ������������ �������� �� ����������
  operatorId                  - id ������������, ���������� ������

  ( <body::deleteFeatureOperator>)
*/
procedure deleteFeatureOperator(
  featureOperatorId integer
, operatorId        integer
);

/* pfunc: findFeatureOperator
  ����� ������������� ������� �� ����������.

  ���������:
  featureOperatorId           - id ������������ �������� �� ����������
  featureOperatorName         - ��� ������������ ���������� ����������
  operatorId                  - id ������������, ������������ �����

  ������� ( ������):
  feature_operator_id         - id ������������ �������� �� ����������
  feature_operator_name       - ��� ������������ �������� �� ����������
  feature_operator_name_en    - ��� ������������ �������� �� ���������� ��
                                ����� ��-���������
  date_ins                    - ���� �������� ������
  operator_id                 - id ������������, ���������� ������
  operator_name               - ��� ������������ �� ����� ��-���������,
                                ���������� ������
  operator_name_en            - ��� ������������, ���������� ������, ��
                                ���������� �����

  ( <body::findFeatureOperator>)
*/
function findFeatureOperator(
  featureOperatorId   integer  := null
, featureOperatorName varchar2 := null
, maxRowCount         integer  := null
, operatorId          integer
)
return sys_refcursor;



/* group: ����������� */

/* pfunc: getBank
  ���������� ������ ������.

  ���������:
  bankBic                     - ���������� ����������������� ��� ( ���)
                                ( ����� �� like, �� ��������� ��� �����������)
  maxRowCount                 - ������������ ����� ������������ �������
                                ( �� ��������� ��� �����������)

  ������� ( ������):
  bic                         - ���������� ����������������� ��� ( ���)
  bankname                    - ������������ �����
  ks                          - �������

  ���������:
  - ������������ ������ ������������� �� bankname;

  ( <body::getBank>)
*/
function getBank(
  bankBic varchar2 := null
  , maxRowCount integer := null
)
return sys_refcursor;

/* pfunc: getFeatureStatus
  ��������� ������ �������� ������� �� ����������.

  ������� ( ������):
  feature_status_code         - ��� ������� ������� �� ����������
  feature_status_name         - ������������ ������� �������
  feature_status_name_en      - ������������ ������� ������� �� ����������

  ( <body::getFeatureStatus>)
*/
function getFeatureStatus
return sys_refcursor;

/* pfunc: getGoodsSegment
  ���������� �������� �������.

  ������� ( ������):
  goods_segment_code          - ��� �������� ������
  goods_segment_name          - ������������ �������� ������

  ���������:
  - ������������ ������ ������������� �� goods_segment_name;

  ( <body::getGoodsSegment>)
*/
function getGoodsSegment
return sys_refcursor;

/* pfunc: getGoodsType
  ���������� ���� �������.

  ������� ( ������):
  goods_type_code           - ��� ���� ������
  goods_type_name           - ������������ ���� ������

  ���������:
  - ������������ ������ ������������� �� goods_type_name;

  ( <body::getGoodsType>)
*/
function getGoodsType
return sys_refcursor;

/* pfunc: getMotivationType
  ���������� ���� ���������.

  ������� ( ������):
  motivation_type_code        - ��� ���� ���������
  motivation_type_name        - ������������ ���� ���������
  motivation_type_comment     - ����������� ��� ���� ���������

  ���������:
  - ������������ ������ ������������� �� motivation_type_name;

  ( <body::getMotivationType>)
*/
function getMotivationType
return sys_refcursor;

/* pfunc: getRequestStatus
  ���������� ������� ������� �� �������.

  ������� ( ������):
  request_status_code         - ��� ������� �������
  request_status_name         - ������������ ������� �������

  ���������:
  - ������������ ������ ������������� �� request_status_name;

  ( <body::getRequestStatus>)
*/
function getRequestStatus
return sys_refcursor;

/* pfunc: getShop
  ���������� ��������.

  ���������:
  shopName                    - ������������ ��������
                                ( ����� �� like ��� ����� ��������)
                                ( �� ��������� ��� �����������)
  maxRowCount                 - ������������ ����� ������������ �������
                                ( �� ��������� ��� �����������)

  ������� ( ������):
  shop_id                     - Id ��������
  shop_name                   - ������������ ��������

  ���������:
  - ������������ ������ ������������� �� shop_name;

  ( <body::getShop>)
*/
function getShop(
  shopName varchar2 := null
  , maxRowCount integer := null
)
return sys_refcursor;

/* pfunc: getUnit
  ���������� ������� ���������.

  ������� ( ������):
  unit_code                   - ��� ������� ���������
  unit_short_name             - ������� ������������ ������� ���������
  unit_name                   - ������������ ������� ���������

  ���������:
  - ������������ ������ ������������� �� unit_name;

  ( <body::getUnit>)
*/
function getUnit
return sys_refcursor;

end pkg_JepRiaShowcase;
/
