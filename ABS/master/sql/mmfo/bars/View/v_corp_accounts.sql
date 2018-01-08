

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CORP_ACCOUNTS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CORP_ACCOUNTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CORP_ACCOUNTS ("CORP_KOD", "CORP_NAME", "RNK", "NMK", "ACC", "NLS", "KV", "NMS", "INST_KOD", "INST_NAME", "TRKK_KOD", "USE_INVP", "VPTYPE", "ALT_CORP_COD", "BRANCH", "DAOS", "DAZS") AS 
  select corp_kod,  corp_name, rnk,  nmk,  acc, nls, kv, nms,  inst_kod,
       name_upf inst_name, trkk_kod, use_invp, vptype, alt_corp_cod, branch, daos, dazs
from (
        select k.kod_cli corp_kod, name_cli corp_name,  c.rnk, c.nmk, a.acc, a.nls, a.kv, a.nms,
               w2.value inst_kod, s.typnls trkk_kod, nvl(w1.value, 'N') use_invp,
               w3.value vptype, alt_corp_cod, a.branch, daos, dazs
          from (select a.rnk, a.branch, a.acc, a.nls, a.kv, a.nms, r.kodk corp_kod,
                       rk.kodk  alt_corp_cod, daos, dazs
                  from accounts      a,
                       rnkp_kod      r,
                       rnkp_kod_acc  rk
                 where a.rnk = r.rnk and a.acc = rk. acc(+)
               )a,
               customer      c,
               accountsw     w1,
               accountsw     w2,
               accountsw     w3,
               specparam_int s,
               kod_cli       k
         where a.rnk = c.rnk
           and a.acc = w1.acc(+) and w1.tag(+) = 'CORPV'
           and a.acc = w2.acc(+) and w2.tag(+) = 'KODU'
           and a.acc = w3.acc(+) and w3.tag(+) = 'VPTYP'
           and to_char(a.corp_kod)  = k.kod_cli
           and a.acc     = s.acc(+)
     ) a, org_pfu o
where  to_char(o.kod_upf(+)) = to_char(a.inst_kod);

PROMPT *** Create  grants  V_CORP_ACCOUNTS ***
grant SELECT                                                                 on V_CORP_ACCOUNTS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CORP_ACCOUNTS to CORP_CLIENT;
grant SELECT                                                                 on V_CORP_ACCOUNTS to RPBN001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CORP_ACCOUNTS.sql =========*** End **
PROMPT ===================================================================================== 
