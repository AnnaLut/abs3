

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/OBPC_ACC_OVER.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view OBPC_ACC_OVER ***

  CREATE OR REPLACE FORCE VIEW BARS.OBPC_ACC_OVER ("ACC", "ACCO", "TIPO") AS 
  SELECT ACC, ACCO, TIPO
      FROM ACC_OVER WHERE TIPO=14
   WITH CHECK OPTION       CONSTRAINT "CHK_OBPC_ACC_OVER";

PROMPT *** Create  grants  OBPC_ACC_OVER ***
grant SELECT                                                                 on OBPC_ACC_OVER   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OBPC_ACC_OVER   to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/OBPC_ACC_OVER.sql =========*** End *** 
PROMPT ===================================================================================== 
