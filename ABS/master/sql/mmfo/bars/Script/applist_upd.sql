BEGIN

  FOR c IN (SELECT '$RM_KREA_U' AS arm_id
                  ,'АРМ Автоматизованих операцій КП ЮО' AS arm_name
              FROM dual
            UNION ALL
            SELECT '$RM_KREA_F' AS arm_id
                  ,'АРМ Автоматизованих операцій КП ФО' AS arm_name
              FROM dual)
  
  LOOP
    user_menu_utl.cor_arm(p_arm_code            => c.arm_id
                         ,p_arm_name            => c.arm_name
                         ,p_application_type_id => 1);
  
  END LOOP;
END;
/
commit;