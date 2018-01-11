

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/OPERLIST1.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view OPERLIST1 ***

  CREATE OR REPLACE FORCE VIEW BARS.OPERLIST1 ("CODEOPER", "NAME", "DLGNAME", "FUNCNAME", "SEMANTIC", "RUNABLE", "PARENTID", "ROLENAME", "FRONTEND", "USEARC") AS 
  select "CODEOPER","NAME","DLGNAME","FUNCNAME","SEMANTIC","RUNABLE","PARENTID","ROLENAME","FRONTEND","USEARC" from operlist WHERE FRONTEND = 1 and RUNABLE <> 3;

PROMPT *** Create  grants  OPERLIST1 ***
grant SELECT                                                                 on OPERLIST1       to BARSREADER_ROLE;
grant SELECT                                                                 on OPERLIST1       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OPERLIST1       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/OPERLIST1.sql =========*** End *** ====
PROMPT ===================================================================================== 
