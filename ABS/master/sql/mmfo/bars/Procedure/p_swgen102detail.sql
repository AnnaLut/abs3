

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_SWGEN102DETAIL.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_SWGEN102DETAIL ***

  CREATE OR REPLACE PROCEDURE BARS.P_SWGEN102DETAIL (
    p_swRef102    in  number )
is

l_swRef       number;
l_swMt        number  := 002;
l_swTrn       varchar2(16);
l_swIo        varchar2(1);
l_swCurr      char(3);
l_swSender    char(11);
l_swReceiver  char(11);
l_swDateIn    date;
l_swDateOut   date;
l_swDateRec   date;
l_swDateValue date;
l_swUserId    sw_journal.id%type;

l_swRef102   number := p_swRef102;


l_hdrFld20    varchar2(200);
l_hdrFld23    varchar2(200);
l_hdrFld50    varchar2(200);
l_hdrOpt50    char(1);
l_hdrFld52    varchar2(200);
l_hdrOpt52    char(1);
l_hdrFld26    varchar2(200);
l_hdrFld77    varchar2(200);
l_hdrFld71    varchar2(200);
l_hdrFld36    varchar2(200);
l_hdrValDate  varchar2(8);

l_seqBPos     number := 0;

l_firstDetail boolean := true;
l_cnt         number := 0;

type t_lnFld71F is table of sw_operw.value%type;

l_lnFld21     sw_operw.value%type;
l_lnFld32     sw_operw.value%type;
l_lnFld50     sw_operw.value%type;
l_lnOpt50     sw_operw.opt%type;
l_lnFld52     sw_operw.value%type;
l_lnOpt52     sw_operw.opt%type;
l_lnFld57     sw_operw.value%type;
l_lnOpt57     sw_operw.opt%type;
l_lnFld59     sw_operw.value%type;
l_lnOpt59     sw_operw.opt%type;
l_lnFld70     sw_operw.value%type;
l_lnFld26     sw_operw.value%type;
l_lnFld77     sw_operw.value%type;
l_lnFld33     sw_operw.value%type;
l_lnFld71A    sw_operw.value%type;
l_lnFld71G    sw_operw.value%type;
l_lnFld36     sw_operw.value%type;
l_lnFld71F    t_lnFld71F;

l_rec         number;
-- l_swRef       number;

l_swcurrc      number;
l_swamnt       number;
l_swcurrCharge number;
l_swamntCharge number;

l_dupSwRef    number;
l_dupFileRef  varchar2(200);

l_submsgAmount varchar2(15);


PROCEDURE SwiftToAmount(
    p_swiftAmount       IN  VARCHAR2,
    p_currCode          OUT NUMBER,
    p_amount            OUT NUMBER )
IS

    l_currency          varchar2(3);
    l_currCode          number;
    l_currDig           number;
    l_amount            varchar2(38);

BEGIN

    -- extracting currency
    l_currency := substr(ltrim(rtrim(p_swiftAmount)), 1, 3);

    -- validate currency and selecting dig fraction
    begin
        select kv, dig into l_currCode, l_currDig
          from tabval
         where lcv = l_currency;
    exception
       when NO_DATA_FOUND then
           raise_application_error(-20787, '\001 Не найден код для валюты ' || l_currency);
    end;

    l_amount := substr(ltrim(rtrim(p_swiftAmount)), 4);

    -- check to decimal separator
    if (instr(l_amount, ',') is null or instr(l_amount, ',') = 0) then
           raise_application_error(-20787, '\002 Ошибка в формате суммы. Символ "," не найден');
    end if;

    -- searching position ','
    while (length(l_amount) - instr(l_amount, ',') < l_currDig)
    loop
        l_amount := l_amount || '0';
    end loop;

    p_currCode   := l_currCode;
    p_amount := to_number(replace(l_amount, ',', ''));

END SwiftToAmount;

function AmountToSwift(
    p_amount            in  number,
    p_currCode          in  number,
    p_IsLeading         in  boolean,
    p_HasCurrency       in  boolean  ) return varchar2
is

    l_result           varchar2(15);    -- Result string
    l_digPos           tabval.dig%type; -- Digital places for spesific curency
    l_currency         tabval.lcv%type; -- chars of curency code
begin

    --Selecting Dig fraction
    begin
       select dig, lcv into l_digPos, l_currency
         from tabval
        where kv = p_currCode;
    exception
        when NO_DATA_FOUND then
            l_digPos   := 2;
            l_currency := 'UAH';
    end;

    --Defining amount and converting it to string
    select replace(to_char(abs(p_amount)/power(10, l_digPos)), '.', ',') into l_result from dual;

    --Adding ',' if integer
    if (instr(l_result, ',') = 0) then
        l_result := l_result || ',';
    end if;

    --Adding leading zero if needed
    if (substr(l_result, 1, 1) = ',') then
        l_result := '0' || l_result;
    end if;

    --Adding currency code
    if (p_HasCurrency) then

        if (p_IsLeading) then
            l_result := l_currency || l_result;
        else
            l_result := l_result || l_currency;
        end if;

    end if;

    return l_result;

end AmountToSwift;


begin

    l_lnFld71F := t_lnFld71F();

    select io_ind, currency, sender, receiver, date_in, date_out, date_rec, vdate, id
      into l_swIo, l_swCurr, l_swSender, l_swReceiver, l_swDateIn, l_swDateOut, l_swDateRec, l_swDateValue, l_swUserId
      from sw_journal
     where swref = l_swRef102;

    -- Читаем блок А (общий)
    for i in (select tag, opt, value, n
                from sw_operw
               where swref = l_swRef102
              order by n )
    loop

        if (i.tag = '21' and i.opt is null) then
            l_seqBPos := i.n;
            exit;                                   -- начинается блок Б, выходим
        elsif (i.tag = '23' and i.opt is null) then
            l_hdrFld23 := i.value;
        elsif (i.tag = '50') then
            l_hdrOpt50 := i.opt;
            l_hdrFld50 := i.value;
        elsif (i.tag = '52') then
            l_hdrOpt52 := i.opt;
            l_hdrFld52 := i.value;
        elsif (i.tag = '26' and i.opt = 'T') then
            l_hdrFld26 := i.value;
        elsif (i.tag = '77' and i.opt = 'B') then
            l_hdrFld77 := i.value;
        elsif (i.tag = '71' and i.opt = 'A') then
            l_hdrFld71 := i.value;
        elsif (i.tag = '36' and i.opt is null) then
            l_hdrFld36 := i.value;
        elsif (i.tag = '20' and i.opt is null) then
            l_hdrFld20 := i.value;
        end if;

    end loop;

    select substr(value, 1, 6)
      into l_hdrValDate
      from sw_operw
     where swref = l_swRef102
       and tag = '32'
       and opt = 'A';

    dbms_output.put_line('23  =>' || l_hdrFld23);
    dbms_output.put_line('50  => opt=' || l_hdrOpt50 || ' val='|| l_hdrFld50);
    dbms_output.put_line('52  => opt=' || l_hdrOpt52 || ' val='|| l_hdrFld52);
    dbms_output.put_line('26T =>' || l_hdrFld26);
    dbms_output.put_line('77B =>' || l_hdrFld77);
    dbms_output.put_line('71A =>' || l_hdrFld71);
    dbms_output.put_line('36  =>' || l_hdrFld36);

    for i in (select tag, opt, value, n
                from sw_operw
               where swref = l_swRef102
                 and n >= l_seqBPos
              order by n )
    loop

        if ((i.tag = '21' and i.opt is null)
            or (i.tag = '32' and i.opt = 'A')) then

           if (l_firstDetail) then
                l_firstDetail := false;
            else

                dbms_output.put_line('***** New submessage found!');
                dbms_output.put_line('21  =>' || l_lnFld21);
                dbms_output.put_line('32B =>' || l_lnFld32);
                dbms_output.put_line('50a => opt=' || l_lnOpt50 || ' val=' || l_lnFld50);
                dbms_output.put_line('52a => opt=' || l_lnOpt52 || ' val=' || l_lnFld52);
                dbms_output.put_line('57a => opt=' || l_lnOpt57 || ' val=' || l_lnFld57);
                dbms_output.put_line('59a => opt=' || l_lnOpt59 || ' val=' || l_lnFld59);
                dbms_output.put_line('70  =>' || l_lnFld70);
                dbms_output.put_line('26T =>' || l_lnFld26);
                dbms_output.put_line('77B =>' || l_lnFld77);
                dbms_output.put_line('33B =>' || l_lnFld33);
                dbms_output.put_line('71A =>' || l_lnFld71A);

                for l in 1..l_lnFld71F.count
                loop
                    dbms_output.put_line('71F =>' || l_lnFld71F(l));
                end loop;

                dbms_output.put_line('71G =>' || l_lnFld71G);
                dbms_output.put_line('36  =>' || l_lnFld36);

                -- Проверка на дубли при расформировании МТ102
                begin

                    select swref into l_dupSwRef
                      from sw_journal
                     where trn = l_lnFld21;

                    select value into l_dupFileRef
                      from sw_operw
                     where swref = l_dupSwRef
                       and tag = '20'
                       and opt is null;


                    if (l_dupFileRef = l_hdrFld20) then
                        raise_application_error(-20100, 'Попытка повторного расформирования сообщения. Найдено дублирующееся сообщения с реф.' || to_char(l_dupSwRef));
                    end if;

                exception
                    when NO_DATA_FOUND then null;
                end;

                -- Пока не будем трогать пакет SWIFT
                select s_sw_journal.nextval
                  into l_swRef
                  from dual;

                dbms_output.put_line('Submessage ref=>' || to_char(l_swRef));

                SwiftToAmount(l_lnFld32, l_swcurrc, l_swamnt);

                --
                -- если есть комиссия, то документ делаем на общую сумму
                --
                if (l_lnFld71G is not null) then

                    SwiftToAmount(l_lnFld71G, l_swcurrCharge, l_swamntCharge);

                    --  дополнительно проверим, чтобы сходились валюты
                    if (l_swcurrc != l_swcurrCharge) then
                        raise_application_error(-20103, '\10002 Обнаружен различный код валюты в полях 32B и 71G');
                    end if;

                else
                    l_swamntCharge := 0;
                end if;

                l_submsgAmount := AmountToSwift(l_swamnt+l_swamntCharge, l_swcurrc, true, true);

                insert into sw_journal(swref, mt, trn, io_ind, currency, sender,
                                       receiver, amount, date_in, date_out, date_rec, vdate, page, id, imported, app_flag, lau_flag)
                values (l_swRef, 002, l_lnFld21, l_swIo, substr(l_lnFld32, 1, 3), l_swSender, l_swReceiver,
                                      l_swamnt+l_swamntCharge, l_swDateIn, l_swDateOut, l_swDateRec, l_swDateValue, 'Page 1/1', l_swUserId, 'Y', 'N', 1);

                dbms_output.put_line('Submessage amount=>' || to_char(l_swamnt+l_swamntCharge));

                l_rec := 1;

                insert into sw_operw(swref, seq, tag, opt, value, n)
                values (l_swRef, 'A', '20', null, l_hdrFld20, l_rec); l_rec := l_rec + 1;

                insert into sw_operw(swref, seq, tag, opt, value, n)
                values (l_swRef, 'A', '21', null, l_lnFld21, l_rec); l_rec := l_rec + 1;

                insert into sw_operw(swref, seq, tag, opt, value, n)
                values (l_swRef, 'A', '23', null, l_hdrFld23, l_rec); l_rec := l_rec + 1;


                insert into sw_operw(swref, seq, tag, opt, value, n)
                values (l_swRef, 'A', '32', 'A', l_hdrValDate || l_submsgAmount, l_rec); l_rec := l_rec + 1;

                if (l_lnFld50 is not null) then
                    insert into sw_operw(swref, seq, tag, opt, value, n)
                    values (l_swRef, 'A', '50', l_lnOpt50, l_lnFld50, l_rec); l_rec := l_rec + 1;
                elsif (l_hdrFld50 is not null) then
                    insert into sw_operw(swref, seq, tag, opt, value, n)
                    values (l_swRef, 'A', '50', l_hdrOpt50, l_hdrFld50, l_rec); l_rec := l_rec + 1;
                end if;

                --
                -- DG (05/06/2006): По просьбе Сбербанка добавил заполнение поля 52А
                --                  BIC-кодом отправителя сообщения, если в сообщении
                --                  данное поле не используется
                --
                if (l_lnFld52 is not null) then
                    insert into sw_operw(swref, seq, tag, opt, value, n)
                    values (l_swRef, 'A', '52', l_lnOpt52, l_lnFld52, l_rec); l_rec := l_rec + 1;
                elsif (l_hdrFld52 is not null) then
                    insert into sw_operw(swref, seq, tag, opt, value, n)
                    values (l_swRef, 'A', '52', l_hdrOpt52, l_hdrFld52, l_rec); l_rec := l_rec + 1;
                else
                    insert into sw_operw(swref, seq, tag, opt, value, n)
                    values (l_swRef, 'A', '52', 'A', l_swSender, l_rec); l_rec := l_rec + 1;
                end if;

                if (l_lnFld57 is not null) then
                    insert into sw_operw(swref, seq, tag, opt, value, n)
                    values (l_swRef, 'A', '57', l_lnOpt57, l_lnFld57, l_rec); l_rec := l_rec + 1;
                end if;

                if (l_lnFld59 is not null) then
                    insert into sw_operw(swref, seq, tag, opt, value, n)
                    values (l_swRef, 'A', '59', l_lnOpt59, l_lnFld59, l_rec); l_rec := l_rec + 1;
                end if;

                if (l_lnFld70 is not null) then
                    insert into sw_operw(swref, seq, tag, opt, value, n)
                    values (l_swRef, 'A', '70', null, l_lnFld70, l_rec); l_rec := l_rec + 1;
                end if;

                if (l_hdrFld26 is not null) then
                    insert into sw_operw(swref, seq, tag, opt, value, n)
                    values (l_swRef, 'A', '26', 'T', l_hdrFld26, l_rec); l_rec := l_rec + 1;
                elsif (l_lnFld26 is not null) then
                    insert into sw_operw(swref, seq, tag, opt, value, n)
                    values (l_swRef, 'A', '26', 'T', l_lnFld26, l_rec); l_rec := l_rec + 1;
                end if;

                if (l_hdrFld77 is not null) then
                    insert into sw_operw(swref, seq, tag, opt, value, n)
                    values (l_swRef, 'A', '77', 'B', l_hdrFld77, l_rec); l_rec := l_rec + 1;
                elsif (l_lnFld77 is not null) then
                    insert into sw_operw(swref, seq, tag, opt, value, n)
                    values (l_swRef, 'A', '77', 'B', l_lnFld26, l_rec); l_rec := l_rec + 1;
                end if;

                if (l_lnFld33 is not null) then
                    insert into sw_operw(swref, seq, tag, opt, value, n)
                    values (l_swRef, 'A', '33', 'B', l_lnFld33, l_rec); l_rec := l_rec + 1;
                end if;

                if (l_hdrFld71 is not null) then
                    insert into sw_operw(swref, seq, tag, opt, value, n)
                    values (l_swRef, 'A', '71', 'A', l_hdrFld71, l_rec); l_rec := l_rec + 1;
                elsif (l_lnFld71A is not null) then
                    insert into sw_operw(swref, seq, tag, opt, value, n)
                    values (l_swRef, 'A', '71', 'A', l_lnFld71A, l_rec); l_rec := l_rec + 1;
                end if;

                for l in 1..l_lnFld71F.count
                loop

                    if (l_lnFld71F(l) is not null) then
                        insert into sw_operw(swref, seq, tag, opt, value, n)
                        values (l_swRef, 'A', '71', 'F', l_lnFld71F(l), l_rec); l_rec := l_rec + 1;
                    end if;

                end loop;

                if (l_lnFld71G is not null) then
                    insert into sw_operw(swref, seq, tag, opt, value, n)
                    values (l_swRef, 'A', '71', 'G', l_lnFld71G, l_rec); l_rec := l_rec + 1;
                end if;

                if (l_lnFld36 is not null) then
                    insert into sw_operw(swref, seq, tag, opt, value, n)
                    values (l_swRef, 'A', '36', null, l_lnFld36, l_rec); l_rec := l_rec + 1;
                end if;


                -- Очищаем
                l_lnFld21   := null;
                l_lnFld32   := null;
                l_lnFld50   := null;
                l_lnOpt50   := null;
                l_lnFld52   := null;
                l_lnOpt52   := null;
                l_lnFld57   := null;
                l_lnOpt57   := null;
                l_lnFld59   := null;
                l_lnOpt59   := null;
                l_lnFld70   := null;
                l_lnFld26   := null;
                l_lnFld77   := null;
                l_lnFld33   := null;
                l_lnFld71A  := null;
                l_lnFld71G  := null;
                l_lnFld36   := null;
                l_lnFld71F.delete;


            end if;

           if (i.tag = '21') then
               l_lnFld21 := i.value;
           else
               exit;
           end if;

        elsif (i.tag = '32' and i.opt = 'B') then
            l_lnFld32 := i.value;
        elsif (i.tag = '50') then
            l_lnOpt50 := i.opt;
            l_lnFld50 := i.value;
        elsif (i.tag = '52') then
            l_lnOpt52 := i.opt;
            l_lnFld52 := i.value;
        elsif (i.tag = '57') then
            l_lnOpt57 := i.opt;
            l_lnFld57 := i.value;
        elsif (i.tag = '59') then
            l_lnOpt59 := i.opt;
            l_lnFld59 := i.value;
        elsif (i.tag = '70' and i.opt is null) then
            l_lnFld70 := i.value;
        elsif (i.tag = '26' and i.opt = 'T') then
            l_lnFld26 := i.value;
        elsif (i.tag = '77' and i.opt = 'B') then
            l_lnFld77 := i.value;
        elsif (i.tag = '33' and i.opt = 'B') then
            l_lnFld33 := i.value;
        elsif (i.tag = '71' and i.opt = 'A') then
            l_lnFld71A := i.value;
        elsif (i.tag = '71' and i.opt = 'F') then
            l_cnt := l_cnt + 1;
            l_lnFld71F.extend();
            l_lnFld71F(l_cnt) := i.value;
        elsif (i.tag = '71' and i.opt = 'G') then
            l_lnFld71G := i.value;
        elsif (i.tag = '36' and i.opt is null) then
            l_hdrFld36 := i.value;
        end if;

    end loop;

end;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_SWGEN102DETAIL.sql =========*** 
PROMPT ===================================================================================== 
