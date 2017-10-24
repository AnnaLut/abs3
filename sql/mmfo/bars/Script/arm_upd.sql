DECLARE
  l_codeoper NUMBER;
  l_codearm  VARCHAR2(10) := '$RM_KREA';
BEGIN
  BEGIN
    SELECT t.codeoper
      INTO l_codeoper
      FROM operlist t
     WHERE t.name = 'КП F0: Авторозбір рахунків погашення SG';
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
     WHERE t.name = 'Start/ Авто-просрочка рахунків боргу SS - ЮО';
  EXCEPTION
    WHEN no_data_found THEN
      NULL;
  END;
  umu.add_func2arm(l_codeoper, l_codearm, 1); --(1/0 - подтвержденный/неподтвержденный ресурс)
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
     WHERE t.name = 'Start/ Авто-просрочка рахунків боргу SS -  ФО';
  EXCEPTION
    WHEN no_data_found THEN
      NULL;
  END;
  umu.add_func2arm(l_codeoper, l_codearm, 1); --(1/0 - подтвержденный/неподтвержденный ресурс)
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
     WHERE t.name = 'Вирівнювання залишків на 9129 по КП ФО';
  EXCEPTION
    WHEN no_data_found THEN
      NULL;
  END;
  umu.add_func2arm(l_codeoper, l_codearm, 1); --(1/0 - подтвержденный/неподтвержденный ресурс)
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
     WHERE t.name = 'КП S7: Амортизація Дисконту/Премії ЮО з ЕПС';
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
     WHERE t.name = 'Амортизація Дисконту/Премії ЮО з ЕПС';
  EXCEPTION
    WHEN no_data_found THEN
      NULL;
  END;
/*'Амортизація Дисконту/Премії ЮО з ЕПС'
,'Амортизація Дисконту/Премії з ЕПС'
,'Амортизація Дисконту/Премії ФО з ЕПС' */

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
     WHERE t.name = 'Амортизація Дисконту/Премії з ЕПС';
  EXCEPTION
    WHEN no_data_found THEN
      NULL;
  END;
/*'Амортизація Дисконту/Премії ЮО з ЕПС'
,'Амортизація Дисконту/Премії з ЕПС'
,'Амортизація Дисконту/Премії ФО з ЕПС' */

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
     WHERE t.name = 'Амортизація Дисконту/Премії ФО з ЕПС';
  EXCEPTION
    WHEN no_data_found THEN
      NULL;
  END;
/*'Амортизація Дисконту/Премії ЮО з ЕПС'
,'Амортизація Дисконту/Премії з ЕПС'
,'Амортизація Дисконту/Премії ФО з ЕПС' */

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
     WHERE t.name = 'Амортизація Дисконту/Премії з ЕПС';
  EXCEPTION
    WHEN no_data_found THEN
      NULL;
  END;
/*'Амортизація Дисконту/Премії ЮО з ЕПС'
,'Амортизація Дисконту/Премії з ЕПС'
,'Амортизація Дисконту/Премії ФО з ЕПС' */

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
     WHERE t.name = 'Амортизація Дисконту/Премії ФО з ЕПС';
  EXCEPTION
    WHEN no_data_found THEN
      NULL;
  END;
/*'Амортизація Дисконту/Премії ЮО з ЕПС'
,'Амортизація Дисконту/Премії з ЕПС'
,'Амортизація Дисконту/Премії ФО з ЕПС' */

  umu.remove_func_from_arm(
        p_func_id => l_codeoper,
        p_arm_code => l_codearm,
        p_approve   => 1) ;
  COMMIT;
END;
/