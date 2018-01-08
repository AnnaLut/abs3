

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OBPC_PFILES_FORM.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OBPC_PFILES_FORM ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OBPC_PFILES_FORM ("DOC_TYPE", "REF", "DK", "CARD_ACC", "CARD_NO", "VDAT", "TRAN_TYPE", "S", "LCV", "NLS", "TIP", "BRN") AS 
  select 1, q.ref, q.dk, x.value card_acc, null card_no,
       d.vdat, t.tran_type, d.s s, v.lcv, a.nls, a.tip,
       i.demand_brn brn
  from pkk_que q, operw x, oper d, obpc_trans_out t, accounts a,
       tabval$global v, specparam_int i
 where q.sos = 0
   and q.ref = x.ref(+) and x.tag(+) = decode(q.dk,1,'CDAC ','CDAC2')
   and q.ref = d.ref and d.tt = t.tt
   and q.dk = t.dk
   and q.acc = a.acc and a.kv = v.kv
   and a.acc = i.acc(+)
       -- оплачен
   and (    d.sos = 5
       -- по плану и след. виза = 30 Контролер БПК
         or d.sos = 1 and d.nextvisagrp = lpad(chk.to_hex(to_number(getglobaloption('BPK_CHK'))),2,'0') )
   and t.tt in (select tt from obpc_trans_out having count(tt) = 1 group by tt)
union all
-- документы на пополнение-списание (списание с карточки на карточку)
select 1, q.ref, q.dk, null card_acc, null card_no,
       d.vdat, t.tran_type, d.s s, v.lcv, a.nls, a.tip,
       i.demand_brn brn
  from pkk_que q, oper d, obpc_trans_out t, accounts a,
       tabval$global v, specparam_int i
 where q.sos = 0
   and q.ref = d.ref and d.tt = t.tt
   and q.dk = t.dk
   and q.acc = a.acc and a.kv = v.kv
   and a.acc = i.acc(+)
       -- по плану
   and d.sos = 1
       -- документы на списание, след. виза = 30 Контролер БПК
   and ( q.dk = 0 and d.nextvisagrp = lpad(chk.to_hex(to_number(getglobaloption('BPK_CHK'))),2,'0')
       -- документы на пополнение, след. виза = 31 Контролер БПК-2
      or q.dk = 1 and d.nextvisagrp = lpad(chk.to_hex(to_number(getglobaloption('BPK_CHK2'))),2,'0') )
   and t.tt in (select tt from obpc_trans_out having count(tt) = 2 group by tt)
 union all
-- информационные документы (dk=3)
select 2, q.rec, d.dk, null card_acc, null card_no,
       d.datp, t.tran_type, d.s s, a.currency, a.lacct, a.tip, null brn
  from pkk_inf q, arc_rrp d, obpc_trans_inf t, obpc_acct_imp a
 where q.rec  = d.rec and d.dk = 3 and d.sos >= 3
   and d.nlsb = t.transit_nls
   and q.nls  = a.lacct
   and q.kv   = decode(a.currency, 'UAH', 980, 840);

PROMPT *** Create  grants  V_OBPC_PFILES_FORM ***
grant SELECT                                                                 on V_OBPC_PFILES_FORM to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_OBPC_PFILES_FORM to OBPC;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_OBPC_PFILES_FORM to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OBPC_PFILES_FORM.sql =========*** End
PROMPT ===================================================================================== 
