

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CP_DATES.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CP_DATES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CP_DATES ("ID", "NPP", "DOK", "DNK", "DNEY", "KUP", "NOM", "IR", "EXP_DAT") AS 
  SELECT ck.id,
            cd.NPP,
            coalesce(lag (cd.DOK) OVER (PARTITION BY ck.id, cd.id ORDER BY cd.dok), ck.dat_em) as dok,
            cd.DOK as dnk,
            (cd.DOK - coalesce(lag (cd.DOK) OVER (PARTITION BY ck.id, cd.id ORDER BY cd.dok), ck.dat_em)) as dney,
            cd.KUP,
            NVL (cd.NOM, 0) nom,
            cd.ir,
            CASE
               WHEN cd.dok >= gl.bd THEN cd.dok + NVL (ck.expiry, 0)
               ELSE NULL
            END
               AS exp_dat
       FROM cp_Dat cd, cp_kod ck
      WHERE cd.id = ck.id union all
        SELECT ck.id,
            1,
            ck.dat_em,
            null,
            ck.period_kup,
            null,
            null,ck.ir,null
       FROM cp_kod ck
      WHERE not exists (select 1 from cp_dat where id =ck.id)
   ORDER BY 1, 2;

PROMPT *** Create  grants  V_CP_DATES ***
grant SELECT                                                                 on V_CP_DATES      to BARSREADER_ROLE;
grant DEBUG,DELETE,FLASHBACK,INSERT,MERGE VIEW,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on V_CP_DATES      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CP_DATES      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CP_DATES.sql =========*** End *** ===
PROMPT ===================================================================================== 
