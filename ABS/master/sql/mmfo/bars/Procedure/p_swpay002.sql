

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_SWPAY002.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_SWPAY002 ***

  CREATE OR REPLACE PROCEDURE BARS.P_SWPAY002 (
    p_swRef    in  number,
    p_ref      in  number )
is

l_mt         sw_journal.mt%type;
l_tmp        sw_operw.value%type;
l_chgType    sw_operw.value%type;
l_currCode   tabval.kv%type;
l_prcAmount  number;
l_chgAmount  number;
l_cnt        number;


l_docAmount    oper.s%type;
l_docDk        oper.dk%type;
l_docAccA      oper.nlsa%type;
l_docAccB      oper.nlsb%type;
l_docCurrCode  oper.kv%type;
l_docValueDate oper.vdat%type;
l_docFlg       number;



procedure SwiftToAmount(
    p_swiftAmount       in   varchar2,
    p_currCode          out  number,
    p_amount            out  number   )
is

    l_currency          varchar2(3);
    l_currCode          number;
    l_currDig           number;
    l_amount            varchar2(38);

begin

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


end SwiftToAmount;



begin

    -- bars_audit.info('SWPAY002: Вход ref= ' || to_char(p_ref) || ' swref=' || to_char(p_swRef));

    -- лучше еще раз проверим
    begin

        select mt
          into l_mt
          from sw_journal
         where swref = p_swRef
           and mt    = 2;

    exception
        when NO_DATA_FOUND then
            raise_application_error(-20787, '\10001 Не найдено SWIFT-сообщение с типом 002');
    end;

    -- ищем сумму перевода
    begin

        select substr(value, 7)
          into l_tmp
          from sw_operw
         where swref = p_swref
           and tag = '32'
           and opt = 'A';

         SwiftToAmount(l_tmp, l_currCode, l_prcAmount);

    exception
        when NO_DATA_FOUND then
            raise_application_error(-20787, '\10002 Не найдена сумма SWIFT-сообщения (поле 32А)');
    end;

    -- ищем тип комиссии
    select value
      into l_chgType
      from sw_operw
     where swref = p_swRef
       and tag = '71'
       and opt = 'A';

    -- Если комиссия присутствует, то получаем ее сумму
    if (l_chgType = 'OUR') then

        select value
          into l_tmp
          from sw_operw
         where swref = p_swRef
           and tag   = '71'
           and opt   = 'G';

         SwiftToAmount(l_tmp, l_currCode, l_chgAmount);

    else

        l_chgAmount := 0;

    end if;

    -- bars_audit.info('SWPAY002: Сумма перевода= ' || to_char(l_prcAmount));
    -- bars_audit.info('SWPAY002: Сумма комиссии= ' || to_char(l_chgAmount));

    dbms_output.put_line('Сумма перевода =>' || to_char(l_prcAmount));
    dbms_output.put_line('Сумма комиссии =>' || to_char(l_chgAmount));

    --
    -- Оплата документа
    --

    begin

        select s, dk, nlsa, nlsb, kv, vdat, decode(sos,5, 1, 0)
          into l_docAmount, l_docDk, l_docAccA, l_docAccB, l_docCurrCode, l_docValueDate, l_docFlg
          from oper
         where ref = p_ref
           and tt  = 'SWD';

        -- Проверим общую сумму документа
        if (l_docAmount != l_prcAmount + l_chgAmount) then
            raise_application_error(-20787, '\10004 Сумма перевода и комисии не совпадает с суммой документа (ref ' || to_char(p_ref) || ')');
        end if;

        select count(*)
          into l_cnt
          from opldok
         where ref = p_ref
           and tt in ('SW1', 'SW2');

        if (l_cnt > 0) then
            raise_application_error(-20787, '\10005 Попытка повторной генерации проводок SW1, SW2 (ref ' || to_char(p_ref) || ')');
        end if;

        -- bars_audit.info('SWPAY002: Вызов gl.payv (cумма перевода)');
        gl.payv(l_docFlg, p_ref, l_docValueDate, 'SW1', l_docDk, l_docCurrCode,
                l_docAccA, l_prcAmount, l_docCurrCode, l_docAccB, l_prcAmount);

        if (l_chgAmount != 0) then
            -- bars_audit.info('SWPAY002: Вызов gl.payv (cумма комиссии)');
            gl.payv(l_docFlg, p_ref, l_docValueDate, 'SW2', l_docDk, l_docCurrCode,
                    l_docAccA, l_chgAmount, l_docCurrCode, l_docAccB, l_chgAmount);
        end if;

    exception
        when NO_DATA_FOUND then
            raise_application_error(-20787, '\10003 Документ с типом SWD не найден (ref ' || to_char(p_ref) || ')');
    end;

end p_swpay002;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_SWPAY002.sql =========*** End **
PROMPT ===================================================================================== 
