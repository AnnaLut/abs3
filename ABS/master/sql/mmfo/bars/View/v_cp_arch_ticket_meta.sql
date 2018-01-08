

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CP_ARCH_TICKET_META.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CP_ARCH_TICKET_META ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CP_ARCH_TICKET_META ("REF", "DOC_DATE", "TT", "STMT", "DK", "DEBIT_S", "CREDIT_S", "SOS", "NMS1", "NLS1", "KV1", "TXT", "NLS2", "KV2", "NMS2") AS 
  select o.ref,
          o.fdat,
          o.tt,
          o.stmt,
          o.dk,
          decode (o.dk, 0, o.s / 100, null) as debit_s,
          decode (o.dk, 1, o.s / 100, null) as credit_s,
          o.sos,
          a.nms as nms1,
          a.nls as nls1,
          a.kv as kv1,
          o.txt,
          r.nls as nls2,
          r.kv as kv2,
          r.nms as nms2
     from opldok o,
          accounts a,
          accounts r
    where r.acc(+) = a.accc
          and a.acc = o.acc;

PROMPT *** Create  grants  V_CP_ARCH_TICKET_META ***
grant SELECT                                                                 on V_CP_ARCH_TICKET_META to BARSREADER_ROLE;
grant SELECT                                                                 on V_CP_ARCH_TICKET_META to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CP_ARCH_TICKET_META to CP_ROLE;
grant SELECT                                                                 on V_CP_ARCH_TICKET_META to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CP_ARCH_TICKET_META.sql =========*** 
PROMPT ===================================================================================== 
