

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OPEN_BANKDATES.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OPEN_BANKDATES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OPEN_BANKDATES ("FDAT") AS 
  select FDAT
  from ( select FDAT
           from FDAT
          where nvl(STAT, 0) = 0
          minus
         select DAT_NEXT_U(to_date(BRANCH_ATTRIBUTE_UTL.GET_ATTRIBUTE_VALUE('/','BANKDATE'),'mm/dd/yyyy'),-1)
           from DUAL
          where TMS_UTL.CHECK_ACCESS(sys_context('bars_context','user_mfo')) = 0
) with read only;

PROMPT *** Create  grants  V_OPEN_BANKDATES ***
grant SELECT                                                                 on V_OPEN_BANKDATES to BARSREADER_ROLE;
grant SELECT                                                                 on V_OPEN_BANKDATES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_OPEN_BANKDATES to START1;
grant SELECT                                                                 on V_OPEN_BANKDATES to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OPEN_BANKDATES.sql =========*** End *
PROMPT ===================================================================================== 
