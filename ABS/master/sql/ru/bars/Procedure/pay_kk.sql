
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/procedure/pay_kk.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PROCEDURE BARS.PAY_KK 
               (flg_ SMALLINT,  -- флаг оплаты
                ref_ INTEGER,   -- референция
               VDAT_ DATE,      -- дата валютировния
                 tt_ CHAR,      -- тип транзакции
                dk_ NUMBER,    -- признак дебет-кредит
                kv_ SMALLINT,  -- код валюты А
               nlsm_ VARCHAR2,  -- номер счета А
                 sa_ DECIMAL,   -- сумма в валюте А
                kvk_ SMALLINT,  -- код валюты Б
               nlsk_ VARCHAR2,  -- номер счета Б
                 ss_ DECIMAL    -- сумма в валюте Б
) IS
/*
25.03.2016 Исправ от Щуцкой
1)    Ид.А НЕ равен Ид.Б   или же
2)    МФО-Б не ОЩ.Банк


Комісії повинна стягуватись в наступних випадках:
1) перерахування коштів із свого 2620 на не свої в будь-якій установі Ощадбанку, в.ч. в тій , в якій відкритиій 2620
2) перерахування коштів з 2620 на будь-які рахунки в іншій установі банку.
   для двох випадків, згідно тарифу: код тарифа = 3 Счет 6110/10

22.03.2016 Исправлено/уточнено - только со счета SS   - (не  вынос на просрочку) !
21.03.2016 Сухова COBUSUPABS-4313
1. КД ФО  в частині видачі кредиту з позичкового рахунку на поточний рахунок 2620 (який використовується для обслуговування кредиту)
2. для випадків КК2 стягується комісія  (п.1.1.2.1. діючих Тарифів за послуги установ АТ «Ощадбанк»)

   КОМИССИЯ  берется только при перечислении за пределы ОБ
   Код тарифа = 3
   Счет 6110/10
   Бранч дох от счета 2620
   За счет собственных средств ( не из суммы кредита)
   При нескольких перечисленияз на разных получателей - столько же комиссионных проводок

*/
  l_Kod   tarif.kod%type      :=  3     ;
  l_nbs   accounts.nbs%type   := '6110' ;
  l_ob    accounts.ob22%type  := '10'   ;
  l_tag   operw.tag%type      := 'KTAR ';
  l_ttK   tts.tt%type         := 'KK1'  ;
  l_ttD   tts.tt%type         := 'D06'  ;
  -----------------------------
  l_ND    nd_acc.nd%type      ;
  l_br    accounts.branch%type;
  l_nls26 accounts.nls%type   ;
  l_nls61 accounts.nls%type   ;
  l_s     oper.s%type         ;
  l_ob22_2620 accounts.ob22%type;
  l_262037_amn number;
  -----------------------------
begin  ------Есть ли "свой-2620" ?
  if NEWNBS.GET_STATE = 1 then
        l_nbs := '6510' ;
  end if;
  begin

     select n.nd             into l_ND          from nd_acc n, accounts a
     where n.acc=a.acc and a.kv=kv_ and a.nls = nlsm_ and a.dazs is null and rownum = 1 and a.tip = 'SS ' ;

     select a.nls, a.branch, a.ob22  into l_nls26, l_br, l_ob22_2620 from nd_acc n, accounts a
     where n.acc=a.acc and a.kv=kv_ and a.nbs= '2620' and a.dazs is null and rownum = 1 and n.nd  = l_ND and a.nls <> nlsk_ ;


     gl.payv ( flg_, ref_, VDAT_, l_ttK, 1, kv_,   nlsm_, sa_, kv_, l_nls26, sa_ );
     gl.payv ( flg_, ref_, VDAT_, tt_, 1, kv_, l_nls26, sa_, kv_,   nlsk_, sa_ );


     begin
       -- 2018-04-19 VPogoda COBUMMFO-7553 - для 2620_37 - тариф выбирается по максимальному значению шкалы
       if substr(l_nls26,1,4) = '2620' and l_ob22_2620 = '37' then
         select vt.smax
           into l_262037_amn
           from v_tarif vt
           where vt.kod = l_kod;
       end if;
       select coalesce(l_262037_amn,f_tarif ( l_Kod, kv_, l_nls26, sa_, 0, null)) ,
              nbs_ob22_bra ( l_nbs, l_ob, substr( l_br,1,15) )
           into l_s, l_nls61
           from dual
           where  not exists (select 1 from banks_ru where mfo = GL.doc.mfob) -- МФО-Б не ОЩ.Банк
              OR  gl.doc.id_a <> gl.doc.id_b  ;                               -- Ид.А НЕ равен Ид.Б
           if l_nls61 is null  then
              raise_application_error(-20203,'PAY_KK:
Не знайдено рахунок 6110 для відділення '||substr( l_br,1,15));
           end if;
           if l_s >=1  then
              gl.payv ( flg_, ref_, VDAT_, l_ttD, 1, kv_, l_nls26, l_s, gl.baseval,  l_nls61, gl.p_icurval(kv_, l_s, gl.bdate) );
           end if;
           update operw set value = to_char(l_kod) where ref = gl.aRef and tag = l_tag;
           if SQL%rowcount = 0 then insert into operw (ref,tag, value) values (Ref_, l_tag, to_char(l_kod) ) ;  end if;

     EXCEPTION WHEN NO_DATA_FOUND THEN  null;
     end;

EXCEPTION WHEN NO_DATA_FOUND THEN    gl.payv(flg_,ref_, VDAT_, tt_,dk_,kv_,nlsm_,sa_,kvk_,nlsk_,ss_);
END;

END PAY_KK;

/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/procedure/pay_kk.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 