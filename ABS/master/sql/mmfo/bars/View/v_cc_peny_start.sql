CREATE OR REPLACE FORCE VIEW BARS.V_CC_PENY_START AS
SELECT acc, nmk, nls, kv, ostc, branch, SUM, ost_sn8, nls_sn8, ir, acc_sn8, nd
FROM 
(SELECT a.acc, c.nmk, a.nls, a.kv, TO_CHAR (p.ostc / 100, '99999999999D99',   'NLS_NUMERIC_CHARACTERS = ''. ''')  ostc,   a.branch,
        TO_CHAR (a.ostc/100,'99999999999D99',  'NLS_NUMERIC_CHARACTERS = ''. ''')    SUM,
        TO_CHAR (fost( NVL ( p.acc_sn8,  (SELECT aa.acc  FROM accounts aa, nd_acc na  WHERE na.acc = aa.acc  AND na.nd = n.nd  AND aa.tip = 'SN8'  AND ROWNUM = 1)),  gl.bd)/100,
                            '99999999999D99','NLS_NUMERIC_CHARACTERS = ''. ''')     ost_sn8,   p.nls_sn8,
         (SELECT CASE WHEN br IS NOT NULL THEN    'Базова ставка' ELSE  TO_CHAR (ir)    END  
          FROM int_ratn r  WHERE  ID = 2  AND acc = a.acc   AND bdat = (SELECT MAX (bdat)   FROM int_ratn   WHERE acc = a.acc AND ID = 2))  ir, 
         p.acc_sn8,     n.nd,    ROW_NUMBER () OVER (PARTITION BY n.nd   ORDER BY n.nd, p.ostc DESC NULLS LAST)    AS numb_nd
 FROM saldo a, customer c, cc_peny_start p, nd_acc n
 WHERE     a.rnk = c.rnk AND n.acc = a.acc AND a.acc = p.acc(+) AND a.dazs IS NULL AND a.tip IN ('SP ', 'SPN', 'SK9')
 ORDER BY n.nd, a.tip
)
WHERE numb_nd = 1 and not exists (select 1 from cc_deal where vidd <> 110);
------------------------------------------------------------------------------
GRANT DELETE, INSERT, SELECT, UPDATE, FLASHBACK ON BARS.V_CC_PENY_START TO BARS_ACCESS_DEFROLE;
