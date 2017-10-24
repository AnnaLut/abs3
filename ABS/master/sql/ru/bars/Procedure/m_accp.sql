

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/M_ACCP.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  procedure M_ACCP ***

  CREATE OR REPLACE PROCEDURE BARS.M_ACCP ( MOD_ int, ND_ int, ACCZ_ int, tip_ int) is


/*
19.03.2015 Сухова

ACCZ_ =  pawn_acc.ACC           счета залога
ND_   =  pawn_acc.DEPOSIT_ID    ID депозита
tip_  =  пока не исп

дд.мм.гггг Марценюк Л.
MOD_ = 0  - Отсоединить
MOD_ = 1  - Присоединить
MOD_ = 15 - Привязать ИД деп.дог в договору залога
-----------------------
TIP_ = 1 - Кредиты
TIP_ = 2 - ОВЕРДРАФТЫ
TIP_ = 3 - БПК

*/
 MPAWN_ int;
 PAWN_  int;
 RNK_   int;
 NDZ_   int;

begin
   if MOD_ = 15 then ---- Привязать ИД деп.дог в договору залога
      update pawn_acc set DEPOSIT_ID = ND_ where acc = ACCZ_;
      Return;
   end if;
   logger.info('ACCP-1 : MOD_='||MOD_||' ND_='||ND_||' ACCZ_='||ACCZ_||' tip_'||tip_);

   if MOD_ =1 then
      ---присoединить
      if tip_ = 1 THEN  -- Кредиты
         for k in (select n.acc,a.tip from nd_acc n, accounts a
                   where a.acc=n.acc and  n.nd =ND_   and
                         a.tip in ('SS ','SL ','SP ','CR9','SN ','SNO','SPN') and
                        (ACCZ_,n.acc) not in (select acc,accs from cc_accp)
                   )
         loop
            INSERT INTO cc_accp (ACC,ND, ACCS,pr_12 ) values (ACCZ_,ND_,k.acc,2);
         end loop;
      Elsif tip_ = 2 THEN  -- ОВЕРДРАФТЫ
         for k in (select * from (select acco acc, nd from acc_over union all
                   select acc_9129, nd from acc_over where acc_9129 is not null union all
                   select a.acc,  o.nd from accounts a,acc_over o
                   where a.acc = (select acra from int_accn where id=0 and acc=o.acco)
                         and a.nbs not like '8%') where nd = nd_
                  )
         loop
            INSERT INTO cc_accp (ACC,ND, ACCS,pr_12 ) values (ACCZ_,ND_,k.acc,2);
         end loop;
      Elsif tip_ = 3 THEN  -- БПК

         for k in (select * from (select acc_2207 ACC,nd from v_W4_acc where acc_2207 is not null union all
                                  select acc_PK      ,nd from v_W4_acc where acc_PK   is not null union all
                                  select acc_2209    ,nd from v_W4_acc where acc_2209 is not null union all
                                  select acc_2208    ,nd from v_W4_acc where acc_2208 is not null union all
                                  select ACC_OVR     ,nd from v_W4_acc where acc_OVR  is not null union all
                                  select ACC_9129    ,nd from v_W4_acc where acc_9129 is not null) b
                   where b.nd = nd_
                  )
         loop
            logger.info('ACCP-0 : accs= ' || k.acc||' ND='||nd_) ;
            INSERT INTO cc_accp (ACC,ND, ACCS,pr_12 ) values (ACCZ_,ND_,k.acc,2);
         end loop;
      end if;
   else
      ---oтсоединить
      --DELETE from cc_accp
      --where ACC=ACCZ_ and ACCS in (select acc from nd_acc where nd=ND_);
      DELETE from cc_accp where ACC=ACCZ_ and nd=ND_;

   end if;


end;
/
show err;

PROMPT *** Create  grants  M_ACCP ***
grant EXECUTE                                                                on M_ACCP          to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/M_ACCP.sql =========*** End *** ==
PROMPT ===================================================================================== 
