

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CORP2_DOCS.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CORP2_DOCS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CORP2_DOCS ("REF", "PDAT", "TT", "KV", "BRANCH", "USERID", "NLSA", "SOS", "DOC_ID", "STATUS_ID", "STATUS_CHANGE_TIME", "TYPE_ID", "DOC_DESC", "TYPE_NAME") AS 
  select o.ref, o.pdat, o.tt, o.kv, o.branch,o.userid, o.nlsa, o.sos, d.doc_id, d.status_id, d.status_change_time, d.type_id, d.doc_desc,
decode(d.type_id, 'P_INT','Внутрішній платіж','P_SEP', 'Зовнішній платіж', 'I_CUREXCH', 'Купівля/продаж валюти', 'P_SWIFT', 'Платіжне доручення') type_name
from oper o, barsaq.doc_export d, barsaq.doc_import i
where o.ref=d.bank_ref and d.doc_desc is not null and o.sos > 0 and d.doc_id=to_number(i.ext_ref) and i.ref=o.ref;

PROMPT *** Create  grants  V_CORP2_DOCS ***
grant SELECT                                                                 on V_CORP2_DOCS    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CORP2_DOCS    to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CORP2_DOCS.sql =========*** End *** =
PROMPT ===================================================================================== 
