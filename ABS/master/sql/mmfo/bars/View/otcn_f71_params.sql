

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/OTCN_F71_PARAMS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view OTCN_F71_PARAMS ***

  CREATE OR REPLACE FORCE VIEW BARS.OTCN_F71_PARAMS ("ACC", "NBS", "NLS", "S031", "NKD") AS 
  SELECT   a.acc, a.nbs, a.nls, s.s031, s.nkd
       FROM specparam s, accounts a
      WHERE
            s.acc = a.acc AND a.dazs IS NULL AND a.nbs IN (SELECT r020
                                                             FROM kl_f3_29
                                                            WHERE kf = '71')
   ORDER BY 1;

PROMPT *** Create  grants  OTCN_F71_PARAMS ***
grant SELECT                                                                 on OTCN_F71_PARAMS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OTCN_F71_PARAMS to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/OTCN_F71_PARAMS.sql =========*** End **
PROMPT ===================================================================================== 
