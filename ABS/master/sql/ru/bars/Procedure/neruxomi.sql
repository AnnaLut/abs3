

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/NERUXOMI.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure NERUXOMI ***

  CREATE OR REPLACE PROCEDURE BARS.NERUXOMI (p_Mode int DEFAULT NULL)
IS
/*
  06-03-2013  в MV_NERUXOMI добавив для 2635   '15', '16' аналітику

  13-03-2011 ob22 переехал в accounts

  28-02-2011 Спот берем для тех вал. котор?е реально существуют
  Дану процедуру все-таки краще виконувати вiд BARS,
  т.я. вона знаходиться в Армi <Розробника>,
  а також призначена для всiляких  обранiзацiйних <перебудов>.

  Я виправила в нiй (по споту) тiльки аналiз на реальнi <робочi> вал.,
  бо було на всi,  а це погано,
  т.я. по ним може просто не було навiть оф.курсу,
  наприклад, по валютам 233, 954, ...
  -----------------------------------

  после миграции МФО или после присоединения филиала надо:
  1) Обновить материализованную вюшку MV_NERUXOMI
  2) Переустановить НЕТТО-поз по операторам лотерей
  3) Доустановки СПОТ-курсов по VP_LIST
  4) Наполнение справочника Для подмены счета 3800 на 7 кл
     при нач.%% (или штрафов) в АСВО

*/

BEGIN

  --  1) Обновить материализованную вюшку MV_NERUXOMI
  begin
    execute immediate 'DROP MATERIALIZED VIEW MV_NERUXOMI';
  exception when others then    null;
  end;

  begin
    execute immediate '
CREATE MATERIALIZED VIEW MV_NERUXOMI
 NOCACHE LOGGING NOCOMPRESS NOPARALLEL BUILD IMMEDIATE
 REFRESH FORCE ON DEMAND WITH PRIMARY KEY AS
SELECT acc, nls, nbs, nms, branch, ob22
FROM accounts a
WHERE a.dazs IS NULL
  AND a.tip = ''ODB''
  AND ( a.nbs = ''2620'' AND ob22 IN (''08'', ''09'', ''11'', ''12'', ''05'')
     OR a.nbs = ''2630'' AND ob22 IN (''11'', ''12'', ''13'', ''14'', ''16'')
     OR a.nbs = ''2635'' AND ob22 IN (''13'', ''14'',''15'',''16'')
     OR a.nbs = ''2628'' AND ob22 IN (''05'')
     OR a.nbs = ''2638'' AND ob22 IN (''17'', ''16'', ''02'')
     OR a.nbs = ''2909'' AND ob22 IN (''18'')
        )';
  exception when others then    null;
  end;

  begin
    execute immediate 'COMMENT ON MATERIALIZED VIEW MV_NERUXOMI IS ''snapshot table for snapshot BARS.MV_NERUXOMI''';
  exception when others then
    null;
  end;

  sys.utl_recomp.recomp_serial('BARS');


-- 2) Переустановить НЕТТО-поз по операторам лотерей

-- онлайн-котроль
-- остатков по операторам лотерей на красное нетто-садьдо
-- при необходимости произвести выплату с 2805 и при оссутствии средств
-- на НЕТТО- позиции . можно поставить лимит на соотв.счет 8999_0000000хх

begin
   EXECUTE IMMEDIATE  'alter TRIGGER TBIU_ACCOUNTS_NBS disable' ;
exception  when others then
   null;
end;

declare
  rnk_  accounts.rnk%type;
  isp_  accounts.isp%type;
  grp_  accounts.grp%type;
  nls_  accounts.nls%type;
  accr_ accounts.acc%type;
  ostc_ accounts.OSTc%type;
  ostb_ accounts.OSTb%type;
  p4_   int;
begin
  TUDA;
  for k in (select substr(txt,1,70) nms,ob22        from sb_ob22
            where r020 = '2905' and  d_close is null )
  loop
     begin
        -- открыть род.счет
        select a.rnk, a.isp, a.grp into rnk_,isp_,grp_
        from accounts a, specparam_int s
        where a.nbs='2905' and a.dazs is null
        and rownum=1 and a.acc=s.acc and  s.ob22=k.ob22 ;

        nls_ :=  vkrzn(substr(gl.amfo,1,5), '899000000000' || k.ob22 );
        op_reg(99,0,0,GRP_,p4_,rnk_,nls_,980,k.nms,'ODB',isp_,accR_);
        update accounts set ostc=0, ostb=0 , nbs= null, pap=3 where acc=accR_;

       -- выставить на нем ост  и подвязать его детей
       delete from saldoa where acc=accR_;
       -- подвязать его детей
       for p in (select a.acc,a.ostc,a.ostb from accounts a, specparam_int i
                 where a.acc=i.acc and i.ob22=k.ob22
                   and a.nbs in ('2905','2805') )
       loop
          update accounts set ostc = ostc + p.ostc,
                              ostb = ostb + p.ostb
                 where acc=accr_;
          update accounts set accc = accR_ where acc=p.acc;
       end loop;

       update accounts set pap=2, lim=0 where acc=accR_;

     EXCEPTION WHEN NO_DATA_FOUND THEN null;
     end;
  end loop;
  commit;
end;

--3) Доустановка СПОТ-курсов = офф по VP_LIST
  TUDA;
declare
  S_ number := 10000000000;
  D_ date   := gl.bd - 1  ;
begin
  insert into SPOT ( KV, VDATE, ACC, BRANCH, RATE_K, RATE_P )
  select a.kv, D_, a.acc, a.branch ,
         gl.p_icurval (a.kv,S_,D_)/S_, gl.p_icurval (a.kv,S_,D_)/S_
  from accounts a, vp_list v
  where a.acc = v.acc3800
    and not exists (select 1 from spot where acc=a.ACC)
    and kv in (select kv from accounts where ostc<>0);
  commit;
end;

--4) Наполнение справочника Для подмены счета 3800 на 7 кл при нач.%% (или штрафов) в АСВО
declare
  nls7d_ varchar2(15);  nls7k_ varchar2(15);
begin
  insert into asvo_dptconsacc (branch,  intnbs ,  intob22,  intname )
  select DISTINCT substr(a.branch,1,15) , a.NBS,  i.ob22, substr(s.txt,1,100)
  from accounts a, specparam_int i , sb_ob22 s
  where a.nbs in (select bsn from dpt_vidd )
    and a.kv <> 980    and a.dazs is null and a.acc= i.acc and a.tip<>'DEN'
    and s.r020 = a.nbs and s.ob22=i.ob22  and a.nbs like '___8'
    and not exists (select 1
                    from asvo_dptconsacc
                    where branch=substr(a.branch,1,15)
                      and intnbs=a.nbs and intob22=i.ob22
                    ) ;

  FOR k in (select * from asvo_dptconsacc where expnlsd is null)
  loop
    begin
        select nbs_ob22_null(nbs_exp, ob22_exp, k.branch),  -- nls витрат
               nbs_ob22_null(nbs_exp, ob22_red, k.branch)   -- nls зменшення витрат
          into nls7d_, nls7k_
          from dpt_ob22
         where nbs_int = k.intnbs
           and ob22_int= k.intob22
           and rownum=1;


        update asvo_dptconsacc
           set expnlsd = nls7d_,
               expnlsk = nls7k_
         where branch = k.branch
           and intnbs = k.intnbs
           and intob22= k.intob22;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN null;
    end;
  end loop;

  commit;

end;
  SUDA;

end NERUXOMI;
/
show err;

PROMPT *** Create  grants  NERUXOMI ***
grant EXECUTE                                                                on NERUXOMI        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on NERUXOMI        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/NERUXOMI.sql =========*** End *** 
PROMPT ===================================================================================== 
