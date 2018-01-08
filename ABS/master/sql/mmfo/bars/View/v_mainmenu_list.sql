

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_MAINMENU_LIST.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_MAINMENU_LIST ***

  CREATE OR REPLACE FORCE VIEW BARS.V_MAINMENU_LIST ("LOGNAME", "ID", "CODEAPP", "APPNAME", "CODEOPER", "NAME", "SEMANTIC", "PARENTID", "RUNABLE", "FLDLEVEL", "FUNCNAME", "ROLENAME") AS 
  select distinct a.logname, a.id, a.codeapp, a.name,
       o.codeoper, o.name, o.semantic, o.parentid,
       o.runable, 0, o.funcname, o.rolename
  from ( select r.codeapp, o.codeoper, o.name, o.semantic, o.parentid,
                o.runable, o.funcname, o.rolename
           from operlist o, operapp r
          where o.codeoper = r.codeoper
            and nvl(o.runable,0) = 1
                --enchamced secure
            and decode(GetGlobalOption('LOSECURE'), 1, 1, nvl(r.approve,0)) = 1
            and decode(GetGlobalOption('LOSECURE'), 1, 1, date_is_valid(r.adate1,r.adate2,r.rdate1,r.rdate2)) = 1
       ) o,
       ( select st.logname, st.id, a.codeapp, a.name
           from staff$base st, applist_staff s, applist a
          where st.id = s.id
            and s.codeapp = a.codeapp
                --enchamced secure
            and decode(GetGlobalOption('LOSECURE'), 1, 1, nvl(s.approve,0)) = 1
            and decode(GetGlobalOption('LOSECURE'), 1, 1, date_is_valid(s.adate1,s.adate2,s.rdate1,s.rdate2)) = 1
                --frontend
            and a.frontend = decode(GetGlobalOption('MULTIFE'), 1, 0, a.frontend)
       ) a
  where o.codeapp(+) = a.codeapp
 ;

PROMPT *** Create  grants  V_MAINMENU_LIST ***
grant SELECT                                                                 on V_MAINMENU_LIST to BARSREADER_ROLE;
grant SELECT                                                                 on V_MAINMENU_LIST to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_MAINMENU_LIST to START1;
grant SELECT                                                                 on V_MAINMENU_LIST to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_MAINMENU_LIST to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_MAINMENU_LIST.sql =========*** End **
PROMPT ===================================================================================== 
