

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_PRIOCOM_FILTER_CLIENTS.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  view V_PRIOCOM_FILTER_CLIENTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_PRIOCOM_FILTER_CLIENTS ("CODE", "CODESAB", "STATUS", "CL_TYPE", "KOD_FIL", "IDENT", "SYSNAME", "REGDATE") AS 
  select
    rnk as code,
    rnk as codesab,
    decode(date_off,null,1,2) as status,
    decode(custtype,3,2,1) as cl_type,
    null as kod_fil,
    okpo as ident,
    nmk as sysname,
    date_on as regdate
from customer;

PROMPT *** Create  grants  V_PRIOCOM_FILTER_CLIENTS ***
grant SELECT                                                                 on V_PRIOCOM_FILTER_CLIENTS to BARSREADER_ROLE;
grant SELECT                                                                 on V_PRIOCOM_FILTER_CLIENTS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_PRIOCOM_FILTER_CLIENTS to START1;
grant SELECT                                                                 on V_PRIOCOM_FILTER_CLIENTS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_PRIOCOM_FILTER_CLIENTS.sql =========*
PROMPT ===================================================================================== 
