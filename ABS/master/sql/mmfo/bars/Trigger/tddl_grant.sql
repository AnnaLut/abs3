

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TDDL_GRANT.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TDDL_GRANT ***

  CREATE OR REPLACE TRIGGER BARS.TDDL_GRANT 
before grant on database
declare

 l_listPrivs  ora_name_list_t;
 l_listUsers  ora_name_list_t;
 l_listUsers2 ora_name_list_t := ora_name_list_t();
 l_cnt        integer;
 l_uid        integer;
 j            integer := 0;
begin

    if (ora_sysevent = 'GRANT') then


        l_cnt := ora_privilege_list(l_listPrivs);
        l_cnt := ora_grantee(l_listUsers);

        -- формируем список пользователей АБС
        for i in 1..l_listUsers.count
        loop
            -- везде есть свои исключения
            if l_listUsers(i) in ('SYS','SYSTEM','BARS','QOWNER','BARSAQ','BARSAQ_ADM',
               'IBS','IBS2','IBSADM','INSPECTOR','JBOSS_USR', 'BARSDWH_ACCESS_USER','BARSUPL','BARS_DM', 'FINMON')
            then
                continue;
            end if;
            begin
                select id
                  into l_uid
                  from bars.staff$base
                 where logname=l_listUsers(i);
                -- добавляем пользователя АБС в список
                l_listUsers2.extend(); j := j + 1;
                l_listUsers2(j) := l_listUsers(i);
            exception when no_data_found then
                null;
            end;
        end loop;

        if l_listUsers2.count=0
        then
            return;
        end if;

        -- Выполняем проверку
        bars.bars_dev.check_privilege(
                          p_objtype     => ora_dict_obj_type,
                          p_objowner    => ora_dict_obj_owner,
                          p_objname     => ora_dict_obj_name,
                          p_privopt     => ora_with_grant_option,
                          p_privlist    => l_listPrivs,
                          p_userlist    => l_listUsers2 );


    end if;

end;
/
ALTER TRIGGER BARS.TDDL_GRANT ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TDDL_GRANT.sql =========*** End *** 
PROMPT ===================================================================================== 
