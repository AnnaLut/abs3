

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NAVIGATOR2.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NAVIGATOR2 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NAVIGATOR2 ("DATE_PAY", "MFOA", "NLSA", "NAM_B", "NB", "SUMMA", "NAZN") AS 
  SELECT   TO_CHAR (a.dat_a, 'DD/MM/YYYY hh24:mi'),
              a.mfoa,
              a.nlsa,
              a.nam_b,
              b.nb,
              a.s / 100,
              a.nazn
       FROM   arc_rrp a, banks b
      WHERE       a.dat_a >= TO_DATE ('01/10/2011', 'DD/MM/YYYY')
              AND a.mfob = '300164'
              AND a.nlsb = '26004005965401'
              AND a.mfoa = b.mfo
   ORDER BY   a.dat_a, b.nb;

PROMPT *** Create  grants  V_NAVIGATOR2 ***
grant FLASHBACK,SELECT                                                       on V_NAVIGATOR2    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_NAVIGATOR2    to START1;
grant FLASHBACK,SELECT                                                       on V_NAVIGATOR2    to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NAVIGATOR2.sql =========*** End *** =
PROMPT ===================================================================================== 
