

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/EBK_QUEUE_RELATEDPERSON_V.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  view EBK_QUEUE_RELATEDPERSON_V ***

  CREATE OR REPLACE FORCE VIEW BARS.EBK_QUEUE_RELATEDPERSON_V ("KF", "relId", "RELATEDNESS", "relIntext", "RNK", "relRnk", "NOTES") AS 
  with ss as (select gl.kf as kf from dual)
select
ss_kf.kf as kf,
t.rel_id as  "relId",
r.relatedness as  relatedness,
t.rel_intext  as  "relIntext",
t.rnk as rnk,
t.rel_rnk as  "relRnk",
t.notes as notes
from v_customer_rel t,
cust_rel r,
customer c,
ss ss_kf
where t.rel_id = r.id
and t.rnk = c.rnk
and c.CUSTTYPE = 3
and (c.BC = 0 or c.BC is null)
and (c.date_off is NULL or c.date_off > sysdate)
and t.rnk <> t.rel_rnk
and exists (select null from ebk_queue_updatecard where rnk = c.rnk );

PROMPT *** Create  grants  EBK_QUEUE_RELATEDPERSON_V ***
grant SELECT                                                                 on EBK_QUEUE_RELATEDPERSON_V to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/EBK_QUEUE_RELATEDPERSON_V.sql =========
PROMPT ===================================================================================== 
