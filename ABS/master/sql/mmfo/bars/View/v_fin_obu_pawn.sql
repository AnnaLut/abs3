

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FIN_OBU_PAWN.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FIN_OBU_PAWN ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FIN_OBU_PAWN ("ID", "ND", "RNK", "PAWN", "NAME", "PR", "KV", "S_SPV", "SUMP_E", "P_ZAST", "DATP", "ACC", "NLS", "SV") AS 
  select distinct p.id,p.nd, p.rnk, p.pawn, cp.name,  c.pr, p.kv, p.s_spv s_spv, gl.p_icurval(p.kv,p.s_spv,sysdate)*c.pr/100 as sump_e, p.p_zast, p.datp, 0 as acc, null as nls, p.s_spv as sv
          from FIN_OBU_PAWN p,  cc_pawn_s080 c, cc_pawn cp
          where 
           p.pawn = cp.pawn and  c.s080(+) = 1
          and c.pawn(+) = cp.pawn_23 and acc is null
union all
select distinct p.id,p.nd, p.rnk, nvl(pp.pawn,p.pawn) pawn, cp.name,  c.pr, p.kv, nvl(pp.ostc/100,p.s_spv) s_spv, gl.p_icurval(nvl(pp.kv,p.kv),nvl(pp.ostc,p.s_spv),sysdate)*c.pr/100 as sump_e, p.p_zast, p.datp, pp.acc, pp.nls, decode(pp.sv,null, nvl(pp.ostc/100,p.s_spv),pp.sv/100)
          from FIN_OBU_PAWN p,  cc_pawn_s080 c, cc_pawn cp, (     select pp.acc, pp.pawn , abs(a.ostc) as ostc, cc.nd, a.kv, a.nls, abs(pp.SV)  as sv
                                                                                                   from  pawn_acc pp, cc_accp cc, accounts a 
                                                                                                 where cc.acc = pp.acc and pp.acc = a.acc) pp 
          where  
           --p.pawn = c.pawn(+) and
           c.pawn(+) = cp.pawn_23  and
           c.s080(+) = 1
          and nvl(pp.pawn,p.pawn) = cp.pawn
          and p.acc = pp.acc
union all
                select distinct -acc id, a.nd, dc.rnk  rnk, a.pawn , cp.name,  c.pr, a.kv, a.ostc/100 s_spv, gl.p_icurval(a.kv,a.ostc,sysdate)*c.pr/100 as sump_e, null p_zast, null datp, a.acc, a.nls, decode(a.sv,null,a.ostc/100,a.SV/100)
          from  ( select distinct pp.pawn, a.acc,  a.kv, abs(a.ostc) as ostc, cc.nd, a.rnk, a.nls, abs(pp.SV)  as sv
                             from  pawn_acc pp, cc_accp cc, accounts a
                             where --cc.nd = 269 and
                                   cc.acc   = pp.acc
                             and pp.acc = a.acc
                             and not exists (select 1 from FIN_OBU_PAWN where a.acc = acc and nd = cc.nd )) a,
                  cc_pawn_s080 c,cc_pawn cp, cc_deal dc
                  where     --a.nd = 5093701 and    
                    cp.pawn_23 = c.pawn(+)  and  c.s080(+) = 1 and a.pawn = cp.pawn and a.nd = dc.nd;

PROMPT *** Create  grants  V_FIN_OBU_PAWN ***
grant SELECT                                                                 on V_FIN_OBU_PAWN  to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_FIN_OBU_PAWN  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_FIN_OBU_PAWN  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FIN_OBU_PAWN.sql =========*** End ***
PROMPT ===================================================================================== 
