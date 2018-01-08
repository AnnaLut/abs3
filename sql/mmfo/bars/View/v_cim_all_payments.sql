

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CIM_ALL_PAYMENTS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CIM_ALL_PAYMENTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CIM_ALL_PAYMENTS ("REF", "DK", "TT", "KV", "S", "VDAT", "NAM_A", "NLSA", "MFOA", "NAM_B", "NLSB", "MFOB", "PDAT", "SOS", "CURRVISAGRP", "NEXTVISAGRP", "KF", "BRANCH", "NAZN", "DIRECT") AS 
  with all_pay as
 (select /*+ MATERIALIZE*/
   a.ref, a.dk, a.tt, a.kv, a.s, a.vdat,
   -- nvl((select max(k.fdat) from opldok k where k.ref=a.ref and fdat>(bankdate-30)),a.vdat) as vdat,
   a.nam_a, a.nlsa, a.mfoa, a.nam_b, a.nlsb, a.mfob, a.pdat, a.sos,
   a.currvisagrp, a.nextvisagrp, a.kf, a.branch, a.nazn --, a.direct
    from (select b.* /*,
                           cim_mgr .check_visa_condition(b.dk,
                                                         b.kv,
                                                         b.nlsa,
                                                         b.nlsb,
                                                         b.tt,
                                                         b.ref)  as direct*/
             from (select o.ref, o.dk, o.tt, o.kv, o.s, o.nam_a, o.nlsa, o.mfoa,
                           o.nam_b, o.nlsb, o.mfob, o.pdat, o.vdat, o.sos,
                           o.currvisagrp, o.nextvisagrp, o.kf, o.branch, o.nazn
                      from ref_que q
                      join oper o
                        on q.ref = o.ref
                     where o.pdat > bankdate - 30) b) a
    left outer join (select tt from chklist_tts where idchk = 7) t
      on t.tt = a.tt
   where /*o.branch like SYS_CONTEXT ('bars_context', 'user_branch_mask') and*/
   a.sos >= 0 and a.sos < 5 /*and a.direct is not null*/
   and (t.tt is null and a.nextvisagrp != '05' or a.nextvisagrp = '07'))
select o."REF",o."DK",o."TT",o."KV",o."S",o."VDAT",o."NAM_A",o."NLSA",o."MFOA",o."NAM_B",o."NLSB",o."MFOB",o."PDAT",o."SOS",o."CURRVISAGRP",o."NEXTVISAGRP",o."KF",o."BRANCH",o."NAZN",o."DIRECT"
  from (select b.*,
               cim_mgr.check_visa_condition(b.dk, b.kv, b.nlsa, b.nlsb, b.tt, b.ref) as direct
           from all_pay b) o
 where o.direct is not null;

PROMPT *** Create  grants  V_CIM_ALL_PAYMENTS ***
grant SELECT                                                                 on V_CIM_ALL_PAYMENTS to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CIM_ALL_PAYMENTS.sql =========*** End
PROMPT ===================================================================================== 
