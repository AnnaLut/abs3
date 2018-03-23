

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TDDL_GRANT.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TDDL_GRANT ***

  CREATE OR REPLACE TRIGGER BARS.TDDL_GRANT 
   BEFORE GRANT
   ON DATABASE
DECLARE
   l_listPrivs    ora_name_list_t;
   l_listUsers    ora_name_list_t;
   l_listUsers2   ora_name_list_t := ora_name_list_t ();
   l_cnt          INTEGER;
   l_uid          INTEGER;
   j              INTEGER := 0;
BEGIN
   IF (ora_sysevent = 'GRANT')
   THEN
      l_cnt := ora_privilege_list (l_listPrivs);
      l_cnt := ora_grantee (l_listUsers);

      -- формируем список пользователей АБС
      FOR i IN 1 .. l_listUsers.COUNT
      LOOP
         -- везде есть свои исключения
         IF l_listUsers (i) IN ('SYS',
                                'SYSTEM',
                                'BARS',
                                'QOWNER',
                                'BARSAQ',
                                'BARSAQ_ADM',
                                'IBS',
                                'IBS2',
                                'IBSADM',
                                'INSPECTOR',
                                'JBOSS_USR',
                                'BARSDWH_ACCESS_USER',
                                'BARSUPL',
                                'BARS_DM',
								'FINMON',
                                'SBON',
                                'OIM',
                                'OIM_APPROVE',
								'BARS_INTGR')
         THEN
            CONTINUE;
         END IF;

         BEGIN
            SELECT id
              INTO l_uid
              FROM bars.staff$base
             WHERE logname = l_listUsers (i);

            -- добавляем пользователя АБС в список
            l_listUsers2.EXTEND ();
            j := j + 1;
            l_listUsers2 (j) := l_listUsers (i);
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               NULL;
         END;
      END LOOP;

      IF l_listUsers2.COUNT = 0
      THEN
         RETURN;
      END IF;

      -- Выполняем проверку
      bars.bars_dev.check_privilege (p_objtype    => ora_dict_obj_type,
                                     p_objowner   => ora_dict_obj_owner,
                                     p_objname    => ora_dict_obj_name,
                                     p_privopt    => ora_with_grant_option,
                                     p_privlist   => l_listPrivs,
                                     p_userlist   => l_listUsers2);
   END IF;
END;
/
ALTER TRIGGER BARS.TDDL_GRANT ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TDDL_GRANT.sql =========*** End *** 
PROMPT ===================================================================================== 
