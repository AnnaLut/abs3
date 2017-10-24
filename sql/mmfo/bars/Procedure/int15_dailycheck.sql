

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/INT15_DAILYCHECK.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure INT15_DAILYCHECK ***

  CREATE OR REPLACE PROCEDURE BARS.INT15_DAILYCHECK (p_dat date)
is
l_s15 number :=0;
l_s15v number :=0;
l_tax_nls varchar2(14);
l_tax_nls_back varchar2(14);
l_tax number;
l_tax_date_begin date;
l_tax_date_end date;
l_bdat date := bankdate;
l_acc_a number;
l_ost number :=0;
l_blkd number :=0;
l_tax_back number :=0;
l_main_acc number;
l_acr_dat date;
l_tax_payed_int number :=0;
l_tax_payed_dep number :=0;
l_tax_payed number;
l_tax_nms varchar2(38);
l_tax_mfo varchar2(50);
l_tax_id varchar2(10);
l_dat date;

l_bdate date;
l_mfo  varchar2(50);

l_ref number;

begin

   l_dat:= to_date(to_char(p_dat,'dd/mm/yyyy'),'dd/mm/yyyy');

   l_tax:=GetGlobalOption('TAX_INT');
   l_tax_date_begin := to_date(GetGlobalOption('TAX_DON'), 'dd.mm.yyyy');
   l_tax_date_end := to_date(nvl(GetGlobalOption('TAX_DOFF'),to_char(add_months(p_dat,1),'dd.mm.yyyy')), 'dd.mm.yyyy');

   if p_dat between l_tax_date_begin and l_tax_date_end

   then
  -- отбираю все начисления ФЛ за указанный банкдень (без разбора, снимался налог, или не снимался)
   for k in (select a.branch as BRA, o.*
                from oper o, accounts a where
                o.vdat = l_dat
                and o.tt = '%%1'
                and o.sos = 5
                and o.dk=0
                and A.nls=o.nlsa
                and length(trim(a.branch))>20
                and substr(o.nlsb, 1,2) =  '70'
                and (substr(o.nlsa, 1,4) ='2628' or substr(o.nlsa, 1,4)= '2638')
                and not exists (select 1 from int_accn where acc in (  select  acc  from accounts
                                                                                              where nbs = '2620'
                                                                                              and ob22 in (14, 17, 20, 21)   --кроме счетов ЗП, соц выплат, пенсий, стипендий
                                                                                              and dazs is null )
                                      and acra = a.acc)
                )

    loop
     -- определяю АСС процентного счета, по которому прошло начисление, остаток, признак блокироваки счета на Дт
          begin
              select acc, ostc, blkd
              into l_acc_a, l_ost, l_blkd
              from accounts
              where nls = k.nlsa
              and kv = k.kv;
          exception
            when no_data_found then
            null;
          end;
     -- вычитываю счета, для аккумулирования налога с начислений ФО по отделению
        l_tax_nls := nbs_ob22_null(3622,37,k.BRA);
        l_tax_nls_back := nbs_ob22_null(3522,29,k.BRA);

        select substr(a.nms,1,38), a.kf, c.okpo
        into l_tax_nms, l_tax_mfo, l_tax_id
        from accounts a, customer c
        where a.rnk = c.rnk
        and a.nls = ltrim(rtrim(l_tax_nls));


       -- определяю АСС основного счета, по которому прошло начисление,  и дату начала налогообложения в качестве даты, с которой будет "игровое" начисление для опеределия базы налогообложения
       select acc, l_tax_date_begin
       into l_main_acc, l_acr_dat
       from int_accn
       where acra = l_acc_a
       and id = 1; -- код процентной карточки - основной. считаем, что начисление по обычной ставке, а не по штрафной

     -- определяю сумму снятых налогов по процентному счету - за "всегда"
        select nvl(sum(s),0)
        into l_tax_payed_int
        from opldok
        where acc =l_acc_a
        and tt = '%15'
        and sos = 5
        and dk=0
        and (fdat <= l_dat or fdat=bankdate);

        -- определяю сумму снятых налогов по основному счету - за "всегда"
        select nvl(sum(s),0)
        into l_tax_payed_dep
        from opldok
        where acc =l_main_acc
        and tt = '%15'
        and sos = 5
        and dk=0
        and (fdat <= l_dat or fdat=bankdate);

        l_tax_payed := l_tax_payed_dep + l_tax_payed_int;

         l_bdate := gl.bdate;
         l_mfo   := gl.amfo;

        acrn.p_int ( l_main_acc,     -- внутр.номер основного счета
                                  1,     -- код процентной карточки
                                  l_acr_dat, -- начальная дата начисления -- константа, дата ввода в действие закона 01/08
                                  dat_next_u(l_dat,-1) , -- конечная дата начисления (всегда сегодняшний БД-1)
                                  l_s15,    -- сумма начисленных процентов OUT с  даты ввода в действие закона 01/08
                                  null, -- сумма начисления
                                  0); -- игровой режим без проводок - посмотреть базу налогообложения

        l_s15:= l_s15*l_tax;
        l_s15:= round(l_s15,0) - l_tax_payed; -- из расчитанного налога от базы налогообложения за "все время"  отнимаем уже стянутый налог (за все время)
        l_s15v :=p_icurval(k.kv, l_s15, k.vdat);

        if l_s15> 0 and l_ost >= l_s15 and l_blkd = 0 then -- если сумма необлаченного налога есть, остаток позволяет, и блокировки счета на Дт нет, то порождаем документ Дт 2638 - Кт 3622

           gl.ref(l_ref);

              gl.in_doc3 (ref_    => l_ref,
                      tt_     => '%15',
                      vob_    => 6,
                      nd_     => to_char(l_ref),
                      pdat_   => sysdate,
                      vdat_   => bankdate,
                      dk_     => 1,
                      kv_     => k.kv,
                      s_      => l_s15,
                      kv2_    => 980,
                      s2_     => l_s15v,
                      sk_     => null,
                      data_   => bankdate,
                      datp_   => bankdate,
                      nam_a_  =>  k.nam_a,
                      nlsa_   => k.nlsa,
                      mfoa_   => nvl(k.mfoa,l_mfo),
                      nam_b_  => l_tax_nms,
                      nlsb_   => l_tax_nls,
                      mfob_   => nvl(l_tax_mfo,l_mfo),
                      nazn_   => 'Стягнення податку з процентних доходів фізичних осіб за ' || to_char(p_dat,'dd.mm.yyyy'),
                      d_rec_  => null,
                      id_a_   => k.id_a,
                      id_b_   => k.id_a,
                      id_o_   => null,
                      sign_   => null,
                      sos_    => null,
                      prty_   => 0,
                      uid_    => user_id);

           gl.payv(1, l_ref, bankdate,'%15', 1, k.kv, k.nlsa, l_s15, k.kv2,l_tax_nls, l_s15v);
        end if;

        insert into int15_log
        select k.ref, sysdate, k.s, k.kv, l_s15, to_char(l_s15v) from dual;

        l_s15:=0; l_s15v:=0;
    end loop;
  else
    null;

 end if;

end int15_dailycheck;
/
show err;

PROMPT *** Create  grants  INT15_DAILYCHECK ***
grant EXECUTE                                                                on INT15_DAILYCHECK to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on INT15_DAILYCHECK to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/INT15_DAILYCHECK.sql =========*** 
PROMPT ===================================================================================== 
