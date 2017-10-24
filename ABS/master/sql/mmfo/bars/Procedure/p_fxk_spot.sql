

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_FXK_SPOT.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_FXK_SPOT ***

  CREATE OR REPLACE PROCEDURE BARS.P_FXK_SPOT (p_par integer, p_nls1819 varchar2, p_dat date)
is

  /* p_par =0 споты, которые сегодня закрываются, выполняется на старте дня
     p_par =1 споты переходящие на след.отчетный период, выполняется на финише дня*/

MODCODE   constant varchar2(3) := 'FX';
-- рабочие счета переоценки
l_nls3540 varchar2(15);  /*3540 - Активи за спот контрактами*/
l_nms3540 VARCHAR2(38);
l_nls3640 varchar2(15);  /*3640 - Зобов'язання за спот контрактами*/
l_nms3640 VARCHAR2(38);
l_nls6204 varchar2(15);  /*6204 - Результат в_д торг.оп.з _ншими ф_н. _нструментами*/
l_nms6204 VARCHAR2(38);
l_nls1819 varchar2(15);  /*счет 1819*/  -- счет 1819 торговый в грн
                                          -- на него свернем результат при закрытии  сделки
l_nms1819 VARCHAR2(38);

-- оплата
l_dk   number;
l_ref1  int;
l_ref2  int;
l_ref3  int;
l_ref4  int;

l_fl   int;       -- флаг оплаты для FXK (37 флаг - 1- по факт, 0 - по плану)
l_okpo VARCHAR2(15);
l_nlsd VARCHAR2(15);
l_nlsk VARCHAR2(15);
l_nmsa VARCHAR2(38);
l_nmsb VARCHAR2(38);
-- откат сегодняшних операций FXK  по переоценке
par2_      number;
par3_     varchar2(30);
/*
  версия
  qwa   08.01.2014 По просьбе Надра добалено в назначение платежа краткое название партнера

  qwa   03.01.2014  Призначення платежу -
                    зам_сть догов_р - т_кет
                           додано     т_кет № в_д ../../..
                           зам_сть "спотової частини угоди"  "спот угоди"


  qwa   14-05-2013  переоц_нка спот угод угод виконується
                    p_par=0  щодня на старт_ дня, для угод як_ закриваються
                    p_par=1  на вимогу користувача в "зв_тну дату" (наприклад в к_нц_ м_сяця), для угод як_ переходять
                             на наступний пер_од (можуть виконуватись щодня)

                    Якщо переоц_нка виконується повторно (на старт_ або на вимогу) - сторнуються сьогодн_шн_ операц_ї
                    по переоц_нц_ _ пот_м виконується повторна переоц_нка.

                    Вс_ операц_ї виконуються з кодом FXK _ мають р_зн_ бухмодел_ та призначення платежу
                    в залежност_ в_д зм_сту операц_ї

                    "0". На старт_ дня розглядаємо т_льки т_ угоди, по яких закриваються в поточному банк_вському дн_
                    зворотн_ операц_ї FX5,
                    тобто :
                    0.1. Виконуємо зворотн_  до попередньої переоц_нки по задан_й угод_ проводки (якщо попередньої
                       переоц_нки не було - зворотн_х немає)
                       Призначення платежу
                         "Зворотня Переоцiнка спотової частини угоди Ref <референс угоди> догов_р <номер т_кета>"
                    0.2. Виконуємо переоц_нку  угод що закриваються  зг_дно курсу поточного дня
                       Призначення платежу
                          "Переоцiнка спотової частини угоди Ref <референс угоди> догов_р <номер т_кета>"

                       Сума переоц_нки : бал варт_сть(БВ) проданої - БВ купленої=s
                                 s>0   ДТ 3540 КТ 6204
                                 s<0   ДТ 6204 КТ 3640
                    0.3. Згораємо активи та зобовязання (3540, 3640) на рахунок 1819 по в_дпов_дн_й сторон_, результат переоц_нки
                      як дох_д або убиток залишиться на 6204. 1819 в свою чергу буде згорнений на 6204 в к_нц_ дня при виведенн_ ф_нрезультату.

                      Призначення платежу
                        "Закриття переоц_нки спот.частини угоди Ref <референс угоди>  догов_р №  <номер т_кета> "
                    !!!!!!!!!!!!!!!!!!!!!!!!!!!
                    Незакрит_ на сьогодн_ спот угоди, в тому числ_ своп умови в_дбору

                    and (( p_par=0 and (  f.dat_a<=p_dat and f.dat_b=p_dat or f.dat_a=p_dat  and f.dat_b<=p_dat )) -- як_ закриваються
                    or p_par=1 and (f.dat_a>p_dat or  f.dat_b>p_dat) )          -- як_ переходять

                    "1" - на вимогу розлядаємо т_льки т_ угоди, як_ переходять на наступний зв_тний пер_од
                    1.1. Виконуємо зворотн_  до попередньої переоц_нки по задан_й угод_ проводки (якщо попередньої
                       переоц_нки не було - зворотн_х немає)
                       Призначення платежу
                         "Зворотня Переоцiнка спот частини угоди Ref <референс угоди> догов_р <номер т_кета>"
                    1.2. Виконуємо переоц_нку  угод що закриваються  зг_дно курсу поточного дня
                       Призначення платежу
                          "Переоцiнка спот частини угоди Ref <референс угоди> догов_р <номер т_кета>"

                       Сума переоц_нки : бал варт_сть(БВ) проданої - БВ купленої=s
                                 s>0   ДТ 3540 КТ 6204
                                 s<0   ДТ 6204 КТ 3640

*/

procedure back_fxk_spot  is
 -- откат всех сегодняшних, если переоценка выполняется повторно
 -- сброс признака того, что сформированы обратные к предыдущим переоценкам

-- l_sos oper.ref%type;

 begin
         for p in (

         select  o.ref,o.nlsa,o.nlsb,o.s,o.sos,d.sos sos_ref,
                 to_number(substr(o.nazn,instr(o.nazn,'Ref ')+4,instr(o.nazn,' тiкет № ')-(instr(o.nazn,'Ref ')+4))) deal_tag,
                 f.sumpa,f.sumpb,f.sump,f.kva,f.kvb,o.nazn
           from oper o, fx_deal f, fx_deal_ref d
          where o.tt='FXK'
            and (( p_par=0 and (  f.dat_a=p_dat and f.dat_b=p_dat )
                            and (o.nazn like 'Переоц%' or o.nazn like 'Закрит%' or o.nazn like 'Зворот%'
                            ))      -- для закрывающихся
               or p_par=1 and (f.dat_a>p_dat and  f.dat_b>p_dat)
                          and (o.nazn like 'Переоц%'  or o.nazn like 'Зворот%'))       -- для переходящих
            and o.sos>=1
            and o.datd=gl.bd
            and substr(o.nazn,instr(o.nazn,'Ref ')+4,instr(o.nazn,' тiкет № ')-(instr(o.nazn,'Ref ')+4))=to_char(f.deal_tag)
            and d.ref=o.ref
            order by o.ref desc

                )
      loop
          bars_audit.info('1FXK'||'back='||p.ref);
          p_back_dok(p.ref,5,null,par2_,par3_,1);

          if    p.nazn like 'Закрит%' or p.nazn like 'Зворот%' then
                update fx_deal_ref
                set   sos=0
                where ref=p.sos_ref;
          end if;

          update operw
            set value='Повторна переоцiнка спот.угод на 3*-6204'
          where ref=p.ref
            and tag='BACKR';

      end loop;
 end back_fxk_spot;


procedure pereoc_spot is

-- переоценка спот сделок
-- балансова варт_сть вал А(грн екв на дату) -бал варт_сть вал Б(грн екв на дату)
/* ВСЕ АКТУАЛЬНЫЕ ДЛЯ ПЕРЕОЦЕНКИ СЕГОДНЯ спот СДЕЛКИ

     ПО ДАТАМ - ВО ВРЕМЕННОМ  ПЕРИОДЕ не больше 2 РАБ ДНей ПО ОТНОШ. К ДАТЕ ЗАКЛЮЧЕНИЯ
     ПО ОТРАЖЕНИЮ НА 9200? 9210 -  FX5 ОПЛАЧЕНА
     СУММУ СДЕЛКИ БЕРЕМ ПО ТИПУ ОСТАТКА НА СЧЕТАХ 9200(А), 9210(П)
oper
   */
  begin
     for k in (

           select f.deal_tag,f.ref,f.ref1,f.dat,f.dat_a,f.dat_b,f.kva,f.suma,f.kvb,f.sumb, f.dat_a fdat,
                decode (kvb, 980, f.sumb, gl.p_icurval(f.kvb,f.sumb,bankdate_g))-
                decode (kva, 980,  f.suma, gl.p_icurval(f.kva,f.suma,bankdate_g))  NKR,
 'Переоцiнка СПОТ угоди Ref '||to_char(f.deal_tag)||' тiкет № '||f.ntik||' вiд '||to_char(f.dat,'dd-mm-yyyy')||' '||nvl(c.nmkk,'')
                                              NAZN1,
                               count_wday(f.dat,f.dat_a)-1 wday
           from fx_deal f, (select * from customer  where custtype=1 and date_off is null) c
           where    f.dat<f.dat_a and f.rnk=c.rnk
              and   f.dat<=bankdate_g  -- в том числе сегодняшние
                   and (( p_par=0 and (  f.dat_a<=p_dat and f.dat_b=p_dat or f.dat_a=p_dat  and f.dat_b<=p_dat )) -- для закрывающихся
                       or p_par=1 and (f.dat_a>p_dat or  f.dat_b>p_dat) )                                           -- для переходящих
                   --and count_wday(f.dat,f.dat_a)-1>=1
                    and exists
                    (select ref
                       from opldok
                      where ref=nvl(f.ref1,f.ref)
                       and sos>=1
                       and tt='FX5')
              order by 1


         )
     loop
       SAVEPOINT do_fxk2;
       begin
       --logger.info('2FXK NKR='||k.NKR ||'nbs='||k.nbs);
         if  k.NKR=0 then goto kin2;
         elsif k.NKR<0 then   -- доход
              l_nlsd:=l_nls3540; l_nmsa:=l_nms3540;
              l_nlsk:=l_nls6204; l_nmsb:=l_nms6204;

         elsif k.NKR>0 then   -- убыток
              l_nlsd:=l_nls6204; l_nmsa:=l_nms6204;
              l_nlsk:=l_nls3640; l_nmsb:=l_nms3640;
         end if;
         BEGIN
           gl.ref (l_ref1);
       --logger.info('3FXK NKR='||k.NKR||'ref='||l_ref1||'l_nlsd='||l_nlsd||'l_nlsk='||l_nlsk);
           INSERT INTO oper
              (ref, tt, vob, nd, dk, pdat, vdat, datd, datp,
               nam_a, nlsa, mfoa, id_a,
               nam_b, nlsb, mfob, id_b,
             kv, s, kv2, s2, nazn, userid)
            VALUES
              (l_ref1, 'FXK', 6, l_ref1, 1, sysdate, bankdate_g, bankdate_g, bankdate_g,
               l_nmsa, l_nlsd, gl.aMFO, l_okpo, l_nmsb, l_nlsk, gl.aMFO, l_okpo,
               980, abs(k.nkr), 980, abs(k.nkr), k.nazn1, USER_ID);
            gl.payv(l_fl, l_ref1, bankdate_g, 'FXK', 1,980, l_nlsd, abs(k.nkr), 980, l_nlsk, abs(k.nkr) );
            EXCEPTION WHEN OTHERS THEN   ROLLBACK TO do_fxk2;
            bars_error.raise_nerror(MODCODE, 'ERR_PAY_FXK');

         END;


         if l_ref1 is not null then
            insert into fx_deal_ref (ref,deal_tag,sos)
                 values (l_ref1,k.deal_tag,0);   -- sos=0  переоценка исходная

          --  bars_audit.info('p_fxk0 ='||'k.nbs,l_nlsd,l_nlsk,k.nkr=='||k.nbs ||'='||l_nlsd||'='||l_nlsk||'='||k.nkr);
          -- этот блок необязательный для варианта УПБ, нет ясности что туда писать
          -- может быть сделаю потом

            if  k.NKR >0   and l_nlsk like '6204%' then
                --bars_audit.info('p_fxka 1 ='||'9202='||k.nkr||' '||k.deal_tag);
                update fx_deal
                  set sumpa=k.nkr
                where deal_tag=k.deal_tag;
            elsif k.NKR< 0 and l_nlsd like '6204%' then
                --bars_audit.info('p_fxka 2 ='||'9202='||k.nkr||' '||k.deal_tag);
                update fx_deal
                  set sumpb=abs(k.nkr)
                where deal_tag=k.deal_tag;
            end if;


            --bars_audit.info('p_fxkp ='||k.nkr||'= '||k.deal_tag);
         elsif  l_ref1 is null then
           --bars_audit.info('p_fxkp====>0'||k.nkr||'= '||k.deal_tag);
            update fx_deal
              set  sumpa=0, sumpb=0,  sump=0
             where deal_tag=k.deal_tag;
         end if;

       end;
       <<kin2>> NULL;
     end loop;
  end pereoc_spot;


procedure close_pereoc_spot  is
      /*
         закрытие  3540, 3640 в корресп с 1819 торг -980 по соотв. валюте
     */

   -- определим счет 1819 или 3801 по настройке строки вызова процедуры
   --
 begin

--  в курсор отбираем только споты, по которым наступила дата закрытия сделки
     for k in (

            select  distinct f.kva, f.kvb,
                 o.nlsa, o.nlsb,
                 o.s s,
                 f.deal_tag,
          'Закриття переоцiнки СПОТ угоди Ref '||to_char(f.deal_tag)||' тiкет № '||f.ntik||' вiд '||to_char(f.dat,'dd-mm-yyyy')||' '||nvl(c.nmkk,'')
                                NAZN3
         from  (
         select ref,nlsa,nlsb,s,nazn
                  from oper
                 where tt='FXK'
                   and sos>=1
                   and nazn like 'Переоц%'
                   and vdat=gl.bd
                  ) o,
                 fx_deal_ref d,
                 fx_deal f,
                 (select * from customer  where custtype=1 and date_off is null) c
          where d.ref=o.ref   -- переоценку сделали
            and d.sos=0
            and d.deal_tag=f.deal_tag and f.rnk=c.rnk
            and p_par=0 and   f.dat_a=p_dat and f.dat_b=p_dat  -- сделка закрывается
            and  not exists (   -- сегодня если еще не было закрытий переоценок по данной сделке
                     select 1
                       from fx_deal_ref
                      where deal_tag=d.deal_tag
                       and  ref in (
                             select ref
                               from oper
                              where tt='FXK'
                               and sos>=1
                               and nazn like 'Закриття%'
                               and vdat=gl.bd))


         )
     loop
       SAVEPOINT do_fxk3;
       begin
       --bars_audit.info('2FXK NKR= '||k.S ||' deal_tag= '||k.deal_tag);

       if substr(p_nls1819,1,4)='1819' then
          begin
            select nls, substr(nms,1,38)
             into l_nls1819,l_nms1819
             from accounts
            where nls=p_nls1819 and kv=980;
              exception when no_data_found then
              bars_error.raise_nerror(MODCODE, 'TT_FXK_NOT_DEFINITION');
          end;
       elsif substr(p_nls1819,1,4)='3800' then goto KIN3;
       else goto KIN3;
       end if;


         bars_audit.info('p_fxk==s=='||k.s||'k.kva=='||k.kva||'k.kvb=='||k.kvb);

         if  k.s=0 then goto kin3;
         elsif k.kva<>980 and k.kvb<>980     then     -- конверсия
               if substr(k.nlsa,1,4)='6204'  then     -- убыток по вал Б
                  l_nlsd:=l_nls3640;     l_nmsa:=l_nms3640;
                  l_nlsk:=l_nls1819;     l_nmsb:=l_nms1819;
               elsif substr(k.nlsb,1,4)='6204' then   -- доход по вал А
                  l_nlsd:=l_nls1819;   l_nmsa:=l_nms1819;
                  l_nlsk:=l_nls3540;  l_nmsb:=l_nms3540;
               end if;
         elsif k.kva<>980 and k.kvb=980    then  -- покупка вал
              if   substr(k.nlsa,1,4)='6204'  then  -- убыток по вал А
                 l_nlsd:=l_nls3640;   l_nmsa:=l_nms3640;
                 l_nlsk:=l_nls1819;   l_nmsb:=l_nms1819;
              elsif substr(k.nlsb,1,4)='6204' then  -- доход по вал А
                 l_nlsd:=l_nls1819;   l_nmsa:=l_nms1819;
                 l_nlsk:=l_nls3540;     l_nmsb:=l_nms3540;
              end if;
         elsif k.kva=980 and k.kvb<>980   then    -- продажа вал
              if   substr(k.nlsa,1,4)='6204'  then  -- убыток по вал Б
                 l_nlsd:=l_nls3640;   l_nmsa:=l_nms3640;
                 l_nlsk:=l_nls1819; l_nmsb:=l_nms1819;
              elsif substr(k.nlsb,1,4)='6204' then  -- доход по вал Б
                 l_nlsd:=l_nls1819;   l_nmsa:=l_nms1819;
                 l_nlsk:=l_nls3540;     l_nmsb:=l_nms3540;
              end if;
         else  goto kin3;
         end if;
         bars_audit.info('p_fxk== l_nlsd=='||l_nlsd||'l_nlsk=='||l_nlsk);
         BEGIN
           gl.ref (l_ref3);
       --bars_audit.info('3FXK S='||k.s||'ref='||l_ref3||'l_nlsd='||l_nlsd||'l_nlsk='||l_nlsk||'l_nls3540='||l_nls3540||'l_nls3640='||l_nls3640);
           INSERT INTO oper
              (ref, tt, vob, nd, dk,
              pdat, vdat, datd, datp,
              nam_a, nlsa, mfoa, id_a,
              nam_b, nlsb, mfob, id_b,
              kv, s, kv2, s2, nazn, userid)
            VALUES
              (l_ref3, 'FXK', 6, l_ref3, 1,
              sysdate, bankdate_g, bankdate_g, bankdate_g,
              l_nmsa, l_nlsd, gl.aMFO, l_okpo,
              l_nmsb, l_nlsk, gl.aMFO, l_okpo,
              980, abs(k.s), 980, abs(k.s), k.nazn3, USER_ID);
            gl.payv(l_fl, l_ref3, bankdate_g, 'FXK', 1,980, l_nlsd, abs(k.s), 980, l_nlsk, abs(k.s) );
            --EXCEPTION WHEN OTHERS THEN   ROLLBACK TO do_fxk3;
            --bars_error.raise_nerror(MODCODE, 'ERR_PAY_FXK');
         END;

         if l_ref3 is not null then
            insert into fx_deal_ref (ref,deal_tag,sos)
                 values (l_ref3,k.deal_tag,5);

          --bars_audit.info('p_fxk0 ='||'l_nlsd,l_nlsk,k.s==='||l_nlsd||'='||l_nlsk||'='||k.s);
         end if;

       end;
       <<kin3>> NULL;
     end loop;
 end close_pereoc_spot;

 --bars_audit.info('p_fxkp-- commit');
--procedure zvorot_fxk_spot (p_par integer) is      -- обратные к последним предыдущим
procedure zvorot_fxk_spot is      -- обратные к последним предыдущим

 dok oper%rowtype;
 l_nazn oper.nazn%type;
 l_s    oper.s%type;
 l_deal_tag fx_deal_ref.deal_tag%type;


 begin
   /*  определим последние переоценки, по ним нужно сделать обратные операции*/

 for k in (

  select r.ref,r.deal_tag,r.sos
     from fx_deal_ref r,fx_deal f
     where r.deal_tag=f.deal_tag
      and (( p_par=0 and   f.dat_a=p_dat and f.dat_b=p_dat  ) -- для закрывающихся
         or (p_par=1 and   f.dat_a>p_dat and  f.dat_b>p_dat ))
      and r.sos=0
      and  exists (select 1 from oper
                     where ref=r.ref
                       and tt='FXK'
                       and sos>=1)


      )
 loop
    begin
      bars_audit.info('p_fxk=k.ref= для обратных '||k.ref);

      select  *
         into dok
         from oper
        where ref =k.ref;

    exception when no_data_found then goto kin4;
    end;
    -- перевернем данные наоборот

    l_nlsd:= dok.nlsb;
    l_nmsa:= dok.nam_b;
    l_nlsk:= dok.nlsa;
    l_nmsb:= dok.nam_a;
    l_s   := dok.s;
    l_nazn:= 'Зворотня '||dok.nazn;
    l_deal_tag :=to_number( substr(dok.nazn,instr(dok.nazn,'Ref ')+4,instr(dok.nazn,' тiкет № ')-(instr(dok.nazn,'Ref ')+4)));

    SAVEPOINT do_fxk4;
    begin
      begin
          gl.ref (l_ref4);
       --logger.info('3FXK NKR='||k.NKR||'ref='||l_ref1||'l_nlsd='||l_nlsd||'l_nlsk='||l_nlsk);
          INSERT INTO oper
              (ref, tt, vob, nd, dk, pdat, vdat, datd, datp,
               nam_a, nlsa, mfoa, id_a,
               nam_b, nlsb, mfob, id_b,
             kv, s, kv2, s2, nazn, userid)
           VALUES
              (l_ref4, 'FXK', 6, l_ref4, 1, sysdate, bankdate_g, bankdate_g, bankdate_g,
               l_nmsa, l_nlsd, gl.aMFO, l_okpo, l_nmsb, l_nlsk, gl.aMFO, l_okpo,
               980, l_s, 980, l_s, l_nazn, USER_ID);
            gl.payv(l_fl, l_ref4, bankdate_g, 'FXK', 1,980, l_nlsd, l_s, 980, l_nlsk, l_s );
            EXCEPTION WHEN OTHERS THEN   ROLLBACK TO do_fxk4;
            bars_error.raise_nerror(MODCODE, 'ERR_PAY_FXK');
      END;

bars_audit.info ('p_fxk_u'||l_ref4);
         if l_ref4 is not null then

            insert into fx_deal_ref (ref,deal_tag,sos)
                 values (l_ref4,l_deal_tag,k.ref);   -- k.ref - запомнили реф. исходной операции по переоценке

            update  fx_deal_ref
              set   sos=5
              where ref=k.ref and deal_tag=l_deal_tag;  -- признак "обработан" для "старой" переоценки

            -- этот блок пока не нужен
            update fx_deal
              set  sumpa=0, sumpb=0,  sump=0
             where deal_tag=l_deal_tag;

         end if;

    end;
       <<kin4>> NULL;
 end loop;
end zvorot_fxk_spot;

---------------------------------------------------------------------
-- главная
---------------------------------------------------------------------
 begin

bars_audit.info ('FXK - старт');

  begin
      -- определим счета 3540, 3640, 6204 по настройке оп FXK  -- !!

   SELECT to_number(substr(t.flags,38,1)),
          t.nlsa,  substr(a.nms,1,38),
          t.nlsb,  substr(b.nms,1,38),
          t.nlsk,  substr(c.nms,1,38)
    INTO l_fl,l_nls3540,l_nms3540,l_nls3640,l_nms3640,l_nls6204,l_nms6204
    FROM tts t,
         (select nls,nms from accounts where kv=980 and nbs='3540') a,
         (select nls,nms from accounts where kv=980 and nbs='3640') b,
         (select nls,nms from accounts where kv=980 and nbs='6204') c
    WHERE t.tt='FXK' and
          ltrim(rtrim(t.nlsa))=a.nls  and
          ltrim(rtrim(t.nlsb))=b.nls  and
          ltrim(rtrim(t.nlsk))=c.nls  ;

   exception when no_data_found then
    bars_error.raise_nerror(MODCODE, 'TT_FXK_NOT_DEFINITION');
  end;

 bars_audit.info('0FXK === l_nls3540='||l_nls3540||' l_nls3640='||l_nls3640||' l_nls6204='||l_nls6204);

  SELECT substr(f_ourokpo,1,15)
    INTO l_okpo
    FROM dual;

  back_fxk_spot   ;      -- откатим сегодняшние если повторно
  bars_audit.info('FXK = back');
  zvorot_fxk_spot ;    -- обратные к последним предыдущим
  bars_audit.info('FXK = zvorot');
  pereoc_spot;      --  переоценка спот сделок (в том числе своп)
  bars_audit.info('FXK = pereoc');

  if p_par=0 then
     close_pereoc_spot;     -- закрытие 3540, 3640 на 1819 если закрываем на старте
     bars_audit.info('FXK = close');
  end if;

 commit;

end p_fxk_spot;
/
show err;

PROMPT *** Create  grants  P_FXK_SPOT ***
grant EXECUTE                                                                on P_FXK_SPOT      to ABS_ADMIN;
grant EXECUTE                                                                on P_FXK_SPOT      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_FXK_SPOT      to BARS_CONNECT;
grant EXECUTE                                                                on P_FXK_SPOT      to FOREX;
grant EXECUTE                                                                on P_FXK_SPOT      to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_FXK_SPOT.sql =========*** End **
PROMPT ===================================================================================== 
