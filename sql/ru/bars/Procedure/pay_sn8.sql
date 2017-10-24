

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/PAY_SN8.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure PAY_SN8 ***

  CREATE OR REPLACE PROCEDURE BARS.PAY_SN8 (FL_ INT)
IS
-- DAV 18.04.2012 Изменил операцию оплаты на с 013 на 015 по логике
-- 8008 - 8006 операции должны быть в одной валюте !!!!

-- ver 1.01 Убал перем l_ACR_DAT
--  l_ACR_DAT date := to_date('28-02-2009','dd-mm-yyyy') ;
  l_NLS_SN8 accounts.NLS%type ;
  l_ACC_SN8 accounts.ACC%type ;
  l_SPN_SD8 accounts.NLS%type := GetGlobalOption('SPN_SD8') ;
  RET_  int;   dk_ int; s_ number;  REF_ OPER.REF%type;
begin
 for k in (select v.nmk, a.rnk,a.isp, a.grp, a.nls, a.kv, a.branch,
                  v.ND, a.mdate, a.acc,
                  v.ostc*100 S, v.acc_SN8
           from v_cc_peny_start v,   accounts a
           where v.ostc<>0 and a.acc=v.acc
--and a.nls='206933026933'
)
 loop
    bars_context.subst_branch(k.branch);
    begin
    select a.nls,a.acc
      into l_NLS_SN8,l_ACC_SN8
      from accounts a,nd_acc n
           where n.acc=a.acc and n.nd=k.nd and a.tip='SN8'
                 and a.dazs is null and rownum=1;
    exception when no_data_found then
     l_ACC_SN8:=null;
    end;
    if l_ACC_SN8 is null then
       -- Aвто-открытие счетов пени
       l_NLS_SN8 := VKRZN(substr(gl.aMFO,1,5),'80080'||substr(k.nls,6,9) );
       cck.cc_op_nls(k.ND,k.KV,l_NLS_SN8,'SN8',k.ISP,k.GRP,'1',k.mdate,l_ACC_SN8);

    end if;

--       update int_accn set acr_dat = l_ACR_DAT where acc=k.ACC and id=2;

       update cc_peny_start set ACC_SN8=l_ACC_SN8, NLS_SN8=l_NLS_SN8
              where acc=k.acc;



    if k.S>= 0 then S_:= k.S; dk_:=1;
    else            S_:=-k.S; dk_:=0;
    end if;

    GL.REF (REF_);
    GL.IN_DOC3 ( REF_,'015', 6, REF_, SYSDATE ,GL.BDATE, dk_,
                 K.KV, S_, k.kv, S_, null,   GL.BDATE,GL.BDATE,
                 substr(k.nmk,1,38), l_NLS_SN8, gl.AMFO,
                 'Контр.Pах', l_SPN_SD8, gl.AMFO,
      'Несплачена Пеня, що нарахована до автоматичного нарахування.',
             NULL,null,null,null ,null, null,null, null);
    GL.PAYV(0,REF_,GL.BDATE,'015',dk_,K.KV, l_NLS_SN8, S_, k.kv, l_SPN_SD8, S_);

If FL_= 2 then
    GL.PAY (2,REF_,GL.BDATE);
end if;

    update cc_peny_start set ostc=0 where acc=k.acc;

commit;

  end loop;

  bc.set_context;
end PAY_SN8;
/
show err;

PROMPT *** Create  grants  PAY_SN8 ***
grant EXECUTE                                                                on PAY_SN8         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on PAY_SN8         to RCC_DEAL;
grant EXECUTE                                                                on PAY_SN8         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/PAY_SN8.sql =========*** End *** =
PROMPT ===================================================================================== 
