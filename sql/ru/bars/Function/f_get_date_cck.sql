
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_get_date_cck.sql =========*** Run
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_GET_DATE_CCK (CC_ID_ VARCHAR2,DAT1_ DATE)  RETURN DATE
IS
--- Функция возвращает ТОЛЬКО СТРОГО БУДУЩУЮ ПЛАТЕЖНУЮДАТУ оттекущего банковского дня!!!!!!

       nRet_   int;     -- Код возврата: =1 не найден, Найден =0
       sRet_   varchar2(256); -- Текст ошибки (?)
       RNK_    int;     -- Рег № заемщика
       nS_     number;  -- Сумма текущего платежа
       nS1_    number;  -- Сумма окончательного платежа
       NMK_    operw.value%type; -- наименованик клиента
       OKPO_   customer.okpo%type; -- OKPO         клиента
       ADRES_  operw.value%type; -- адрес        клиента
       KV_     accounts.KV%type;  -- код валюты   КД
       LCV_    tabval.LCV%type;    -- ISO валюты   КД
       NAMEV_  tabval.NAME%type;  -- валютa       КД
       UNIT_   tabval.UNIT%type;  -- коп.валюты   КД
       GENDER_ tabval.GENDER%type; -- пол валюты   КД
       nSS_    number;  -- Тек.Сумма осн.долга
       DAT4_   date;    --\ дата завершения КД
       nSS1_   number;  --/ Оконч.Сумма осн.долга
       DAT_SN_ date;    --\ По какую дату нач %
       nSN_    number;  --/ Сумма нач %
       nSN1_   number; -- | Оконч.Сумма проц.долга
       DAT_SK_ date;    --\ По какую дату нач ком
       nSK_    number;  --/ сумма уже начисленной комиссии
       nSK1_   number;  --| Оконч.Сумма комис.долга
       KV_KOM_ int;     -- Вал комиссии
       DAT_SP_ date;    -- По какую дату нач пеня
       nSP_    number;  -- сумма уже начисленной пени
       SN8_NLS accounts.NLS%type; --\
       SD8_NLS accounts.NLS%type; --/ счета начисления пени
       MFOK_   varchar2(6); --\
       NLSK_   varchar2(15); --/ счет гашения
       nSSP_    number; --\ сумма просроченного тела
       nSSPN_   number; --\ сумма просроченных процентов
       nSSPK_   number; --\ сумма  просроченной комиссии
       KV_SN8   varchar2(3);
       Mess_    Varchar2(1024);
       ND_      cc_deal.ND%type; --\ Референс КД
       DATP_SS_   date;    --\ дата ближайшего платежа по телу КД
       DATP_SN_   date;    --\ дата ближайшего платежа по процентам КД

       SUM_SP number := 0;

       NextPayDate date;

   BEGIN
        begin
        --1. Определяем реф. договора
           begin
              SELECT d.nd, a.KV
              INTO    ND_, KV_
              FROM cc_deal d, cc_add a
              WHERE d.ND   = a.ND   and d.sos>9 and d.sos<15
                and d.cc_id= CC_ID_ and d.SDATE = DAT1_ and d.vidd in (11,12,13);
              -- ОДНОВАЛЮТНЫЙ, нашли однозначно, все хорошо
           EXCEPTION
            WHEN TOO_MANY_ROWS THEN
                -- нашли НЕоднозн, м.б. МУЛЬТИВАЛ ? По концепции в базе должен быть один на дату
                  raise_application_error(-20210,
                 'пом. №1 КД № '||CC_ID_||' від '||to_char(DAT1_,'dd/mm/yyyy')||' НЕ один в БД. Зверніться в службу підтримки.',
                                        TRUE);
            WHEN NO_DATA_FOUND THEN
                 raise_application_error(-20210,
                 'пом. №2 КД № '||CC_ID_||' від '||to_char(DAT1_,'dd/mm/yyyy')||'р. НЕ знайдено !',
                                        TRUE);
           end;
        end;

          begin
             --2. Ищем ближайшее плановое погашение по телу или %
            begin
                  SELECT MIN (fdat)
                    INTO DATP_SS_
                    FROM cc_lim
                   WHERE nd = ND_ AND fdat > gl.bd AND sumg > 0
                GROUP BY nd;
             EXCEPTION
                   WHEN NO_DATA_FOUND THEN
                    DATP_SS_:=gl.bd+1;
            end;

            begin
                  SELECT MIN (fdat)
                    INTO DATP_SN_
                    FROM cc_lim
                   WHERE nd = ND_ AND fdat > gl.bd AND sumo - sumg - nvl(sumk,0) > 0
                GROUP BY nd;
                 EXCEPTION
                         WHEN NO_DATA_FOUND THEN
                         DATP_SN_:=gl.bd+1;
            end;


        begin
                select sum( a.ostc)
                into SUM_SP
                from accounts a, nd_acc na
                where a.acc = na.acc
                and na.nd = ND_
                and a.tip in ('SP ','SL ','SPN','SK9');

                exception
                when no_data_found then SUM_SP := 0;
                end;

                if nvl(SUM_SP,0) != 0
                then NextPayDate := gl.bd+1;
                else NextPayDate:=least(DATP_SS_,DATP_SN_);
                end if;

          end;

return NextPayDate;
END;
/
 show err;
 
PROMPT *** Create  grants  F_GET_DATE_CCK ***
grant EXECUTE                                                                on F_GET_DATE_CCK  to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_get_date_cck.sql =========*** End
 PROMPT ===================================================================================== 
 