

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CORPS_ACC.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CORPS_ACC ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CORPS_ACC ("RNK", "ID", "MFO", "NLS", "KV", "COMMENTS") AS 
  select
		ca.rnk,
        ca.id,
        ca.mfo,
        ca.nls,
        ca.kv,
        ca.comments
from corps_acc ca
union all
select
		cca.rnk,
		cca.id,
		cca.mfo,
		cca.nls,
		cca.kv,
		cca.comments
from clv_corps_acc cca,
     clv_request q
WHERE cca.rnk = q.rnk
    AND q.req_type IN (0, 2);

PROMPT *** Create  grants  V_CORPS_ACC ***
grant SELECT                                                                 on V_CORPS_ACC     to BARSREADER_ROLE;
grant SELECT                                                                 on V_CORPS_ACC     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CORPS_ACC     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CORPS_ACC.sql =========*** End *** ==
PROMPT ===================================================================================== 
