-- script: Install/Schema/10.1.0/Revert/jrs_feature.sql
-- �������������� ������� <jrs_feature>.


-- �������� ����

alter table
  jrs_feature
drop (
  work_sequence
)
/