-- script: DB\Install\Schema\10.2.0\revert.sql
-- �������� ��������� ��������� � ������, ��������� ��� ��������� ������ 10.2.0.

@oms-run Install/Data/10.2.0/Revert/upd_jrs_feature_process.sql
@oms-run Install/Data/10.2.0/Revert/jrs_feature_status.sql
