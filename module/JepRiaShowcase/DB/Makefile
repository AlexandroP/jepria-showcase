# makefile: ������

# ������� ������ OMS-������
omsModuleDir = OmsModule

# �������� ����������� ������� ������ �������
include $(omsModuleDir)/init.mk

# ����������� ����
.PHONY:                 \
  all                   \
  clean                 \
  set-version           \
  show-oms-version      \
  update-oms-version    \
  gendoc                \
  gendoc-clean          \
  gendoc-menu           \
  grant-exec            \
  grant-save-info       \
  grant                 \
  load                  \
  load-clean            \
  install               \
  install-after         \
  install-batch         \
  install-before        \
  install-data          \
  install-load          \
  install-save-info     \
  install-schema        \
  install-test          \
  test                  \
  uninstall             \
  uninstall-after       \
  uninstall-before      \
  uninstall-data        \
  uninstall-load        \
  uninstall-save-info   \
  uninstall-schema      \



#
# group: ����� ����
#

# target: all
# ������� �������� ������.

all: all.oms



# target: clean
# ������� �����, ��������� ��� ������.

clean: clean.oms



#
# group: ������ ������
#

# build var: MODULE_VERSION
# ����� ������� ������ ������.
# ������ ���� ���� ����� ��� ������������� ���� <set-version>.
# ���� �� ����� ����, �� ��� ���������� �����, ���������� � ��, �������������
# ������������ �� �������� ���� version � map-����� ( Doc/map.xml). ��� ����
# � ������, ���� � <INSTALL_VERSION> ������� ����� ������� ������, ��� �
# map-�����, � ��� ������������ � ������ ( ���� ��������������� ����������� �
# ����� DB/Install ��� ��������������� � DB/Doc/version.txt), �� ������
# ������ ������������� ��������������� � ��������, ��������� �
# <INSTALL_VERSION> ( ��� ���� �������� ��������� ����� ������, ����������
# ���������� ���� <set-version>).
#
MODULE_VERSION =



# target: set-version
# ������������� ����� ������� ������ ������.
# ����� ����� ������ ����������� � ��������� <MODULE_VERSION>. ��� ���������
# ������ ����������� �������� ���� version � map-����� ( Doc/map.xml) � ����
# SubTitle � ���� ������������ ( DB/OmsModule/NaturalDocs/Menu.txt).  �����
# ����� ����� ������������ � ���� ������������ ����� �� ���������� ( ��������,
# �������� 'make gendoc').
#

set-version: set-version.oms



#
# group: ������ OMS-������
#

# target: show-oms-version
# ���������� ������ OMS-������, �������� � ������ ������.
#
# ���� �� ����� ��������� ������������ ������������� ������
# ������� OMS ������, ��� ���� ���������� ����� ���������� ������,
# ����� ��������� �������:
# (code)
#    oms-load --version
# (end code)
#
# � ������, ���� ������ ( ������, �.�. �������) OMS ������,
# ��� ������ OMS-������ ������, ��� ������ � �������
# ������������� �������� ( ����������) OMS.
#
# ���� ������ ( ������) OMS ������, ��� ����������
# ������������� �������� ������ OMS-������, �������� � ������
# ������ � ������� <oms-update-module>.
#

show-oms-version: show-oms-version.oms



# target: update-oms-version
# ��������� OMS-�����, �������� � ������ ������.

update-oms-version: update-oms-version.oms



#
# group: ��������� ������������
#

# build var: GENDOC_DB_DIR
# ������� ��� ��������� ������������ �� DB-����� �������.
GENDOC_DB_DIR      = ../Doc/DB/AutoGen

# build var: GENDOC_DB_FLAGS
# �������������� ��������� ��������� ������������.
GENDOC_DB_FLAGS    =


# target: gendoc
# ���������� ������������.

gendoc: gendoc.oms



# target: gendoc-clean
# ������� ��������� ����� ( ���) ������� ����������������.

gendoc-clean: gendoc-clean.oms



# target: gendoc-menu
# ���������� ���� � ������������.

gendoc-menu: gendoc-menu.oms



#
# group: �������� ������ � ��
#

# build var: NLS_LANG
# ��������� ������, ������������ ��� �������� ������ � ��.
export NLS_LANG = AMERICAN_CIS.CL8MSWIN1251

# build var: PLSQL_WARNINGS
# ������ �������������� ����������� PL/SQL.
# ������������� ��������� plsql_warnings ������ Oracle.
#
# ������ ��������: "ENABLE:SEVERE"
#
PLSQL_WARNINGS =

# build var: LOAD_DB
# �� ��� ��������.
LOAD_DB =

# build var: LOAD_USERID
# ������������ ��� �������� ( ������: [userName[/password]][@dbName]).
#
# ����� ��������� � ������ ������������ � <LOAD_DB>.
LOAD_USERID =

# ������������ �� ��� �������� �� ������������ ��� ��������.
override LOAD_DB := $(call getDbName,$(LOAD_USERID),$(LOAD_DB))

# build var: LOAD_DB2
# �� ��� �������� #2.
LOAD_DB2 =

# build var: LOAD_USERID2
# ������������ ��� �������� #2 ( ������: [userName[/password]][@dbName]).
#
# ����� ��������� � ������ ������������ � <LOAD_DB2>.
LOAD_USERID2 =

# ������������ �� ��� �������� �� ������������ ��� ��������.
override LOAD_DB2 := $(call getDbName,$(LOAD_USERID2),$(LOAD_DB2))

# build var: LOAD_DB3
# �� ��� �������� #3.
LOAD_DB3 =

# build var: LOAD_USERID3
# ������������ ��� �������� #3 ( ������: [userName[/password]][@dbName]).
#
# ����� ��������� � ������ ������������ � <LOAD_DB3>.
LOAD_USERID3 =

# ������������ �� ��� �������� �� ������������ ��� ��������.
override LOAD_DB3 := $(call getDbName,$(LOAD_USERID3),$(LOAD_DB3))

# build var: LOAD_DB4
# �� ��� �������� #4.
LOAD_DB4 =

# build var: LOAD_USERID4
# ������������ ��� �������� #4 ( ������: [userName[/password]][@dbName]).
#
# ����� ��������� � ������ ������������ � <LOAD_DB4>.
LOAD_USERID4 =

# ������������ �� ��� �������� �� ������������ ��� ��������.
override LOAD_DB4 := $(call getDbName,$(LOAD_USERID4),$(LOAD_DB4))

# build var: LOAD_DB5
# �� ��� �������� #5.
LOAD_DB5 =

# build var: LOAD_USERID5
# ������������ ��� �������� #5 ( ������: [userName[/password]][@dbName]).
#
# ����� ��������� � ������ ������������ � <LOAD_DB5>.
LOAD_USERID5 =

# ������������ �� ��� �������� �� ������������ ��� ��������.
override LOAD_DB5 := $(call getDbName,$(LOAD_USERID5),$(LOAD_DB5))

# build var: LOAD_DB6
# �� ��� �������� #6.
LOAD_DB6 =

# build var: LOAD_USERID6
# ������������ ��� �������� #6 ( ������: [userName[/password]][@dbName]).
#
# ����� ��������� � ������ ������������ � <LOAD_DB6>.
LOAD_USERID6 =

# ������������ �� ��� �������� �� ������������ ��� ��������.
override LOAD_DB6 := $(call getDbName,$(LOAD_USERID6),$(LOAD_DB6))

# build var: LOAD_DB7
# �� ��� �������� #7.
LOAD_DB7 =

# build var: LOAD_USERID7
# ������������ ��� �������� #7 ( ������: [userName[/password]][@dbName]).
#
# ����� ��������� � ������ ������������ � <LOAD_DB7>.
LOAD_USERID7 =

# ������������ �� ��� �������� �� ������������ ��� ��������.
override LOAD_DB7 := $(call getDbName,$(LOAD_USERID7),$(LOAD_DB7))

# build var: LOAD_DB8
# �� ��� �������� #8.
LOAD_DB8 =

# build var: LOAD_USERID8
# ������������ ��� �������� #8 ( ������: [userName[/password]][@dbName]).
#
# ����� ��������� � ������ ������������ � <LOAD_DB8>.
LOAD_USERID8 =

# ������������ �� ��� �������� �� ������������ ��� ��������.
override LOAD_DB8 := $(call getDbName,$(LOAD_USERID8),$(LOAD_DB8))

# build var: LOAD_DB9
# �� ��� �������� #9.
LOAD_DB9 =

# build var: LOAD_USERID9
# ������������ ��� �������� #9 ( ������: [userName[/password]][@dbName]).
#
# ����� ��������� � ������ ������������ � <LOAD_DB9>.
LOAD_USERID9 =

# ������������ �� ��� �������� �� ������������ ��� ��������.
override LOAD_DB9 := $(call getDbName,$(LOAD_USERID9),$(LOAD_DB9))



# build var: LOAD_OPERATORID
# �������� ��� �������� ( ������: operatorName[/password] ).
#
# � ������ ������� ��������, ����� ����� ����������� ������������
# ����������� ��������� ( ����� ������ Operator) � ��.
# �� ��������� ������������ �������� ���������� ��������� ORACLE_OPERATOR
# ( ���� ����).
LOAD_OPERATORID := $(ORACLE_OPERATOR)



# build var: LOCAL_DB_DIR
# ��� ����������� ��� �������� ��������� ��������, ����������� � ������������
# ��.
# ������������ ������������� �� ������ �������� ��������� <LOAD_DB9>
# ( <LOAD_USERID9>).
LOCAL_DB_DIR = $(call getProductionDbName,$(LOAD_DB9))

# ������������ ���������� �������� ����������
override LOCAL_DB_DIR := $(call getLocalDbDir,$(LOCAL_DB_DIR))

# build var: LOCAL_USER_DIR
# ������������ ����������� ��� �������� ��������� ��������, ����������� �
# ������������� ������������ �� ( ������: dbDirName/userDirName).
# ������������ ������������� �� ������ �������� ���������� <LOCAL_DB_DIR> �
# <LOAD_USERID9>.
#
LOCAL_USER_DIR = \
  $(addsuffix /$(call getUserName,$(LOAD_USERID9)),$(LOCAL_DB_DIR))

# ������������ ���������� �������� ����������
override LOCAL_USER_DIR := $(call getLocalUserDir,$(LOCAL_USER_DIR))



# build var: SQL_DEFINE
# ������ �������� ��� ���������� SQL*Plus.
#
# ���������� ��������� �������� define ����� ��������� ������� �����.
# ������ ����������� � ������� name=value[,name2=value2]..., ��� �������������
# ����������� ����� �������������� �������� ����, ��� ������� �������� �����
# ��������� ������ � �������. ������� � ����� �����, � ����� ��������� �
# �������� ������� � ����� ��������, ������������, ��� ���������� ���������
# ��� �������� �������� � �������� ����� ������������ ������� ( ��������,
# SQL_DEFINE="name1 = \"a \, b\", name2 =c" ������ ���������� name1 �� ���������
# "a , b"  � ���������� name2 �� ��������� "c").
SQL_DEFINE =

# build var: SKIP_FILE_MASK
# ����� ��� ���������� ���������� ( ��������) ������ � ��.
#
# ������������ ����� ������ ( ����� �������) ����� �� ���� � ������
# ������������ �������� DB ( ����� ������������ ����������� "*" � "?").
# �����, ��������������� �����, �� ����������� ( �� �����������) � ��.
SKIP_FILE_MASK :=

# build var: FILE_MASK
# ����� ��� ���������� ( ��������) ������ � ��.
#
# ������������ ����� ������ ( ����� �������) ����� �� ���� � ������
# ������������ �������� DB ( ����� ������������ ����������� "*" � "?").
# � ������ ������� �����, �� ��������������� �����, �� ����������� ( ��
# �����������) � ��.
FILE_MASK :=


# build var: LOAD_FILE_MASK
# ����� ��� ����������� ����������� �� ���� load ������.
#
# ������������ ����� ������ ( ����� �������) ����� �� ���� � ����������� ������
# ������������ �������� DB ( ����� ������������ ����������� "*" � "?").
# ���� ����� ������, �� �����, ������� ������ ����������� �� ���� load � ��
# ��������������� ������, ��� �������� ������������.
LOAD_FILE_MASK :=

# ����� ��� ��������
loadTarget =                             \
  $(addsuffix .$(lu),                    \
    $(wildcard Install/Schema/Last/*.vw) \
    $(wildcard Install/Schema/Last/*.trg) \
    $(wildcard *.typ *.pks *.tyb *.pkb) \
  )                                      \
  $(addsuffix .$(lu2),                  \
  )                                      \
  $(addsuffix .$(lu3),                  \
  )                                      \

# ������ ���������� ��� ����������� ������.
#
# ��� ��������� �������� ���������� ��� ��������/���������� ���������� �����
# � ������ ����� �������� ������ ����
#   $(call getArgumentDefine,<filePath>.$([l,r]u*),"arg1"[ "arg2"]...)
# ��� filePath - ���� � ����� ������������ �������� DB ( � ������ ��������,
# ����� ������������ �����������).
# � ������� ��������������� ���������� ( ��������, $(lu2)) ������������ �����
# � ��� ��������, ��� ������� ������������ ��������� ( ���� ��� �����, �� �����
# ������� *).
loadArgumentList +=



# target: load
# ��������� ����� � ��.

load: load.oms



# target: load-clean
# ������� ��������� �����, ��������� ��� �������� � ��.

load-clean: load-clean.oms



#
# group: ��������� ������ � ��
#

# build var: INSTALL_VERSION
# ������ ������ ��� ��������� � ��.
# ��� �������������� ��������� ������ � �� ������ ����������� �������� "Last".
INSTALL_VERSION  =

# ������ �������������� ���������� ���������, ������������ � ������.
# ������������ ���������� � ���� ��������� �������� �������������� ����������
# ( � ������ ������� � ��� �������� ��������).
# ������: ������ ���� ���������� � �������� � �������� �����������.
installAddonOptionList =


# ������ �������� ��� ������������ �������� ���������� ����� ���������� �
# ������� ���������.
# ������ ������ ����� ��, ��� � loadTarget.
mandatoryCheckLockTarget = op_operator.tab



# ������ �������� ��� �������� ���������� ���������� ����� ����������.
# �� ������ ������������� ����������� �����, �� ����������� ��-�� ��������
# ���������� FILE_MASK, LOAD_FILE_MASK � SKIP_FILE_MASK.
# ������ ������ ����� ��, ��� � loadTarget.
installCheckLockTarget =                      \
  $(loadTarget)                               \

# ����������� ��������, ����������� ����� ����������.
# �������� ����������� ���������, ��������� � OMS.
# �������� ���������� �� ������ ���������� � ������ ( � ������ �������������
# ����� ������� ������������� ���� ���������� �� installBeforeTarget � ���������
# ��� ������� ����������� ����������� ��������).
installBeforeOmsAction =                      \
  oms-check-lock.sql                          \
  oms-show-invalid.sql                        \



# ��������, ����������� ����� ���������� ������.
installBeforeTarget =                          \
  $(addsuffix .$(ru),                          \
    $(if $(INSTALL_VERSION), \
      $(wildcard Install/Config/$(INSTALL_VERSION)/before-action.sql),) \
    $(wildcard Install/Config/before-action.sql)      \
    $(installBeforeOmsAction)                  \
  )                                            \
  $(addsuffix .$(ru2),                        \
    $(installBeforeOmsAction)                  \
  )                                            \
  $(addsuffix .$(ru3),                        \
    $(installBeforeOmsAction)                  \
  )                                            \



# target: install-before
# ��������� ��������������� �������� ����� ����������.

install-before: install-before.oms



# ������� ��� ���������� ��������� �����
installSchemaTarget =                   \
  $(addsuffix .$(lu),                    \
    $(wildcard Install/Schema/$(INSTALL_VERSION)/run.sql)      \
  )                                      \
  $(addsuffix .$(lu2),                  \
    $(wildcard Install/Schema/$(INSTALL_VERSION)/Dba/run.sql)      \
  )                                      \
  $(addsuffix .$(lu3),                  \
  )                                      \



# target: install-schema
# ������������� ������� ����� � ��.
# ��� ���������� ���������/���������� �������� ����� ����������� ������� ��
# �������� Install/Schema/$(INSTALL_VERSION).

install-schema: install-schema.oms



# target: install-load
# ��������� ������� � �� ��� ���������� ���������.
# ������ ����������� �������� ����� ��, ��� ��� ���� load ( ������� ��
# ���������� loadTarget).

install-load: install-load.oms



# �������� ��� �������� ������������ ������.
# ������ ����������� ������ �� �������� Install/Data/Last. ������������� ���
# ��������� ���������� ( INSTALL_VERSION=N.N.N) ����������� ������ �� ��������
# Install/Data/N.N.N, ��� �������������� ��������� ��������� ������
# ( INSTALL_VERSION=Last) ����������� ������ �� ���� ��������� ����������
# ( Install/Data/[0-9.]*) � ������� ��������� ������.
#
installDataDir = \
  $(wildcard Install/Data/Last) \
  $(if $(INSTALL_VERSION), \
    $(if $(call nullif,$(call upper,$(INSTALL_VERSION)),LAST), \
      $(wildcard Install/Data/$(INSTALL_VERSION)) \
      , $(call getVersionDir,Install/Data) \
    ) \
  )



# build func: getInstallDataFile
# ���������� ����� ��� �������� ������������ ������.
#
# ���������:
# $(1)    - �������� ����������� � �������� �������� ��������, ������ �������
#           ����� ��� �������� ( �� ��������� �� ��������� ��������)
#
# ���������:
# - � ������ ���������� � �������� �������� run.sql � run-after.sql ���
#   �������� ���������� ������� *.sql ( �� ����������� revert.sql) � *.dat,
#   � ��������� ������ ������� ������� run.sql, *.dat, run-after.sql;
#
# ������:
# - ��� ��������� �������� �� ��������� Install/Data/*/DbName1 � ������������
#   � ������� ��������������� ������ ����� ���������
#   $(call getInstallDataFile,DbName1)
#
getInstallDataFile = \
  $(filter-out %/revert.sql, \
    $(foreach d,$(addsuffix $(addprefix /,$(1)),$(installDataDir)), \
      $(wildcard \
        $(if $(wildcard $(d)/run.sql $(d)/run-after.sql), \
          $(d)/run.sql $(d)/*.dat $(d)/run-after.sql \
          , $(d)/*.sql $(d)/*.dat \
        ) \
      ) \
    ) \
  )



# ������� ��� �������� ������������ ������ � ��.
installDataTarget = \
  $(addsuffix .$(lu), \
    $(call getInstallDataFile) \
  ) \
  $(addsuffix .$(lu2), \
  ) \
  $(addsuffix .$(lu3), \
    $(wildcard Install/Data/Last/AccessOperator-User/*.sql) \
  ) \



# target: install-data
# ��������� ������������ ������ � ��.
# ��� ���������� �������� ������������ ������ ����������� ������� ��
# �������� Install/Data/$(INSTALL_VERSION).

install-data: install-data.oms



# build var: BATCH_MASK
# ������ ����� ��� ����������� ��������������� �������� �������. ������������
# ����� ������ ( ����� �������) ����� �������� ������������ �������� �������.
# ( ����� ������������ ����������� "*" � "?").
#
# ������: ��� �������� ��������
# ������� ClearOldLog � CheckBatchExecution ����� ����� ���� �����
# "ClearOldLog,CheckBatchExecution".
BATCH_MASK =

# build var: SKIP_BATCH_MASK
# ������ ����� ��� ���������� ��������������� �������� �������. ������������
# ����� ������ ( ����� �������) ����� �������� ������������ �������� �������.
# ( ����� ������������ ����������� "*" � "?").
#
# ������: ��� ���������� ��������
# �������, ������������ � Check, ����� ������ ���� ����� "Check*".
#
# ����� BATCH_MASK, SKIP_BATCH_MASK ����� ������������ ������������ �
# FILE_MASK, SKIP_FILE_MASK.
SKIP_BATCH_MASK =

# build var: SKIP_CHECK_JOB
# ���� �������� �������� ������������ ( ����������) PL/SQL-������ �������
# ������ Scheduler ( "1" �� ���������, �� ��������� ���������).
SKIP_CHECK_JOB =

# build var: SKIP_LOAD_OPTION
# ���� ���������� �������� ���������� �������� ������� ������ Scheduler.  ���
# ���������� �������� ����� ������� 1, �� ��������� ��������� ���
# ��������������� �������� �������.
SKIP_LOAD_OPTION =

# build var: UPDATE_OPTION_VALUE
# ���� ��������� ������������ �������� ���������� �������� ������� ������
# Scheduler ��� �� �������� �������� ��������� � ������������ ( "1" ���������,
# �� ��������� �� ��������� ( ��� ���� �������� ����������, ��������� �
# ������������, ������������ ������ ��� �������� ����������)).
UPDATE_OPTION_VALUE =

# build var: UPDATE_SCHEDULE
# ���� ���������� ���������� ������� �������� ������� ������ Scheduler ��������
# ���������� � ������������ ( "1" ���������, �� ��������� �� ��������� ( ���
# ���� ���������� � ������������ ������������ ������ ��� ������ ���������
# �������)). � ������� ���������� ������ ����� ��������� ������� � ��������
# ����� ������������ ���������� ������. ����������� ����, �������� �� ��������
# ������� ����� � ������ ������ ������ ��� ������ � ���� �� ��������� ������� (
# batch.xml � batch-config.xml) ����������� � ������ Scheduler.
UPDATE_SCHEDULE =

# ������� ��� �������� �������� ������� � �� ���������� � ��.
installBatchTarget = \
  $(addsuffix .$(lu), \
    $(wildcard Install/Batch/Last/*.job.sql) \
    $(wildcard Install/Batch/Last/*/*.job.sql) \
    $(wildcard Install/Batch/Last/*/batch.xml) \
  ) \
  $(addsuffix .$(lu2), \
  ) \
  $(addsuffix .$(lu3), \
  ) \



# target: install-batch
# ������������� �������� ������� � ��.

install-batch: install-batch.oms



# ����������� ��������, ����������� ����� ���������.
# �������� ����������� ���������, ��������� � OMS.
# �������� ���������� �� ������ ���������� � ������ ( � ������ �������������
# ����� ������� ������������� ���� ���������� �� installAfterTarget � ���������
# ��� ������� ����������� ����������� ��������).
installAfterOmsAction =                        \
  oms-compile-invalid.sql                      \



# ��������, ����������� ����� ���������.
installAfterTarget =                          \
  $(addsuffix .$(ru),                          \
    $(installAfterOmsAction)                  \
    $(wildcard Install/Config/after-action.sql)      \
    $(if $(INSTALL_VERSION), \
      $(wildcard Install/Config/$(INSTALL_VERSION)/after-action.sql),) \
  )                                            \
  $(addsuffix .$(ru2),                        \
    $(installAfterOmsAction)                  \
  )                                            \
  $(addsuffix .$(ru3),                        \
    $(installAfterOmsAction)                  \
  )                                            \



# target: install-after
# ��������� ����������� ��������� ��������.

install-after: install-after.oms



# target: install-save-info
# ��������� � �� ���������� �� ��������� ������.

install-save-info: install-save-info.oms



# target: install
# ������������� ������ � ��.

install: install.oms



#
# group: ������������ ������
#

# ������� ��� �������� � �� �������� ��� ������������
installTestTarget = \
  $(addsuffix .$(lu), \
    $(wildcard \
      $(addprefix Test/, \
        *.typ *.pks *.tyb *.pkb \
      ) \
    ) \
  ) \
  $(addsuffix .$(lu2), \
  ) \
  $(addsuffix .$(lu3), \
  ) \



# target: install-test
# ��������� ������� ��� ������������ � ��.
install-test: install-test.oms



# build var: TEST_SCRIPT
# ��� ������� ��� ������� ������������.
TEST_SCRIPT = run.sql

# ������ ��� ������� ��� ������� ������������ ( ������ � �����������).
# ��� ���������� ���������� ����������� ������������ �� ��������� ( ".sql").
ifneq ($(TEST_SCRIPT),)
  testScript = \
    $(if $(suffix $(TEST_SCRIPT)),$(TEST_SCRIPT),$(TEST_SCRIPT).sql)
else
  testScript = ""
endif

# ������� ��� ������� ������������
testTarget = \
  $(addsuffix .$(ru), \
    $(wildcard Test/$(testScript)) \
  ) \
  $(addsuffix .$(ru2), \
  ) \
  $(addsuffix .$(ru3), \
  ) \



# target: test
# ��������� ������������ ������.
test: test.oms



#
# group: ������ ��������� ������ � ��
#

# build var: UNINSTALL_RESULT_VERSION
# ������ ������, ������� ���������� � ���������� ������ ��������� ������ ������.
# ������������ ��� ���������� � �� ���������� �� ������ ���������, ����������
# ��������� ��� ������ ��������� ����������.
UNINSTALL_RESULT_VERSION  =

# ������ �������� ��� �������� ���������� ���������� ����� ������� ���������.
# �� ������ ������������� ����������� �����, �� ����������� ��-�� ��������
# ��������� FILE_MASK, SKIP_FILE_MASK.
# ������ ������ ����� ��, ��� � loadTarget.
uninstallCheckLockTarget = \
  $(uninstallLoadTarget) \


# ����������� ��������, ����������� ����� ������� ���������.
# �������� ����������� ���������, ��������� � OMS.
# �������� ���������� �� ������ ���������� � ������ ( � ������ �������������
# ����� ������� ������������� ���� ���������� �� uninstallBeforeTarget �
# ��������� ��� ������� ����������� ����������� ��������).
uninstallBeforeOmsAction = \
  oms-check-lock.sql \
  oms-show-invalid.sql \



# ��������, ����������� ����� ������� ��������� ������.
uninstallBeforeTarget = \
  $(addsuffix .$(ru), \
    $(if $(INSTALL_VERSION), \
      $(wildcard Install/Config/$(INSTALL_VERSION)/Revert/before-action.sql),) \
    $(wildcard Install/Config/before-action.sql) \
    $(uninstallBeforeOmsAction) \
  ) \
  $(addsuffix .$(ru2), \
    $(uninstallBeforeOmsAction) \
  ) \
  $(addsuffix .$(ru3), \
    $(uninstallBeforeOmsAction) \
  ) \



# target: uninstall-before
# ��������� ��������������� �������� ����� ������� ���������.

uninstall-before: uninstall-before.oms



# ������� ��� ������ ��������� �����
uninstallSchemaTarget = \
  $(addsuffix .$(ru), \
    $(wildcard Install/Schema/$(INSTALL_VERSION)/revert.sql) \
  ) \
  $(addsuffix .$(ru2), \
  ) \
  $(addsuffix .$(ru3), \
  ) \



# target: uninstall-schema
# �������� ���������, ��������� � ������� ����� ��� ���������� ���������
# ( �� ���� <install-schema>).
# ��� ������ ���������, ��������� � ������� �����, ����������� ������� ��
# �������� Install/Schema/$(INSTALL_VERSION).

uninstall-schema: uninstall-schema.oms



# ����� � ����������� �������� ��������, ������������ ��� ������ ���������.
uninstallLoadTarget = \
  $(addsuffix .$(ru), \
    $(if $(INSTALL_VERSION), \
      $(foreach m, *.typ *.vw *.pks *.trg *.tyb *.pkb, \
        $(wildcard Install/Schema/$(INSTALL_VERSION)/Revert/$(m)) \
      ) \
    ,) \
  ) \
  $(addsuffix .$(ru2), \
  ) \
  $(addsuffix .$(ru3), \
  ) \



# target: uninstall-load
# ��������� ���������� ������ �������� � �� ��� ������ ���������.

uninstall-load: uninstall-load.oms



# ������� ��� ������ ���������, ��������� ��� �������� ������������ ������ � ��.
uninstallDataTarget = \
  $(addsuffix .$(ru), \
    $(wildcard Install/Data/$(INSTALL_VERSION)/revert.sql) \
  ) \
  $(addsuffix .$(ru2), \
  ) \
  $(addsuffix .$(ru3), \
  ) \



# target: uninstall-data
# �������� ���������, ��������� ��� �������� ������������ ������ � ��
# ( �� ���� <install-data>).

uninstall-data: uninstall-data.oms



# ����������� ��������, ����������� ����� ������ ���������.
# �������� ����������� ���������, ��������� � OMS.
# �������� ���������� �� ������ ���������� � ������ ( � ������ �������������
# ����� ������� ������������� ���� ���������� �� uninstallAfterTarget �
# ��������� ��� ������� ����������� ����������� ��������).
uninstallAfterOmsAction = \
  oms-compile-invalid.sql \



# ��������, ����������� ����� ������ ���������.
uninstallAfterTarget = \
  $(addsuffix .$(ru), \
    $(uninstallAfterOmsAction) \
    $(wildcard Install/Config/after-action.sql) \
    $(if $(INSTALL_VERSION), \
      $(wildcard Install/Config/$(INSTALL_VERSION)/Revert/after-action.sql),) \
  ) \
  $(addsuffix .$(ru2), \
    $(uninstallAfterOmsAction) \
  ) \
  $(addsuffix .$(ru3), \
    $(uninstallAfterOmsAction) \
  ) \



# target: uninstall-after
# ��������� ����������� ������ ��������� ��������.

uninstall-after: uninstall-after.oms



# target: uninstall-save-info
# ��������� � �� ���������� �� ������ ��������� ������.

uninstall-save-info: uninstall-save-info.oms



# target: uninstall
# �������� ��������� ������ ������ � ��.
# ������, ��������� ������� ����������, ������������ ��������� ���������
# <INSTALL_VERSION>.

uninstall: uninstall.oms



#
# group: ������ ���� ������������� ��
#

# build var: TO_USERNAME
# ��� ������������ ��, �������� �������� �����.
TO_USERNAME =

# build var: GRANT_SCRIPT
# ��� ������� ��� ������ ����.
GRANT_SCRIPT = run.sql

# ������ ��� ������� ��� ������ ���� ( ������ � �����������).
# ��� ���������� ���������� ����������� ������������ �� ��������� ( ".sql").
ifneq ($(GRANT_SCRIPT),)
grantScript = \
  $(if $(suffix $(GRANT_SCRIPT)),$(GRANT_SCRIPT),$(GRANT_SCRIPT).sql)
else
grantScript = ""
endif

# ������ ��������, ������������ ��� ������ ����.
# �� ��������� ������������ Last.
grantVersion = $(if $(INSTALL_VERSION),$(INSTALL_VERSION),Last)

# ��������, ����������� ��� ������ ����.
grantTarget =                           \
  $(addsuffix .$(ru),                   \
    $(wildcard Install/Grant/$(grantVersion)/$(grantScript)) \
  )                                     \
  $(addsuffix .$(ru2),                  \
  )                                     \
  $(addsuffix .$(ru3),                  \
  )                                     \



# target: grant-exec
# ��������� ������� ������ ����.

grant-exec: grant-exec.oms



# target: grant-save-info
# ��������� � �� ���������� � ������ ���� ������������.

grant-save-info: grant-save-info.oms



# target: grant
# ������ ����� ������������ ��.

grant: grant.oms



# �������� ����������� ��������� ������ �������
include $(omsModuleDir)/common.mk
