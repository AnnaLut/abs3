

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ANI34.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ANI34 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ANI34 ("B", "E", "G01", "G02", "G03", "G04", "G05", "G06", "G07", "G08", "G08A", "G08B", "G09", "G10", "G11", "G12", "G13", "G14", "G15", "G16", "G17", "G18", "G19", "G20", "G21", "G22") AS 
  SELECT z.B, z.E,
       DECODE (z.noga, 1, 'Форвард',  2, 'Вал.своп',  'Депо-своп') G01,
       z.tag1 G02 ,   z.ntik g03,    z.rnk g04,   c.nmk g05, z.dat g06, 
       DECODE (z.noga,1,TO_DATE(NULL),z.dat_M) g07,        z.dat_X g08,
       z.KVA g08a,    z.KVb g08b,  
       DECODE (z.noga, 1, TO_NUMBER (NULL), z.suma1)/ 100 g09,
       DECODE (z.noga, 1, TO_NUMBER (NULL), z.sumb1)/ 100 g10,
       z.suma2 / 100 g11,                   z.sumb2 / 100 g12,
       DECODE (z.noga, 1, TO_NUMBER (NULL), fx_6204 (z.tag1, '6204','**',z.B, z.E)) / 100   g13,
       DECODE (z.noga, 1, TO_NUMBER (NULL), fx_6204 (z.tag1, '6204','20',z.B, z.E)) / 100   g14,
       DECODE (z.noga, 1, TO_NUMBER (NULL), fx_6204 (z.tag1, '6204','19',z.B, z.E)) / 100   g15,
       fx_6204(z.tag1,'6209','04',z.B,z.E) / 100 g16,
       fx_6204(z.tag1,'6209','05',z.B,z.E) / 100 g17,
       fx_6204(z.tag1,'6209','06',z.B,z.E) / 100 g18,
-------------------------------------------
      (DECODE (z.noga,1,0,fx_6204(z.tag1,'6204','**',z.B,z.E)+ fx_6204 (z.tag1,'6204','20',z.B,z.E))
     + fx_6204(z.tag1,'6209','04',z.B,z.E) +
       fx_6204(z.tag1,'6209','05',z.B,z.E))/ 100 g19,
----------------------------------------------
      (DECODE (z.noga,1,0,fx_6204(z.tag1,'6204','19',z.B, z.E))
     + fx_6204(z.tag1,'6209','06',z.B,z.E))/ 100 g20,
-------------------------------------------------------
      (DECODE (z.noga,1,0,fx_6204(z.tag1,'6204','**',z.B,z.E)
     + fx_6204(z.tag1,'6204','20',z.B, z.E) + fx_6204 (z.tag1,'6204','19',z.B,z.E))
     + fx_6204(z.tag1,'6209','04',z.B,z.E)
     + fx_6204(z.tag1,'6209','05',z.B,z.E)
     + fx_6204(z.tag1,'6209','06',z.B,z.E))/ 100 g21,
------------------------------------------------------
   CASE WHEN z.dat_X <= z.E THEN 'Завершена'   ELSE 'Відкрита' END   g22 
 FROM ( SELECT FOREX.get_forextype (x.dat, MAX (GREATEST (x.dat_a, x.dat_b)),  MAX (GREATEST (x.dat_a, x.dat_b)))    kod,
               NVL (x.swap_tag, x.deal_tag) tag1,
               x.dat, x.ntik, x.rnk, v.B, v.E, COUNT (*) noga,
               MIN (LEAST (x.dat_a, x.dat_b)) dat_M,
               MAX (GREATEST (x.dat_a, x.dat_b)) dat_X,
               MIN (DECODE (NVL (x.swap_tag, x.deal_tag),   x.deal_tag, x.KVA,      NULL))    KVA,
               SUM (DECODE (NVL (x.swap_tag, x.deal_tag),   x.deal_tag, x.suma,        0))    suma1,
               SUM (DECODE (NVL (x.swap_tag, x.deal_tag),   x.deal_tag, 0,        x.sumb))    suma2,
               MIN (DECODE (NVL (x.swap_tag, x.deal_tag),   x.deal_tag, x.KVb,      NULL))    KVb,
               SUM (DECODE (NVL (x.swap_tag, x.deal_tag),   x.deal_tag, x.sumb,        0))    sumb1,
               SUM (DECODE (NVL (x.swap_tag, x.deal_tag),   x.deal_tag, 0,        x.suma))    sumb2
       FROM (SELECT * FROM fx_deal 
--WHERE SWAP_TAG = 96751  
) x, V_SFDAT v
       GROUP BY NVL (x.swap_tag, x.deal_tag), x.dat,  x.ntik,  x.rnk,  v.B, v.E
       HAVING  ( FOREX.get_forextype ( x.dat, MAX (GREATEST (x.dat_a, x.dat_b)), MAX (GREATEST (x.dat_a, x.dat_b))) = 'FORWARD'  OR COUNT (*) > 1)
          AND MIN (LEAST (x.dat_a, x.dat_b)) <= v.E    AND MAX (GREATEST (x.dat_a, x.dat_b)) >= v.B) z,
      customer c
WHERE z.rnk = c.rnk;

PROMPT *** Create  grants  V_ANI34 ***
grant SELECT                                                                 on V_ANI34         to BARSREADER_ROLE;
grant SELECT                                                                 on V_ANI34         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_ANI34         to START1;
grant SELECT                                                                 on V_ANI34         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ANI34.sql =========*** End *** ======
PROMPT ===================================================================================== 
