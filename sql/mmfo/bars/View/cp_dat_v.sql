

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CP_DAT_V.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view CP_DAT_V ***

  CREATE OR REPLACE FORCE VIEW BARS.CP_DAT_V ("CP_ID", "ID", "DAT_EM", "DATP", "NPP", "DAYS", "DNK", "DOK", "KUP", "NOM") AS 
  SELECT k.cp_id,
            np1.id,
            k.dat_em,
            k.datp,
            np1.npp,
            DECODE (np1.npp, 1, np1.dok - k.dat_em, np1.dok - np0.dok) DAYS,
            np1.dok DNK,
            DECODE (np1.npp, 1, k.dat_em, np0.dok) DOK,
            np1.kup,
            NVL (np1.nom, 0) NOM
       FROM cp_kod k, (SELECT d.id,
                              d.dok,
                              npp,
                              kup,
                              nom
                         FROM cp_dat d) np1, (SELECT d.id,
                                                     d.dok,
                                                     npp,
                                                     kup,
                                                     nom
                                                FROM cp_dat d) np0
      WHERE     np1.id = k.id
            AND np0.id = np1.id
            AND np0.npp = DECODE (np1.npp, 1, np1.npp, np1.npp - 1) --and rownum < 1000
   --   and cena!=cena_start
   ORDER BY 2, 7;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CP_DAT_V.sql =========*** End *** =====
PROMPT ===================================================================================== 
