-- script: Install/Schema/10.2.0/Revert/jrs_feature_status.sql
-- �������������� ������� <jrs_feature_status>.


-- �������� ����

alter table
  jrs_feature_status
drop (
  status_order
)
/
