-- script: DB\Install\Schema\9.2.0\revert.sql
-- �������� ��������� � �������� �����, ��������� ��� ��������� ������ 1.1.0.
--


-- �������

drop table jrs_feature_process
/
drop table jrs_feature_operator
/
drop table jrs_feature_status
/

drop sequence jrs_feature_process_seq
/

@oms-run Install/Schema/9.2.0/Revert/jrs_feature.sql
