

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_STAFF_USER_ORA_ROLES.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_STAFF_USER_ORA_ROLES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_STAFF_USER_ORA_ROLES ("ID", "LOGNAME", "ROLE_NAME", "STATE") AS 
  select "ID","LOGNAME","ROLE_NAME","STATE"
  from (select s.id,
               s.logname,
               t1.role_name,
               case
                 when r.column_value is null then
                  0
                 else
                  1
               end state
          from roles$base t1
          join staff$base s
            on 1 = 1
          left join table(user_utl.get_ora_user_roles(s.logname)) r
            on trim(upper(r.column_value)) = trim(upper(t1.role_name)));

PROMPT *** Create  grants  V_STAFF_USER_ORA_ROLES ***
grant SELECT                                                                 on V_STAFF_USER_ORA_ROLES to BARSREADER_ROLE;
grant SELECT                                                                 on V_STAFF_USER_ORA_ROLES to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_STAFF_USER_ORA_ROLES.sql =========***
PROMPT ===================================================================================== 
