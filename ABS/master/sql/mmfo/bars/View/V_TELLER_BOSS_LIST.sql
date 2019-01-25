
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/view/v_teller_boss_list.sql =========*** Run
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FORCE VIEW BARS.V_TELLER_BOSS_LIST ("USER_ID", "USERLIST") AS 
  select user_id,
       listagg(fio,',') within group (order by fio) userlist
  from (
        select tu.user_id, tu.user_name, b.logname, b.fio, br.priority, rs.role_code, rank() over (order by br.priority) rnk
        from staff$base u, staff$base b, teller_boss_roles br, v_role_staff rs, teller_users tu
        where u.branch = b.branch and b.disable = 0 and b.clsid in (0,4)
          and b.id = rs.user_id
          and rs.role_code = br.userrole
          and tu.user_id = b.id
        union
        select tu.user_id, tu.user_name, 'absadm01','absadm01',1,'11',1 from teller_users tu
        union
        select tu.user_id, tu.user_name, 'bondarenkona','absadm01',1,'11',1 from teller_users tu
      )
  group by user_id
;
 show err;
 
PROMPT *** Create  grants  V_TELLER_BOSS_LIST ***
grant FLASHBACK,SELECT                                                       on V_TELLER_BOSS_LIST to WR_REFREAD;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/view/v_teller_boss_list.sql =========*** End
 PROMPT ===================================================================================== 
 