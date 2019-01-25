
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/view/v_operapp.sql =========*** Run *** ====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FORCE VIEW BARS.V_OPERAPP ("CODEOPER", "APPNAME", "CODEAPP", "OPERNAME", "FUNCNAME", "SEMANTIC", "PARENTID", "RUNABLE", "OPFLDLEVEL", "FRONTEND", "DATE_START", "DATE_FINISH") AS 
  select unique o.codeoper, a.name appname, a.codeapp, o.name opername,
       o.funcname, o.semantic, o.parentid, o.runable, null opfldlevel, a.frontend, null, null
  from applist_staff s, applist a, operapp r, operlist o,
  (select id_whom, date_start, date_finish
   from   staff_substitute
   where   id_who = user_id and date_is_valid (date_start, date_finish, null, null) = 1
   union all select user_id, null,null from dual ) ss
 where
   s.id = ss.id_whom
   and s.codeapp = a.codeapp
   and s.codeapp = r.codeapp
   and r.codeoper = o.codeoper
   and o.runable != 2
   -- timing
   and date_is_valid(s.adate1, s.adate2, s.rdate1, s.rdate2) = 1
   and date_is_valid(r.adate1, r.adate2, r.rdate1, r.rdate2) = 1
   --current schema
   and (   o.usearc = decode(sys_context('bars_context', 'cschema'), 'HIST', 1, 'BARS', 0)
        or o.usearc = decode(sys_context('bars_context', 'cschema'), 'HIST', 2, 'BARS', 1))
   --enchanced security
   and 1 = decode((select nvl(min(to_number(val)), 0)
                     from params
                    where par = 'LOSECURE'), 0, nvl(s.approve, 0), 1)
   and 1 = decode((select nvl(min(to_number(val)), 0)
                     from params
                    where par = 'LOSECURE'), 0, nvl(r.approve, 0), 1)
   and teller_utils.teller_arms(a.codeapp) = 1
;
 show err;
 
PROMPT *** Create  grants  V_OPERAPP ***
grant SELECT                                                                 on V_OPERAPP       to ABS_ADMIN;
grant SELECT                                                                 on V_OPERAPP       to BARSREADER_ROLE;
grant SELECT                                                                 on V_OPERAPP       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_OPERAPP       to BASIC_INFO;
grant SELECT                                                                 on V_OPERAPP       to MENU_READER;
grant SELECT                                                                 on V_OPERAPP       to START1;
grant SELECT                                                                 on V_OPERAPP       to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_OPERAPP       to WR_ALL_RIGHTS;
grant SELECT                                                                 on V_OPERAPP       to WR_DIAGNOSTICS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/view/v_operapp.sql =========*** End *** ====
 PROMPT ===================================================================================== 
 