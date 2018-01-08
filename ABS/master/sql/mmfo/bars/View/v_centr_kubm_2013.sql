

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CENTR_KUBM_2013.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CENTR_KUBM_2013 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CENTR_KUBM_2013 ("KOD", "NAME", "CENA_K", "CENA", "KV", "VES_G", "VES_U", "NAMET", "PROBA", "KUP1GR", "PRD1GR", "DAT", "HH", "MI", "SS") AS 
  SELECT k.kod,
          SUBSTR (k.NAME, 1, 100),
          b.cena_k / 100,
          b.cena / 100,
          k.kv,
          k.ves,
          k.ves_un,
          t.NAME,
          k.proba,
          DECODE (NVL (k.ves, 0), 0, 0, (b.cena_k / k.ves) / 100) kup1gr,
          DECODE (NVL (k.ves, 0), 0, 0, (b.cena / k.ves) / 100) prd1gr,
          TRUNC (fdat),
          TO_CHAR (fdat, 'HH24') HH,
          TO_CHAR (fdat, 'MI') MI,
          TO_CHAR (fdat, 'SS') SS
     FROM bank_metals k, bank_metals$local b, bank_metals_type t
    WHERE k.kod = b.kod AND k.type_ = t.kod --AND b.fdat > trunc(SYSDATE) and b.fdat < sysdate
      --and b.fdat in (select max(fdat) from bank_metals$local where kod = b.kod and fdat <= sysdate)
      --and          ( cena_bm(2,k.kod) is not null or  cena_bm(1,k.kod) is not null)
	 ;

PROMPT *** Create  grants  V_CENTR_KUBM_2013 ***
grant SELECT                                                                 on V_CENTR_KUBM_2013 to BARSREADER_ROLE;
grant SELECT                                                                 on V_CENTR_KUBM_2013 to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CENTR_KUBM_2013 to START1;
grant SELECT                                                                 on V_CENTR_KUBM_2013 to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CENTR_KUBM_2013.sql =========*** End 
PROMPT ===================================================================================== 
