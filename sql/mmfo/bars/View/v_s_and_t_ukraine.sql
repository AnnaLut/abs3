

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_S_AND_T_UKRAINE.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_S_AND_T_UKRAINE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_S_AND_T_UKRAINE ("DATE_PAY", "MFOA", "NLSA", "NB", "SUMMA", "NAZN") AS 
  SELECT   TO_CHAR (a.dat_a, 'DD/MM/YYYY hh24:mi'),
              a.mfoa,
              a.nlsa,
              b.nb,
              a.s / 100,
              a.nazn
       FROM   arc_rrp a, banks b
      WHERE       a.dat_a >= to_date('01/03/2011','DD/MM/YYYY')
              AND a.mfob = 380582
              AND a.nlsb = 26008010306833
              AND a.mfoa = b.mfo
   ORDER BY   a.dat_a, b.nb;

PROMPT *** Create  grants  V_S_AND_T_UKRAINE ***
grant FLASHBACK,SELECT                                                       on V_S_AND_T_UKRAINE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_S_AND_T_UKRAINE to START1;
grant FLASHBACK,SELECT                                                       on V_S_AND_T_UKRAINE to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_S_AND_T_UKRAINE.sql =========*** End 
PROMPT ===================================================================================== 
