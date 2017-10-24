
CREATE OR REPLACE VIEW V_XOZKWT as 
select  a.kv, a.nls, a.ob22, a.branch, a.ostc/100 ost, a.nms, x.REF1, x.STMT1, x.REF2, x.ACC, x.MDATE, x.S/100 s, x.FDAT, x.S0/100 s0, x.DATZ
from xoz_ref x, accounts a  where a.acc= x.acc and  x.datz = NVL( to_date (pul.GET('DATZ'), 'dd.mm.yyyy') , gl.bd )  ;
/