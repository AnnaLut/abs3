

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_VAL_283.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_VAL_283 ***

  CREATE OR REPLACE PROCEDURE BARS.P_VAL_283 (p_dat1 date, p_dat2 date, p_branch varchar2)
is
     l_period number:=92;
     G_MODULE          constant varchar2(64)  := 'REP';
begin
       if p_dat1 > p_dat2 then
          bars_error.raise_error(G_MODULE, 43, to_char(p_dat1,'dd/mm/yyyy'), to_char(p_dat2,'dd/mm/yyyy'));
       end if;

       if p_dat2 - p_dat1 > l_period then
          bars_error.raise_error(G_MODULE, 44, to_char(l_period), to_char(p_dat2 - p_dat1));
       end if;
/*
	цей запит треба переписати так як він важкий

*/

delete from valuta_283;

insert into valuta_283
SELECT x.KV, t.LCV, t.NAME, x.BRANCH, b.name NAMEB,
       x.KUPL_VAL, x.ZATR_GRN, x.PROD_VAL, x.VYRU_GRN, x.KURS_KUPL, x.KURS_PROD
FROM tabval t,
     branch b,
     (
select
sum(nvl(decode(a.kp,'KUP',a.NOM),0)) kupl_val,
sum(nvl(decode(a.kp,'KUP',a.EQ),0)) zatr_grn,
case when sum(nvl(decode(a.kp,'KUP',a.NOM),0))>0 then
round(sum(nvl(decode(a.kp,'KUP',a.NOM),0)*f_numeric_characters(a.kurs))/sum(nvl(decode(a.kp,'KUP',a.NOM),0)), 4) else 0 end kurs_kupl,
--nvl(decode(a.kp, 'KUP', a.kurs),0) kurs_kupl,
sum(nvl(decode(a.kp,'PROD',a.NOM),0)) prod_val,
sum(nvl(decode(a.kp,'PROD',a.EQ),0)) vyru_grn,
case when sum(nvl(decode(a.kp,'PROD',a.NOM),0))>0 then
round(sum(nvl(decode(a.kp,'PROD',a.NOM),0)*f_numeric_characters(a.kurs))/sum(nvl(decode(a.kp,'PROD',a.NOM),0)), 4) else 0 end kurs_prod,
--nvl(decode(a.kp, 'PROD', a.kurs),0) kurs_prod,
a.kv,
a.branch
 from (
select 'KUP' kp, a.fdat,a.kv, a.branch, a.s nom, a.sq eq, /*o.value*/
case when f_operw(a.ref, 'KURS') is null then to_char(f_ret_rate(a.kv, a.fdat, 'B')) when a.tt='046' then  to_char(f_ret_rate(a.kv, a.fdat, 'B'))
else f_operw(a.ref, 'KURS') end kurs
from (
select o.ref, o.fdat, o.tt, o.dk d, a.nls nls1002, a.kv,o2.dk k, a2.nls nls3800, o.s, o3.sq, a.branch
from opldok o, accounts a, opldok o2, accounts a2, opldok o3, accounts a3, opldok o4, accounts a4, oper r
where o.fdat>= p_dat1
  and o.fdat<= p_dat2
  and o.acc=a.acc
  and r.ref=o.ref
  and r.sos=5
  and o.tt<>'045'
  and o3.tt<>'045'
  and o.tt<>'145'
  and o3.tt<>'145'
  and a.nbs like '100%'
 -- and ((a.kv=980 and a2.kv<>980) or (a.kv<>980 and a2.kv=980))
  and o.dk=0
  and o2.dk=1
  and o2.ref=o.ref
  and o2.stmt=o.stmt
  and o2.acc=a2.acc
  and a2.nbs='3800'
  and o3.ref=o.ref
  and o3.acc=a3.acc
  and a3.nbs='3801'
  and o3.dk=0
  and o3.stmt=o4.stmt
  and o4.ref=o.ref
  and o4.acc=a4.acc
  and a4.nbs like '100%'
  and o4.dk=1
  ) a /*, operw o
  where a.ref=o.ref
  and o.tag='KURS'
  and a.branch like  p_branch||'%'*/
  where a.branch like  p_branch||'%'
 --group by a.fdat,a.kv, a.branch
  union all
  select 'PROD' kp, a.fdat,a.kv, a.branch, a.s nom, a.sq eq, /*o.value*/
  case when f_operw(a.ref, 'KURS') is null then to_char(f_ret_rate(a.kv, a.fdat, 'S')) when a.tt='046' then  to_char(f_ret_rate(a.kv, a.fdat, 'S'))
  else f_operw(a.ref, 'KURS') end kurs from (
select o.ref, o.fdat, o.tt, o.dk d, a.nls nls1002, a.kv,o2.dk k, a2.nls nls3800, o.s, o3.sq, a.branch
from opldok o, accounts a, opldok o2, accounts a2, opldok o3, accounts a3, opldok o4, accounts a4, oper r
where o.fdat>= p_dat1
  and o.fdat<= p_dat2
  and r.ref=o.ref
  and r.sos=5
  and o.tt<>'045'
  and o3.tt<>'045'
  and o.tt<>'145'
  and o3.tt<>'145'
  and o.acc=a.acc
  and a.nbs like '100%'
  --and ((a.kv=980 and a2.kv<>980) or (a.kv<>980 and a2.kv=980))
  and o.dk=1
  and o2.dk=0
  and o2.ref=o.ref
  and o2.stmt=o.stmt
  and o2.acc=a2.acc
  and a2.nbs='3800'
  and o3.ref=o.ref
  and o3.acc=a3.acc
  and a3.nbs='3801'
  and o3.dk=1
  and o3.stmt=o4.stmt
  and o4.ref=o.ref
  and o4.acc=a4.acc
  and a4.nbs like '100%'
  and o4.dk=0
  ) a/*, operw o
  where a.ref=o.ref
  and o.tag='KURS'
  and a.branch like  p_branch||'%'*/
  where a.branch like  p_branch||'%'
 -- group by a.fdat,a.kv, a.branch
   ) a
   group by kv,branch--, nvl(decode(a.kp, 'KUP', a.kurs),0), nvl(decode(a.kp, 'PROD', a.kurs),0)
  order by branch, kv
    )x
    WHERE x.kv=t.kv and x.branch=b.branch
ORDER BY x.KV, x.BRANCH;
End;
/
show err;

PROMPT *** Create  grants  P_VAL_283 ***
grant EXECUTE                                                                on P_VAL_283       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_VAL_283       to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_VAL_283.sql =========*** End ***
PROMPT ===================================================================================== 
