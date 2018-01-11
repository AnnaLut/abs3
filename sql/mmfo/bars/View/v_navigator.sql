

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NAVIGATOR.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NAVIGATOR ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NAVIGATOR ("DATE_PAY", "MFOA", "NLSA", "NAM_B", "NB", "SUMMA", "NAZN") AS 
  SELECT TO_CHAR (a.dat_a, 'DD/MM/YYYY hh24:mi'),
            a.mfoa,
            a.nlsa,
            a.nam_b,
            b.nb,
            a.s / 100,
            a.nazn
       FROM arc_rrp a, banks b
      WHERE     a.dat_a >= TO_DATE ('01/01/2013', 'DD/MM/YYYY')
--            AND a.mfob = 380582
--            AND a.nlsb = 26008010306833
            AND a.id_b = '23704614' 
            AND a.mfoa = b.mfo
   ORDER BY a.dat_a, b.nb;

PROMPT *** Create  grants  V_NAVIGATOR ***
grant SELECT                                                                 on V_NAVIGATOR     to BARSREADER_ROLE;
grant FLASHBACK,SELECT                                                       on V_NAVIGATOR     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_NAVIGATOR     to START1;
grant SELECT                                                                 on V_NAVIGATOR     to UPLD;
grant FLASHBACK,SELECT                                                       on V_NAVIGATOR     to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NAVIGATOR.sql =========*** End *** ==
PROMPT ===================================================================================== 
