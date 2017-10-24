

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_FXK_U.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_FXK_U ***

  CREATE OR REPLACE PROCEDURE BARS.P_FXK_U (p_par integer, p_nls3800 varchar2, p_dat date)
is

  /* p_par =0 форварды, которые сегодня закрываются, выполняется на старте дня
     p_par =1 форварды переходящие на след.отчетный период, выполняется по требованию*/

MODCODE   constant varchar2(3) := 'FX';
--==============================
  t_oper       oper%rowtype           ;
  t_fx_d_ref   fx_deal_ref%rowtype;
--==============================
-- рабочие счета переоценки
l_nls3041 varchar2(15);  /*3041 - Активи за форвардними контрактами*/
l_nms3041 VARCHAR2(38);
l_nls3351 varchar2(15);  /*3351 - Зобов'язання за форвардними контрактами*/
l_nms3351 VARCHAR2(38);
l_nls6209 varchar2(15);  /*6209 - Результат в_д торг.оп.з _ншими ф_н. _нструментами*/
l_nms6209 VARCHAR2(38);
l_nls3801_a varchar2(15);  /*счет 3801*/  -- счет 3801 валюты А
                                          -- его рассчитаем на основании 3800-kva - открыт мультивалютно
                                          -- на него свернем результат при закрытии  сделки
l_nms3801_a VARCHAR2(38);
l_nls3801_b varchar2(15);  /*счет 3801*/  -- счет 3801 валюты Б
                                          -- его рассчитаем на основании 3800-kvb - открыт мультивалютно
                                          -- на него свернем результат при закрытии  сделки
l_nms3801_b VARCHAR2(38);

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
  qwa   14-05-2013  По постановц_ УПБ
                    переоц_нка форвардних угод угод виконується
                    p_par=0  щодня на старт_ дня, для угод як_ закриваються
                    p_par=1  на вимогу користувача в "зв_тну дату" (наприклад в к_нц_ м_сяця), для угод як_ переходять
                             на наступний пер_од (можуть виконуватись щодня)

                    Якщо переоц_нка виконується повторно (на старт_ або на вимогу) - сторнуються сьогодн_шн_ операц_ї
                    по переоц_нц_ _ пот_м виконується повторна переоц_нка.

                    Вс_ операц_ї виконуються з кодом FXK _ мають р_зн_ бухмодел_ та призначення платежу
                    в залежност_ в_д зм_сту операц_ї

                    "0". На старт_ дня розглядаємо т_льки т_ угоди, по яких закриваються в поточному банк_вському дн_
                    зворотн_ операц_ї FXF,
                    тобто :
                    0.1. Виконуємо зворотн_  до попередньої переоц_нки по задан_й угод_ проводки (якщо попередньої
                       переоц_нки не було - зворотн_х немає)
                       Призначення платежу
                         "Зворотня Переоцiнка форвардної частини угоди Ref <референс угоди> догов_р <номер т_кета>"
                    0.2. Виконуємо переоц_нку  угод що закриваються  зг_дно курсу поточного дня
                       Призначення платежу
                          "Переоцiнка форвардної частини угоди Ref <референс угоди> догов_р <номер т_кета>"

                       Сума переоц_нки : бал варт_сть(БВ) проданої - БВ купленої=s
                                 s>0   ДТ 3041 КТ 6209
                                 s<0   ДТ 6209 КТ 3351
                    0.3. Згораємо активи та зобовязання (3041, 3351) на рахунок 3801 по в_дпов_дн_й сторон_, результат переоц_нки
                      як дох_д або убиток залишиться на 6209. 3801 в свою чергу буде допереоц_нений операц_єю PVP.

                      Призначення платежу
                        "Закриття переоц_нки форвард.частини угоди Ref <референс угоди>  догов_р №  <номер т_кета> "
                    !!!!!!!!!!!!!!!!!!!!!!!!!!!
                    Незакрит_ на сьогодн_ форвард угоди, в тому числ_ своп умови в_дбору

                    and (( p_par=0 and (  f.dat_a<=p_dat and f.dat_b=p_dat or f.dat_a=p_dat  and f.dat_b<=p_dat )) -- як_ закриваються
                    or p_par=1 and (f.dat_a>p_dat or  f.dat_b>p_dat) )          -- як_ переходять

                    "1" - на вимогу розлядаємо т_льки т_ угоди, як_ переходять на наступний зв_тний пер_од
                    1.1. Виконуємо зворотн_  до попередньої переоц_нки по задан_й угод_ проводки (якщо попередньої
                       переоц_нки не було - зворотн_х немає)
                       Призначення платежу
                         "Зворотня Переоцiнка форвардної частини угоди Ref <референс угоди> догов_р <номер т_кета>"
                    1.2. Виконуємо переоц_нку  угод що закриваються  зг_дно курсу поточного дня
                       Призначення платежу
                          "Переоцiнка форвардної частини угоди Ref <референс угоди> догов_р <номер т_кета>"

                       Сума переоц_нки : бал варт_сть(БВ) проданої - БВ купленої=s
                                 s>0   ДТ 3041 КТ 6209
                                 s<0   ДТ 6209 КТ 3351

*/

procedure back_fxk  is
 -- откат всех сегодняшних, если переоценка выполняется повторно
 -- сброс признака того, что сформированы обратные к предыдущим переоценкам

-- l_sos oper.ref%type;

 begin
         for p in (

         select  o.ref,o.nlsa,o.nlsb,o.s,o.sos,d.sos sos_ref,
                 to_number(substr(o.nazn,instr(o.nazn,'Ref ')+4,instr(o.nazn,' догов_р № ')-(instr(o.nazn,'Ref ')+4))) deal_tag,
                 f.sumpa,f.sumpb,f.sump,f.kva,f.kvb,o.nazn
           from oper o, fx_deal f, fx_deal_ref d
          where o.tt='FXK'
            and (( p_par=0 and (  f.dat_a<=p_dat and f.dat_b=p_dat or f.dat_a=p_dat  and f.dat_b<=p_dat )
                            and (o.nazn like 'Переоц%' or o.nazn like 'Закрит%'))      -- для закрывающихся
               or p_par=1 and (f.dat_a>p_dat or  f.dat_b>p_dat)
                          and (o.nazn like 'Переоц%'  or o.nazn like 'Зворот%'))       -- для переходящих
            and o.sos>0
            and o.datd=gl.bd
            and substr(o.nazn,instr(o.nazn,'Ref ')+4,instr(o.nazn,' догов_р № ')-(instr(o.nazn,'Ref ')+4))=to_char(f.deal_tag)
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
            set value='Повторна переоцiнка форвард.угод на 3*-6209'
          where ref=p.ref
            and tag='BACKR';

      end loop;
 end back_fxk;


procedure pereoc_forw is

-- переоценка форвардных сделок
-- балансова варт_сть вал А(грн екв на дату) -бал варт_сть вал Б(грн екв на дату)
/* ВСЕ АКТУАЛЬНЫЕ ДЛЯ ПЕРЕОЦЕНКИ СЕГОДНЯ ФОРВАРДНЫЕ СДЕЛКИ

     ПО ДАТАМ - ВО ВРЕМЕННОМ  ПЕРИОДЕ + 2 РАБ ДНЯ ПО ОТНОШ. К ДАТЕ ЗАКЛЮЧЕНИЯ
     ПО ОТРАЖЕНИЮ НА 9202? 9212 -  FXF ОПЛАЧЕНА
     СУММУ СДЕЛКИ БЕРЕМ ПО ТИПУ ОСТАТКА НА СЧЕТАХ 9202(А), 9212(П)

   */
  begin
     for k in (

           select f.deal_tag,f.ref,f.ref1,f.dat,f.dat_a,f.dat_b,f.kva,f.suma,f.kvb,f.sumb, f.dat_a fdat,
                decode (kvb, 980, f.sumb, gl.p_icurval(f.kvb,f.sumb,bankdate_g))-
                decode (kva, 980,  f.suma, gl.p_icurval(f.kva,f.suma,bankdate_g))  NKR,
 'Переоцiнка форвардної частини угоди Ref '||to_char(f.deal_tag)||' догов_р № '||f.ntik
                               NAZN1
                               ,count_wday(f.dat,f.dat_a)-1 wday
           from fx_deal f
           where    f.dat<f.dat_a
              and   f.dat<bankdate_g  -- сегодняшние не переоцениваем
                   and (( p_par=0 and (  f.dat_a<=p_dat and f.dat_b=p_dat or f.dat_a=p_dat  and f.dat_b<=p_dat )) -- для закрывающихся
                       or p_par=1 and (f.dat_a>p_dat or  f.dat_b>p_dat) )                                           -- для переходящих
                   --and count_wday(f.dat,f.dat_a)-1>=1
                    and exists
                    (select ref from opldok where ref=nvl(f.ref1,f.ref) and sos=5 and tt='FXF')
              order by 1


         )
     loop
       SAVEPOINT do_fxk2;
       begin
       --logger.info('2FXK NKR='||k.NKR ||'nbs='||k.nbs);
         if  k.NKR=0 then goto kin2;
         elsif k.NKR<0 then   -- доход
              l_nlsd:=l_nls3041; l_nmsa:=l_nms3041;
              l_nlsk:=l_nls6209; l_nmsb:=l_nms6209;

         elsif k.NKR>0 then   -- убыток
              l_nlsd:=l_nls6209; l_nmsa:=l_nms6209;
              l_nlsk:=l_nls3351; l_nmsb:=l_nms3351;
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

            if  k.NKR >0   and l_nlsk like '6209%' then
                --bars_audit.info('p_fxka 1 ='||'9202='||k.nkr||' '||k.deal_tag);
                update fx_deal
                  set sumpa=k.nkr
                where deal_tag=k.deal_tag;
            elsif k.NKR< 0 and l_nlsd like '6209%' then
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
  end pereoc_forw;


procedure close_pereoc  is
      /*
         закрытие  3041, 3351 в корресп с 3801-980 по соотв. валюте
                   3801 вычислим от параметра процедуры p_nls3800
                  они разные в зависимости от валют А и Б по конкретной сделке
      */

   -- определим счета 3801 по настройке строки вызова процедуры     !!!!
   --
 begin

--  в курсор отбираем только форварды, по которым наступила дата закрытия сделки
     for k in (

            select  distinct f.kva, f.kvb,
                 o.nlsa, o.nlsb,
                 o.s s,
                 f.deal_tag,
          'Закриття переоц_нки форвард.частини угоди Ref '||to_char(f.deal_tag)||' догов_р № '||f.ntik
                                NAZN3
         from  (
         select ref,nlsa,nlsb,s,nazn
                  from oper
                 where tt='FXK'
                   and sos=5
                   and nazn like 'Переоц%'
                   and vdat=gl.bd
                  ) o,
                 fx_deal_ref d,
                 fx_deal f
          where d.ref=o.ref   -- переоценку сделали
            and d.sos=0
            and d.deal_tag=f.deal_tag
            and ( p_par=0 and (  f.dat_a<=p_dat and f.dat_b=p_dat or f.dat_a=p_dat  and f.dat_b<=p_dat )) -- сделка закрывается
            and  not exists (   -- сегодня если еще не было закрытий переоценок по данной сделке
                     select 1
                       from fx_deal_ref
                      where deal_tag=d.deal_tag
                       and  ref in (
                             select ref
                               from oper
                              where tt='FXK'
                               and sos=5
                               and nazn like 'Закриття%'
                               and vdat=gl.bd))


         )
     loop
       SAVEPOINT do_fxk3;
       begin
       --bars_audit.info('2FXK NKR= '||k.S ||' deal_tag= '||k.deal_tag);

       /*  счета 3801 по валютам сделки А и-или Б  */

         if k.kva<>980   then
           begin
           select b.nls,substr(b.nms,1,38)
            into l_nls3801_a,l_nms3801_a
             from (select * from accounts where nbs='3800') a,
                  (select * from accounts where nbs='3801') b,
                  vp_list v
            where a.nls=p_nls3800    -- 3800310001
              and v.acc3800=a.acc
              and v.acc3801=b.acc
              and a.kv=k.kva;

           exception when no_data_found then
           bars_error.raise_nerror(MODCODE, 'TT_FXK_NOT_DEFINITION');
            end;
         end if;

         if k.kvb<>980 then
          begin
           select b.nls,substr(b.nms,1,38)
             into l_nls3801_b,l_nms3801_b
             from (select * from accounts where nbs='3800') a,
                  (select * from accounts where nbs='3801') b,
                  vp_list v
            where a.nls=p_nls3800
              and v.acc3800=a.acc
              and v.acc3801=b.acc
              and a.kv=k.kvb;
          exception when no_data_found then
          bars_error.raise_nerror(MODCODE, 'TT_FXK_NOT_DEFINITION');
          end;
         end if;

         bars_audit.info('p_fxk==s=='||k.s||'k.kva=='||k.kva||'k.kvb=='||k.kvb);

         if  k.s=0 then goto kin3;
         elsif k.kva<>980 and k.kvb<>980     then     -- конверсия
               if substr(k.nlsa,1,4)='6209'  then     -- убыток по вал Б
                  l_nlsd:=l_nls3351;     l_nmsa:=l_nms3351;
                  l_nlsk:=l_nls3801_b;   l_nmsb:=l_nms3801_b;
               elsif substr(k.nlsb,1,4)='6209' then   -- доход по вал А
                  l_nlsd:=l_nls3801_a;   l_nmsa:=l_nms3801_a;
                  l_nlsk:=l_nls3041;     l_nmsb:=l_nms3041;
               end if;
         elsif k.kva<>980 and k.kvb=980    then  -- покупка вал
              if   substr(k.nlsa,1,4)='6209'  then  -- убыток по вал А
                 l_nlsd:=l_nls3351;   l_nmsa:=l_nms3351;
                 l_nlsk:=l_nls3801_a; l_nmsb:=l_nms3801_a;
              elsif substr(k.nlsb,1,4)='6209' then  -- доход по вал А
                 l_nlsd:=l_nls3801_a;   l_nmsa:=l_nms3801_a;
                 l_nlsk:=l_nls3041;     l_nmsb:=l_nms3041;
              end if;
         elsif k.kva=980 and k.kvb<>980   then    -- продажа вал
              if   substr(k.nlsa,1,4)='6209'  then  -- убыток по вал Б
                 l_nlsd:=l_nls3351;   l_nmsa:=l_nms3351;
                 l_nlsk:=l_nls3801_b; l_nmsb:=l_nms3801_b;
              elsif substr(k.nlsb,1,4)='6209' then  -- доход по вал Б
                 l_nlsd:=l_nls3801_b;   l_nmsa:=l_nms3801_b;
                 l_nlsk:=l_nls3041;     l_nmsb:=l_nms3041;
              end if;
         else  goto kin3;
         end if;
         bars_audit.info('p_fxk== l_nlsd=='||l_nlsd||'l_nlsk=='||l_nlsk);
         BEGIN
           gl.ref (l_ref3);
       --bars_audit.info('3FXK S='||k.s||'ref='||l_ref3||'l_nlsd='||l_nlsd||'l_nlsk='||l_nlsk||'l_nls3041='||l_nls3041||'l_nls3351='||l_nls3351);
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
 end close_pereoc;

 --bars_audit.info('p_fxkp-- commit');
--procedure zvorot_fxk (p_par integer) is      -- обратные к последним предыдущим
procedure zvorot_fxk is      -- обратные к последним предыдущим

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
      and (( p_par=0 and (  f.dat_a<=p_dat and f.dat_b=p_dat or f.dat_a=p_dat  and f.dat_b<=p_dat )) -- для закрывающихся
               or p_par=1 and (f.dat_a>p_dat or  f.dat_b>p_dat) )
      and r.sos=0
      and  exists (select 1 from oper
                     where ref=r.ref
                       and tt='FXK'
                       and sos=5)


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
    l_deal_tag :=to_number( substr(dok.nazn,instr(dok.nazn,'Ref ')+4,instr(dok.nazn,' догов_р № ')-(instr(dok.nazn,'Ref ')+4)));

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
end zvorot_fxk;

---------------------------------------------------------------------
-- главная
---------------------------------------------------------------------
 begin

  begin
      -- определим счета 3401, 3351, 6209 по настройке оп FXK  -- !!

   SELECT to_number(substr(t.flags,38,1)),
          t.nlsa,  substr(a.nms,1,38),
          t.nlsb,  substr(b.nms,1,38),
          t.nlsk,  substr(c.nms,1,38)
    INTO l_fl,l_nls3041,l_nms3041,l_nls3351,l_nms3351,l_nls6209,l_nms6209
    FROM tts t,
         (select nls,nms from accounts where kv=980 and nbs='3041') a,
         (select nls,nms from accounts where kv=980 and nbs='3351') b,
         (select nls,nms from accounts where kv=980 and nbs='6209') c
    WHERE t.tt='FXK' and
          ltrim(rtrim(t.nlsa))=a.nls  and
          ltrim(rtrim(t.nlsb))=b.nls  and
          ltrim(rtrim(t.nlsk))=c.nls  ;

   exception when no_data_found then
    bars_error.raise_nerror(MODCODE, 'TT_FXK_NOT_DEFINITION');
  end;

 bars_audit.info('0FXK === l_nls3041='||l_nls3041||' l_nls3351='||l_nls3351||' l_nls6209='||l_nls6209);

  SELECT substr(f_ourokpo,1,15)
    INTO l_okpo
    FROM dual;

  back_fxk   ;      -- откатим сегодняшние если повторно
  bars_audit.info('FXK = back');
  zvorot_fxk ;    -- обратные к последним предыдущим
  bars_audit.info('FXK = zvorot');
  pereoc_forw;      --  переоценка форвардных сделок (в том числе своп)
  bars_audit.info('FXK = pereoc');

  if p_par=0 then
     close_pereoc;     -- закрытие 3041, 3351 на 3801 если закрываем на старте
     bars_audit.info('FXK = close');
  end if;

 commit;

end p_fxk_u;
/
show err;

PROMPT *** Create  grants  P_FXK_U ***
grant EXECUTE                                                                on P_FXK_U         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_FXK_U         to FOREX;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_FXK_U.sql =========*** End *** =
PROMPT ===================================================================================== 
