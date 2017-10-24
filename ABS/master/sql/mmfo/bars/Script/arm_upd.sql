DECLARE
  l_codeoper NUMBER;
  l_codearm  VARCHAR2(10) := '$RM_KREA';
BEGIN
  BEGIN
    SELECT t.codeoper
      INTO l_codeoper
      FROM operlist t
     WHERE t.name = '�� F0: ��������� ������� ��������� SG';
  EXCEPTION
    WHEN no_data_found THEN
      NULL;
  END;
  umu.add_func2arm(l_codeoper, l_codearm, 1); 
  COMMIT;
END;
/
DECLARE
  l_codeoper NUMBER;
  l_codearm  VARCHAR2(10) := '$RM_KREA_U';
BEGIN
  BEGIN
    SELECT t.codeoper
      INTO l_codeoper
      FROM operlist t
     WHERE t.name = 'Start/ ����-��������� ������� ����� SS - ��';
  EXCEPTION
    WHEN no_data_found THEN
      NULL;
  END;
  umu.add_func2arm(l_codeoper, l_codearm, 1); --(1/0 - ��������������/���������������� ������)
  COMMIT;
END;
/
DECLARE
  l_codeoper NUMBER;
  l_codearm  VARCHAR2(10) := '$RM_KREA_F';
BEGIN
  BEGIN
    SELECT t.codeoper
      INTO l_codeoper
      FROM operlist t
     WHERE t.name = 'Start/ ����-��������� ������� ����� SS -  ��';
  EXCEPTION
    WHEN no_data_found THEN
      NULL;
  END;
  umu.add_func2arm(l_codeoper, l_codearm, 1); --(1/0 - ��������������/���������������� ������)
  COMMIT;
END;
/
DECLARE
  l_codeoper NUMBER;
  l_codearm  VARCHAR2(10) := '$RM_KREA_F';
BEGIN
  BEGIN
    SELECT t.codeoper
      INTO l_codeoper
      FROM operlist t
     WHERE t.name = '����������� ������� �� 9129 �� �� ��';
  EXCEPTION
    WHEN no_data_found THEN
      NULL;
  END;
  umu.add_func2arm(l_codeoper, l_codearm, 1); --(1/0 - ��������������/���������������� ������)
  COMMIT;
END;
/
DECLARE
  l_codeoper NUMBER;
  l_codearm  VARCHAR2(10) := '$RM_KREA';
BEGIN
  BEGIN
    SELECT t.codeoper
      INTO l_codeoper
      FROM operlist t
     WHERE t.name = '�� S7: ����������� ��������/���쳿 �� � ���';
  EXCEPTION
    WHEN no_data_found THEN
      NULL;
  END;
   umu.remove_func_from_arm(
        p_func_id => l_codeoper,
        p_arm_code => l_codearm,
        p_approve   => 1) ;
  COMMIT;
END;
/
DECLARE
  l_codeoper NUMBER;
  l_codearm  VARCHAR2(10) := '$RM_UCCK';
BEGIN
  BEGIN
    SELECT t.codeoper
      INTO l_codeoper
      FROM operlist t
     WHERE t.name = '����������� ��������/���쳿 �� � ���';
  EXCEPTION
    WHEN no_data_found THEN
      NULL;
  END;
/*'����������� ��������/���쳿 �� � ���'
,'����������� ��������/���쳿 � ���'
,'����������� ��������/���쳿 �� � ���' */

  umu.remove_func_from_arm(
        p_func_id => l_codeoper,
        p_arm_code => l_codearm,
        p_approve   => 1) ;
  COMMIT;
END;
/
DECLARE
  l_codeoper NUMBER;
  l_codearm  VARCHAR2(10) := '$RM_UCCK';
BEGIN
  BEGIN
    SELECT t.codeoper
      INTO l_codeoper
      FROM operlist t
     WHERE t.name = '����������� ��������/���쳿 � ���';
  EXCEPTION
    WHEN no_data_found THEN
      NULL;
  END;
/*'����������� ��������/���쳿 �� � ���'
,'����������� ��������/���쳿 � ���'
,'����������� ��������/���쳿 �� � ���' */

  umu.remove_func_from_arm(
        p_func_id => l_codeoper,
        p_arm_code => l_codearm,
        p_approve   => 1) ;
  COMMIT;
END;
/
DECLARE
  l_codeoper NUMBER;
  l_codearm  VARCHAR2(10) := '$RM_UCCK';
BEGIN
  BEGIN
    SELECT t.codeoper
      INTO l_codeoper
      FROM operlist t
     WHERE t.name = '����������� ��������/���쳿 �� � ���';
  EXCEPTION
    WHEN no_data_found THEN
      NULL;
  END;
/*'����������� ��������/���쳿 �� � ���'
,'����������� ��������/���쳿 � ���'
,'����������� ��������/���쳿 �� � ���' */

  umu.remove_func_from_arm(
        p_func_id => l_codeoper,
        p_arm_code => l_codearm,
        p_approve   => 1) ;
  COMMIT;
END;
/
DECLARE
  l_codeoper NUMBER;
  l_codearm  VARCHAR2(10) := '$RM_WCCK';
BEGIN
  BEGIN
    SELECT t.codeoper
      INTO l_codeoper
      FROM operlist t
     WHERE t.name = '����������� ��������/���쳿 � ���';
  EXCEPTION
    WHEN no_data_found THEN
      NULL;
  END;
/*'����������� ��������/���쳿 �� � ���'
,'����������� ��������/���쳿 � ���'
,'����������� ��������/���쳿 �� � ���' */

  umu.remove_func_from_arm(
        p_func_id => l_codeoper,
        p_arm_code => l_codearm,
        p_approve   => 1) ;
  COMMIT;
END;
/
DECLARE
  l_codeoper NUMBER;
  l_codearm  VARCHAR2(10) := '$RM_WCCK';
BEGIN
  BEGIN
    SELECT t.codeoper
      INTO l_codeoper
      FROM operlist t
     WHERE t.name = '����������� ��������/���쳿 �� � ���';
  EXCEPTION
    WHEN no_data_found THEN
      NULL;
  END;
/*'����������� ��������/���쳿 �� � ���'
,'����������� ��������/���쳿 � ���'
,'����������� ��������/���쳿 �� � ���' */

  umu.remove_func_from_arm(
        p_func_id => l_codeoper,
        p_arm_code => l_codearm,
        p_approve   => 1) ;
  COMMIT;
END;
/