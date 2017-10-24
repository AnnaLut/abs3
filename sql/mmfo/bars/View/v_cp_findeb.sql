

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CP_FINDEB.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CP_FINDEB ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CP_FINDEB ("ID", "CP_ID", "RYN", "REF", "INITIAL_REF", "NLSFD", "NLSN", "OSTN", "NLSR", "OSTR", "NLSR2", "OSTR2", "NLSR3", "OSTR3", "NLSEXPR", "OSTEXPR", "NLSD", "OSTD", "NLSP", "OSTP", "NLSS", "OSTS", "RNK", "FLAG_RUN") AS 
  SELECT cd.id,
            (SELECT cp_id
               FROM cp_kod
              WHERE id = cd.id)
               AS cp_id,
            cd.ryn,
            cd.REF,
            CASE
               WHEN cd.ryn IN (SELECT ryn
                                 FROM cp_ryn
                                WHERE quality = -1)
               THEN
                  cd.initial_ref
               ELSE
                  NULL
            END,
            ca.nlsfd,
            MAX (CASE WHEN cpa.cp_acctype IN ('N', 's3541') THEN a.nls END)
               NLSN,
            SUM (
               CASE
                  WHEN cpa.cp_acctype IN ('N', 's3541') THEN a.ostc
                  ELSE 0
               END)
            / 100
               ostN,
            MAX (CASE WHEN cpa.cp_acctype = 'R' THEN a.nls END) NLSR,
            SUM (CASE WHEN cpa.cp_acctype = 'R' THEN a.ostc ELSE 0 END) / 100
               ostR,
            MAX (CASE WHEN cpa.cp_acctype = 'R2' THEN a.nls END) NLSR2,
            SUM (CASE WHEN cpa.cp_acctype = 'R2' THEN a.ostc ELSE 0 END) / 100
               ostr2,
            MAX (CASE WHEN cpa.cp_acctype = 'R3' THEN a.nls END) NLSR3,
            SUM (CASE WHEN cpa.cp_acctype = 'R3' THEN a.ostc ELSE 0 END) / 100
               ostr3,
            MAX (CASE WHEN cpa.cp_acctype = 'EXPR' THEN a.nls END) NLSEXPR,
            SUM (CASE WHEN cpa.cp_acctype = 'EXPR' THEN a.ostc ELSE 0 END) / 100
               ostexpr,               
            MAX (CASE WHEN cpa.cp_acctype = 'D' THEN a.nls END) NLSD,
            SUM (CASE WHEN cpa.cp_acctype = 'D' THEN a.ostc ELSE 0 END) / 100
               ostD,
            MAX (CASE WHEN cpa.cp_acctype = 'P' THEN a.nls END) NLSP,
            SUM (CASE WHEN cpa.cp_acctype = 'P' THEN a.ostc ELSE 0 END) / 100
               ostP,
            MAX (CASE WHEN cpa.cp_acctype = 'S' THEN a.nls END) NLSS,
            SUM (CASE WHEN cpa.cp_acctype = 'S' THEN a.ostc ELSE 0 END) / 100
               ostS,
            MIN (a.rnk) rnk,
            0 AS flag_run
       FROM cp_deal cd,
            cp_accc ca,
            cp_accounts cpa,
            accounts a
      WHERE     CD.RYN = CA.RYN
            AND cd.REF = cpa.cp_ref
            AND cpa.cp_acc = a.acc
            AND cd.active = 1
   GROUP BY cd.id,
            cd.ryn,
            cd.REF,
            ca.nlsfd,
            cd.initial_ref
   ORDER BY id DESC, REF ASC;

PROMPT *** Create  grants  V_CP_FINDEB ***
grant DEBUG,DELETE,FLASHBACK,INSERT,MERGE VIEW,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on V_CP_FINDEB     to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_CP_FINDEB     to CP_ROLE;
grant FLASHBACK,SELECT                                                       on V_CP_FINDEB     to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CP_FINDEB.sql =========*** End *** ==
PROMPT ===================================================================================== 
