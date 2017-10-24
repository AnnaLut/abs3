

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_FXK.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_FXK ***

  CREATE OR REPLACE PROCEDURE BARS.P_FXK (p_par integer, p_nls1819 varchar2, p_dat date)
is
-- для p_par=1
l_nls3    varchar2(15);  /*счет 3811*/
l_nls6    varchar2(15);  /*счет 6204*/
l_nms3 VARCHAR2(38);
l_nms6 VARCHAR2(38);
-- для p_par=2,3
l_nls3041 varchar2(15);  /*счет 3041*/
l_nls3351 varchar2(15);  /*счет 3351*/
l_nls6209 varchar2(15);  /*счет 6209*/
l_nms3041 VARCHAR2(38);
l_nms3351 VARCHAR2(38);
l_nms6209 VARCHAR2(38);
l_nls1819 varchar2(15);  /* торговый грн-счет    */
l_nms1819 VARCHAR2(38);  /* на него сворачиваем  */
-- для оплаты
l_dk   number;       /* признак ДТ-КТ */
l_ref1  int;
l_ref2  int;
l_ref3  int;
l_fl   int;
l_okpo VARCHAR2(15);
l_nlsd VARCHAR2(15);
l_nlsk VARCHAR2(15);
l_nmsa VARCHAR2(38);
l_nmsb VARCHAR2(38);
 --переменные для отката сегодняшних операций FXK  по переоценке
par2_      number;
par3_     varchar2(30);
/*
  версия
  qwa   31.08.2011  Новая постановка для форвардных сделок - в соотв. с постановл. 309
                    !!!спот не участвует потому что по спот-сделкам не формируется 9 класс!!!
                    !!!только форвард!!!
                     ---------------------   параметры вызова 2 (ежедневная переоценка )
                                                              3 (обратная проводка по счетам 3351, 3041 в корр с 1819 )
        Краткое описание:
        Форвардные сделки >2 раб.дней, в дату ввода раскрываем 9 класс операцией FXF
        согласно настроек fx_spot
        1. 9 класс переоцениваем как обычно (для получения грн-эквивалента наряду со всей валютой)
        и отдельно !! на финише дня !!  данной процедурой фиксируем  результат переоценки
                                       на 3041-6209 для положит результата переоц.
                                       на 6209-3351 для отрицат результата переоц.
        фиксируем результат переоценки в fx_deal.sumpa для вал А, fx_deal.sumpb для вал Б,
                           суммарный   результат    в fx_deal.sump (вклад в 6209)
        2. На старте дня по сделкам, у которых закрывается форвардный 9 класс формируем 2 обратных
           проводки (закрываем 3041, 3351 в части текущей сделки  в корреспонденции с 1819т -торговым)
           Результат переоценки остается суммарно на 6209 и для текущей сделки это поле fx_deal.sump
        Отличия по отношению к предыдущей версии
        а. Не формируем форвард на закрытие
        б. Другие счета для отражения переоценки (стало 3041,3351,6209 - было 3811 - 6204)
        в. Запоминаем результат переоценки в архиве и реф.документов по переоценке в fx_deal_ref
        г. Сворачивание переоценки обязательств и активов делаем на старте дня - параметр
           вызова функции 3 .

*/
MODCODE   constant varchar2(3) := 'FX';

/*  qwa   08.08.2008  в соотв с заявкой Петрокома 1075
        предложено всем польз. модуля (использовали ГОУ ОБ, Петроком, УПБ)
   Заявка 1075
   Процедура отражения результатов переоценки сумм своп (спот и форвард) - сделок на 3811-6204
   (9 класс для спот и форвард согласно справочника fx_spot)
   Постанова НБУ №135 + письмо   ------------------------------ параметр вызова 1
   Предположения для реализации:
   а) Используем операцию  FXK
   б) Счета 3811-6204 - одна пара для всех валют, всех сделок
   в) Процедура выполняется на финише дня в списке после переоценки остатков
      в инвалюте (операции будут порождены от имени пользователя закрывающего
      день). Порождаются прямые проводки по учету переоценки сделки а также
      обратные форвардные для сворачивания 3811
   г) Если процедура запускается повторно, в течении дня будем снимать
      все предыдущие "сегодняшние"  FXK, сделанные ранее. Наверное можно
      анализировать, если сумма не меняется то оставлять, если меняется -
      откатить. Пока будем удалять все!!!
      Откатим также форвардные обратные, порожденные сегодня

   Как мы понимаем положительный и отрицательный результат
   переоценки сумм сделок
   здесь НР - нереализованный результат
1) Покупка валюты     Курс растет
   *** Счет 9200(А)  ***
   Пример было  -100USD*4.5=-450.00
          стало -100USD*4.6=-460.00   НР=-10.00 (ДТ)
   Положительный результат  переоценки
         ДТ3811   КТ6204  10.00
2) Покупка валюты     Курс падает
    ***  Счет  9200(А) ***
   Пример было  -100USD*4.5=-450.00
          стало -100USD*4.4=-440.00   НР=10.00 (КТ)
   Отрицательный результат  переоценки
         ДТ6204   КТ3811  10.00
3) Продажа валюты   Курс растет
   *** Счет  9210(П)     ***
   Пример было  100USD*4.5=450.00
          стало 100USD*4.6=460.00   НР=10.00 (КТ)
   Отрицательный результат  переоценки
         ДТ6204   КТ3811  10.00
4) Продажа валюты Курс падает
   *** Счет  9210(П)    ***
   Пример было  100USD*4.5=450.00
          стало 100USD*4.4=440.00   НР=-10.00 (ДТ)
   Положительный результат  переоценки
         ДТ3811   КТ6204  10.00
*/

begin
 if p_par=1 then   /*   переоценка на 3811-6204 с формированием форвардных обратных
                       внебаланс 9202, 9212 */
    begin
   -- определим счета 3811, 6204 по настройке оп FXK
    SELECT to_number(substr(t.flags,38,1)),t.nlsa,substr(a.nms,1,38),t.nlsb,substr(b.nms,1,38)
     INTO l_fl,l_nls3,l_nms3,l_nls6,l_nms6
     FROM tts t,accounts a,accounts b
     WHERE t.tt='FXK' and
          ltrim(rtrim(t.nlsa))=a.nls and a.kv=980 and
          ltrim(rtrim(t.nlsb))=b.nls and b.kv=980  ;
    exception when no_data_found then
    bars_error.raise_nerror(MODCODE, 'TT_FXK_NOT_DEFINITION');
    end;
--logger.info('0FXK NLS3='||l_nls3||'NLS6='||l_nls6);
   SELECT substr(f_ourokpo,1,15) INTO l_okpo FROM dual;
 -- проверим были ли "сегодня" операции FXK
 -- откатим все сегодняшние
   begin
      for p in (select ref  from oper  where tt='FXK'
                and ((nlsa=l_nls3 and nlsb=l_nls6) or
                    ( nlsa=l_nls6 and nlsb=l_nls3))
                and sos>0 and datd=gl.BDATE)
      loop
       -- logger.info('1FXK'||'back');
        p_back_dok(p.ref,5,null,par2_,par3_,1);
        update operw set value='Повторна переоцiнка спот-угод на 3811-6204' where ref=p.ref and tag='BACKR';
      end loop;
   end;
 /* все актуальные для переоценки сегодня сделки на условиях спот
    -- по датам - во временном  периоде + 2 раб дня по отнош. к дате заключения
    -- по отражению на 9200 -  FX5 оплачена
    -- сумму сделки берем по типу остатка на счетах 9200(А), 9210(П)
 */
    for k in (
           select f.deal_tag,f.ref,f.ref1,f.dat,f.dat_a,f.dat_b,f.kva,-f.suma,f.kvb,f.sumb, '9200' nbs,f.dat_a fdat,
              ( gl.p_icurval(f.kva,-f.suma,bankdate_g)-
                gl.p_icurval(f.kva,-f.suma,
                (select max(fdat) from fdat where fdat<bankdate_g ))) NKR,
'Переоцiнка позаб.спот-угоди №'||f.ntik||'купiвля ВАЛ-'||f.kva||' на суму ' ||ltrim(rtrim(to_char(f.suma/100,'99999999999.99')))
                               NAZN1
  ,
'Зворотня проводка по переоц.позаб.спот-угоди №'||f.ntik||'купiвля ВАЛ-'||f.kva||' на суму ' ||ltrim(rtrim(to_char(f.suma/100,'99999999999.99')))
                                NAZN2
           from fx_deal f
           where   f.dat<f.dat_a           and    f.dat<bankdate_g     and
                   f.dat_a>=bankdate_g     and    f.kva<>980           and
                   count_wday(f.dat,f.dat_a)-1 in (1,2) and exists
                   (select ref from opldok where ref=nvl(f.ref1,f.ref) and sos=5 and tt='FX5') -- или FXF ------
         union all
         select deal_tag,ref,ref1,dat,dat_a,dat_b,kva,-suma,kvb,sumb, '9210' nbs,dat_b fdat,
               ( gl.p_icurval(kvb,sumb,bankdate_g)-
                gl.p_icurval(kvb,sumb,
                (select max(fdat) from fdat where fdat<bankdate_g ))) NKR,
'Переоцiнка позаб.спот-угоди №'||ntik||'продаж ВАЛ-'||kvb||' на суму ' ||ltrim(rtrim(to_char(sumb/100,'99999999999.99')))
                                NAZN1
,
'Зворотня проводка по переоц.позаб.спот-угоди №'||ntik||'продаж ВАЛ-'||kvb||' на суму ' ||ltrim(rtrim(to_char(sumb/100,'99999999999.99')))
                                NAZN2
        from fx_deal f
        where   dat<dat_b           and    dat<bankdate_g     and
                dat_b>=bankdate_g   and    f.kvb<>980           and
                count_wday(dat,dat_b)-1 in (1,2) and exists
                   (select ref from opldok where ref=nvl(f.ref1,f.ref) and sos=5 and tt='FX5')  -- или FXF ------
         )
    loop
     SAVEPOINT do_fxk1;
     begin
       --logger.info('2FXK NKR='||k.NKR ||'nbs='||k.nbs);
        if  k.NKR=0 then goto kin1;
        elsif ((k.nbs='9200' and k.NKR<0)  or (k.nbs='9210' and k.NKR<0))  then
              l_nlsd:=l_nls3; l_nmsa:=l_nms3;
              l_nlsk:=l_nls6; l_nmsb:=l_nms6;
        elsif  ((k.nbs='9200' and k.NKR>0)   or (k.nbs='9210' and k.NKR>0)) then
              l_nlsd:=l_nls6; l_nmsa:=l_nms6;
              l_nlsk:=l_nls3; l_nmsb:=l_nms3;
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
              (l_ref1, 'FXK', 6, l_ref1, 1, sysdate, gl.bDATE, gl.bDATE, gl.bDATE,
               l_nmsa, l_nlsd, gl.aMFO, l_okpo, l_nmsb, l_nlsk, gl.aMFO, l_okpo,
               980, abs(k.nkr), 980, abs(k.nkr), k.nazn1, USER_ID);
          gl.payv(l_fl, l_ref1, GL.BDATE, 'FXK', 1,980, l_nlsd, abs(k.nkr), 980, l_nlsk, abs(k.nkr) );
          EXCEPTION WHEN OTHERS THEN   ROLLBACK TO do_fxk1;
          bars_error.raise_nerror(MODCODE, 'ERR_PAY_FXK');
        END;
       /*  == зворотня ==  */
        BEGIN
         gl.ref (l_ref2);
         --logger.info('3FXK NKR='||k.NKR||'ref='||l_ref2||'l_nlsd='||l_nlsd||'l_nlsk='||l_nlsk);
         INSERT INTO oper
              (ref, tt, vob, nd, dk, pdat,
               vdat,
               datd, datp,
               nam_a, nlsa, mfoa, id_a,
               nam_b, nlsb, mfob, id_b,
	       kv, s, kv2, s2, nazn, userid)
         VALUES
              (l_ref2, 'FXK', 6, l_ref2, 1, sysdate,
               decode(k.nbs,'9200',k.dat_a,'9210',k.dat_b),
               gl.bDATE, gl.bDATE,
               l_nmsb, l_nlsk, gl.aMFO, l_okpo, l_nmsa, l_nlsd, gl.aMFO, l_okpo,
               980, abs(k.nkr), 980, abs(k.nkr), k.nazn2, USER_ID);
         gl.payv(l_fl, l_ref2, k.fdat, 'FXK', 1,980, l_nlsk, abs(k.nkr), 980, l_nlsd, abs(k.nkr) );
         EXCEPTION WHEN OTHERS THEN   ROLLBACK TO do_fxk1;
         bars_error.raise_nerror(MODCODE, 'ERR_PAY_FXK');
        END;
     end;
     <<kin1>> NULL;
    end loop;

 elsif p_par in (2,3) then   /*   переоценка на 3041, 3351,6209 с запоминанием суммы переоценки в архиве      p_par=2,
                                  в дату закрытия внебаланса должна отработать на старте дня данная процедура p_par=3
                                  внебаланс на 9202, 9212
                              */
  begin
   -- определим счета 3401, 3351, 6209 по настройке оп FXK
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
--logger.info('0FXK NLS3='||l_nls3||'NLS6='||l_nls6);

  SELECT substr(f_ourokpo,1,15)
    INTO l_okpo
    FROM dual;

  if p_par=2 then  -- переоценка
   -- проверим были ли "сегодня" операции FXK
   -- откатим все сегодняшние
      begin
         for p in (

         select  o.ref,o.nlsa,o.nlsb,o.s,o.sos,
                 to_number(substr(o.nazn, instr(o.nazn,'ВАЛ-')+4,3)) kv,
                 to_number( substr(o.nazn,instr(o.nazn,'Ref ')+4,instr(o.nazn,'№')-(instr(o.nazn,'Ref ')+4))) deal_tag,
                 f.sumpa,f.sumpb,f.sump,f.kva,f.kvb
           from oper o, fx_deal f
          where o.tt='FXK'
            and o.sos>0
            and o.datd=bankdate_g
            and substr(o.nazn,instr(o.nazn,'Ref ')+4,instr(o.nazn,'№')-(instr(o.nazn,'Ref ')+4))=to_char(f.deal_tag)
            and o.nazn like 'Переоц%'

                )
      loop
       -- logger.info('1FXK'||'back');
          p_back_dok(p.ref,5,null,par2_,par3_,1);

          update operw
            set value='Повторна переоцiнка спот-угод на 3*-6209'
          where ref=p.ref
            and tag='BACKR';

          if      p.sos=5
             and  p.kv=p.kva
             and  p.nlsa like '3041%'
             and  p.nlsb like '6209%'
             and  nvl(p.sumpa,0)<>0 then
--bars_audit.info('p_fxk = sos1 = '||p.deal_tag);
             update fx_deal
               set  sumpa = nvl(sumpa,0)-p.s,
                    sump  = nvl(sump,0) -p.s
              where deal_tag=p.deal_tag;

          elsif   p.sos=5
             and  p.kv=p.kva
             and  p.nlsa like '6209%'
             and  p.nlsb like '3351%'
             and  nvl(p.sumpa,0)<>0  then
--bars_audit.info('p_fxk = sos2= '||p.deal_tag);
             update fx_deal
               set  sumpa = nvl(sumpa,0)+p.s,
                    sump  = nvl(sump,0) +p.s
              where deal_tag=p.deal_tag;

          elsif   p.sos=5
             and  p.kv=p.kvb
             and  p.nlsa like '3041%'
             and  p.nlsb like '6209%'
             and  nvl(p.sumpb,0)<>0  then
--bars_audit.info('p_fxk = sos3= '||p.deal_tag);
             update fx_deal
                set  sumpb = nvl(sumpb,0)-p.s,
                     sump  = nvl(sump,0) -p.s
              where deal_tag=p.deal_tag;

          elsif   p.sos=5
             and  p.kv=p.kvb
             and  p.nlsa like '6209%'
             and  p.nlsb like '3351%'
             and  nvl(p.sumpb,0)<>0  then
--bars_audit.info('p_fxk = sos4= '||p.deal_tag);
             update fx_deal
               set  sumpb = nvl(sumpb,0)+p.s,
                    sump  = nvl(sump,0) +p.s
              where deal_tag=p.deal_tag;

          end if;

      end loop;
      end;
   /* все актуальные для переоценки сегодня сделки на условиях спот
    -- по датам - во временном  периоде + 2 раб дня по отнош. к дате заключения
    -- по отражению на 9202? 9212 -  FXF оплачена
    -- сумму сделки берем по типу остатка на счетах 9202(А), 9212(П)
   */
     for k in (

           select f.deal_tag,f.ref,f.ref1,f.dat,f.dat_a,f.dat_b,f.kva,-f.suma,f.kvb,f.sumb, '9202' nbs,f.dat_a fdat,
              ( gl.p_icurval(f.kva,-f.suma,bankdate_g)-
                gl.p_icurval(f.kva,-f.suma,
                (select max(fdat) from fdat where fdat<bankdate_g ))) NKR,
 'Переоцiнка позаб.спот-угоди Ref '||to_char(f.deal_tag)||'№'||f.ntik||'купiвля ВАЛ-'||f.kva||' на суму ' ||ltrim(rtrim(to_char(f.suma/100,'99999999999.99')))
                               NAZN1
                               ,count_wday(f.dat,f.dat_a)-1 wday
           from fx_deal f
           where   f.dat<f.dat_a           and    f.dat<bankdate_g     and
                   f.dat_a>=bankdate_g     and    f.kva<>980
                   and count_wday(f.dat,f.dat_a)-1>=1
                   and exists
                   (select ref from opldok where ref=nvl(f.ref1,f.ref) and sos=5 and tt='FXF')
         union all
         select deal_tag,ref,ref1,dat,dat_a,dat_b,kva,-suma,kvb,sumb, '9212' nbs,dat_b fdat,
               ( gl.p_icurval(kvb,sumb,bankdate_g)-
                gl.p_icurval(kvb,sumb,
                (select max(fdat) from fdat where fdat<bankdate_g ))) NKR,
'Переоцiнка позаб.спот-угоди Ref '||to_char(f.deal_tag)||'№'||ntik||'продаж ВАЛ-'||kvb||' на суму ' ||ltrim(rtrim(to_char(sumb/100,'99999999999.99')))
                                NAZN1
                                ,count_wday(dat,dat_b)-1
        from fx_deal f
        where   dat<dat_b           and    dat<bankdate_g     and
                dat_b>=bankdate_g   and    f.kvb<>980
                and count_wday(dat,dat_b)-1 >=1
                and exists
                   (select ref from opldok where ref=nvl(f.ref1,f.ref) and sos=5 and tt='FXF')
         order by 1


         )
     loop
       SAVEPOINT do_fxk2;
       begin
       --logger.info('2FXK NKR='||k.NKR ||'nbs='||k.nbs);
         if  k.NKR=0 then goto kin2;
         elsif ((k.nbs='9202' and k.NKR<0)  or (k.nbs='9212' and k.NKR<0))  then
              l_nlsd:=l_nls3041; l_nmsa:=l_nms3041;
              l_nlsk:=l_nls6209; l_nmsb:=l_nms6209;

         elsif  ((k.nbs='9202' and k.NKR>0)   or (k.nbs='9212' and k.NKR>0)) then
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
            insert into fx_deal_ref (ref,deal_tag)
                 values (l_ref1,k.deal_tag);

          --  bars_audit.info('p_fxk0 ='||'k.nbs,l_nlsd,l_nlsk,k.nkr=='||k.nbs ||'='||l_nlsd||'='||l_nlsk||'='||k.nkr);

            if k.nbs='9202' and k.NKR<>0   and l_nlsk like '6209%' then
                --bars_audit.info('p_fxka 1 ='||'9202='||k.nkr||' '||k.deal_tag);
                update fx_deal
                  set sumpa=nvl(sumpa,0)+abs(k.nkr)
                where deal_tag=k.deal_tag;
            elsif  k.nbs='9202' and k.NKR<>0 and l_nlsd like '6209%' then
                --bars_audit.info('p_fxka 2 ='||'9202='||k.nkr||' '||k.deal_tag);
                update fx_deal
                  set sumpa=nvl(sumpa,0)-abs(k.nkr)
                where deal_tag=k.deal_tag;
            end if;

            if  k.nbs='9212' and k.NKR<>0 and l_nlsk like '6209%' then
                --bars_audit.info('p_fxkb 1 ='||'9212='||k.nkr||' '||k.deal_tag);

                update fx_deal
                  set sumpb=nvl(sumpb,0)+abs(k.nkr)
                where deal_tag=k.deal_tag;
            elsif
                k.nbs='9212' and k.NKR<>0 and l_nlsd like '6209%' then
                --bars_audit.info('p_fxkb 2 ='||'9212='||k.nkr||' '||k.deal_tag);
                update fx_deal
                  set sumpb=nvl(sumpb,0)-abs(k.nkr)
                where deal_tag=k.deal_tag;
            end if;


            --bars_audit.info('p_fxkp ='||k.nkr||'= '||k.deal_tag);
            update fx_deal
               set sump=nvl(sumpa,0)+nvl(sumpb,0)
               where deal_tag=k.deal_tag ;
         elsif  l_ref1 is null then
           --bars_audit.info('p_fxkp====>0'||k.nkr||'= '||k.deal_tag);
            update fx_deal
              set  sumpa=0, sumpb=0,  sump=0
             where deal_tag=k.deal_tag;

         end if;

       end;
       <<kin2>> NULL;
     end loop;

  elsif p_par=3 then       /*
                           закрытие  3041, 3351 в корресп с 1819-980 торговым (параметр процедуры)
                           */

   -- определим счет 1819 (торговый)  по настройке строки вызова процедуры
   --

     begin

       select  substr(nms,1,38),p_nls1819
         into  l_nms1819,l_nls1819
         from  accounts
        where  kv=980
          and  nls=p_nls1819;

        exception when no_data_found then
         bars_error.raise_nerror(MODCODE, 'TT_FXK_NOT_DEFINITION');
     end;
--  в курсор отбираем только те, по которым наступила дата закрытия сделки
--  и
     for k in (

           select  distinct o.ref,o.nlsa, o.nlsb, o.nazn,
                 sum(o.s) over (partition by o.nlsa,o.nlsb) s,
                 f.deal_tag,
          'Зворотня проводка по переоц.позаб.спот-угоди Ref '||to_char(f.deal_tag)||'№'||d.ntik||'продаж ВАЛ-'||d.kvb||' на суму ' ||ltrim(rtrim(to_char(d.sumb/100,'99999999999.99')))
                                NAZN3
         from  (select ref,nlsa,nlsb,s,nazn
                  from oper
                 where tt='FXK'
                   and sos=5
                   and nazn like 'Переоц%'
                  ) o,
                 fx_deal_ref f,
                 fx_deal d
          where f.ref=o.ref
            and d.deal_tag=f.deal_tag
            and d.dat_a<=bankdate_g
            and d.dat_b<=bankdate_g
            and d.dat_a=d.dat_b
            and  not exists (   -- если еще не было сворачиваний переоценок по данной сделке
                     select 1
                       from fx_deal_ref
                      where deal_tag=f.deal_tag
                       and  ref in (
                             select ref
                               from oper
                              where tt='FXK'
                               and sos=5
                               and nazn like 'Зворот%'))

         )
     loop
       SAVEPOINT do_fxk3;
       begin
       --logger.info('2FXK NKR='||k.NKR ||'nbs='||k.nbs);
         if  k.s=0 then goto kin3;
         elsif substr(k.nlsa,1,4)='6209'   then
              l_nlsd:=l_nls3351; l_nmsa:=l_nms3351;
              l_nlsk:=l_nls1819; l_nmsb:=l_nms1819;
         elsif substr(k.nlsb,1,4)='6209'   then
              l_nlsd:=l_nls1819; l_nmsa:=l_nms1819;
              l_nlsk:=l_nls3041; l_nmsb:=l_nms3041;
         else  goto kin3;
         end if;

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
            EXCEPTION WHEN OTHERS THEN   ROLLBACK TO do_fxk3;
            bars_error.raise_nerror(MODCODE, 'ERR_PAY_FXK');
         END;

         if l_ref3 is not null then
            insert into fx_deal_ref (ref,deal_tag)
                 values (l_ref3,k.deal_tag);

          --bars_audit.info('p_fxk0 ='||'l_nlsd,l_nlsk,k.s==='||l_nlsd||'='||l_nlsk||'='||k.s);
         end if;

       end;
       <<kin3>> NULL;
     end loop;

  end if;
 end if;
 --bars_audit.info('p_fxkp-- commit');
 commit;
end p_FXK;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_FXK.sql =========*** End *** ===
PROMPT ===================================================================================== 
