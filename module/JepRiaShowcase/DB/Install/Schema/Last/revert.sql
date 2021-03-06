-- script: Install/Schema/Last/revert.sql
-- �������� ��������� ������, ������ ��������� ������� �����.


-- ������

drop package pkg_JepRiaShowcase
/


-- �������������

drop view v_bic_bank
/
drop view v_jrs_feature_lob
/


-- ������� �����

@oms-drop-foreign-key jrs_bic_bank
@oms-drop-foreign-key jrs_feature
@oms-drop-foreign-key jrs_feature_operator
@oms-drop-foreign-key jrs_feature_process
@oms-drop-foreign-key jrs_feature_status
@oms-drop-foreign-key jrs_goods
@oms-drop-foreign-key jrs_goods_catalog
@oms-drop-foreign-key jrs_goods_catalog_link
@oms-drop-foreign-key jrs_goods_segment
@oms-drop-foreign-key jrs_goods_segment_link
@oms-drop-foreign-key jrs_goods_type
@oms-drop-foreign-key jrs_motivation_type
@oms-drop-foreign-key jrs_request
@oms-drop-foreign-key jrs_request_process
@oms-drop-foreign-key jrs_request_status
@oms-drop-foreign-key jrs_shop
@oms-drop-foreign-key jrs_shop_goods
@oms-drop-foreign-key jrs_supplier
@oms-drop-foreign-key jrs_unit


-- �������

drop table jrs_bic_bank
/
drop table jrs_feature
/
drop table jrs_feature_operator
/
drop table jrs_feature_process
/
drop table jrs_feature_status
/
drop table jrs_goods
/
drop table jrs_goods_catalog
/
drop table jrs_goods_catalog_link
/
drop table jrs_goods_segment
/
drop table jrs_goods_segment_link
/
drop table jrs_goods_type
/
drop table jrs_motivation_type
/
drop table jrs_request
/
drop table jrs_request_process
/
drop table jrs_request_status
/
drop table jrs_shop
/
drop table jrs_shop_goods
/
drop table jrs_supplier
/
drop table jrs_unit
/


-- ������������������

drop sequence jrs_feature_process_seq
/
drop sequence jrs_feature_seq
/
drop sequence jrs_goods_catalog_seq
/
drop sequence jrs_goods_seq
/
drop sequence jrs_request_process_seq
/
drop sequence jrs_request_seq
/
drop sequence jrs_shop_goods_seq
/
drop sequence jrs_shop_seq
/
drop sequence jrs_supplier_seq
/
