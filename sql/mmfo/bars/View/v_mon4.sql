

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_MON4.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_MON4 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_MON4 ("CENA1", "CENAF1", "KOD", "NAME", "NOM_MON", "CENA2", "KODF", "NAMEF", "CENAF2", "PRODAZA") AS 
  SELECT cena1,
          cenaf1,
          kod,
          NAME,
          nom_mon,
          cena2,
          kodf,
          namef,
          cenaf2,
          make_docinput_url ('BKY',
                             'Продати',
                             'reqv_BM__C',
                             kod,
                             'reqv_BM__N',
                             NAME,
                             'reqv_BM__Y',
                             nom_mon,
                             'reqv_BM__R',
                             cena2,
                             'reqv_BM_FC',
                             kodf,
                             'reqv_BM_FN',
                             namef,
                             'reqv_BM_FR',
                             cenaf2)
     FROM v_mon0
    WHERE nom_mon <> 0;

PROMPT *** Create  grants  V_MON4 ***
grant SELECT                                                                 on V_MON4          to BARSREADER_ROLE;
grant FLASHBACK,SELECT                                                       on V_MON4          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_MON4          to PYOD001;
grant SELECT                                                                 on V_MON4          to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_MON4          to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on V_MON4          to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_MON4.sql =========*** End *** =======
PROMPT ===================================================================================== 
