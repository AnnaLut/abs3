PROMPT ===================================================================================== 
PROMPT *** Run *** ======= Scripts /Sql/BARS/View/V_OZNAKA_351.sql ======*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OZNAKA_351 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OZNAKA_351 AS 
  SELECT o.id,
            pul.get_mas_ini_val ('ND') nd,
            DECODE (NVL (n.id, 0), 0, 0, 1) pr,
            o.kod,
            o.txt
       FROM (select * from nd_oznaka_351 n where nd = pul.get_mas_ini_val ('ND') )  n, oznaka_351 o
      WHERE     o.kod = n.kod (+)
   ORDER BY id;

PROMPT *** Create  grants V_OZNAKA_351  ***
grant SELECT, UPDATE                                    on V_OZNAKA_351          to BARS_ACCESS_DEFROLE;
grant SELECT, UPDATE                                    on V_OZNAKA_351          to START1;
grant SELECT, UPDATE                                    on V_OZNAKA_351          to UPLD;


PROMPT ===================================================================================== 
PROMPT *** End *** ======= Scripts /Sql/BARS/View/V_OZNAKA_351.sql ======*** End *** =======
PROMPT ===================================================================================== 

