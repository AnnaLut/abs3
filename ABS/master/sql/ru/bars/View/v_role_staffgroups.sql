create or replace force view v_role_staffgroups
(
   staff_group_id,
   staff_group_name,
   role_id,
   role_code,
   role_state_id,
   role_state_name
)
as
   select resource_id staff_group_id,
          g.name staff_group_name,
          grantee_id role_id,
          sr.role_code role_code,
          state_id role_state_id,
          decode (state_id,
                  1, 'Активна',
                  2, 'Заблокована',
                  3, 'Закрита')
             role_state_name
     from adm_resource t, staff_role sr, groups g
    where     t.grantee_type_id = 10                                 -- в роли
          and t.resource_type_id = 1            -- выдано группы пользователей
          and t.grantee_id = sr.id
          and g.id = t.resource_id;


grant select on v_role_staff to bars_access_defrole;		  		  
		  
