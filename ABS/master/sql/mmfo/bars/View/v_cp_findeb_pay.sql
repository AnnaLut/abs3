

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CP_FINDEB_PAY.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CP_FINDEB_PAY ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CP_FINDEB_PAY ("ID", "CP_ID", "RYN", "REF", "INITIAL_REF", "NLSFD", "NLSN", "OSTN", "FLAG_RUNN", "NLSR", "OSTR", "FLAG_RUNR") AS 
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
            END
               initial_ref,
            ca.nlsfd,
            MAX (CASE WHEN cpa.cp_acctype IN ('N') THEN a.nls END) NLSN,
            SUM (CASE WHEN cpa.cp_acctype IN ('N') THEN a.ostc ELSE 0 END) ostN,
            0 AS flag_runn,
            MAX (CASE WHEN cpa.cp_acctype = 'R' THEN a.nls END) NLSR,
            SUM (CASE WHEN cpa.cp_acctype = 'R' THEN a.ostc ELSE 0 END) ostR,
            0 AS flag_runr
       FROM cp_deal cd,
            cp_accc ca,
            cp_accounts cpa,
            accounts a
      WHERE     CD.RYN = CA.RYN
            AND cd.REF = cpa.cp_ref
            AND cpa.cp_acc = a.acc
            AND cd.active = 1
            AND cd.ryn IN (SELECT ryn
                             FROM cp_ryn
                            WHERE quality = -1)
   GROUP BY cd.id,
            cd.ryn,
            cd.REF,
            ca.nlsfd,
            cd.initial_ref
     HAVING SUM (CASE WHEN cpa.cp_acctype IN ('N') THEN a.ostc ELSE 0 END) !=
               0
            OR SUM (CASE WHEN cpa.cp_acctype = 'R' THEN a.ostc ELSE 0 END) !=
                  0
   ORDER BY id DESC, REF ASC;

PROMPT *** Create  grants  V_CP_FINDEB_PAY ***
grant DEBUG,DELETE,FLASHBACK,INSERT,MERGE VIEW,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on V_CP_FINDEB_PAY to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_CP_FINDEB_PAY to CP_ROLE;
grant FLASHBACK,SELECT                                                       on V_CP_FINDEB_PAY to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CP_FINDEB_PAY.sql =========*** End **
PROMPT ===================================================================================== 
