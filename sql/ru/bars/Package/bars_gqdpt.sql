
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_gqdpt.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BARS_GQDPT 
is


    -----------------------------------------------------------------
    -- Constants
    --
    --
    g_headerVersion   constant varchar2(64)  := 'version 1.00 03.11.2006';
    g_headerDefs      constant varchar2(512) := '';



    -----------------------------------------------------------------
    -- HEADER_VERSION()
    --
    --     Функция возвращает строку с версией заголовка пакета
    --
    --
    --
    function header_version return varchar2;

    -----------------------------------------------------------------
    -- BODY_VERSION()
    --
    --     Функция возвращает строку с версией тела пакета
    --
    --
    --
    function body_version return varchar2;


    -----------------------------------------------------------------
    -- CREATE_BALANCE_QUERY()
    --
    --     Процедура создания запроса на получение информации/средств
    --     по депозитному договору
    --
    --     Параметры:
    --
    --         p_querytype        Тип запроса
    --                                 0 - информационные запрос
    --                                 1 - выплата процентов
    --                                 2 - выплата вклада и процентов
    --
    --         p_branch           Код отделения, в котором открыт договор
    --
    --         p_dptnum           Номер депозитного договора
    --
    --         p_custfirstname    Имя клиента
    --
    --         p_custmiddlename   Отчетство клиента
    --
    --         p_custlastname     Фамилия клиента
    --
    --         p_custidcode       Идентификационный код клиента
    --
    --         p_custdocserial    Серия документа клиента
    --
    --         p_custdocnumber    Номер документа клиента
    --
    --         p_custdocdate      Дата выдачи документа клиента
    --
    --         p_amount           Сумма к выдаче
    --
    --         p_queryid          Идентификатор созданного запроса
    --
    procedure create_balance_query(
        p_querytype       in   number,
        p_branch          in   branch.branch%type,
        p_dptnum          in   dpt_deposit.nd%type,
        p_custfirstname   in   varchar2,
        p_custmiddlename  in   varchar2,
        p_custlastname    in   varchar2,
        p_custidcode      in   customer.okpo%type,
        p_custdocserial   in   person.ser%type,
        p_custdocnumber   in   person.numdoc%type,
        p_custdocdate     in   person.pdate%type,
        p_amount          in   number,
        p_queryid         out  gq_query.query_id%type );

    -----------------------------------------------------------------
    -- GET_BALANCE_QUERY()
    --
    --     Процедура получения результата запроса по депозитному договору
    --
    --     Параметры:
    --
    --         p_queryid          Идентификатор запроса
    --
    --         p_querystatus      Состояние запроса
    --                              0 - не обработан
    --                              1 - успешно обработан
    --                              2 - обработан с ошибкой
    --
    --         p_errmsg           Текст ошибки
    --                            Устанавливается при состоянии 2
    --
    --         p_dptaccnum        Номер депозитного счета
    --
    --         p_dptacccur        Код валюты депозитного счета
    --
    --         p_dptaccbal        Остаток на депозитном счете
    --
    --         p_dptaccbalavl     Доступный остаток на депозитном счете
    --
    --         p_intaccnum        Номер счета начисленных процентов
    --
    --         p_intacccur        Код валюты счета начисленных процентов
    --
    --         p_intaccbal        Остаток на счете начисленных процентов
    --
    --         p_intaccbalavl     Доступный остаток на счете начисленных
    --                            процентов
    --
    --         p_transfamount     Перечисленная на транзит сумма
    --
    procedure get_balance_query(
        p_queryid         in   gq_query.query_id%type,
        p_querystatus     out  gq_query.query_status%type,
        p_errmsg          out  varchar2,
        p_dptaccnum       out  accounts.nls%type,
        p_dptacccur       out  accounts.kv%type,
        p_dptaccbal       out  accounts.ostc%type,
        p_dptaccbalavl    out  accounts.ostc%type,
        p_intaccnum       out  accounts.nls%type,
        p_intacccur       out  accounts.kv%type,
        p_intaccbal       out  accounts.ostc%type,
        p_intaccbalavl    out  accounts.ostc%type,
        p_transfamount    out  accounts.ostc%type,
        p_transfdocref    out  oper.ref%type,
        p_branch          out  branch.branch%type,
        p_dptnum          out  dpt_deposit.nd%type,
        p_custfirstname   out  varchar2,
        p_custmiddlename  out  varchar2,
        p_custlastname    out  varchar2,
        p_custidcode      out  customer.okpo%type,
        p_custdocserial   out  person.ser%type,
        p_custdocnumber   out  person.numdoc%type,
        p_custdocdate     out  person.pdate%type,
        p_amount          out   number               );


    -----------------------------------------------------------------
    -- PROCESS_BALANCE_QUERY()
    --
    --     Процедура обработки запроса по депозитному договору
    --
    --     Параметры:
    --
    --         p_request          Запрос
    --
    --         p_status           Результат обработки запроса
    --                              1 - успешно обработан
    --                              2 - обработан с ошибкой
    --
    --         p_response         Ответ на запрос
    --
    --
    procedure process_balance_query(
        p_request         in   gq_query.request%type,
        p_status          out  gq_query.query_status%type,
        p_response        out  gq_query.response%type      );

end bars_gqdpt;
/

 show err;
 
PROMPT *** Create  grants  BARS_GQDPT ***
grant EXECUTE                                                                on BARS_GQDPT      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on BARS_GQDPT      to DPT_ROLE;
grant EXECUTE                                                                on BARS_GQDPT      to START1;
grant EXECUTE                                                                on BARS_GQDPT      to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bars_gqdpt.sql =========*** End *** 
 PROMPT ===================================================================================== 
 