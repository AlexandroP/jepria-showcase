-- script: Install/Schema/10.2.0/jrs_feature_status.sql
-- �������������� ������� <jrs_feature_status>.


-- ���������� ����

alter table
  jrs_feature_status
add (
  status_order                  integer             default 0       not null
)
/


-- ���������� ����������� � ����

comment on column jrs_feature_status.status_order is
  '���� ��� �������������� ������� �������� (� ����� ������ � ������� ���������� ��������)'
/

