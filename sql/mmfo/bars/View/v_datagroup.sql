

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DATAGROUP.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DATAGROUP ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DATAGROUP ("DATE_PAY", "MFOA", "NLSA", "NB", "SUMMA", "NAZN") AS 
  SELECT   TO_CHAR (a.dat_a, 'DD/MM/YYYY hh24:mi'),
              a.mfoa,
              a.nlsa,
              b.nb,
              a.s / 100,
              a.nazn
       FROM   arc_rrp a, banks b
      WHERE       a.dat_a >= '01-oct-2011'
              AND a.mfob = 351005
              AND a.nlsb = 26003266043700
              AND a.mfoa = b.mfo
   ORDER BY   a.dat_a, b.nb;

PROMPT *** Create  grants  V_DATAGROUP ***
grant FLASHBACK,SELECT                                                       on V_DATAGROUP     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DATAGROUP     to START1;
grant FLASHBACK,SELECT                                                       on V_DATAGROUP     to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DATAGROUP.sql =========*** End *** ==
PROMPT ===================================================================================== 
