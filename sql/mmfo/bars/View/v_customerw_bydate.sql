

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CUSTOMERW_BYDATE.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CUSTOMERW_BYDATE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CUSTOMERW_BYDATE ("RNK", "TAG", "VALUE", "ISP", "CHGDATE", "CHGACTION", "DONEBY", "IDUPD", "EFFECTDATE") AS 
  select "RNK","TAG","VALUE","ISP","CHGDATE","CHGACTION","DONEBY","IDUPD","EFFECTDATE"
  from customerw_update
 where (rnk, tag, idupd) in
       ( select rnk, tag, max(idupd) idupd
           from customerw_update u
          where trunc(chgdate) <= to_date(pul.get_mas_ini_val('DAT'), 'dd/mm/yyyy')
            and chgaction in (1,2)
            and not exists ( select 1 from customerw_update
                              where rnk = u.rnk and tag = u.tag
                                and chgaction = 3
                                and chgdate > u.chgdate
                                and trunc(chgdate) <= to_date(pul.get_mas_ini_val('DAT'), 'dd/mm/yyyy') )
          group by rnk, tag );



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CUSTOMERW_BYDATE.sql =========*** End
PROMPT ===================================================================================== 
