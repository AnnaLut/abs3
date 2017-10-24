

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_3800_6204.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_3800_6204 ***

  CREATE OR REPLACE PROCEDURE BARS.P_3800_6204 ( p_mode int ) is

--   27-04-2011 Ќе брать закрытые валюты, закрытые счета. особенно 954
--   26-11-2010 —ухова.

/*
 ---------------------------------------
 p_MODE = 1
  засе€ть/пересе€ть  VP_LIST  нужными счетами 6204
  в зависимости от бранча и об22 счета 3800

  Ёто можно использовать при :
      1) внедрении
      2) присоединении филиала
      3) переоткрытия 6204
  ƒелу Ќ≈ вредит.  ¬ыполнять можно сколько угодно раз, и когда угодно.
 ---------------------------------------
 p_MODE = 2
   засе€ть SPOT офф курсами, если нет записи никакой

*/

 o1_ char(2);  o2_ char(2);  o3_ char(2); BSUM_ int := 100000000; DAT_ date;
begin

If p_MODE = 2 then

   DAT_ := gl.BDATE -1 ;

   insert into SPOT (KV, BRANCH, VDATE, ACC, RATE_K, RATE_P )
   select a.kv, a.branch , DAT_, a.acc,
          gl.p_icurval( a.kv, BSUM_, DAT_ ) / BSUM_ ,
          gl.p_icurval( a.kv, BSUM_, DAT_ ) / BSUM_
   from accounts a, vp_list v, tabval t
   where v.acc3800= a.acc
     and t.kv = a.kv
     and t.d_close is null
     and a.dazs is null
     and t.kv not in (954)
     and not exists (select 1 from spot where acc=a.acc);

   RETURN;

end if;

for k in (select a.kv,a.branch,a.acc,s.ob22 from accounts a,vp_list v, specparam_int s
          where v.acc3800 = a.acc and a.acc = s.acc )
loop
  If k.kv in (959,961,962) then o1_ :='15'; o2_ :='07'; o3_ :='06';
  else
     if k.ob22 ='10'       then o1_ :='01'; o2_ :='10'; o3_ :='09';
     else                       o1_ :='01'; o2_ :='08'; o3_ :='05';
     end if;
  end if;

  update  vp_list
    set acc6204=(select acc from accounts where kv=980 and nls =
                 nvl(nbs_ob22_null('6204',o1_,k.branch),nbs_ob22('6204',o1_))),
        acc_rrr=(select acc from accounts where kv=980 and nls =
                 nvl(nbs_ob22_null('6204',o2_,k.branch),nbs_ob22('6204',o2_))),
        acc_rrs=(select acc from accounts where kv=980 and nls =
                 nvl(nbs_ob22_null('6204',o3_,k.branch),nbs_ob22('6204',o3_)))
  where acc3800 = k.acc;

end loop;

update vp_list set acc_rrd = acc_rrr;

end P_3800_6204;
/
show err;

PROMPT *** Create  grants  P_3800_6204 ***
grant EXECUTE                                                                on P_3800_6204     to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_3800_6204     to CUST001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_3800_6204.sql =========*** End *
PROMPT ===================================================================================== 
