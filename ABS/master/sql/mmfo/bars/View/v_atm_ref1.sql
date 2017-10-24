prompt ####################################################################################
prompt ... Вюшки-гляделки  D:\K\MMFO\kwt_2924\Sql\View\ATM_vie.sql 
prompt ..........................................

create or replace view v_ATMREF1 as 
select a.acc, a.kv, a.nls, a.nms, a.branch, a.tip, a.ob22, a.ostc/100 OSTC , a.pap-1 DK, 
       r1.REF1, o1.vdat vdat1, o1.s/100 s1, o1.tt||'*'||o1.nazn nazn1,  NVL(r2.KOL,0) kol,  NVL(r2.S/100,0) S2  , (o1.S - nvl(r2.s,0))/100 DEL  
from (select * from accounts where acc = to_number(pul.GET('ATM_ACC')) )  a, 
     (select * from atm_ref1 where acc = to_number(pul.GET('ATM_ACC')) ) r1, 
     oper o1,  
     (select r.ref1, count(*) kol, sum (o.s) s from atm_ref2 r, oper o where o.ref = r.ref2 and o.sos = 5 group by r.ref1) r2 
where a.acc =  r1.acc and r1.ref1 = o1.ref   and r1.ref1 = r2.ref1 (+)  and o1.sos = 5 ;

grant select  on bars.v_ATMREF1  TO BARS_ACCESS_DEFROLE;

