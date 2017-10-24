

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/NACH_VN3.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure NACH_VN3 ***

  CREATE OR REPLACE PROCEDURE BARS.NACH_VN3 (p_MFO varchar2, p_DAT date) is

/*

 Sta 13-04-2010 Передача даты в проц x*_3800 (тест-Черкасы)

ЧАСТЬ III.  необходимая. Валютные позиции.
*/
  branch_  varchar2(30) := '/'||p_MFO||'/';
  dat31_   date;
  dat30_   date;
  nTmp_    number;
begin

  bars_context.subst_branch(branch_);

  --закрыть навсегда иногодные счета
  for k in (select acc from accounts
            where nbs='6204' and kv<>980 and daZs is null)
  loop
     update accounts set daZs = GL.bd-1 where acc=k.acc;
  end loop;

  xm_3800 ( p_MFO, null, p_DAT );
  commit;
  xv_3800 ( p_MFO, null, p_DAT );
  commit;
  xz_3800 ( p_MFO, null, p_DAT );
  commit;

  --спот-курсы
  select max(fdat)  into dat31_ from fdat where fdat < trunc(P_DAT,'MM');
  If dat31_ is null then dat31_ := P_DAT; end if;

  select max(fdat) into dat30_ from fdat where fdat < DAT31_;

  If DAT30_ is not null then

     for k in (select a.kv,
           SUM(decode(sign(fost(a.acc,DAT30_)), 1,fostq(a.acc,DAT30_),0)) QP,
           SUM(decode(sign(fost(a.acc,DAT30_)), 1,fost (a.acc,DAT30_),0)) NP,
           SUM(decode(sign(fost(a.acc,DAT30_)),-1,fostq(a.acc,DAT30_),0)) QA,
           SUM(decode(sign(fost(a.acc,DAT30_)),-1,fost (a.acc,DAT30_),0)) NA
               from accounts a where a.nbs='3800'
               group by a.KV)

     loop
       If k.NP >0 then

          nTmp_ := k.QP / k.NP;

          insert into SPOT( KV, VDATE, acc, RATE_K, RATE_P, BRANCH)
          select a.kv, DAT30_, a.acc, nTmp_, 0, a.branch
          from accounts a
          where a.acc in (select acc3800 from vp_list)
            and a.ostc>0 and a.kv=k.KV
            and not exists
              (select 1 from spot where acc=a.acc and vdate=dat30_);

       elsIf k.NA < 0 then

          nTmp_ := k.QA / k.NA;
          insert into SPOT( KV, VDATE, acc, RATE_K, RATE_P, BRANCH)
          select a.kv, DAT30_, a.acc, 0, nTmp_, a.branch
          from accounts a
          where acc in (select acc3800 from vp_list)
            and ostc<0 and a.kv=k.KV
            and not exists
              (select 1 from spot where acc=a.acc and vdate=dat30_);


       else
          insert into SPOT( KV, VDATE, acc, RATE_K, RATE_P, BRANCH)
          select a.kv, DAT30_, a.acc, 0, 0, a.branch
          from accounts a
          where acc in (select acc3800 from vp_list)
            and ostc=0 and a.kv=k.KV
            and not exists
              (select 1 from spot where acc=a.acc and vdate=dat30_);

       end if;

     end loop;

     commit;
  end if;

  bc.set_context;

  -- 1.Для нерухомих -- создать мат.представление

  neruxomi;

end NACH_VN3;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/NACH_VN3.sql =========*** End *** 
PROMPT ===================================================================================== 
