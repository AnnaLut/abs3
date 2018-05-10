PROMPT *** Create  view EBK_QUEUE_RELATEDPERSON_V ***

CREATE OR REPLACE FORCE VIEW BARS.EBK_QUEUE_RELATEDPERSON_V
( "KF", "relId", "RELATEDNESS", "relIntext", "RNK", "relRnk", "NOTES"
, CUST_ID
) AS
  select c.kf
     , t.rel_id      as "relId"
     , r.relatedness
     , t.rel_intext  as "relIntext"
     , t.RNK
     , t.rel_rnk     as "relRnk"
     , t.notes
     , t.RNK          as CUST_ID
  from BARS.V_CUSTOMER_REL t
     , BARS.CUST_REL r
     , BARS.CUSTOMER c
 where t.rel_id = r.id
   and t.rnk = c.rnk
   and c.CUSTTYPE = 3
   and (c.BC = 0 or c.BC is null)
   and (c.date_off is NULL or c.date_off > sysdate)
   and t.rnk <> t.rel_rnk
   and exists (select null from EBK_QUEUE_UPDATECARD where rnk = c.rnk )
;

show errors;

grant SELECT on EBK_QUEUE_RELATEDPERSON_V to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/EBK_QUEUE_RELATEDPERSON_V.sql =========
PROMPT ===================================================================================== 
