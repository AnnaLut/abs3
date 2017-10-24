CREATE OR REPLACE FORCE VIEW v_accp_branch
AS
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

GRANT DELETE, INSERT, SELECT, UPDATE ON v_accp_branch TO BARS_ACCESS_DEFROLE;          