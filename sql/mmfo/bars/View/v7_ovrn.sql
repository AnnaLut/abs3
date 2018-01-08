create or replace view v7_ovrn as
select d.REF, d.ACC, d.datm , o.ND, o.VDAT, o.S/100 s , o.tt, o.ID_A, o.NAM_A, o.NLSA, o.MFOA, o.NAZN, o.NAM_B, o.NLSB, o.MFOB
from OVR_CHKO_DET  d, oper o
where d.ref = o.ref  and acc   = PUL.get('ACC26')  and d.datm = TO_DATE ( pul.get ('DATM01'), 'dd.mm.yyyy');

grant select on  BARS.v7_ovrn  to start1 ;
grant select on  BARS.v7_ovrn  to BARS_ACCESS_DEFROLE ; 