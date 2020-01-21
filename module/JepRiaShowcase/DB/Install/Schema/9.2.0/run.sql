-- script: Install/Schema/9.2.0/run.sql
-- ���������� �������� ����� �� ������ 9.2.0.
--
-- �������� ���������:
--  - ���������� ������� <jrs_feature_status>;
--  - ���������� ������� <jrs_feature_process>;
--  - ���������� ������� <jrs_feature_operator>;
--  - ���������� ���� responsible_id � <jrs_feature>
--

-- ���������� ��������� ������������ ��� ��������
@oms-set-indexTablespace.sql

@oms-run jrs_feature.sql


@oms-run Install/Schema/Last/jrs_feature_status.tab
@oms-run Install/Schema/Last/jrs_feature_process.tab
@oms-run Install/Schema/Last/jrs_feature_operator.tab


@oms-run Install/Schema/Last/jrs_feature_status.con
@oms-run Install/Schema/Last/jrs_feature_process.con
@oms-run Install/Schema/Last/jrs_feature_operator.con


@oms-run Install/Schema/Last/jrs_feature_process_seq.sqs
