

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_INS_CORPS.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_INS_CORPS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_INS_CORPS ("RNK", "NAME_FULL", "NAME_SHORT", "INN", "TEL", "MFO", "NLS", "ADR") AS 
  select c.rnk,
       c.nmk      as name_full,
       c.nmkk     as name_short,
       c.okpo     as inn,
       cp.tel_fax as tel,
       cp.mainmfo as mfo,
       cp.mainnls as nls,
       c.adr      as adr
  from customer c, corps cp
 where c.custtype = 2
   and c.rnk = cp.rnk
 order by c.rnk desc;

PROMPT *** Create  grants  V_INS_CORPS ***
grant SELECT                                                                 on V_INS_CORPS     to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_INS_CORPS.sql =========*** End *** ==
PROMPT ===================================================================================== 
