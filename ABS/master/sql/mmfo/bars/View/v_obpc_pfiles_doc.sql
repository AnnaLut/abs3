

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OBPC_PFILES_DOC.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OBPC_PFILES_DOC ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OBPC_PFILES_DOC ("FILE_NAME", "FILE_DATE", "CARD_ACCT", "REF", "TT", "NLS_A", "NAM_A", "NLS_B", "NAM_B", "S", "LCV", "NAZN", "BRANCH") AS 
  select k.f_n, f_d, k.card_acct, k.ref, k.tt,
       k.nlsa, k.nam_a, k.nlsb, k.nam_b,
       k.s, v.lcv, k.nazn, k.branch
  from ( -- pkk_history_arc - tag=CDAC
         select q.f_n, q.f_d, w.value card_acct, o.ref, q.acc, o.tt,
                decode (o.dk, 0, o.nlsb, o.nlsa) nlsa,
                decode (o.dk, 0, o.nam_b, o.nam_a) nam_a,
                decode (o.dk, 0, o.nlsa, o.nlsb) nlsb,
                decode (o.dk, 0, o.nam_a, o.nam_b) nam_b,
                o.s/100 s, o.nazn, o.branch
           from pkk_history_arc q, oper o, operw w
          where q.ref = o.ref
            and o.ref = w.ref and w.tag = 'CDAC'
         union all
         -- pkk_history - dk=1, tag=CDAC
         select q.f_n, q.f_d, w.value card_acct, o.ref, q.acc, o.tt,
                decode (o.dk, 0, o.nlsb, o.nlsa) nlsa,
                decode (o.dk, 0, o.nam_b, o.nam_a) nam_a,
                decode (o.dk, 0, o.nlsa, o.nlsb) nlsb,
                decode (o.dk, 0, o.nam_a, o.nam_b) nam_b,
                o.s/100 s, o.nazn, o.branch
           from pkk_history q, oper o, operw w
          where q.ref = o.ref
            and q.dk  = 1
            and o.ref = w.ref and w.tag = 'OBDT'
         union all
         -- pkk_history - dk=0, tag=CDAC2
         select q.f_n, q.f_d, w.value card_acct, o.ref, q.acc, o.tt,
                decode (o.dk, 0, o.nlsb, o.nlsa) nlsa,
                decode (o.dk, 0, o.nam_b, o.nam_a) nam_a,
                decode (o.dk, 0, o.nlsa, o.nlsb) nlsb,
                decode (o.dk, 0, o.nam_a, o.nam_b) nam_b,
                o.s/100 s, o.nazn, o.branch
           from pkk_history q, oper o, operw w
          where q.ref = o.ref
            and q.dk  = 0
            and o.ref = w.ref and w.tag = 'OBDT2'
         union all
         -- pkk_que
         select q.f_n, q.f_d, q.card_acct, o.ref, q.acc, o.tt,
                decode (o.dk, 0, o.nlsb, o.nlsa) nlsa,
                decode (o.dk, 0, o.nam_b, o.nam_a) nam_a,
                decode (o.dk, 0, o.nlsa, o.nlsb) nlsb,
                decode (o.dk, 0, o.nam_a, o.nam_b) nam_b,
                o.s/100, o.nazn, o.branch
           from pkk_que q, oper o
          where q.sos = 1
            and q.ref = o.ref ) k, accounts a, tabval$global v
 where k.acc = a.acc
   and a.kv = v.kv
   and k.branch like sys_context ('bars_context', 'user_branch_mask')
union all
select k.f_n, f_d, k.card_acct, k.rec, k.tt,
       k.nlsa, k.nam_a, k.nlsb, k.nam_b,
       k.s, v.lcv, k.nazn, k.branch
  from ( select q.f_n, q.f_d, q.card_acct, o.rec, null acc, null tt,
                o.nlsa, o.nam_a, o.nlsb, o.nam_b,
                o.s/100 s, o.nazn, '/' || o.kf || '/' branch, o.kv
           from pkk_inf_history q, arc_rrp o
          where q.rec = o.rec
         union all
         select q.f_n, q.f_d, q.card_acct, o.rec, null acc, null tt,
                o.nlsa, o.nam_a, o.nlsb, o.nam_b,
                o.s/100, o.nazn, '/' || o.kf || '/', o.kv
           from pkk_inf_arc q, arc_rrp o
          where q.rec = o.rec) k, tabval$global v
 where k.kv = v.kv
   and k.branch like sys_context ('bars_context', 'user_branch_mask');

PROMPT *** Create  grants  V_OBPC_PFILES_DOC ***
grant SELECT                                                                 on V_OBPC_PFILES_DOC to BARSREADER_ROLE;
grant SELECT                                                                 on V_OBPC_PFILES_DOC to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_OBPC_PFILES_DOC to OBPC;
grant SELECT                                                                 on V_OBPC_PFILES_DOC to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OBPC_PFILES_DOC.sql =========*** End 
PROMPT ===================================================================================== 
