

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/OPERLIST0.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view OPERLIST0 ***

  CREATE OR REPLACE FORCE VIEW BARS.OPERLIST0 ("CODEOPER", "NAME", "DLGNAME", "FUNCNAME", "SEMANTIC", "RUNABLE", "PARENTID", "ROLENAME", "FRONTEND", "USEARC") AS 
  select "CODEOPER","NAME","DLGNAME","FUNCNAME","SEMANTIC","RUNABLE","PARENTID","ROLENAME","FRONTEND","USEARC" from operlist WHERE FRONTEND = 0 and RUNABLE <> 3;

PROMPT *** Create  grants  OPERLIST0 ***
grant SELECT                                                                 on OPERLIST0       to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/OPERLIST0.sql =========*** End *** ====
PROMPT ===================================================================================== 
