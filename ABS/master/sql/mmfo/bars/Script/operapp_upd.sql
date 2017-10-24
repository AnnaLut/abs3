BEGIN
bc.go('/');
  FOR c IN (SELECT t.codeapp, t1.codeoper
              FROM operapp t, operlist t1
             WHERE t1.codeoper = t.codeoper
               AND t1.name IN
                   ('�� F0: ��������� ������� ��������� SG'
                   ,'��: ����������� ���i����� ���i�i� �� ��'))
  LOOP
    BEGIN
      UPDATE operapp
         SET codeapp = '$RM_KREA'
       WHERE codeapp = c.codeapp
         AND codeoper = c.codeoper;
    EXCEPTION
      WHEN OTHERS THEN
        IF SQLCODE = -06512 THEN
          NULL;
        END IF;
    END;
  END LOOP;
  FOR c IN (SELECT t.codeapp, t1.codeoper
              FROM operapp t, operlist t1
             WHERE t1.codeoper = t.codeoper
               AND t1.name IN
                   ('#2) �� S38: ������-�� �� �����. ���. ����� ��� � ���� �����. ��'
                   ,'#4) �� F0_3: ����-����i� ������i� ��������� SG ��'
                   ,'����������� ��������/���쳿 ��'
                   ,'�� S8: ���� �������� �������� ��'))
  LOOP
    BEGIN
      UPDATE operapp
         SET codeapp = '$RM_KREA_F'
       WHERE codeapp = c.codeapp
         AND codeoper = c.codeoper;
    EXCEPTION
      WHEN OTHERS THEN
        IF SQLCODE = -06512 THEN
          NULL;
        END IF;
    END;
  
  END LOOP;
  
  
  FOR c IN (SELECT t.codeapp, t.codeoper
              FROM operapp t, operlist t1
             WHERE t1.codeoper = t.codeoper
               AND t1.name IN
                   ('#2) �� S38: ������-�� �� �����. ���. ����� ��� � ���� �����. ��'
                   ,'#4) �� F0_3: ����-����i� ������i� ��������� SG ��'
                   ,'����������� ��������/���쳿 ��'
                   ,'�� S8: ���� �������� �������� ��'
                   ,'����������� ������� �� 9129 �� �� ��'
                   ,'���i ��� ��������������i� �� ��'
                   ,'�� F0: ��������� ������� ��������� SG'
                   ,'��: ����������� ���i����� ���i�i� �� ��'
                   ,'����������� ��������/���쳿 ��'
                   ,'����������� ��������/���쳿'
                   ,'Start/ ����-��������� ������� ����� SS - ��')
               AND t.codeapp <> '$RM_KREA_F')
  LOOP
  
    user_menu_utl.remove_func_from_arm(p_func_id  => c.codeoper
                                      ,p_arm_code => c.codeapp
                                      ,p_approve  => 0);
  
  END LOOP;


 FOR c IN (SELECT t.codeapp, t1.codeoper
              FROM operapp t, operlist t1
             WHERE t1.codeoper = t.codeoper
               AND t1.name IN
                   ('����������� ������� �� 9129 �� �� ��'
                   ,'Start/ ����-��������� ������� ����� SS - ��'
                   ,'����������� ��������/���쳿 ��'
                   ,'��: ����������� ���i����� ���i�i� �� ��'
                   ,'�� S8: ���� �������� �������� ��'
                   ,'�������-�� �� �����. %% ����� ��� � ���� ����� ��'))
  LOOP
    BEGIN
      UPDATE operapp
         SET codeapp = '$RM_KREA_U'
       WHERE codeapp = c.codeapp
         AND codeoper = c.codeoper;
    EXCEPTION
      WHEN OTHERS THEN
        IF SQLCODE = -06512 THEN
          NULL;
        END IF;
    END;
  
  END LOOP;
  bc.home;
END;
/
commit;


BEGIN

  FOR c IN (SELECT t.codeapp, t1.codeoper
              FROM operapp t, operlist t1
             WHERE t1.codeoper = t.codeoper
               AND t1.name IN
                   ('�������-�� �� �����. %% ����� ��� � ���� ����� ��'
                   ,'������� �� �� - ������ �� ����������(�� �����)'
                   ,'�� S32: ����-��������� ������� �����.% SN ��'))
  LOOP
    BEGIN
      UPDATE operapp
         SET codeapp = '$RM_KREA_U'
       WHERE codeapp = c.codeapp
         AND codeoper = c.codeoper;
    EXCEPTION
      WHEN OTHERS THEN
        IF SQLCODE = -06512 THEN
          NULL;
        END IF;
    END;
    
    umu.remove_func_from_arm(
        p_func_id => c.codeoper,
        p_arm_code => '$RM_UCCK',
        p_approve   => 1) ;
END loop;

end;

/
commit;