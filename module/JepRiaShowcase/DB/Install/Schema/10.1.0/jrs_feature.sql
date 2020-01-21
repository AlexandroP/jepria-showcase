-- script: Install/Schema/10.1.0/jrs_feature.sql
-- �������������� ������� <jrs_feature>.


-- ���������� ����

alter table
  jrs_feature
add (
  work_sequence integer
)
/


-- ���������� ����������� � ����

comment on column jrs_feature.work_sequence is
  '������� ���������� �������'
/


-- ������ ��� ���������� ������������ �� ������� ���������� �������.
-- index: jrs_feature_ux_work_sequence

create unique index
  jrs_feature_ux_work_sequence
on
  jrs_feature(
    work_sequence
  )
tablespace &indexTablespace
/