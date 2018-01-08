

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_PRIOCOM_DOC_STATUS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  view V_PRIOCOM_DOC_STATUS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_PRIOCOM_DOC_STATUS ("FNAME", "ROWNUMBER", "OPERDATE", "DOC_ID", "STATUS", "ERRMESSAGE") AS 
  select
    d.fname,
    d.rownumber,
    d.operdate,
    d.ref as doc_id,
    4 as status,
    d.errmessage
from priocom_documents d
where d.ref is null
union all
select
    d.fname,
    d.rownumber,
    d.operdate,
    d.ref as doc_id,
    case
        when o.sos=5 then 5
        when o.sos<0 then 4
        when o.sos>=1 and o.sos<5 then 2
        else 0
    end
    as status,
    case
        when o.sos=5 then null
        when o.sos<0 then (select value from operw where ref=o.ref and tag='BACKR')
        else null
    end
    as errmessage
from priocom_documents d, oper o
where d.ref is not null and d.ref=o.ref;

PROMPT *** Create  grants  V_PRIOCOM_DOC_STATUS ***
grant SELECT                                                                 on V_PRIOCOM_DOC_STATUS to BARSREADER_ROLE;
grant SELECT                                                                 on V_PRIOCOM_DOC_STATUS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_PRIOCOM_DOC_STATUS to START1;
grant SELECT                                                                 on V_PRIOCOM_DOC_STATUS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_PRIOCOM_DOC_STATUS.sql =========*** E
PROMPT ===================================================================================== 
