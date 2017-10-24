

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/SW_STMT_CUSTOMER_LIST.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  view SW_STMT_CUSTOMER_LIST ***

  CREATE OR REPLACE FORCE VIEW BARS.SW_STMT_CUSTOMER_LIST ("RNK", "NMK", "BIC", "STMT") AS 
  (
SELECT c.rnk, c.nmk, b.bic, c.stmt
 FROM customer c, custbank b
 WHERE c.rnk=b.rnk AND c.stmt IN (10,11) AND c.custtype=1
UNION
SELECT c.rnk, c.nmk, b.bic, TO_NUMBER(w.value)
 FROM customer c, custbank b,
      (SELECT rnk, tag, max(value) value FROM customerw GROUP BY rnk, tag) w
 WHERE c.rnk=b.rnk AND c.custtype=1 AND w.rnk=c.rnk AND w.tag='STMT ' AND
       w.value in ('10','11')
)
UNION ALL
(
SELECT c.rnk, c.nmk, SUBSTR(b.value,1,11) bic, c.stmt
 FROM customer c, (SELECT rnk, tag, max(value) value FROM customerw GROUP BY rnk, tag) b
 WHERE c.rnk=b.rnk AND
       b.tag='BIC  ' AND
       b.value IS NOT NULL AND
       c.stmt IN (10,11) AND c.custtype=2
UNION
SELECT c.rnk, c.nmk, SUBSTR(b.value,1,11) bic, TO_NUMBER(w.value)
 FROM customer c,
      (SELECT rnk, tag, max(value) value FROM customerw GROUP BY rnk, tag) b,
      (SELECT rnk, tag, max(value) value FROM customerw GROUP BY rnk, tag) w
 WHERE c.rnk=b.rnk AND c.rnk=w.rnk AND
       b.tag='BIC  ' AND
       b.value IS NOT NULL AND
       w.tag='STMT ' AND
       w.value in ('10','11') AND
       c.custtype=2
)
ORDER BY bic
 ;

PROMPT *** Create  grants  SW_STMT_CUSTOMER_LIST ***
grant SELECT                                                                 on SW_STMT_CUSTOMER_LIST to BARS013;
grant SELECT                                                                 on SW_STMT_CUSTOMER_LIST to BARS_ACCESS_DEFROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SW_STMT_CUSTOMER_LIST to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/SW_STMT_CUSTOMER_LIST.sql =========*** 
PROMPT ===================================================================================== 
