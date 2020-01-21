-- script: db/install/data/last/op_role.sql
declare

  -- ����� ��������� �����
  nChanged integer := 0;

  /*
    ���������� ��� ���������� ����.
  */
  function mergeRoleLegacy(
    roleShortName varchar2
  , roleName      varchar2
  , roleNameEn    varchar2
  , description   varchar2
  )
  return integer
  is
    roleId integer;
    mergeRoleResult integer;
  begin
    execute immediate
    '
    select
      min( t.role_id)
    from
      op_role t
    where
      t.short_name = :shortName
    '
    into roleId
    using
      roleShortName
    ;
    if roleId is null then
      execute immediate
      '
    begin
      :roleId := pkg_Operator.createRole(
        roleName      => :roleName
        , roleNameEn  => :roleNameEn
        , shortName   => :shortName
        , description => :description
        , operatorId  => pkg_Operator.getCurrentUserId()
      );
    end;
      '
      using
        out roleId
        , in roleName
        , in roleNameEn
        , in roleShortName
        , in description
      ;
      dbms_output.put_line(
        'role created: ' || roleShortName || ' ( role_id=' || roleId || ')'
      );
      mergeRoleResult := 1;
    else
      mergeRoleResult := 0;
    end if;
    return mergeRoleResult;
  end mergeRoleLegacy;

  /*
    ���������� ��� ���������� ����.
  */
  function mergeRole(
    roleShortName varchar2
  , roleName      varchar2
  , roleNameEn    varchar2
  , description   varchar2
  )
  return integer
  is
    mergeResult integer;
  begin
    execute immediate
      '
      begin
        :mergeResult :=
pkg_AccessOperator.mergeRole(
  roleShortName => :roleShortName
  , roleName    => :roleName
  , roleNameEn  => :roleNameEn
  , description => :description
);
      end;'
    using
      out mergeResult
      , in roleShortName
      , in roleName
      , in roleNameEn
      , in description
    ;
    return mergeResult;
  exception when others then
    return
      mergeRoleLegacy(
      roleShortName => roleShortName
    , roleName      => roleName
    , roleNameEn    => roleNameEn
    , description   => description
      );
  end mergeRole;

-- main
begin
  nChanged :=
  mergeRole(
    roleShortName => 'JrsEditFeature'
    , roleName    =>
        'ITM: ���������� ������ ��������� �� ����� ����������'
    , roleNameEn  =>
        'ITM: Own feature request management'
    , description =>
        '������������ � ������ ����� ����� ������ � ����������� ���������� ������ ��������� �� ����� ����������'
  )
  +
  mergeRole(
    roleShortName => 'JrsEditAllFeature'
    , roleName    =>
        'ITM: ���������� ����� ��������� �� ����� ����������'
    , roleNameEn  =>
        'ITM: All feature request management'
    , description =>
        '������������ � ������ �����, ����� ������ � ����������� ���������� ����� ��������� �� ����� ����������'
  )
  +
  mergeRole(
    roleShortName => 'JrsAssignResponsibleFeature'
    , roleName    =>
        'ITM: ���������� �������������� �� ������ �� ����� ����������'
    , roleNameEn  =>
        'ITM: Assign responsible for feature request'
    , description =>
        '������������ � ������ ����� ����� ��������� �������������� �� ������ �� ����� ����������'
  )
  +
  mergeRole(
    roleShortName => 'JrsAssignWorkSequenceFeature'
    , roleName    =>
        'ITM: ���������� ������� ���������� ������ �� ����� ����������'
    , roleNameEn  =>
        'ITM: Assign work sequence for feature request'
    , description =>
        '������������ � ������ ����� ����� ��������� ������� ���������� ������� �� ����� ����������'
  )
  +
  mergeRole(
    roleShortName => 'JrsOperatorFeature'
    , roleName    =>
        'ITM: �������� ������������� �������� �� ����� ����������'
    , roleNameEn  =>
        'ITM: Setup operators for feature request'
    , description =>
        '������������ � ������ ����� ����� ��������� �������������  �������� �� ����� ���������� (�� ��������� ���� ������������� �������)'
  )
  +
  mergeRole(
    roleShortName => 'JrsEditGoods'
    , roleName    =>
        'JepRiaShowcase: �������������� ������ �� �������'
    , roleNameEn  =>
        'JepRiaShowcase: Access to edit goods data'
    , description =>
        '������������ � ������ ����� ����� �������� � ������� � �������'
  )
  +
  mergeRole(
    roleShortName => 'JrsEditRequest'
    , roleName    =>
        'JepRiaShowcase: �������������� ������ �� �������� �� �������'
    , roleNameEn  =>
        'JepRiaShowcase: Access to edit goods data'
    , description =>
        '������������ � ������ ����� ����� �������� � ������� �� �������� �� �������'
  )
  +
  mergeRole(
    roleShortName => 'JrsEditRequestProcess'
    , roleName    =>
        'JepRiaShowcase: �������������� ������ �� ��������� �������� �� �������'
    , roleNameEn  =>
        'JepRiaShowcase: Access to edit goods data'
    , description =>
        '������������ � ������ ����� ����� �������� � ������� �� ��������� �������� �� �������'
  )
  +
  mergeRole(
    roleShortName => 'JrsEditShopGoods'
    , roleName    =>
        'JepRiaShowcase: �������������� ������ �� ������� � ���������'
    , roleNameEn  =>
        'JepRiaShowcase: Access to edit data about goods in shop'
    , description =>
        '������������ � ������ ����� ����� �������� � ������� �� ������� � ���������'
  )
  +
  mergeRole(
    roleShortName => 'JrsEditSupplier'
    , roleName    =>
        'JepRiaShowcase: �������������� ������ �� �����������'
    , roleNameEn  =>
        'JepRiaShowcase: Access to edit suppliers data'
    , description =>
        '������������ � ������ ����� ����� �������� � ������� � �����������'
  );
  dbms_output.put_line(
    'roles changed: ' || nChanged || ')'
  );
  commit;
end;
/
