BEGIN
bc.go('/');
  FOR c IN (SELECT t.codeapp, t1.codeoper
              FROM operapp t, operlist t1
             WHERE t1.codeoper = t.codeoper
               AND t1.name IN
                   ('КП F0: Авторозбір рахунків погашення SG'
                   ,'КП: Нарахування щомiсячної комiсiї по КП'))
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
                   ('#2) КП S38: Перене-ня на прост. відс. згідно ДНЯ і ТИПУ погаш. ФО'
                   ,'#4) КП F0_3: Авто-разбiр рахункiв погашення SG ФО'
                   ,'Амортизація Дисконту/Премії ФО'
                   ,'КП S8: Авто закриття договорів ФО'))
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
                   ('#2) КП S38: Перене-ня на прост. відс. згідно ДНЯ і ТИПУ погаш. ФО'
                   ,'#4) КП F0_3: Авто-разбiр рахункiв погашення SG ФО'
                   ,'Амортизація Дисконту/Премії ФО'
                   ,'КП S8: Авто закриття договорів ФО'
                   ,'Вирівнювання залишків на 9129 по КП ЮО'
                   ,'Данi про реструктуризацiю КД ЮО'
                   ,'КП F0: Авторозбір рахунків погашення SG'
                   ,'КП: Нарахування щомiсячної комiсiї по КП'
                   ,'Амортизація Дисконту/Премії ЮО'
                   ,'Амортизація Дисконту/Премії'
                   ,'Start/ Авто-просрочка рахунків боргу SS - ЮО')
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
                   ('Вирівнювання залишків на 9129 по КП ЮО'
                   ,'Start/ Авто-просрочка рахунків боргу SS - ЮО'
                   ,'Амортизація Дисконту/Премії ЮО'
                   ,'КП: Нарахування щомiсячної комiсiї по КП'
                   ,'КП S8: Авто закриття договорів ЮО'
                   ,'Перенес-ня на проср. %% згідно ДНЯ і ТИПУ погаш ЮО'))
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
                   ('Перенес-ня на проср. %% згідно ДНЯ і ТИПУ погаш ЮО'
                   ,'Обробка КП ЮО - виноси на прострочку(на старті)'
                   ,'КП S32: Авто-просрочка рахунків нарах.% SN ЮО'))
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