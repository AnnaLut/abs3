

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ACCP_BRANCH.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ACCP_BRANCH ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ACCP_BRANCH ("BRANCH", "OBL") AS 
  SELECT branch, obl
     FROM (SELECT branch, obl
             FROM (SELECT branch,
                          b040,
                          CASE CASE SUBSTR (B040, 9, 1)
                                  WHEN '2' THEN SUBSTR (B040, 15, 2)
                                  WHEN '0' THEN SUBSTR (B040, 4, 2)
                                  WHEN '1' THEN SUBSTR (B040, 10, 2)
                                  ELSE NULL
                               END
                             WHEN '26' THEN 1
                             WHEN '09' THEN 2
                             ELSE NULL
                          END AS obl
                     FROM branch
                    WHERE date_closed IS NULL AND LENGTH (branch) = 15)
            WHERE obl IS NOT NULL
            UNION ALL
            SELECT branch, obl
              FROM ACCP_BRANCH);

PROMPT *** Create  grants  V_ACCP_BRANCH ***
grant DELETE,INSERT,SELECT,UPDATE                                            on V_ACCP_BRANCH   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_ACCP_BRANCH   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ACCP_BRANCH.sql =========*** End *** 
PROMPT ===================================================================================== 
