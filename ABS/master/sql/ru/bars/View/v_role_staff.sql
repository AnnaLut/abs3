create or replace force view v_role_staff
(
   user_id,
   user_name,
   branch,
   user_logname,
   role_id,
   role_code,
   role_state_id,
   role_state_name
)
as
   select grantee_id user_id,
          g.fio user_name,
          g.branch branch,
          g.logname user_logname,
          resource_id role_id,
          sr.role_code role_code,
          state_id role_state_id,
          decode (state_id,
                  1, 'Активна',
                  2, 'Заблокована',
                  3, 'Закрита')
             role_state_name
     from adm_resource t, staff_role sr, staff$base g
    where     t.grantee_type_id = 11                                 -- в роли
          and t.resource_type_id = 10                        --користувачі абс
          and t.grantee_id = sr.id
          and t.grantee_id = g.id;
		  
		  
grant select on v_role_staff to bars_access_defrole;		  
