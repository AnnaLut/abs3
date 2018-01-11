

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_PF_ACCOUNTS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_PF_ACCOUNTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_PF_ACCOUNTS ("ACC", "NLS", "KV", "NMS", "UPF_CODE", "UPF_NAME", "RNK", "USE_INVP1", "USE_INVP2") AS 
  select  acc, nls, kv, nms,  o.kod_upf, o.name_upf, rnk, use_invp1, use_invp2
  from (
        select a.acc, nls, kv, nms,  w3.value kod_upf, a.rnk, nvl(w1.value, 0) use_invp1, nvl(w2.value, 0) use_invp2
        from accounts a,
             accountsw w1,
             accountsw w2,
             accountsw w3,
             rnkp_kod r
       where a.rnk = r.rnk
         and a.acc = w1.acc(+) and w1.tag(+) = 'VPPF'
         and a.acc = w2.acc(+) and w2.tag(+) = 'VPPF2'
         and a.acc = w3.acc(+) and w3.tag(+) = 'KODU'
         and r.kodk = 1
       ) a, org_pfu o
 where a.kod_upf = to_char(o.kod_upf(+));

PROMPT *** Create  grants  V_PF_ACCOUNTS ***
grant SELECT                                                                 on V_PF_ACCOUNTS   to BARSREADER_ROLE;
grant SELECT                                                                 on V_PF_ACCOUNTS   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_PF_ACCOUNTS   to RPBN001;
grant SELECT                                                                 on V_PF_ACCOUNTS   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_PF_ACCOUNTS.sql =========*** End *** 
PROMPT ===================================================================================== 
