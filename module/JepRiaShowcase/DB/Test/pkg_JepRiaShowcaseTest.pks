create or replace package pkg_JepRiaShowcaseTest is
/* package: pkg_JepRiaShowcaseTest
  ������� ��� ������������ ������.

  SVN root: JEP/Module/JepRiaShowcase
*/



/* group: ������� */

/* pproc: endTestException
  ��������� ���� � ��������� ����������.

  ���������:
  expectedException           - ��������� ����� ����������
  inExceptionFlag             - ��������� �� ����� � ����� ���������
                                ����������
  exceptionText               - ����� ���������� ( ���������� �� ������ ���
                                ����������� �����)

  ���������:
  - � ������ ���������� ������������� ����������� ����������� �������� �
    TestUtility;

  ( <body::endTestException>)
*/
procedure endTestException(
  expectedException             varchar2
  , inExceptionFlag             integer
  , exceptionText               varchar2 := null
);

/* pproc: testEditFeatureAccess
  �������� ������������� ���� ������� �� �������������� � �������� ������� ��
  ����������.

  ( <body::testEditFeatureAccess>)
*/
procedure testEditFeatureAccess;

/* pproc: testFeatureStatus
  �������� ��������� ������� ������� �� ����� ����������.

  ( <body::testFeatureStatus>)
*/
procedure testFeatureStatus;

/* pproc: testUserApi
  ������������ API ��� ����������������� ����������.

  ( <body::testUserApi>)
*/
procedure testUserApi;

/* pproc: testFeatureOperator
  ���� ������������� �������� �� ����������.

  ( <body::testFeatureOperator>)
*/
procedure testFeatureOperator;

/* pproc: testFindFeature
  ���� ������ �������� �� ����������.

  ( <body::testFindFeature>)
*/
procedure testFindFeature;

/* pproc: testSetFeatureWorkSequence
  ���� ��������� ������� ���������� �������� �� ����������.

  ( <body::testSetFeatureWorkSequence>)
*/
procedure testSetFeatureWorkSequence;

/* pproc: testSetFeatureResponsible
  ���� ��������� �������������� �� ������ �� ����� ����������

  ( <body::testSetFeatureResponsible>)
*/
procedure testSetFeatureResponsible;

end pkg_JepRiaShowcaseTest;
/
