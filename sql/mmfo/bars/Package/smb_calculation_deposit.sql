PROMPT =================================================================================== 
PROMPT *** Run *** == Scripts /Sql/BARS/package/smb_calculation_deposit.sql == *** Run ***
PROMPT ===================================================================================

create or replace package smb_calculation_deposit 
-- расчет по депозитам ММСБ
as


    /*
    operation_type
    1          DU$    DU$ Списання зайвонарахованих відсотків – 
    2          DU%   DU% Нарахування відсотків
    3          DU0    DU0 Внесення коштів на депозитний рахунок  - необхідно додати тип документа меморіальний ордер для операцій Строковий депозит
    4          DU1    DU1 Виплата відсотків (внутр.)
    6          DU3    DU3 Погашення депозиту (внутр.)
    8          DU5    DU5 Поповнення депозиту -- необхідно додати тип документа меморіальний ордер для операцій Строковий депозит
    16         DUT    DUT Стягнення недост.суми штрафу з деп.рахунку – 
    */
/*
Для тестування ОБ22 не принципово, але можливо використати наступні відкриті аналітичні рахунки:

I3 - операційні доходи від перерахування процентів за короткостроковими вкладами (депозитами) "Депозитна лінія" у національній валюті (рахунок 2610);
I4 - операційні доходи від перерахування процентів за короткостроковими вкладами (депозитами) "Депозитна лінія" в іноземній валюті (рахунок 2610);
I7 - операційні доходи від перерахування процентів за короткостроковими вкладами (депозитами) "Депозитна лінія" у національній валюті (рахунок 2651);
I8 - операційні доходи від перерахування процентів за короткостроковими вкладами (депозитами) "Депозитна лінія" в іноземній валюті (рахунок 2651);
*/

    -- REPORT constant
    CLOSED_TRANCHE_REPORT           constant varchar2(50) := 'CLOSED_TRANCHE_REPORT';
    CLOSED_DOD_REPORT               constant varchar2(50) := 'CLOSED_DOD_REPORT';

    ACCRUED_INT_TRANCHE_REPORT      constant varchar2(50) := 'ACCRUED_INTEREST_TRANCHE_REPORT';
    ACCRUED_INT_DOD_REPORT          constant varchar2(50) := 'ACCRUED_INTEREST_DOD_REPORT';
    
    PROLONGATION_TRANCHE_REPORT     constant varchar2(50) := 'PROLONGATION_TRANCHE_REPORT';
    
    INTEREST_PAYMENT_REPORT         constant varchar2(50) := 'INTEREST_PAYMENT_REPORT';

    type t_smb_report is record(
        id                           number
       ,account_number               varchar2(20)
       ,lcv                          varchar2(10)
       ,currency_id                  number
       ,start_date                   date
       ,expiry_date                  date
       ,amount_tranche               number
       ,state_name                   varchar2(30)
       ,customer_id                  number
       ,okpo                         varchar2(20)
       ,customer_name                varchar2(100)
       ,branch_id                    varchar2(40)
       ,branch_name                  varchar2(100)
       ,interest_rate_general        number
       ,interest_rate_add_bonus      number
       ,interest_rate_bonus          number
       ,current_interest_rate        number
       ,is_prolongation              number
       ,is_replenishment_tranche     number
       ,interest_rate_prolongation   number
       ,amount_on_start_date         number
       ,amount_on_end_date           number
       ,difference_amounts           number
       ,account_id                   number
       ,object_type_id               number
       ,state_id                     number
       ,deposit_number               varchar2(50)
       ,mfo_code                     varchar2(6)
       ,dbo_contract_number          varchar2(50)
       ,dbo_contract_date            varchar2(20)
       ,is_short_term                number
       ,deposit_term                 number
    );

    type tt_smb_report is table of t_smb_report;

    type t_smb_auto_report is record(
        id                           number
       ,deposit_number               varchar2(50) 
       ,account_number               varchar2(20)
       ,lcv                          varchar2(10)
       ,customer_name                varchar2(100)
       ,okpo                         varchar2(40)
       ,ref_                         number
       ,document_amount              number
       ,comment_text                 varchar2(4000)
       ,currency_id                  number
       ,branch_id                    varchar2(40)
       ,branch_name                  varchar2(100)
       ,start_date                   date
       ,end_date                     date
    );

    type tt_smb_auto_report is table of t_smb_auto_report;

    type t_smb_report_3a is record(
        kf                     varchar2(40)
       ,ref                    number                -- референс проводки     
       ,document_date          date                  -- дата проводки
       ,currency_name          varchar2(10)          -- валюта
       ,account_id             number                -- номер счета (ACC)
       ,account_number         varchar2(30)          -- номер счета (NLS)
       ,deposit_id             number                -- ID транша
       ,amount_document        number                -- сумма привлечения (в номинале)
       ,interest_rate          number                --  % ставка
       ,s180                   varchar2(10)          -- срок (по справочнику S180)
       ,sos                    number                -- SOS
       ,tt                     varchar2(20)          -- TT (тип операции)
       ,currency_id            number
       -- додати у вибірку параметр R011 з таблиці SPECPARAM, дату початку та закінчення дії депозиту (траншу) та РНК контрагенту.   
       ,start_date             date
       ,expiry_date            date
       ,customer_id            number 
       ,r011                   varchar2(10)
       );

    type tt_smb_report_3a is table of t_smb_report_3a;

    type t_smb_report_a7 is record(
        report_date           date            -- Дата на которую формируются остатки
       ,expiry_date           date            -- дата погашения транша
       ,deposit_id            number          -- ID транша
       ,customer_id           number          -- RNK 
       ,account_id            number          -- ACC
       ,account_number        varchar2(40)    -- nls
       ,deposit_amount        number          -- сумма транша на дату (номинал)
       ,currency_name         varchar2(20)    -- валюта транша
       ,deposit_number        varchar2(100)   -- ND номер депозитного договора
       ,s240                  varchar2(10)    -- s240 
       ,currency_id           number          
       );

    type tt_smb_report_a7 is table of t_smb_report_a7;

    type t_smb_report_e8 is record(
        account_id             number         -- ACC основного счета (БС=2610, 2651)
       ,account_number         varchar2(40)   -- nls
       ,currency_id            number         -- код валюты
       ,currency_name          varchar2(50)   -- валюта наименование
       ,contract_number        varchar2(100)  -- номер договора ДБО
       ,start_date             date           -- дата начала договора ДБО
       ,end_date               date           -- дата окончания договора (если нет определенной даты - не заполняем)
       ,deposit_amount         number          -- остаток по основному счету (2610, 2651) за указанную дату
       ,interest_rate          number         -- средневзвешенная % ставка (если по договору есть несколько траншей с разными % ставками, то расчитываем средневзвешенную % ставку с учетом суммы остатка по каждому траншу) = sum(Si*Ni)/sum(Si), где Si - сумма i-ого транша, Ni - % ставка i-ого транша на указанную дату
       ,customer_id            number
       ,report_date            date           -- Дата на которую формируются остатки
       );

    type tt_smb_report_e8 is table of t_smb_report_e8;


    с_accrual_interest_oper_type  constant varchar2(3) := 'DU%'; -- Нарахування відсотків
    с_payment_deposit_oper_type   constant varchar2(3) := 'DU3'; -- Погашення депозиту (внутр.)
    с_payment_interest_oper_type  constant varchar2(3) := 'DU1'; -- Виплата відсотків (внутр.)
    с_penalty_oper_type           constant varchar2(3) := 'DU$'; -- Списання зайвонарахованих відсотків
    с_income_tax_oper_type        constant varchar2(3) := '%15'; -- податок на прибуток з ФО
    c_military_tax_oper_type      constant varchar2(3) := 'MIL'; -- військовий збір з ФО

    -- вернуть только сумму рассчитанных %
    function get_calc_interest_only_sum(
                 p_id            in number
                ,p_start_date    in date 
                ,p_end_date      in date
                ,p_mode          in number default 1)
         return number;

    -- получить расчет % 
    -- p_deposit_list - список депозитов (object.id) или null/empty тогда по всем
    -- p_end_date         - дата на которую производится расчет
    --- ***
    -- p_mode   (может біть использовано для перерасчета)      
    --     1 - с учетом предыдущих параметров расчета (если были)  
    --         + дату последнего начисления (last_accrual_date или acr_dat) 
    --         + параметры p_end_date + p_deposit_list
    --     2 - учитывается передаваемые даты (параметры предыдущих расчетов на учитываются)
    --         p_start_date и p_end_date + p_deposit_list
    function get_calculate_interest(
                 p_deposit_list  in number_list
                ,p_start_date    in date 
                ,p_end_date      in date
                ,p_mode          in number default 1)
      return tt_deposit_calculator;

    -- попытка объединить в одном месте перевод денег со счета на счет
    function money_transfer(
            p_sender_row          in accounts%rowtype
           ,p_recipient_row       in accounts%rowtype
           ,p_sender_amount       in number
           ,p_recipient_amount    in number
           ,p_operation_type      in varchar2
           ,p_purpose             in varchar2
           ,p_date                in date default gl.bdate
           ,p_ref                 in number default null
                          )
     return number;

    -- заполнение доп. параметров
    -- в данном случае ND - идентификатор депозита (object -> id)
    -- для каких операций его заполнять (???)
    procedure fill_operw (
              p_ref  in  number
             ,p_tag  in  varchar2
             ,p_val  in  varchar2);

    -- счета для налогов
    function get_tax_account (
                            p_tax_type in   number      -- Тип податку: 1 - податок на прибуток з ФО, 2 - військовий збір з ФО
                           ,p_nls_type in   number      -- Тип рахунка: 0 - для повернення податку, 1 - для сплати податку
                           ,p_branch   in   varchar2 )  -- Код філії рахунка
         return number;

    -- начисление % на дату
    -- p_deposit_list - договора. если указаны, то расчет только по ним
    procedure auto_accrual_interest(
                                 p_date         in date
                                ,p_deposit_list in number_list);

    -- ручное досрочное закрытие депозита ()
    procedure manual_deposit_closing(p_id  in number);

    -- закрытие счетов депозитного / начисленных %
    procedure auto_account_deposit_closing(p_date in date);

    -- закрытие депозита по сроку действия, только транши (???)
    procedure auto_deposit_closing(p_date in date);

    -- пролонгация депозита
    procedure auto_deposit_prolongation(p_date in date);

    -- капитализация / стандартная выплата начисленных %, капитализация - только для траншей
    procedure auto_payment_accrued_interest(p_date in date);

    -- попытка перевести деньги со счета для списания на депозитный счет
    -- т.е. если денег не  достаточно на счету для списания, когда БО подтверждал депозит
    -- выполняется по закрытию банковского дня 
    procedure transfer_funds_failed_deposit;

    --  блокировка депозитного транша
    --  p_lock_type_id тип блокировки :
    --    1  -  блокировка в связи с арестом по решению суда/исполнительной службы – не требует использования транзитного счета
    --    2  -         --  блокировка в связи с обеспечением депозита по кредиту – требует использования транзитного счета 
    --                    (предварительно 3739 – который используется при продукте - залог имущественных прав)
    procedure blocking_deposit (
                               p_id         in number 
                              ,p_process_id in number);

    --  разблокировка депозитного транша
    procedure unblocking_deposit (p_id         in number
                                 ,p_process_id in number);

    -- отчет по депозитам Додаток-1                             
    function get_deposit_info(
                              p_start_date   in date
                             ,p_end_date     in date
                             ,p_term_deposit in number default 0
                             ,p_mfo_code     in varchar2 default null
                             ,p_type_deposit in number default 0)
          return tt_smb_report pipelined;

    function get_auto_report(
                              p_report_type  in varchar2
                             ,p_start_date   in date
                             ,p_end_date     in date)
          return tt_smb_auto_report pipelined; 

    -- дані по ММСБ для формування файлу 3А
    function get_report_3a(p_date in date)
          return tt_smb_report_3a pipelined;

    -- витрина для файла А7 по депозитам ММСБ
    function get_report_a7(p_date in date)
          return tt_smb_report_a7 pipelined;

    -- витрина для файла E8 по депозитам (транши) ММСБ
    function get_report_e8(p_date in date)
          return tt_smb_report_e8 pipelined;


    -- возвращает % ставку для DWH 
    function get_interest_rate(p_id   in number
                              ,p_date in date)
          return number;

end;
/
create or replace package body smb_calculation_deposit
as

    g_main_account_type_id          number(38);
    g_int_account_type_id           number;
    g_reg_trn_int_amount_type_id    number;
    g_reg_dod_int_amount_type_id    number;
    g_reg_trn_principal_type_id     number;
    g_reg_blocked_amount_type_id    number;
    g_reg_dod_principal_type_id     number;
    g_reg_trn_paid_int_type_id      number;
    g_reg_dod_paid_int_type_id      number;
    g_reg_trn_income_tax_type_id    number;
    g_reg_trn_military_tax_type_id  number;
    g_process_tranche               number(38);
    g_process_on_demand             number(38);
    g_process_replenishment         number;
    g_process_prolongation          number;
    g_process_processing_blocked    number;
    g_tranche_object_type_id        number(38);
    g_dod_object_type_id            number(38);
    g_trn_attr_interest_rate_id     number;
    g_trn_attribute_penalty_id      number;
    g_dod_attr_interest_rate_id     number;
    g_dod_accrual_method_id         number;

    g_object_active_state_id        number(38);
    g_object_created_state_id       number(38);
    g_object_blocked_state_id       number(38);
    g_object_closed_state_id        number(38);
    g_object_deleted_state_id       number(38);

    -- использовать накопление остатка (разница реально расчитанная - округленная)
    C_USE_TAIL   constant           number := 0;

    -- вернуть только сумму рассчитанных % по 1-ому депозиту
    function get_calc_interest_only_sum(
                 p_id            in number
                ,p_start_date    in date 
                ,p_end_date      in date
                ,p_mode          in number default 1)
         return number
     is
        l_result number;
    begin
        select nvl(sum(x.interest_amount), 0)
          into l_result     
          from table(get_calculate_interest(
                           p_deposit_list  => number_list(p_id)
                          ,p_start_date    => p_start_date
                          ,p_end_date      => p_end_date
                          ,p_mode          => p_mode)) x;
        return l_result;                  
    end;        
              
    -- получить расчет % 
    -- p_deposit_list - список депозитов (object.id) или null/empty тогда по всем
    -- p_start_date   - дата с учитывается только при p_mode = 2, 3
    -- p_end_date     - дата на которую производится расчет
    --- ***
    -- p_mode   (может біть использовано для перерасчета)      
    --     1 - с учетом предыдущих параметров расчета (если были)  
    --         + дату последнего начисления (last_accrual_date или acr_dat) 
    --         + параметры p_end_date + p_deposit_list
    --         - без учета p_start_date 
    --     2 - учитывается передаваемые даты (параметры предыдущих расчетов не учитываются)
    --         p_start_date и p_end_date + p_deposit_list
    --     3 - аналогично значению 2, но учитывается тоько штрафная ставка
    function get_calculate_interest(
                 p_deposit_list  in number_list
                ,p_start_date    in date 
                ,p_end_date      in date
                ,p_mode          in number default 1)
      return tt_deposit_calculator
     is
        cursor c_get_deposit_data (
                                 p_tranche_type_id           number       -- тип объекта для траншей
                                ,p_dod_type_id               number       -- тип объекта для ДпТ
                                ,p_deposit_list              number_list  -- список дапозитов (object_id) - может бать empty / null
                                ,p_start_date                date         -- дата начала (учитывается при p_mode = 2)
                                ,p_end_date                  date         -- дата по которую идет расчет
                                ,p_register_type_amount_id   number       -- тип регистра для траншей (сумма депозита)
                                ,p_trn_attr_interest_rate_id number       -- тип атрибута для % ставки по траншам
                                ,p_dod_attr_interest_rate_id number       -- тип атрибута для % ставки по ДпТ, если установлена индивидуальная ставка
                                ,p_primary_account_type_id   number       -- тип депозитного счета
                                ,p_dod_accrual_method_id     number       -- тип модель расчета для ДпТ
                                ,p_on_demand_kind_type_id    number       -- тип вида для % ставок по ДпТ
                                ,p_mode                      number       -- тип расчета
                                ) 
          is
                   with tObj$ as( 
                        select --+ 000999000
                               *
                          from(
                               select 
                                     o.id
                                    ,t.currency_id 
                                    ,d.start_date
                                    ,nvl(t.expiry_date_prolongation, d.expiry_date) expiry_date
                                    ,t.tail_amount  
                                    ,da.account_id
                                    ,o.object_type_id
                                    ,case when p_mode = 1 
                                                   -- если реальное начисление - берем дату последнего начисления + 1 или дату начала (если это 1-ый расчет )
                                              then nvl(t.last_accrual_date + 
                                                       case when d.expiry_date is null then 1 
                                                            -- дату окончания не включаем
                                                            when t.last_accrual_date + 1 = nvl(t.expiry_date_prolongation, d.expiry_date) then 2 
                                                            else 1 end
                                                       ,d.start_date + 1)
                                                   -- для остальных случаев берем большее 
                                              else greatest(nvl(p_start_date, d.start_date + 1), d.start_date + 1)
                                     end start_date_ 
                                    ,least(coalesce(d.close_date
                                                    -- если транш заблокирован и срок действия закончился, то начисления продолжаем делать согласно ТЗ
                                                    -- что делать если только установлен лимит (???) 
                                                   ,case when o.state_id = g_object_blocked_state_id or a.blkd > 0 then p_end_date end
                                                   -- транш еще не закрыт (срок закрытия прошел), но были проблемы со счетом (блокировка, мин. остаток ...)
                                                   ,case when d.close_date is null and
                                                              o.state_id = g_object_active_state_id and
                                                              nvl(t.expiry_date_prolongation, d.expiry_date) <= p_end_date and
                                                              (select count(*)
                                                                 from process p
                                                                where p.object_id = o.id
                                                                  and p.process_type_id = g_process_processing_blocked) > 0
                                                         then p_end_date
                                                    end 
                                                   -- дату окончания не включаем
                                                   ,t.expiry_date_prolongation - case when t.is_prolongation = 0 then 0
                                                                                      -- последняя пролонгация прошла - закрытие
                                                                                      when t.number_prolongation = t.current_prolongation_number then 1
                                                                                      else 0
                                                                                 end 
                                                   , d.expiry_date - 1, p_end_date), p_end_date) end_date_
                                    ,t.is_capitalization
                                    ,t.is_individual_rate
                                    ,d.customer_id
                                    ,t.is_prolongation
                                    ,d.expiry_date expiry_date_deposit
                                from object o
                                    ,deal d
                                    ,smb_deposit t
                                    ,deal_account da
                                    ,int_accn ic
                                    ,accounts a
                               where 1 = 1
                                 and o.object_type_id in (p_tranche_type_id, p_dod_type_id) 
                                 and (o.state_id in (g_object_active_state_id, g_object_blocked_state_id)
                                      -- добавил OR
                                      -- ХАК смотри описание в deposit_closing
                                      or (o.state_id  = g_object_closed_state_id) )
                                 and o.id = d.id 
                                 and o.id = t.id
                                 and o.id = da.deal_id 
                                 and da.account_type_id = p_primary_account_type_id
                                 and da.account_id = ic.acc
                                 and ic.id = interest_utl.INTEREST_KIND_LIABILITIES
                                 and da.account_id = a.acc
                                 and (d.close_date is null -- убирать ли это ограничени (что делать при перерасчете закрытого ??)
                                    or p_mode = 2)
                                 and (p_deposit_list is null  
                                   or p_deposit_list is empty
                                   or o.id in
                                       (
                                    select x.column_value
                                      from table(p_deposit_list) x
                                        )))
                         where end_date_ >= start_date_
                         )
                 , tObj as(
                         select o.*
                           from tObj$ o
                          where o.is_prolongation = 0
                         union all 
                         -- тело депозита без пролонгации
                         select o.id
                               ,o.currency_id 
                               ,o.start_date
                               ,o.expiry_date
                               ,o.tail_amount  
                               ,o.account_id
                               ,o.object_type_id
                               ,o.start_date_ start_date_ 
                               ,least(o.end_date_, o.expiry_date_deposit - 1) end_date_
                               ,o.is_capitalization
                               ,o.is_individual_rate
                               ,o.customer_id
                               ,o.is_prolongation
                               ,o.expiry_date_deposit
                           from tObj$ o
                          where o.is_prolongation = 1
                            and o.start_date_ < o.expiry_date_deposit
                         union all 
                         -- тело депозитав, при заблокированом счете/транше
                         select o.id
                               ,o.currency_id 
                               ,o.start_date
                               ,o.expiry_date
                               ,o.tail_amount  
                               ,o.account_id
                               ,o.object_type_id
                               ,o.expiry_date + 1 start_date_
                               ,o.end_date_
                               ,o.is_capitalization
                               ,o.is_individual_rate
                               ,o.customer_id
                               ,o.is_prolongation
                               ,o.expiry_date_deposit
                           from tObj$ o
                          where o.is_prolongation = 1
                            and o.end_date_ > o.expiry_date
                         union all   
                         -- пролонгации депозита
                         select o.id
                               ,o.currency_id 
                               ,o.start_date
                               ,o.expiry_date
                               ,o.tail_amount  
                               ,o.account_id
                               ,o.object_type_id
                               ,greatest(x.start_date + 1, o.start_date_) start_date_ 
                               ,least(x.expiry_date - 1, o.end_date_) end_date_
                               ,o.is_capitalization
                               ,o.is_individual_rate
                               ,o.customer_id
                               ,o.is_prolongation
                               ,o.expiry_date_deposit
                           from tObj$ o
                               ,table(smb_deposit_utl.get_prolongation(p_deposit_id => o.id)) x
                          where o.is_prolongation = 1
                            and x.start_date < o.end_date_
                            and x.expiry_date > o.start_date_)
                 -- % ставки       
                 , ir_ as(
                      -- выбираем процентные ставки
                      --   для ДпТ берем только индивидуальную % ставку, иначе % ставку берем от суммы на счете
                      --   для траншей берем из атрибутов
                      select o.*
                            ,greatest(a.value_date, o.start_date_) value_date
                            ,a.number_value interest_rate
                        from tOBJ o
                            ,attribute_value_by_date a    
                       where a.attribute_id in (p_trn_attr_interest_rate_id, p_dod_attr_interest_rate_id)
                         and a.object_id = o.id
                         and nvl(p_mode, 0) <> 3
                         and a.value_date between 
                             (select nvl(max(au.value_date), o.start_date_)
                                from attribute_value_by_date au
                               where au.attribute_id = a.attribute_id
                                 and au.object_id = o.id
                                 and au.value_date <= o.start_date_)
                             and o.end_date_
                      union all  -- !!!!
                      -- штраф
                      select o.*
                            ,o.start_date_ value_date
                            ,a.number_value interest_rate
                        from tOBJ o
                            ,attribute_value_by_date a    
                       where a.attribute_id = g_trn_attribute_penalty_id
                         and a.object_id = o.id
                         and p_mode = 3
                           )
                  -- метод начисления для ДпТ       
                 ,mtd_ as(
                      select o.*
                            ,greatest(a.value_date, o.start_date_) value_date
                            ,a.number_value accrual_method
                        from tOBJ o
                            ,attribute_value_by_date a    
                       where a.attribute_id = p_dod_accrual_method_id
                         and a.object_id = o.id
                         and o.object_type_id = p_dod_type_id
                         and a.value_date between 
                             (select nvl(max(au.value_date), o.start_date_)
                                from attribute_value_by_date au
                               where au.attribute_id = a.attribute_id
                                 and au.object_id = o.id
                                 and au.value_date <= o.start_date_)
                             and o.end_date_
                    )
                 , r$val as (
                     -- суммы для траншей
                     select -- сумма учитывается только на следующий день, т.е день поступления денег не учитываем (???)
                            h.value_date + 1 value_date
                           ,sum(sum(case when o.is_capitalization = 1 and v.register_type_id = g_reg_trn_paid_int_type_id then -1 else 1 end * h.amount)) 
                                    over (partition by v.object_id, o.end_date_ order by h.value_date) amount
                           ,v.object_id
                       from tObj o
                           ,register_value v
                           ,register_history h
                      where o.object_type_id = p_tranche_type_id
                        and o.id = v.object_id
                        and (--  основная сумма
                             v.register_type_id = p_register_type_amount_id 
                            or (
                              -- при p_mode in (2, 3) убираем суммы выплаченных %% по капитализации (???)
                              v.register_type_id = g_reg_trn_paid_int_type_id
                              and o.is_capitalization = 1
                              and p_mode in (2, 3)
                               ))
                        and h.register_value_id = v.id
                        and h.is_active = 'Y'
                        and h.is_planned = 'N' -- берем только не плановые суммы и активные
                     group by h.value_date
                             ,v.object_id
                             ,o.end_date_)           
                 , bln as(
                     -- берем суммы по траншу
                     select o.*
                           ,h.value_date value_date
                           ,h.amount
                       from tOBJ o
                           ,r$val h 
                      where h.object_id = o.id
                        and o.object_type_id = p_tranche_type_id
                        and h.value_date between
                            (select nvl(max(v.value_date), o.start_date_)
                               from r$val v
                              where v.object_id = o.id      
                                and v.value_date  <= o.start_date_)
                        and o.end_date_        
                     union all
                     -- суммы по ДпТ берем из saldoa ()
                     select o.*
                            -- сумма учитывается только на следующий день, т.е день поступления денег не учитываем (???)
                           ,greatest(s.fdat, o.start_date_) value_date
                           -- отрицательную сумму в 0
                           ,greatest(s.ostf - s.dos + s.kos, 0) amount  
                       from tOBJ o
                           ,saldoa s
                      where o.object_type_id = p_dod_type_id
                        and o.account_id = s.acc
                        and s.fdat between
                             (select nvl(max(b.fdat), o.start_date_)
                                from saldoa b
                               where b.acc = s.acc
                                 and b.fdat <= o.start_date_)
                        and o.end_date_
                               )
                 , preproc_ as(
                        select account_id, id object_id, start_date_, end_date_, currency_id, tail_amount, object_type_id, is_capitalization, customer_id 
                              ,greatest(value_date, start_date_) calc_start_date
                              ,least(lead(greatest(value_date, start_date_) - 1, 1, end_date_) 
                                          over (partition by id order by greatest(value_date, start_date_)), end_date_) calc_end_date
                              -- подтягиваем данные где null
                              ,first_value(max(h.amount) ignore nulls)         
                                          over (partition by id  order by greatest(value_date, start_date_) desc 
                                                rows between current row and unbounded following) amount_deposit 
                              ,first_value(max(h.interest_rate) ignore nulls)  
                                          over (partition by id  order by greatest(value_date, start_date_) desc
                                                rows between current row and unbounded following) interest_rate
                              ,first_value(max(h.accrual_method) ignore nulls) 
                                          over (partition by id  order by greatest(value_date, start_date_) desc 
                                                rows between current row and unbounded following) accrual_method
                               --  с помощью этих 2-х полей будем разруливать начисление по среднему                 
                               -- дата начала действия метода начисления (данная дата есть группой для метода начисления)
                              ,first_value(case when max(h.accrual_method) is not null then greatest(value_date, start_date_) end ignore nulls) 
                                                    over (partition by id  order by greatest(value_date, start_date_) desc 
                                                          rows between current row and unbounded following) accrual_method_group
                               -- дата начала действия % ставки (данная дата есть группой для % ставки)
                              ,first_value(case when max(h.interest_rate) is not null then greatest(value_date, start_date_) end ignore nulls) 
                                                    over (partition by id  order by greatest(value_date, start_date_) desc 
                                                          rows between current row and unbounded following) interest_rate_group
                              ,start_date                            
                          from( -- баланс по счету              
                                select account_id, id, start_date_, end_date_, amount, null interest_rate, null accrual_method
                                      ,currency_id, tail_amount, value_date, object_type_id, is_capitalization, customer_id, start_date
                                  from bln    
                                union all
                                -- % ставки
                                select account_id, id, start_date_, end_date_, null amount, interest_rate, null accrual_method
                                      ,currency_id, tail_amount, value_date, object_type_id, is_capitalization, customer_id, start_date
                                  from ir_
                                union all  
                                -- методы начислений
                                select account_id, id, start_date_, end_date_, null amount, null interest_rate, accrual_method
                                      ,currency_id, tail_amount, value_date, object_type_id, is_capitalization, customer_id, start_date 
                                  from mtd_
                                -- переход года  
                                   -- убрал в int_reckonings оплата проходит одной суммой
                               /* union all   
                                select account_id, id, start_date_, end_date_, null amount, null interest_rate, null accrual_method
                                      ,currency_id, tail_amount, trunc(end_date_, 'year') value_date, object_type_id, is_capitalization, customer_id
                                  from tOBJ o
                                 where extract(year from start_date_) <> extract(year from end_date_) */
                                  ) h
                        group by account_id, id, start_date_, end_date_, currency_id, tail_amount, object_type_id
                                ,greatest(value_date, start_date_), is_capitalization, customer_id, start_date
                                )
                  -- расчет по среднему для ДпТ, при accrual_method = 2                 
                 , accrual_on_average as(
                    select x.*
                           -- среднее за период = SUM( AMOUNT_DEPOSIT[i] * (CAlC_END_DATE[i] - CAlC_START_DATE[i] + 1) ) / ( END_PERIOD - START_PERIOD + 1 )
                          ,sum(x.amount_deposit * (x.calc_end_date - x.calc_start_date + 1)) 
                                                   over (partition by x.object_id, x.accrual_method_group, x.interest_rate_group) /
                           (max(x.end_date_)   over (partition by x.object_id, x.accrual_method_group, x.interest_rate_group) - 
                            min(x.start_date_) over (partition by x.object_id, x.accrual_method_group, x.interest_rate_group) + 1) accrual_amount
                      from preproc_ x
                     where accrual_method = 2   
                )
            select x.*
                  ,case when x.object_type_id = p_tranche_type_id
                      -- для траншей берем % ставку из атрибутов (выше)  
                      then x.interest_rate
                      else 
                         -- для ДпТ   
                         -- если установлена индивидуальная % ставка берем ее (взяли из атрибутов) 
                         coalesce(x.interest_rate
                           -- берем % ставку справочника с учетом суммы на депозите
                          ,(select min(c.interest_rate) keep (dense_rank first order by c.amount_from desc, o.valid_from desc) 
                              from deal_interest_option o
                                  ,deposit_on_demand_condition c
                             where o.rate_kind_id = p_on_demand_kind_type_id 
                               and o.id = c.interest_option_id
                               and c.currency_id = x.currency_id
                               -- % ставку берем на дату начала действия ДпТ
                               and o.valid_from <= x.start_date -- x.calc_start_date
                               and c.amount_from <= x.accrual_amount / c.denom
                               and o.is_active = 1)) 
                   end interest_rate_calc
              from(    
                    -- начисление обычное
                    --      отрицательные суммы берем как 0 (???)
                    select x.*, greatest(0, amount_deposit) accrual_amount
                      from preproc_ x
                     where nvl(accrual_method, 1) = 1
                    -- начисление по среднему
                    union all                
                    select * 
                      from accrual_on_average
                   ) x
                    ,tabval$global c
               where x.currency_id = c.kv
            -- where x.calc_start_date <= x.calc_end_date
            order by x.object_id, x.calc_start_date;
                  --- 

        l_base_year               number := 365;      -- кол-во дней в году (тупо взял)
        l_tail_amount             number;
        l_current_object_id       number;
        l_calc                    number;
        l_result                  tt_deposit_calculator := tt_deposit_calculator();
        l_capitalization_date     date_list;
        l_accumulated             number := 0;             -- накопленная сумма для капитализации
        l_tax_inc                 number;
        l_tax_mil                 number;
        l_is_tax                  number;
        l_on_demand_kind_type_id  number;
    begin
        select max(id)
           into l_on_demand_kind_type_id
           from deal_interest_rate_kind irk
         where irk.kind_code = 'SMB_ON_DEMAND_GENERAL';

        -- берем налоги, нужны при капитализации (для custtype = 3)
        l_tax_inc := make_interest.get_tax_rate(
                                           p_tax_date   => gl.bdate
                                          ,p_tax_type   => 1 );        -- Тип податку: 1 - податок на прибуток з ФО, 2 - військовий збір з ФО
        l_tax_mil := make_interest.get_tax_rate(
                                           p_tax_date   => gl.bdate
                                          ,p_tax_type   => 2);        -- Тип податку: 1 - податок на прибуток з ФО, 2 - військовий збір з ФО

        l_tail_amount       := 0;   
        l_current_object_id := -1;                                     
        for i in c_get_deposit_data (
                                 p_tranche_type_id           => g_tranche_object_type_id       
                                ,p_dod_type_id               => g_dod_object_type_id
                                ,p_deposit_list              => p_deposit_list
                                ,p_start_date                => trunc(p_start_date)
                                ,p_end_date                  => trunc(p_end_date)
                                ,p_register_type_amount_id   => g_reg_trn_principal_type_id
                                ,p_trn_attr_interest_rate_id => g_trn_attr_interest_rate_id
                                ,p_dod_attr_interest_rate_id => g_dod_attr_interest_rate_id
                                ,p_primary_account_type_id   => g_main_account_type_id
                                ,p_dod_accrual_method_id     => g_dod_accrual_method_id
                                ,p_on_demand_kind_type_id    => l_on_demand_kind_type_id
                                ,p_mode                      => p_mode) 
        loop
            -- init new object
            if l_current_object_id <> i.object_id then
                l_tail_amount         := case when C_USE_TAIL = 0 then 0 else nvl(i.tail_amount, 0) end;
                l_current_object_id   := i.object_id;
                l_capitalization_date := null;
                l_accumulated := 0;
                -- на данный момент капитализация обрабатывается, если были реальные выплаты. так наверное правильно
                -- обработка капитализации, при p_mode in (2, 3)
                if p_mode in (2, 3) and i.is_capitalization = 1 then
                    -- выбираем все даты капитализации по депозиту
                    --   +1 капитализация учитывается на следующий день после выплаты
                    select value_date + 1
                      bulk collect into l_capitalization_date
                      from(
                           select h.value_date
                             from register_value v
                                 ,register_history h
                            where v.object_id = i.object_id
                              and v.register_type_id = g_reg_trn_paid_int_type_id
                              and h.register_value_id = v.id
                              and h.is_active = 'Y'
                              and h.is_planned = 'N' -- берем только не плановые суммы и активные 
                           group by h.value_date);
                    -- учитывать налоги
                    select count(*)
                      into l_is_tax
                      from customer x
                     where x.rnk = i.customer_id
                       and x.custtype = 3;
                end if;
            end if;
            -- капитализация
            if i.calc_start_date member of l_capitalization_date and nvl(l_accumulated, 0) > 0 then
                -- нужно вычесть налоги, если нужно
                if l_is_tax > 0 then
                    l_accumulated := l_accumulated - (l_accumulated * l_tax_inc + l_accumulated * l_tax_mil);
                end if;   
                i.accrual_amount := i.accrual_amount + round(l_accumulated);
                l_accumulated := 0;
            end if; 
            -- расчет
            l_calc        := i.accrual_amount * (i.calc_end_date - i.calc_start_date + 1) / l_base_year * i.interest_rate_calc / 100 + l_tail_amount;
            -- остаток для следующего расчета
            l_tail_amount := case when C_USE_TAIL = 0 then 0 else nvl(l_calc - round(l_calc), 0) end; 
            l_accumulated := l_accumulated + nvl(round(l_calc), 0);
            l_result.extend();
            l_result(l_result.last)  := 
                          t_deposit_calculator(
                                  id                 => l_current_object_id
                                 ,account_id         => i.account_id 
                                 ,start_date         => i.calc_start_date
                                 ,end_date           => i.calc_end_date
                                 ,amount_deposit     => i.amount_deposit
                                 ,amount_for_accrual => i.accrual_amount
                                 ,interest_rate      => i.interest_rate_calc
                                 ,interest_amount    => round(l_calc)
                                 ,interest_tail      => l_tail_amount
                                 ,accrual_method     => i.accrual_method
                                 ,currency_id        => i.currency_id
                                 ,comment_           => null);
        end loop;                        
        return l_result;
    end;   

    -- заполнение доп. параметров
    -- в данном случае ND - идентификатор депозита (object -> id)
    -- для каких операций его заполнять (???)
    procedure fill_operw (
              p_ref  in  number
             ,p_tag  in  varchar2
             ,p_val  in  varchar2)
     is
    begin
        insert into operw (ref, tag, value)
        values (p_ref, p_tag, p_val);
    exception
      when dup_val_on_index then
        update operw set 
         value = p_val
         where ref = p_ref
           and tag = p_tag;
    end;
    
    -- счета для налогов
    function get_tax_account (
                            p_tax_type in   number      -- Тип податку: 1 - податок на прибуток з ФО, 2 - військовий збір з ФО
                           ,p_nls_type in   number      -- Тип рахунка: 0 - для повернення податку, 1 - для сплати податку
                           ,p_branch   in   varchar2 )  -- Код філії рахунка
         return number
     is
        -- константы взято из MAKE_INTEREST 
        -- не использую MAKE_INTEREST из-за глобальных переменнных :
        --   заполнение массивов завит от бранча, из которого был сделан первый вызов
        -- 1 - для сплати податку
        c_nbs_tax_pay    constant varchar2(10) := '3622';
        c_ob22_inc_pay   constant varchar2(10) := '37';
        c_ob22_mil_pay   constant varchar2(10) := '36';
        -- 0 - для повернення податку
        c_nbs_tax_ret    constant varchar2(10) := '3522';
        c_ob22_inc_ret   constant varchar2(10) := '29';
        c_ob22_mil_ret   constant varchar2(10) := '30';
        -- 
        l_nbs            varchar2(4);
        l_ob22           varchar2(2);
        l_baseval        number       := gl.baseval;
        l_result         number;
        l_mfo            varchar2(20) := bc.extract_mfo(p_branch);
    begin 
        l_nbs   := case when p_nls_type = 1 then c_nbs_tax_pay else c_nbs_tax_ret end;
        l_ob22  := case p_nls_type 
                       when 1 then case when p_tax_type = 1 then c_ob22_inc_pay else c_ob22_mil_pay end  
                       when 0 then case when p_tax_type = 1 then c_ob22_inc_ret else c_ob22_mil_ret end     
                   end; 
        with tab as ( 
                 select acc, branch, daos
                   from accounts
                  where nbs  = l_nbs
                    and kv   = l_baseval
                    and ob22 = l_ob22
                    and dazs is null
                    and kf = l_mfo)
             select max(acc) keep (dense_rank first order by daos desc)
               into l_result
               from (                
                   select acc, branch, daos
                     from tab
                   union all
                   select acc, SubStr(branch, 1,15), daos
                     from tab
                    where branch like '/______/______/06____/')
              where branch = p_branch;
        if l_result is null then
            raise_application_error( -20666, 'Не знайдено рахунок для ' ||
                                             case p_nls_type when 0 then 'повернення ' else 'сплати ' end ||
                                             case p_tax_type when 1 then 'податоку на прибуток з ФО' else 'військового збору з ФО' end, TRUE );
        end if;      
        return l_result;
    end;          

    -- налоги установка 
    procedure set_tax(
                   p_amount          in number
                  ,p_tax_account_inc out number  -- счет  - податок на прибуток з ФО
                  ,p_tax_account_mil out number  -- счет  - військовий збір з ФО
                  ,p_tax_amount_inc  out number  -- сумма - податок на прибуток з ФО
                  ,p_tax_amount_mil  out number  -- сумма - військовий збір з ФО
                  ,p_branch          in varchar2
                   )
     is 
         l_tax_inc            number;
         l_tax_mil            number;
     begin
        logger.log_info(p_procedure_name => $$plsql_unit||'.set_tax'
                       ,p_log_message    => 'p_amount : ' || p_amount || chr(10) ||
                                            'p_branch : ' || p_branch
                       ,p_object_id      => null
                                );

         --находим налоги (их 2)
         -- Військовий збір
         -- Оподаткування НДФЛ (Постанова 4110а)
         l_tax_inc := make_interest.get_tax_rate(
                                           p_tax_date   => gl.bdate
                                          ,p_tax_type   => 1 );        -- Тип податку: 1 - податок на прибуток з ФО, 2 - військовий збір з ФО
         l_tax_mil := make_interest.get_tax_rate(
                                           p_tax_date   => gl.bdate
                                          ,p_tax_type   => 2);        -- Тип податку: 1 - податок на прибуток з ФО, 2 - військовий збір з ФО

         p_tax_account_inc := get_tax_account(
                                           p_tax_type   => 1                      -- Тип податку: 1 - податок на прибуток з ФО, 2 - військовий збір з ФО
                                          ,p_nls_type   => 1                      -- Тип рахунка: 0 - для повернення податку, 1 - для сплати податку
                                          ,p_branch     => p_branch ); -- Код філії рахунка

         p_tax_account_mil := get_tax_account(
                                           p_tax_type   => 2                      -- Тип податку: 1 - податок на прибуток з ФО, 2 - військовий збір з ФО
                                          ,p_nls_type   => 1                      -- Тип рахунка: 0 - для повернення податку, 1 - для сплати податку
                                          ,p_branch     => p_branch);  -- Код філії рахунка

         p_tax_amount_inc  := nvl(round(p_amount * l_tax_inc), 0);
         p_tax_amount_mil  := nvl(round(p_amount * l_tax_mil), 0);
    end;

    -- счет для первода штрафа (по банковскому хз)
    function get_penalty_account(
                        p_id          in number -- объект
                       ,p_currency_id in number
                       ,p_branch      in varchar2)
          return number 
     is                   
    begin
            -- счет расходов
        return smb_deposit_utl.get_expense_account(
                                      p_object_id         => p_id
                                     ,p_account_type_code => 'DEPOSIT_PENALTY_EXPENSE_ACCOUNT');
        /*
        return deal_utl.get_deal_account_settings(
                             p_account_type_code => 'DEPOSIT_PENALTY_EXPENSE_ACCOUNT' 
                            ,p_deal_group_id     => attribute_utl.get_number_value(
                                                                     p_object_id      => p_id 
                                                                    ,p_attribute_code => 'DEAL_BALANCE_GROUP'
                                                                    ,p_value_date     => null)    
                            ,p_currency_id       => case when p_currency_id = gl.baseval 
                                                       then p_currency_id
                                                    end  -- если не нац.валюта пердаем null
                            ,p_product_id        => null
                            ,p_branch_code       => p_branch);*/
    end; 

    -- запись истории начислений в int_reckonings
    procedure set_history (
                      p_calc              tt_deposit_calculator
                     ,p_interest_kind_id  number default interest_utl.RECKONING_TYPE_ORDINARY_INT
                     ,p_ref               number
                          )
     is
        l_group_id        number;                  
        l_int             number;                
    begin
        -- почистим предыдущие расчеты
        for i in (select id, account_id, min(start_date) start_date
                    from table (p_calc) 
                   group by id, account_id) loop
            delete from int_reckonings t
             where t.account_id = i.account_id 
               and t.deal_id = i.id
               and t.interest_kind_id = p_interest_kind_id
               and t.date_through >= i.start_date;
        end loop;            
        for i in (select x.*
                        ,min(x.start_date)          over (partition by x.id) start_date_group
                        ,max(x.end_date)            over (partition by x.id) end_date_group
                        ,sum(x.interest_amount)     over (partition by x.id) interest_amount_group
                        ,max(x.amount_for_accrual)  keep (dense_rank first order by x.end_date desc) 
                                                    over (partition by x.id) amount_for_accrual_group
                        ,max(x.interest_rate)       keep (dense_rank first order by x.end_date desc) 
                                                    over (partition by x.id) interest_rate_group
                        ,max(x.interest_tail)       keep (dense_rank first order by x.end_date desc) 
                                                    over (partition by x.id) interest_tail_group
                    from table(p_calc) x
                   order by x.id, x.start_date ) loop
            if l_group_id is null then       
                l_group_id := interest_utl.create_interest_reckoning(
                             p_reckoning_type_id => interest_utl.RECKONING_TYPE_ORDINARY_INT
                            ,p_account_id        => i.account_id
                            ,p_interest_kind_id  => p_interest_kind_id
                            ,p_date_from         => i.start_date_group
                            ,p_date_through      => i.end_date_group
                            ,p_account_rest      => i.amount_for_accrual_group
                            ,p_interest_rate     => i.interest_rate_group
                            ,p_interest_amount   => i.interest_amount_group
                            ,p_interest_tail     => i.interest_tail_group
                            ,p_is_grouping_unit  => 'Y'
                            ,p_state_id          => case when p_ref is not null then interest_utl.RECKONING_STATE_ACCRUED end
                            ,p_deal_id           => i.id);
                if p_ref is not null then
                    update int_reckonings r
                       set r.accrual_document_id = p_ref
                     where r.id = l_group_id;        
                end if;            
            end if;              
            l_int := interest_utl.create_interest_reckoning(
                             p_reckoning_type_id => interest_utl.RECKONING_TYPE_ORDINARY_INT
                            ,p_account_id        => i.account_id
                            ,p_interest_kind_id  => p_interest_kind_id
                            ,p_date_from         => i.start_date
                            ,p_date_through      => i.end_date
                            ,p_account_rest      => i.amount_for_accrual
                            ,p_interest_rate     => i.interest_rate
                            ,p_interest_amount   => i.interest_amount
                            ,p_interest_tail     => i.interest_tail
                            ,p_is_grouping_unit  => null
                            ,p_state_id          => null
                            ,p_deal_id           => i.id);
            if l_group_id is not null then
                update int_reckonings r
                   set r.grouping_line_id = l_group_id
                      ,r.state_id         = case when p_ref is not null then interest_utl.RECKONING_STATE_GROUPED else r.state_id end 
                 where r.id = l_int;        
            end if;            
        end loop;          
    end;

    -- попытка объединить в одном месте перевод денег со счета на счет
    function money_transfer(
            p_sender_row          in accounts%rowtype
           ,p_recipient_row       in accounts%rowtype
           ,p_sender_amount       in number
           ,p_recipient_amount    in number
           ,p_operation_type      in varchar2
           ,p_purpose             in varchar2
           ,p_date                in date default gl.bdate
           ,p_ref                 in number default null
                          )
     return number 
     as
        l_document_id     number;
        l_dk              number := 1;        
        l_date            date := nvl(p_date, gl.bdate);
    begin
        if p_ref is null then
            gl.ref (l_document_id);
            
            gl.in_doc3(ref_   => l_document_id
                      ,tt_    => p_operation_type 
                      ,vob_   => 6  -- могут быть другие значения (???)
                      ,nd_    => substr(to_char(l_document_id), 1, 10)
                      ,pdat_  => sysdate
                      ,vdat_  => l_date
                      ,dk_    => l_dk
                      ,kv_    => p_sender_row.kv
                      ,s_     => p_sender_amount
                      ,kv2_   => p_recipient_row.kv
                      ,s2_    => p_recipient_amount
                      ,sk_    => null
                      ,data_  => l_date
                      ,datp_  => l_date
                      ,nam_a_ => substr(p_sender_row.nms, 1, 38)
                      ,nlsa_  => p_sender_row.nls
                      ,mfoa_  => gl.amfo
                      ,nam_b_ => substr(p_recipient_row.nms, 1, 38)
                      ,nlsb_  => p_recipient_row.nls
                      ,mfob_  => p_recipient_row.kf
                      ,nazn_  => p_purpose
                      ,d_rec_ => null
                      ,id_a_  => customer_utl.get_customer_okpo(p_sender_row.rnk)
                      ,id_b_  => customer_utl.get_customer_okpo(p_recipient_row.rnk)
                      ,id_o_  => null
                      ,sign_  => null
                      ,sos_   => 1
                      ,prty_  => null
                      ,uid_   => null);      
        else        
            l_document_id := p_ref;       
        end if;
         -- зарахування коштів на деп рахунок строкового траншу 
         -- подтверждение
         --  вместо paytt
        gl.payv(flg_  => 0                   -- Plan/Fact flg
               ,ref_  => l_document_id       -- Reference
               ,dat_  => l_date               -- Value Date
               ,tt_   => p_operation_type    -- Transaction code
               ,dk_   => l_dk                -- Debit/Credit
               ,kv1_  => p_sender_row.kv     -- Currency code 1
               ,nls1_ => p_sender_row.nls    -- Account number 1
               ,sum1_ => p_sender_amount     -- Amount 1
               ,kv2_  => p_recipient_row.kv  -- Currency code 2
               ,nls2_ => p_recipient_row.nls -- Account number 2
               ,sum2_ => p_recipient_amount  -- Amount 2
              );
           -- автоматом   
        gl.pay(p_flag => 2, p_ref => l_document_id, p_vdat => l_date);
        
        return l_document_id;
    end;  

    function money_transfer(
                            p_sender_account_id    in number
                           ,p_recipient_account_id in number 
                           ,p_amount               in number
                           ,p_operation_type       in varchar2
                           ,p_purpose              in varchar2
                           ,p_date                 in date default gl.bdate
                           ,p_is_sender_amount     in number-- default 1
                           ,p_ref                  in number default null)
          return number                  
     is
        l_sender_row       accounts%rowtype;  
        l_recipient_row    accounts%rowtype;
        l_sender_amount    number := p_amount;
        l_recipient_amount number := p_amount; 
    begin 
        if nvl(p_amount, 0) = 0 then
            return null;
        end if;
        l_sender_row    := account_utl.read_account(p_account_id => p_sender_account_id);
        l_recipient_row := account_utl.read_account(p_account_id => p_recipient_account_id); 
        -- если валюта счетов разная
        if l_recipient_row.kv <> l_sender_row.kv then
            case -- прямой порядок оплаты,
                 -- сумма принадлежит отправителю, т.е. сумма оплаты идет от отправителя 
                 -- -- переводим сумму из валюты отправителя в валюту получателя 
                when p_is_sender_amount = 1 then
                  l_recipient_amount := currency_utl.convert_amount(
                                                      p_amount           => p_amount 
                                                     ,p_from_currency_id => l_sender_row.kv
                                                     ,p_to_currency_id   => l_recipient_row.kv
                                                     ,p_bank_date        => p_date);
                 -- если p_is_sender_amount = 0 то сумма принадлежит получателю
                 -- переводим сумму из валюты получателя в валюту отправителя
                when p_is_sender_amount = 0 then
                  l_sender_amount := currency_utl.convert_amount(
                                                p_amount           => p_amount 
                                               ,p_from_currency_id => l_recipient_row.kv
                                               ,p_to_currency_id   => l_sender_row.kv
                                               ,p_bank_date        => gl.bdate);
                else 
                 return null; 
            end case; 
        end if;                                       
        
        return money_transfer(
                        p_sender_row       => l_sender_row
                       ,p_recipient_row    => l_recipient_row
                       ,p_sender_amount    => l_sender_amount
                       ,p_recipient_amount => l_recipient_amount
                       ,p_operation_type   => p_operation_type
                       ,p_purpose          => p_purpose 
                       ,p_date             => p_date
                       ,p_ref              => p_ref);
    end;                             

    -- выплата налогов с начисленных % для ФОП
    -- возвращает сумму налога
    function payout_tax (p_int_accn_row    in int_accn%rowtype
                        ,p_interest_amount in number
                        ,p_date            in date
                        ,p_deal_id         in number
                        ,p_ref             in number) 
         return number
     is
        l_tax_account_mil   number;
        l_tax_account_inc   number;
        l_tax_amount_inc    number;
        l_tax_amount_mil    number;
        l_accounts_row      accounts%rowtype;
        l_purpose           varchar2(500);
        l_register_value    number;

            procedure tax(p_tax_amount         in number
                         ,p_tax_account        in number                      
                         ,p_tax_oper_type      in varchar2
                         ,p_register_type_code in varchar2
                         ,p_purpose            in varchar2)
             is
            begin
                -- налог пишем в документ начисленных %%
                if p_tax_amount > 0 then
                   -- счет начисленных % может отличаться от счета податок на прибуток (он вроде всегда в UAH)
                   tools.hide_hint(
                       money_transfer(
                                    p_sender_account_id    => p_int_accn_row.acra
                                   ,p_recipient_account_id => p_tax_account
                                   ,p_amount               => p_tax_amount
                                   ,p_operation_type       => p_tax_oper_type
                                   ,p_purpose              => p_purpose
                                   ,p_date                 => p_date
                                   ,p_is_sender_amount     => 1 -- сумма отправителя
                                   ,p_ref                  => p_ref)); 

                    l_register_value := null;                       
                    -- списываем сумму с регистра по начисленным %
                    tools.hide_hint(
                        register_utl.cor_register_value_common_type(
                                       p_register_value_id         => l_register_value
                                      ,p_object_id                 => p_deal_id
                                      ,p_register_common_type_code => register_utl.COMMON_INTEREST_AMOUNT_CODE
                                      ,p_plan_value                => -1 * p_tax_amount
                                      ,p_value                     => -1 * p_tax_amount
                                      ,p_date                      => p_date
                                      ,p_currency_id               => l_accounts_row.kv
                                      ,p_is_planned                => 'N'
                                      ,p_document_id               => p_ref));
                    l_register_value := null;
                    -- запишем сумму налога в регистр
                    tools.hide_hint(
                        register_utl.cor_register_value_common_type(
                                       p_register_value_id         => l_register_value
                                      ,p_object_id                 => p_deal_id
                                      ,p_register_common_type_code => p_register_type_code
                                      ,p_plan_value                => p_tax_amount
                                      ,p_value                     => p_tax_amount
                                      ,p_date                      => p_date
                                      ,p_currency_id               => l_accounts_row.kv
                                      ,p_is_planned                => 'N'
                                      ,p_document_id               => p_ref));
                end if;
            end; 
    begin
        --находим налоги (их 2)
        -- Військовий збір
        -- Оподаткування НДФЛ (Постанова 4110а)
        l_accounts_row := account_utl.read_account(p_account_id => p_int_accn_row.acc);
        set_tax(
               p_amount          => p_interest_amount
              ,p_tax_account_inc => l_tax_account_inc     -- счет  - податок на прибуток з ФО
              ,p_tax_account_mil => l_tax_account_mil     -- счет  - військовий збір з ФО
              ,p_tax_amount_inc  => l_tax_amount_inc      -- сумма - податок на прибуток з ФО
              ,p_tax_amount_mil  => l_tax_amount_mil      -- сумма - військовий збір з ФО
              ,p_branch          => l_accounts_row.branch );
        -- податок на прибуток з ФО
        tax(          
                      p_tax_amount         => l_tax_amount_inc
                     ,p_tax_account        => l_tax_account_inc                      
                     ,p_tax_oper_type      => с_income_tax_oper_type -- податок на прибуток з ФО 
                     ,p_register_type_code => register_utl.COMMON_INCOME_TAX_CODE
                     ,p_purpose            => l_purpose);
        -- військовий збір з ФО
        tax(          
                      p_tax_amount         => l_tax_amount_mil
                     ,p_tax_account        => l_tax_account_mil                      
                     ,p_tax_oper_type      => c_military_tax_oper_type -- військовий збір з ФО 
                     ,p_register_type_code => register_utl.COMMON_MILITARY_TAX_CODE
                     ,p_purpose            => l_purpose);
        return l_tax_amount_inc + l_tax_amount_mil;             
    end;     

    -- начисление процентов
    -- p_start_date   - дата с учитывается только при p_mode = 2, 3
    -- p_end_date     - дата на которую производится расчет
    --- ***
    -- p_mode   (может быть использовано для перерасчета)      
    -- пока 2 не обрабатем
    --     1 - с учетом предыдущих параметров расчета (если были)  
    --         + дату последнего начисления (last_accrual_date или acr_dat) 
    --         + параметры p_end_date + p_deposit_list
    --     2 - учитывается передаваемые даты (параметры предыдущих расчетов не учитываются)
    --         p_start_date и p_end_date + p_deposit_list
    --     3 - аналогично значению 2, но учитывается тоько штрафная ставка
    procedure accrual_interest(
                           p_deposit_list in number_list
                          ,p_start_date   in date 
                          ,p_end_date     in date
                          ,p_mode         in number default 1
                          ,p_silent_mode   in number default 1)
     is
        l_calc                tt_deposit_calculator;
        l_hist_calc           tt_deposit_calculator;
        l_document_id         number;
        l_object_row          object%rowtype;
        
        function get_purpose (p_deal_id    in number
                             ,p_start_date in date
                             ,p_end_date   in date)
               return varchar2
         is
            l_deal_row             deal%rowtype;
            l_object_type_id       number;
        begin
            l_deal_row       := deal_utl.read_deal(p_deal_id => p_deal_id);
            l_object_type_id := object_utl.read_object(p_object_id => p_deal_id).object_type_id;
            return  'Нарахування % за '||
                    case when l_object_type_id = g_tranche_object_type_id 
                         then 'строк. депозит зг.Заяви про розміщення Траншу № '
                         when l_object_type_id = g_dod_object_type_id
                         then 'вкладом на вимогу зг.Заяви № '
                    end ||
                    l_deal_row.deal_number||
                    ' від '||to_char(l_deal_row.start_date, 'dd.mm.yyyy"р."')||
                    ' за період '||to_char(p_start_date, 'dd.mm.yyyy')||
                    to_char(p_end_date, ' - dd.mm.yyyy'); 
        end;
        
        function create_transfer(
                              p_account_id          number
                             ,p_interest_amount     number
                             ,p_start_date          date
                             ,p_end_date            date
                             ,p_deal_id             number
                             ,p_currency_id         number
                                )
               return number                 
         is
            l_int_accn_row         int_accn%rowtype;
            l_purpose              varchar2(1000);
            l_ref                  number;
            l_customer_type        number;
            l_register_value       number;
        begin
            if nvl(p_interest_amount, 0 ) = 0 then return null; end if;
            select ic.*
              into l_int_accn_row
              from int_accn ic
             where ic.acc = p_account_id
               and ic.id = interest_utl.INTEREST_KIND_LIABILITIES;

            l_purpose := get_purpose (p_deal_id    => p_deal_id
                                     ,p_start_date => p_start_date
                                     ,p_end_date   => p_end_date);
            -- перевод со счета расходов банка по начислению % на счет начисленных %%   
            l_ref := money_transfer(
                        p_sender_account_id    => l_int_accn_row.acrb
                       ,p_recipient_account_id => l_int_accn_row.acra
                       ,p_amount               => p_interest_amount
                       ,p_operation_type       => с_accrual_interest_oper_type -- Нарахування відсотків
                       ,p_purpose              => l_purpose
                       ,p_date                 => gl.bdate
                       ,p_is_sender_amount     => 0); -- сумма получателя 
            l_register_value := null;                       
            -- добавляем сумму в регистры по начисленным % 
            tools.hide_hint(
                register_utl.cor_register_value_common_type(
                               p_register_value_id         => l_register_value
                              ,p_object_id                 => p_deal_id
                              ,p_register_common_type_code => register_utl.COMMON_INTEREST_AMOUNT_CODE
                              ,p_plan_value                => p_interest_amount
                              ,p_value                     => p_interest_amount
                              ,p_date                      => gl.bdate
                              ,p_currency_id               => p_currency_id
                              ,p_is_planned                => 'N'
                              ,p_document_id               => l_ref));
            -- снимаем с начисленных процентов налог
            l_customer_type := customer_utl.read_customer(
                                                  p_customer_id => deal_utl.read_deal(p_deal_id => p_deal_id).customer_id).custtype;
            -- ФОП
            if l_customer_type = 3 then
                tools.hide_hint(
                                payout_tax (p_int_accn_row    => l_int_accn_row
                                           ,p_interest_amount => p_interest_amount
                                           ,p_date            => gl.bdate
                                           ,p_deal_id         => p_deal_id
                                           ,p_ref             => l_ref));
            end if;               
            return l_ref;           
        end;                        
    begin
        logger.log_info(p_procedure_name => $$plsql_unit||'.accrual_interest calc start'
                       ,p_log_message    => 'quantity obj : ' || p_deposit_list.count()  || chr(10) ||
                                            case when p_deposit_list.count() = 1 then 'object_id    : '|| p_deposit_list(1)|| chr(10) end ||
                                            'start_date   : ' || to_char(p_start_date, 'yyyy-mm-dd') || chr(10) ||
                                            'end_date     : ' || to_char(p_end_date, 'yyyy-mm-dd') || chr(10) ||
                                            'p_mode       : ' || p_mode
                       ,p_object_id      => null
                                );
        -- пока 2 не обрабатем                        
        if nvl(p_mode, 0) not in (1, 3) then return; end if;
        -- расчет процентов, получаем коллекцию                        
        l_calc := get_calculate_interest(
                           p_deposit_list  => p_deposit_list
                          ,p_start_date    => p_start_date 
                          ,p_end_date      => p_end_date
                          ,p_mode          => p_mode);

        logger.log_info(p_procedure_name => $$plsql_unit||'.accrual_interest calc end'
                       ,p_log_message    => 'quantity      : ' || l_calc.count()
                        ,p_object_id      => null
                                );        

        -- делаем проводки по начисленным %
        -- записываем одной суммой, если не переход года
        for i in (select x.account_id
                        ,x.id
                        ,min(x.start_date) start_date
                        ,max(x.end_date) end_date
                        ,sum(x.interest_amount) interest_amount
                        ,min(x.interest_tail) keep (dense_rank first order by x.end_date desc) interest_tail
                        ,x.currency_id
                    from table(l_calc) x
                  group by x.account_id
                          ,x.id
                          ,x.currency_id
                  order by x.id, start_date 
                  ) loop
                  
                logger.log_info(p_procedure_name => $$plsql_unit||'.accrual_interest transfer' 
                               ,p_log_message    => 'account_id      : ' || i.account_id   || chr(10) ||
                                                    'interest_amount : ' || i.interest_amount  || chr(10) ||
                                                    'start_date      : ' || to_char(i.start_date, 'yyyy-mm-dd')  || chr(10) ||
                                                    'end_date        : ' || to_char(i.end_date, 'yyyy-mm-dd')
                               ,p_object_id      => i.id
                               ,p_auxiliary_info => null
                                );
                begin             
                    savepoint sp_accrual_interest;
                    -- проводка             
                    l_document_id := create_transfer(
                                            p_account_id      => i.account_id
                                           ,p_interest_amount => i.interest_amount
                                           ,p_start_date      => i.start_date
                                           ,p_end_date        => i.end_date 
                                           ,p_deal_id         => i.id
                                           ,p_currency_id     => i.currency_id);
                   
                    l_object_row := object_utl.read_object(p_object_id => i.id);
                    -- записать "хвост" и дату последнего расчета ( для траншей и ДпТ)
                    smb_deposit_utl.set_calc_info_deposit(
                                            p_object_id         => i.id
                                           ,p_last_accrual_date => i.end_date
                                           ,p_tail_amount       => i.interest_tail);
                    -- запишем в int_accn для ДпТ (для траншей информативно - не используется)
                    update int_accn t set    
                           t.acr_dat = i.end_date
                          ,t.s       = i.interest_tail
                    where t.acc = i.account_id
                      and t.id = interest_utl.INTEREST_KIND_LIABILITIES;
                    -- запишем историю в int_reckonings (нужно ли ??) 
                    -- детальную информацию (проводку делаем одной суммой в пределах года (???) в saldoa будет 1 сумма на банковскую дату )
                    select  t_deposit_calculator(
                                  id                 => id
                                 ,account_id         => account_id 
                                 ,start_date         => start_date
                                 ,end_date           => end_date
                                 ,amount_deposit     => amount_deposit
                                 ,amount_for_accrual => amount_for_accrual
                                 ,interest_rate      => interest_rate
                                 ,interest_amount    => interest_amount
                                 ,interest_tail      => interest_tail
                                 ,accrual_method     => accrual_method
                                 ,currency_id        => currency_id
                                 ,comment_           => comment_ )
                      bulk collect into l_hist_calc
                      from table(l_calc) x 
                     where x.id = i.id 
                       and x.account_id = i.account_id;

                    set_history (p_calc             => l_hist_calc
                                ,p_interest_kind_id => case p_mode 
                                                          when 3 then interest_utl.INTEREST_KIND_DEPOSIT_FEE 
                                                          else interest_utl.RECKONING_TYPE_ORDINARY_INT 
                                                       end
                                ,p_ref               => l_document_id);
                exception
                    when others then
                       rollback to sp_accrual_interest;
                       bars_audit.error($$plsql_unit||'.accrual_interest' || chr(10) ||
                              'object_id       : ' || i.id                                || chr(10) ||
                              'account_id      : ' || i.account_id                        || chr(10) ||
                              'start_date      : ' || to_char(i.start_date, 'yyyy-mm-dd') || chr(10) ||
                              'end_date        : ' || to_char(i.end_date, 'yyyy-mm-dd')   || chr(10) ||
                              'interest_amount : ' || i.interest_amount                   || chr(10) ||
                               sqlerrm || chr(10)  || dbms_utility.format_error_backtrace());
                       smb_deposit_utl.registration_calc_errors(
                                       p_object_id   => i.id
                                      ,p_action_type => $$plsql_unit||'.accrual_interest'
                                      ,p_error       => sqlerrm || chr(10)  || dbms_utility.format_error_backtrace());
                       if p_silent_mode = 0 then raise_application_error(-20000, sqlerrm || chr(10)  || dbms_utility.format_error_backtrace()); end if;
                end;                  
        end loop;
    end;

    -- закрытие депозита
    procedure deposit_closing (p_id            in number
                              ,p_accrual_date  in date     
                              ,p_close_date    in date
                              ,p_silent_mode   in number default 1);

    -- начисление % на дату
    -- p_deposit_list - договора. если указаны, то расчет только по ним
    procedure auto_accrual_interest(
                                 p_date         in date
                                ,p_deposit_list in number_list)
     is 
        l_calc_date        date;
        l_accrual_date     date;
        l_deposits         number_list;
        l_is_last_day      number := 0;
        l_is_flag          number;
        l_expiry_date      date;
    begin
        -- если передаваемая дата не последний день месяца
        -- то нужно сделать расчет процентов для депозитов, у которых завтра истекает срок депозита (??)
        -- (только транши, ДпТ не имеют дату окнчания)
        -- для тестов поставил sysdate -> todo gl.bdate
        l_calc_date := trunc(case when p_date is null then gl.bdate else p_date end);
        -- последний рабочий день месяца
        -- dat_last_work
        if (l_calc_date = dat_next_u( last_day(l_calc_date) + 1, -1)) then
            -- дату расчета % устанавливаем в последний день месяца
            l_accrual_date := last_day(l_calc_date);
            l_is_last_day := 1;
        -- если пятница (расчет за субботу, воскресенье, выходной)    
        elsif l_calc_date <> dat_next_u(l_calc_date, 1) - 1 then
            l_accrual_date := dat_next_u(l_calc_date, 1) - 1;
        else 
            l_accrual_date := l_calc_date;
        end if;
        logger.log_info(p_procedure_name => $$plsql_unit||'.auto_accrual_interest start'
                                   ,p_log_message    => 'kf           : ' || bc.current_mfo || chr(10) ||
                                                        'bank date    : ' || to_char(gl.bdate, 'yyyy-mm-dd') || chr(10) ||                                   
                                                        'date         : ' || to_char(p_date, 'yyyy-mm-dd') || chr(10) ||
                                                        'accrual date : ' || to_char(l_accrual_date, 'yyyy-mm-dd')); 
        for i in(                                                
            with dpt$ as(
                  select o.id
                        ,t.last_accrual_date
                        ,d.start_date
                        ,nvl(t.expiry_date_prolongation, d.expiry_date) expiry_date
                        ,d.close_date
                        ,o.object_type_id
                        ,t.number_prolongation
                        ,t.current_prolongation_number
                        ,t.is_prolongation
                        ,case when o.state_id = g_object_blocked_state_id or
                                   a.blkd <> 0 
                              then 1 
                              else 0     
                         end is_blocked
                        ,o.state_id 
                    from object o
                        ,deal d
                        ,smb_deposit t
                        ,deal_account da
                        ,int_accn ic
                        ,customer c -- + policy
                        ,accounts a
                   where 1 = 1
                     and o.object_type_id in (g_tranche_object_type_id, g_dod_object_type_id)
                     and o.state_id in (g_object_active_state_id, g_object_blocked_state_id) -- trigger tiu_blkd11 - занятное чтиво (???)
                     and o.id = d.id 
                     and o.id = t.id
                     and o.id = da.deal_id 
                     and da.account_type_id = g_main_account_type_id
                     and da.account_id = ic.acc
                     and ic.id = interest_utl.INTEREST_KIND_LIABILITIES
                     and d.close_date is null -- убирать ли это ограничени (что делать при перерасчете закрытого ??)
                     and d.customer_id = c.rnk
                     and ic.acc = a.acc 
                     )
                  select d.id
                        ,d.last_accrual_date
                        ,d.expiry_date
                        ,d.is_blocked
                        ,d.is_prolongation
                        ,d.current_prolongation_number
                    from dpt$ d
                   where l_is_last_day = 1
                     and l_accrual_date > nvl(d.last_accrual_date, d.start_date) 
                     and (p_deposit_list is null or p_deposit_list is empty)
                  union all   
                  select d.id
                        ,d.last_accrual_date
                        ,d.expiry_date
                        ,d.is_blocked 
                        ,d.is_prolongation
                        ,d.current_prolongation_number
                    from dpt$ d
                   where l_is_last_day = 0
                     -- обработка для закрытия депозита
                     -- начисление выполняется на день раньше
                     and l_accrual_date >= d.expiry_date - 1
                     and l_accrual_date > nvl(d.last_accrual_date, d.start_date) 
                     and (p_deposit_list is null or p_deposit_list is empty)
                     -- транш не заблокирован или еще не было начислений
                     and (is_blocked = 0 or d.last_accrual_date is null)
                  union all
                  -- по списку
                  select d.id
                        ,d.last_accrual_date
                        ,d.expiry_date
                        ,d.is_blocked
                        ,d.is_prolongation
                        ,d.current_prolongation_number
                    from dpt$ d
                        ,table(p_deposit_list)  x
                   where 1 = 1
                     and l_accrual_date > nvl(d.last_accrual_date, d.start_date) 
                     and d.id = x.column_value
                    )
        loop
            logger.log_info(p_procedure_name => $$plsql_unit||'.auto_accrual_interest'
                           ,p_log_message    => 'l_accrual_date    : '|| to_char(l_accrual_date, 'yyyy-mm-dd') || chr(10) ||
                                                'expiry_date       : '|| to_char(i.expiry_date, 'yyyy-mm-dd') || chr(10) ||
                                                'last_accrual_date : '|| to_char(i.last_accrual_date, 'yyyy-mm-dd') || chr(10) ||
                                                'l_is_last_day     : '|| l_is_last_day || chr(10) ||
                                                'is_blocked        : '|| i.is_blocked
                           ,p_object_id      => i.id);
            if l_accrual_date >= i.expiry_date then
             -- дата расчета больше даты закрытия   
                -- обработка пролонгаций которые стартуюют в выходные
                if i.is_prolongation = 1 then
                    -- первая
                    if i.current_prolongation_number is null then 
                        smb_deposit_utl.set_deposit_prolongation(p_object_id => i.id);
                    end if;                  
                    loop
                        l_expiry_date := null;
                        select max(dpt.expiry_date_prolongation)
                          into l_expiry_date
                          from smb_deposit dpt
                         where dpt.id = i.id
                           and dpt.number_prolongation > nvl(dpt.current_prolongation_number, 0)    
                           and dpt.expiry_date_prolongation <= l_accrual_date;
                         if l_expiry_date is null then exit; end if;
                         smb_deposit_utl.set_deposit_prolongation(p_object_id => i.id);
                    end loop;
                    -- меняем дату окончания
                    select least(dpt.expiry_date_prolongation - 1, l_accrual_date)
                      into l_expiry_date
                      from smb_deposit dpt
                     where dpt.id = i.id;
                else 
                    l_expiry_date := i.expiry_date - 1;
                end if;
                -- конец месяца                  
                if l_is_last_day = 1 then
                    -- делаем начисление  
                    accrual_interest(
                                   p_deposit_list => number_list(i.id)
                                  ,p_start_date   => null
                                  ,p_end_date     => l_accrual_date
                                  ,p_mode         => 1);
                -- еще не было начислений, но пора закрывать
                elsif i.last_accrual_date is null then
                    accrual_interest(
                                   p_deposit_list => number_list(i.id)
                                  ,p_start_date   => null
                                  ,p_end_date     => l_expiry_date
                                  ,p_mode         => 1);
                -- рабочий день не понятна причина не закрытия (может лимит установлен)                  
                elsif l_is_last_day = 0 and i.last_accrual_date is not null  then
                    -- проверим возможность закрыть депозит  
                    begin 
                        savepoint sp_check_deposit_closing;
                        l_is_flag := 1;
                        deposit_closing (
                                   p_id            => i.id
                                  ,p_accrual_date  => l_accrual_date
                                  ,p_close_date    => l_accrual_date
                                  ,p_silent_mode   => 0);
                        rollback to sp_check_deposit_closing;          
                        exception
                          when others then 
                            rollback to sp_check_deposit_closing;
                            l_is_flag := 0;
                    end;  
                    -- возможно закрытие депозита
                    if l_is_flag = 1 then
                        accrual_interest(
                                       p_deposit_list => number_list(i.id)
                                      ,p_start_date   => null
                                      ,p_end_date     => l_accrual_date
                                      ,p_mode         => 1);
                    end if;
                end if;
            else -- начислить % 
                accrual_interest(
                               p_deposit_list => number_list(i.id)
                              ,p_start_date   => null
                              ,p_end_date     => l_accrual_date
                              ,p_mode         => 1);
            end if;                  
        end loop;
        /*
                -- обработка пролонгаций которые стартуюют в выходные
                if i.is_prolongation = 1 then
                    -- первая
                    if i.current_prolongation_number is null then 
                        smb_deposit_utl.set_deposit_prolongation(p_object_id => i.id);
                    end if;                  
                    loop
                        l_expiry_date := null;
                        select max(dpt.expiry_date_prolongation)
                          into l_expiry_date
                          from smb_deposit dpt
                         where dpt.id = i.id
                           and dpt.number_prolongation > nvl(dpt.current_prolongation_number, 0)    
                           and dpt.expiry_date_prolongation <= l_accrual_date;
                         if l_expiry_date is null then exit; end if;
                         smb_deposit_utl.set_deposit_prolongation(p_object_id => i.id);
                    end loop;
                    -- меняем дату окончания
                    select least(dpt.expiry_date_prolongation - 1, l_accrual_date)
                      into l_expiry_date
                      from smb_deposit dpt
                     where dpt.id = i.id;
                else 
                    l_expiry_date := i.expiry_date - 1;
                end if;
                -- конец месяца                  
                if i.is_blocked = 1 and l_is_last_day = 1 then 
                    -- делаем начисление  
                    accrual_interest(
                                   p_deposit_list => number_list(i.id)
                                  ,p_start_date   => null
                                  ,p_end_date     => l_accrual_date
                                  ,p_mode         => 1);
                -- если заблокирован и не конец месяца
                elsif i.is_blocked = 1 and l_is_last_day = 0 and i.last_accrual_date <= l_expiry_date then
                    accrual_interest(
                                   p_deposit_list => number_list(i.id)
                                  ,p_start_date   => null
                                  ,p_end_date     => l_expiry_date
                                  ,p_mode         => 1);
                elsif i.last_accrual_date is null then
                    accrual_interest(
                                   p_deposit_list => number_list(i.id)
                                  ,p_start_date   => null
                                  ,p_end_date     => l_expiry_date
                                  ,p_mode         => 1);
                -- рабочий день не понятна причина не закрытия (может лимит установлен)                  
                elsif l_is_last_day = 0 and i.last_accrual_date is not null  then
                    -- проверим возможность закрыть депозит  
                    begin 
                        -- с пролонгациями нужно разобраться !!!
                        savepoint sp_check_deposit_closing;
                        l_is_flag := 1;
                        deposit_closing (
                                   p_id            => i.id
                                  ,p_accrual_date  => l_accrual_date
                                  ,p_close_date    => l_accrual_date
                                  ,p_silent_mode   => 0);
                        rollback to sp_check_deposit_closing;          
                        exception
                          when others then 
                            rollback to sp_check_deposit_closing;
                            l_is_flag := 0;
                    end;  
                    -- возможно закрытие депозита
                    if l_is_flag = 1 then
                        accrual_interest(
                                       p_deposit_list => number_list(i.id)
                                      ,p_start_date   => null
                                      ,p_end_date     => l_accrual_date
                                      ,p_mode         => 1);
                    end if;
                end if;
            else -- начислить % 
                accrual_interest(
                               p_deposit_list => number_list(i.id)
                              ,p_start_date   => null
                              ,p_end_date     => l_accrual_date
                              ,p_mode         => 1);
            end if;                  
        end loop;
        /*
        if l_deposits.count() <> 0 then 
            logger.log_info(p_procedure_name => $$plsql_unit||'.auto_accrual_interest'
                                   ,p_log_message    => 'kf           : ' || bc.current_mfo || chr(10) ||
                                                        'amount of deposits for accrual = ' || l_deposits.count() || chr(10) || 
                                                        '{' || to_char(l_accrual_date, 'yyyy-mm-dd') || '}' || chr(10)
                                    ); 
                                    
            -- начислить %         
            accrual_interest(
                           p_deposit_list => l_deposits
                          ,p_start_date   => null
                          ,p_end_date     => l_accrual_date
                          ,p_mode         => 1);
        else 
            logger.log_info(p_procedure_name => $$plsql_unit||'.auto_accrual_interest'
                                   ,p_log_message    => 'kf           : ' || bc.current_mfo || chr(10) ||
                                                        'no data for accrual {' || to_char(l_accrual_date, 'yyyy-mm-dd') ||' } '
                                    ); 
        end if;*/
        logger.log_info(p_procedure_name => $$plsql_unit||'.auto_accrual_interest end'
                                   ,p_log_message    => 'kf           : ' || bc.current_mfo
                                    ); 

    end;

    function get_account_for_return(p_object_id in number)
      return number
     is
        l_account_number varchar2(50);
        l_currency_id    number;
    begin
        select nvl(pt.return_account, pod.return_account)
              ,nvl(pt.currency_id, pod.currency_id)
          into l_account_number, l_currency_id
          from process p
              ,xmltable ('/SMBDepositTranche' passing xmltype(p.process_data) columns
                       return_account      varchar2(50)  path 'ReturnAccount'
                      ,currency_id         number        path 'CurrencyId' 
                        )(+) pt
              ,xmltable ('/SMBDepositOnDemand' passing xmltype(p.process_data) columns
                       return_account      varchar2(50)  path 'ReturnAccount'
                      ,currency_id         number        path 'CurrencyId'  
                        )(+) pod
         where p.object_id = p_object_id
           and p.process_type_id in (g_process_tranche, g_process_on_demand);

        return account_utl.get_account_id(p_account_number => l_account_number
                                         ,p_currency_id    => l_currency_id);
    end; 

    -- возврат со счета депозитный на для возврата 
    --   -- по окончании действия / досрочном закрытии договора
    procedure payment_deposit(p_deposit_list in number_list
                             ,p_silent_mode  in number default 1)
     is
        l_sender_row       accounts%rowtype;
        l_recipient_row    accounts%rowtype;
        l_purpose          varchar2(1000);
        l_sender_amount    number;
        l_recipient_amount number;
        l_document_id      number;
        l_register_value   number;

        function get_purpose (p_deal_id in number)
               return varchar2
         is
            l_deal_row             deal%rowtype;
            l_object_type_id       number;
        begin
            l_deal_row       := deal_utl.read_deal(p_deal_id => p_deal_id);
            l_object_type_id := object_utl.read_object(p_object_id => p_deal_id).object_type_id;
            return  'Повернення коштів за '||
                    case when l_object_type_id = g_tranche_object_type_id 
                         then 'строк. депозит зг.Заяви про розміщення Траншу №'
                         when l_object_type_id = g_dod_object_type_id
                         then 'вкладом на вимогу зг.Заяви № '
                    end ||
                    l_deal_row.deal_number||
                    ' від '||to_char(l_deal_row.start_date, 'dd.mm.yyyy"р."'); 
        end;
    begin
        for i in (
                  select da.account_id
                         -- для траншей берем с регистра
                        ,case when r.register_type_id = g_reg_trn_principal_type_id
                             then r.actual_value 
                             -- для ДпТ берем остаток с accounts
                             else a.ostc
                         end amount_deposit   
                        ,o.id object_id
                        -- счет для возврата 
                        ,a.ostc account_balance
                        ,a.nls
                    from table(p_deposit_list) x
                        ,object o 
                        ,register_value r
                        ,deal_account da
                        ,process p
                        ,accounts a
                   where x.column_value = o.id
                     and o.state_id = g_object_active_state_id
                     and o.object_type_id in (g_tranche_object_type_id, g_dod_object_type_id)
                     and x.column_value = r.object_id(+)
                     and r.register_type_id(+) in (g_reg_trn_principal_type_id, g_reg_dod_principal_type_id)
                     and x.column_value = da.deal_id
                     and da.account_type_id = g_main_account_type_id
                     and da.account_id = a.acc
                     and x.column_value = p.object_id
                     and p.process_type_id in (g_process_tranche, g_process_on_demand)) loop
                logger.log_info(p_procedure_name => $$plsql_unit||'.payment_deposit',
                                    p_log_message    => 'account_id     : ' || i.account_id       || chr(10) ||          
                                                        'amount_deposit : '||i.amount_deposit
                                   ,p_object_id      => i.object_id
                                   ,p_auxiliary_info => null
                                    );
                -- if i.account_balance < amount_deposit then
                --    raise_application_error(-20000, 'Не достаточно денег на счете {'||i.nls||'}');
                -- end if;
                if i.amount_deposit <> 0 then                    
                    begin                              
                        savepoint sp_payment_deposit;
                        l_sender_row       := account_utl.read_account(p_account_id => i.account_id);
                        l_recipient_row    := account_utl.read_account(p_account_id => get_account_for_return(p_object_id => i.object_id));
                        l_sender_amount    := i.amount_deposit;
                        l_recipient_amount := i.amount_deposit;
                        l_purpose          := get_purpose (p_deal_id => i.object_id);
                        l_document_id := money_transfer(
                                              p_sender_row       => l_sender_row
                                             ,p_recipient_row    => l_recipient_row
                                             ,p_sender_amount    => l_sender_amount
                                             ,p_recipient_amount => l_recipient_amount
                                             ,p_operation_type   => с_payment_deposit_oper_type -- Погашення депозиту (внутр.)
                                             ,p_purpose          => l_purpose
                                             ,p_date             => gl.bdate
                                             ,p_ref              => null );
                        -- выплату депозита записать в регистры (???)
                        l_register_value := null;
                        tools.hide_hint(
                            register_utl.cor_register_value_common_type(
                                           p_register_value_id         => l_register_value
                                          ,p_object_id                 => i.object_id
                                          ,p_register_common_type_code => register_utl.COMMON_PRINCIPAL_AMOUNT_CODE
                                          ,p_plan_value                => -1 * l_sender_amount
                                          ,p_value                     => -1 * l_sender_amount
                                          ,p_date                      => gl.bdate
                                          ,p_currency_id               => l_sender_row.kv
                                          ,p_is_planned                => 'N'
                                          ,p_document_id               => l_document_id));
                    exception
                       when others then
                           rollback to sp_payment_deposit;
                           smb_deposit_utl.registration_calc_errors(
                                         p_object_id   => i.object_id
                                        ,p_action_type => $$plsql_unit||'.payment_deposit'
                                        ,p_error       => sqlerrm || chr(10)  || dbms_utility.format_error_backtrace());
                           bars_audit.error($$plsql_unit||'.payment_deposit' || chr(10) ||
                                  'object_id       : ' || i.object_id        || chr(10) ||
                                  'account_id      : ' || i.account_id       || chr(10) ||
                                  'amount_deposit  : ' || i.amount_deposit   || chr(10) ||
                                   sqlerrm || chr(10)  || dbms_utility.format_error_backtrace());
                           if p_silent_mode = 0 then raise_application_error(-20000, sqlerrm || chr(10)  || dbms_utility.format_error_backtrace()); end if;
                    end;
                end if;   
        end loop;             
    end;

    -- выплата начисленных %
    -- p_mode_payout in 0, 1
    --  0  выплата %     - перевод со счета начисленных % на счет для возврата
    --  1  капитализация - перевод со счета начисленных % на депозитный счет 
    procedure payment_interest(p_deposit_list in number_list
                              ,p_mode_payout  in number default 0
                              ,p_silent_mode  in number default 1)
     is
        l_document_id          number;

        function get_purpose (p_deal_id    in number
                             ,p_start_date in date
                             ,p_end_date   in date)
               return varchar2
         is
            l_deal_row             deal%rowtype;
            l_object_type_id       number;
        begin
            -- Нарахування % за строковим депозитом згідно Заяви про розміщення Траншу № …від … за період….
            l_deal_row       := deal_utl.read_deal(p_deal_id => p_deal_id);
            l_object_type_id := object_utl.read_object(p_object_id => p_deal_id).object_type_id;
            return  'Виплата нарахованих % за '||
                    case when l_object_type_id = g_tranche_object_type_id 
                         then 'строк. депозит зг.Заяви про розміщення Траншу № '
                         when l_object_type_id = g_dod_object_type_id
                         then 'вкладом на вимогу зг.Заяви № '
                    end ||
                    l_deal_row.deal_number||
                    ' від '||to_char(l_deal_row.start_date, 'dd.mm.yyyy"р."')||
                    case when p_start_date is not null
                         then ' за період '||to_char(p_start_date, 'dd.mm.yyyy')||
                                             to_char(p_end_date, ' - dd.mm.yyyy')
                    end; 
        end;

        -- перевод начисленных процентов
        function payout (
                         p_account_id      in number
                        ,p_interest_amount in number
                        ,p_deal_id         in number)
            return number 
         is
            l_int_accn_row     int_accn%rowtype;
            l_interest_amount  number := p_interest_amount;
            l_recipient_amount number;
            l_sender_amount    number;
            l_sender_row       accounts%rowtype;
            l_recipient_row    accounts%rowtype;
            l_register_value   number;
            l_document_id      number;
            l_purpose          varchar2(500);
            l_start_date       date;
            l_end_date         date;
        begin
            l_int_accn_row := interest_utl.read_int_accn(
                                                p_account_id => p_account_id
                                               ,p_interest_kind_id => interest_utl.INTEREST_KIND_LIABILITIES);

            select min(x.date_from)
                  ,max(x.date_through) 
              into l_start_date
                  ,l_end_date
              from int_reckonings x
             where x.account_id = p_account_id
               and x.deal_id = p_deal_id
               and x.state_id = interest_utl.RECKONING_STATE_ACCRUED
               and x.is_grouping_unit = 'Y';
            
            l_purpose := get_purpose (p_deal_id    => p_deal_id
                                     ,p_start_date => l_start_date
                                     ,p_end_date   => l_end_date);
            -- ФОП
            -- снятие налога перенес в accrual_interest (аналогично make_int)
            -- переводим со счета начисленных процентов на депозитный счет/для возврата зависит от p_mode_payout
            l_sender_row       := account_utl.read_account(p_account_id => l_int_accn_row.acra);
            if p_mode_payout = 0 then
                -- выплата на счет для возврата
                l_recipient_row    := account_utl.read_account(p_account_id => get_account_for_return(p_object_id => p_deal_id));
            else
                -- капитализация
                l_recipient_row    := account_utl.read_account(p_account_id => l_int_accn_row.acc); 
            end if;  
            l_recipient_amount := l_interest_amount;
            l_sender_amount    := l_recipient_amount;
            logger.log_info(p_procedure_name => $$plsql_unit||'.payment_interest',
                                    p_log_message    => 'l_sender_row.nls     : '||l_sender_row.nls     || chr(10) ||
                                                        'l_recipient_row.nls  : '||l_recipient_row.nls  || chr(10) ||
                                                        'l_sender_row.ostc    : '||l_sender_row.ostc    || chr(10)||
                                                        'l_recipient_row.ostc : '||l_recipient_row.ostc || chr(10) ||
                                                        'l_sender_amount      : '||l_sender_amount 
                                   ,p_object_id      => p_deal_id
                                   ,p_auxiliary_info => null
                                    );

            -- TODO проверить реальную сумму на счете (через accounts/saldoa (???))
            -- счет начисленных % и депозитный счет/для возврата в одной валюте
            l_document_id := money_transfer(
                                  p_sender_row       => l_sender_row
                                 ,p_recipient_row    => l_recipient_row
                                 ,p_sender_amount    => l_sender_amount
                                 ,p_recipient_amount => l_recipient_amount
                                 ,p_operation_type   => с_payment_interest_oper_type -- Виплата відсотків (внутр.)
                                 ,p_purpose          => l_purpose 
                                 ,p_date             => gl.bdate
                                 ,p_ref              => null );
            -- запишем историю                     
            -- обновление payment_document_id обновляю последний расчет, так как уникальный индекс по этому полю (зачем он там)
            update int_reckonings x set
                   x.state_id            = interest_utl.RECKONING_STATE_PAYED
                  ,x.payment_document_id = l_document_id  
             where x.account_id = p_account_id
               and x.deal_id = p_deal_id
               and x.state_id = interest_utl.RECKONING_STATE_ACCRUED
               and x.is_grouping_unit = 'Y'
               and x.id = (select max(i.id) keep (dense_rank first order by i.date_through desc)
                             from int_reckonings i
                            where i.account_id = x.account_id
                              and i.deal_id = x.deal_id
                              and i.state_id = x.state_id
                              and i.payment_document_id is null
                              and i.is_grouping_unit = x.is_grouping_unit) ;
            -- установим статус выплачено для всех начисленных, не устанавливая payment_document_id
            -- так как уникальное поле payment_document_id
            update int_reckonings x set
                   x.state_id = interest_utl.RECKONING_STATE_PAYED
             where x.account_id = p_account_id
               and x.deal_id = p_deal_id
               and x.state_id = interest_utl.RECKONING_STATE_ACCRUED
               and x.is_grouping_unit = 'Y';

            l_register_value := null;
            -- списываем сумму с регистра по начисленным %
            tools.hide_hint(
                register_utl.cor_register_value_common_type(
                               p_register_value_id         => l_register_value
                              ,p_object_id                 => p_deal_id
                              ,p_register_common_type_code => register_utl.COMMON_INTEREST_AMOUNT_CODE
                              ,p_plan_value                => -1 * l_sender_amount
                              ,p_value                     => -1 * l_sender_amount
                              ,p_date                      => gl.bdate
                              ,p_currency_id               => l_sender_row.kv
                              ,p_is_planned                => 'N'
                              ,p_document_id               => l_document_id));
            -- сохраняем сумму выплаченных % на регистр
            l_register_value := null;
            tools.hide_hint(
                register_utl.cor_register_value_common_type(
                               p_register_value_id         => l_register_value
                              ,p_object_id                 => p_deal_id
                              ,p_register_common_type_code => register_utl.COMMON_INTEREST_PAID_CODE
                              ,p_plan_value                => l_sender_amount
                              ,p_value                     => l_sender_amount
                              ,p_date                      => gl.bdate
                              ,p_currency_id               => l_sender_row.kv
                              ,p_is_planned                => 'N'
                              ,p_document_id               => l_document_id));

            -- добавляем сумму начисленных % на регистр по основному счету
            -- для капитализации
            if p_mode_payout = 1 then
                l_register_value := null;
                tools.hide_hint(
                    register_utl.cor_register_value_common_type(
                                   p_register_value_id         => l_register_value
                                  ,p_object_id                 => p_deal_id
                                  ,p_register_common_type_code => register_utl.COMMON_PRINCIPAL_AMOUNT_CODE
                                  ,p_plan_value                => l_sender_amount
                                  ,p_value                     => l_sender_amount
                                  ,p_date                      => gl.bdate
                                  ,p_currency_id               => l_sender_row.kv
                                  ,p_is_planned                => 'N'
                                  ,p_document_id               => l_document_id));
            end if;                                   
            return l_document_id;
        end;  

        procedure set_payment_date(
                         p_account_id      in number
                        ,p_deal_id         in number)
         is
        begin
            -- изменить дату выплаты в int_accn
            update int_accn t
               set t.apl_dat = gl.bdate
             where t.acc = p_account_id
               and t.id = interest_utl.INTEREST_KIND_LIABILITIES;

            update smb_deposit set
                  last_payment_date = gl.bdate
             where id = p_deal_id;                                                
        end;        
    begin
        logger.log_info(p_procedure_name => $$plsql_unit||'.payment_interest',
                                p_log_message    => 'p_deposit_list count : '||p_deposit_list.count()
                               ,p_object_id      => null
                               ,p_auxiliary_info => null
                                );
        for i in (
                  select da.account_id
                        ,r.actual_value interest_amount
                        ,r.currency_id
                        ,r.object_id 
                        ,a.rnk customer_id
                    from table(p_deposit_list) x
                        ,register_value r
                        ,deal_account da
                        ,int_accn ic
                        ,accounts a
                   where x.column_value = r.object_id
                     and r.register_type_id in (g_reg_trn_int_amount_type_id, g_reg_dod_int_amount_type_id)
                     and x.column_value = da.deal_id
                     and da.account_type_id = g_main_account_type_id 
                     and da.account_id = ic.acc
                     and ic.acra = a.acc
                     and ic.id = interest_utl.INTEREST_KIND_LIABILITIES
                     ) loop
           -- есть что переводить
           if i.interest_amount <> 0 then
               logger.log_info(p_procedure_name => $$plsql_unit||'.payment_interest',
                                p_log_message    => 'interest_amount : '||i.interest_amount
                               ,p_object_id      => i.object_id
                               ,p_auxiliary_info => null
                                );
               begin             
                   savepoint sp_payment_interest;
                   l_document_id := payout (
                                       p_account_id      => i.account_id
                                      ,p_interest_amount => i.interest_amount
                                      ,p_deal_id         => i.object_id);
                   -- меняем дату последней выплаты                   
                   set_payment_date( 
                                       p_account_id      => i.account_id
                                      ,p_deal_id         => i.object_id);
               exception
                  when others then
                     rollback to sp_payment_interest;
                     bars_audit.error($$plsql_unit||'.payment_interest' || chr(10) ||
                              'object_id       : '  || i.object_id                         || chr(10) ||
                              'account_id      : '  || i.account_id                        || chr(10) ||
                              'interest_amount : '  || i.interest_amount                   || chr(10) ||
                                 sqlerrm || chr(10) || dbms_utility.format_error_backtrace() ||
                                            chr(10) || dbms_utility.format_call_stack());
                     smb_deposit_utl.registration_calc_errors(
                                         p_object_id   => i.object_id
                                        ,p_action_type => $$plsql_unit||'.payment_interest'
                                        ,p_error       => sqlerrm || chr(10)  || dbms_utility.format_error_backtrace());
                     if p_silent_mode = 0 then raise_application_error(-20000, sqlerrm || chr(10)  || dbms_utility.format_error_backtrace()); end if;
               end;                   
           else 
               logger.log_info(p_procedure_name => $$plsql_unit||'.payment_interest 0',
                                p_log_message    => 'object_id       : ' || i.object_id    || chr(10) ||
                                                    'account_id      : ' || i.account_id   || chr(10) ||
                                                    'interest_amount : ' || i.interest_amount
                               ,p_object_id      => i.object_id
                               ,p_auxiliary_info => null
                                );
           end if;                                     
        end loop;
    end;

    -- применить штраф за досрочное закрытие
    procedure payment_penalty (p_id in number)
     is
        l_process_type_id         number;
        l_amount                  number;
        l_amount_tax_inc          number;
        l_amount_tax_mil          number;
        l_amount_tax_inc_penalty  number := 0;
        l_amount_tax_mil_penalty  number := 0;
        l_tax_account_inc         number;
        l_tax_account_mil         number;
        l_tax_account_ret         number;
        l_amount_penalty          number;
        l_ref                     number;
        l_penalty_acc_id          number;
        l_purpose                 varchar2(1000);
        l_register_value          number;
        l_tmp_amount              number;

        -- возврат начисленных налогв
        procedure tax_refund(p_tax_type        in number -- Тип податку: 1 - податок на прибуток з ФО, 2 - військовий збір з ФО
                            ,p_amount_tax      in number -- разница в налогах по обычной ставке и штрафной
                            ,p_account_id      in number
                            ,p_tax_oper_type   in number
                            ,p_object_id       in number
                            ,p_reg_type_code   in varchar2
                            ,p_branch          in varchar2                
                            ,p_purpose         in varchar2
                            ,p_ref             in number
                            ,p_currency_id     in number
                                  )
         is
            l_tax_account_ret number;
        begin
            logger.log_info(p_procedure_name => $$plsql_unit||'.payment_penalty step 1. 2',
                                    p_log_message    => 'tax penalty : ' || p_amount_tax || chr(10) ||
                                                        'tax type    : ' || p_tax_type
                                   ,p_object_id      => p_object_id
                                   ,p_auxiliary_info => null);

            l_tax_account_ret := get_tax_account (
                                    p_tax_type => p_tax_type -- Тип податку: 1 - податок на прибуток з ФО, 2 - військовий збір з ФО
                                   ,p_nls_type => 0          -- Тип рахунка: 0 - для повернення податку, 1 - для сплати податку
                                   ,p_branch   => p_branch);
            -- переводим
            tools.hide_hint(
                money_transfer(
                                    p_sender_account_id    => l_tax_account_ret
                                   ,p_recipient_account_id => p_account_id
                                   ,p_amount               => p_amount_tax
                                   ,p_operation_type       => p_tax_oper_type
                                   ,p_purpose              => p_purpose
                                   ,p_date                 => gl.bdate
                                   ,p_is_sender_amount     => 0      -- деньги p_recipient_account_id
                                   ,p_ref                  => p_ref)); 
            -- добавим на основной счет                       
            l_register_value := null;
            tools.hide_hint(
                register_utl.cor_register_value_common_type(
                                    p_register_value_id         => l_register_value
                                   ,p_object_id                 => p_object_id
                                   ,p_register_common_type_code => register_utl.COMMON_PRINCIPAL_AMOUNT_CODE
                                   ,p_plan_value                => p_amount_tax
                                   ,p_value                     => p_amount_tax
                                   ,p_date                      => gl.bdate
                                   ,p_currency_id               => p_currency_id
                                   ,p_is_planned                => 'N'
                                   ,p_document_id               => p_ref));

            --    - запишем сумму в регистр по налогам, вычтем разность 
            l_register_value := null;
            tools.hide_hint(
                register_utl.cor_register_value_common_type(
                                    p_register_value_id         => l_register_value
                                   ,p_object_id                 => p_object_id
                                   ,p_register_common_type_code => p_reg_type_code
                                   ,p_plan_value                => -1 * p_amount_tax
                                   ,p_value                     => -1 * p_amount_tax
                                   ,p_date                      => gl.bdate
                                   ,p_currency_id               => p_currency_id
                                   ,p_is_planned                => 'N'
                                   ,p_document_id               => p_ref));
        end; 
                         
    begin 
        -- *********
        -- решил сделать по другому (раньше был монстр (по svn можно увидеть)
        --   1. если не было начислений (соответственно не было выплат)
        --      -  делаем расчет %% по штрафной ставке и выходим
        --   2. есть не выплаченные начисления
        --      -  доначисляем %% если нужно т.е. last_accrual_date до дата_закрытия -1 (gl.bdate)
        --      -  делаем выплату
        --   3. делаем расчет %% по штрафной ставке от даты начала по дата_закрытия - 1
        --      -  теперь все движения будут на депозитном счете

        -- logs TODO 
        -- *********
        -- тип процесса при досрочном закрытии
        l_process_type_id := process_utl.get_proc_type_id(
                                              p_proc_type_code => smb_deposit_utl.PROCESS_EARLY_RETURN_TRANCHE
                                             ,p_module_code    => smb_deposit_utl.PROCESS_TRANCHE_MODULE);
        logger.log_info(p_procedure_name => $$plsql_unit||'.payment_penalty',
                                p_log_message    => null
                               ,p_object_id      => p_id
                               ,p_auxiliary_info => null);
        -- штраф может быть только у траншей при досрочном закрытии
        -- как бы 2-а раза не применить штраф (???) close_date учитывать ?
        for i in (select p.object_id
                        ,t.start_date
                        ,least(nvl(t.action_date, gl.bdate), gl.bdate) end_date
                        ,dpt.last_payment_date
                        ,dpt.last_accrual_date
                        ,da.account_id main_account_id
                        ,ic.acra       interest_account_id
                        ,dpt.currency_id
                        ,d.branch_id
                        ,dpt.is_capitalization
                    from process p 
                        ,xmltable('/SMBDepositTranche' passing xmltype(p.process_data) columns
                                    start_date        date         path 'StartDate'
                                   ,action_date       date         path 'ActionDate') t
                        ,smb_deposit dpt
                        ,deal_account da
                        ,int_accn ic
                        ,deal d
                   where p.object_id = p_id
                     and p.process_type_id = l_process_type_id
                     and p.object_id = dpt.id
                     and p.object_id = da.deal_id
                     and da.account_type_id = g_main_account_type_id 
                     and da.account_id = ic.acc
                     and ic.id = interest_utl.INTEREST_KIND_LIABILITIES
                     and dpt.id = d.id
                     and exists (
                          select null
                            from attribute_value_by_date a    
                           where a.attribute_id = g_trn_attribute_penalty_id
                             and a.object_id = p.object_id
                             and nvl(a.number_value, 0) > 0)
                     ) loop
            logger.log_info(p_procedure_name => $$plsql_unit||'.payment_penalty step 0',
                                p_log_message    => ''
                               ,p_object_id      => i.object_id
                               ,p_auxiliary_info => null);

            -- 0. если не было выплат и расчета % 
            --     делаем расчет %% по штрафной ставке (???) и выходим
            if i.last_accrual_date is null then
                logger.log_info(p_procedure_name => $$plsql_unit||'.payment_penalty step 0. 1',
                                p_log_message    => 'calc only the penalty rate'
                               ,p_object_id      => i.object_id
                               ,p_auxiliary_info => null
                                );
                accrual_interest(
                           p_deposit_list => number_list(i.object_id)
                          ,p_start_date   => i.start_date
                          ,p_end_date     => i.end_date - 1 -- на дату закрытия не начисляем
                          ,p_mode         => 3 -- штраф
                          ,p_silent_mode  => 0); 
                -- может лог записать (???)          
                -- выходим
                return;
            end if;

            -- делаем начисления по обычной схеме
            if i.last_accrual_date < i.end_date - 1 then
                accrual_interest(
                           p_deposit_list => number_list(i.object_id)
                          ,p_start_date   => i.last_accrual_date + 1
                          ,p_end_date     => i.end_date - 1 -- на дату закрытия не начисляем
                          ,p_mode         => 1 -- 
                          ,p_silent_mode  => 0);
            end if;
            
            -- делаем выплату, как капитализацию
            payment_interest(p_deposit_list => number_list(i.object_id)
                            ,p_mode_payout  => 1
                            ,p_silent_mode  => 0);
                               
            -- берем сумму по штрафной ставке
            -- расчет % по штрафной ставке за период начислений, start_date : дата_закрытия - 1
            l_amount_penalty := get_calc_interest_only_sum(
                                     p_id         => i.object_id
                                    ,p_start_date => i.start_date
                                    ,p_end_date   => i.end_date - 1 -- на дату закрытия не начисляем
                                    ,p_mode       => 3); -- применить штрафную ставку
            -- так как мы все выплатили, то                        
            -- берем с регистра сумму выплаченных %% и налоги
            select nvl(sum(case when r.register_type_id = g_reg_trn_paid_int_type_id     then r.actual_value end), 0)
                  ,nvl(sum(case when r.register_type_id = g_reg_trn_income_tax_type_id   then r.actual_value end), 0)           
                  ,nvl(sum(case when r.register_type_id = g_reg_trn_military_tax_type_id then r.actual_value end), 0) 
              into l_amount, l_amount_tax_inc, l_amount_tax_mil
              from register_value r
             where r.object_id = i.object_id
               and r.register_type_id in (g_reg_trn_paid_int_type_id
                                         ,g_reg_trn_income_tax_type_id
                                         ,g_reg_trn_military_tax_type_id);
            -- сумма по штрафной ставке меньше начисленных %%                             
            if l_amount + l_amount_tax_inc + l_amount_tax_mil > l_amount_penalty then
                -- если были налоги, берем налоги от суммы штрафа 
                if l_amount_tax_inc + l_amount_tax_mil > 0 then
                    set_tax(
                           p_amount          => l_amount_penalty
                          ,p_tax_account_inc => l_tax_account_inc         -- счет  - податок на прибуток з ФО
                          ,p_tax_account_mil => l_tax_account_mil         -- счет  - військовий збір з ФО
                          ,p_tax_amount_inc  => l_amount_tax_inc_penalty      -- сумма - податок на прибуток з ФО
                          ,p_tax_amount_mil  => l_amount_tax_mil_penalty      -- сумма - військовий збір з ФО
                          ,p_branch          => i.branch_id );
                end if;          
                l_penalty_acc_id := get_penalty_account(
                                              p_id          => i.object_id
                                             ,p_currency_id => i.currency_id
                                             ,p_branch      => i.branch_id);
                -- снимем основную разницу между выплаченными и штрафными, на депозитном счете
                l_tmp_amount := round(l_amount - (l_amount_penalty - l_amount_tax_inc_penalty - l_amount_tax_mil_penalty) -  
                                                 -- эту сумму вернем из излишне начисленного - податок на прибуток з ФО
                                                 (l_amount_tax_inc - l_amount_tax_inc_penalty) - 
                                                 -- эту сумму вернем из излишне начисленного - військовий збір з ФО
                                                 (l_amount_tax_mil - l_amount_tax_mil_penalty)); 
                l_ref := money_transfer(
                              p_sender_account_id    => i.main_account_id
                             ,p_recipient_account_id => l_penalty_acc_id
                             ,p_amount               => l_tmp_amount
                             ,p_operation_type       => с_penalty_oper_type
                             ,p_purpose              => l_purpose
                             ,p_date                 => gl.bdate
                             ,p_is_sender_amount     => 1); -- деньги основного счета (т.е. отправителя)
                 -- записать в регистр, снимаем разницу с регистра основной суммы
                l_register_value := null;
                tools.hide_hint(
                    register_utl.cor_register_value_common_type(
                                   p_register_value_id         => l_register_value
                                  ,p_object_id                 => i.object_id
                                  ,p_register_common_type_code => register_utl.COMMON_PRINCIPAL_AMOUNT_CODE
                                  ,p_plan_value                => -1 * l_tmp_amount
                                  ,p_value                     => -1 * l_tmp_amount
                                  ,p_date                      => gl.bdate
                                  ,p_currency_id               => i.currency_id
                                  ,p_is_planned                => 'N'
                                  ,p_document_id               => l_ref));
                -- работаем с налогами                  
                if l_amount_tax_inc_penalty + l_amount_tax_mil_penalty > 0 then
                    -- податок на прибуток - перевести деньги с 3522 на счет начисленных % (???)      
                    if l_amount_tax_inc > l_amount_tax_inc_penalty then
                        tax_refund(p_tax_type        => 1 
                                  ,p_amount_tax      => l_amount_tax_inc - l_amount_tax_inc_penalty
                                  ,p_account_id      => i.main_account_id
                                  ,p_tax_oper_type   => с_income_tax_oper_type
                                  ,p_object_id       => i.object_id
                                  ,p_reg_type_code   => register_utl.COMMON_INCOME_TAX_CODE
                                  ,p_branch          => i.branch_id
                                  ,p_purpose         => l_purpose
                                  ,p_ref             => l_ref
                                  ,p_currency_id     => i.currency_id);
                    end if;                            
                    -- військовий збір з ФО - перевести деньги с 3522 на счет начисленных % (???)      
                    if l_amount_tax_mil > l_amount_tax_mil_penalty then
                        tax_refund(p_tax_type        => 2 
                                  ,p_amount_tax      => l_amount_tax_mil - l_amount_tax_mil_penalty
                                  ,p_account_id      => i.main_account_id
                                  ,p_tax_oper_type   => c_military_tax_oper_type
                                  ,p_object_id       => i.object_id
                                  ,p_reg_type_code   => register_utl.COMMON_MILITARY_TAX_CODE
                                  ,p_branch          => i.branch_id          
                                  ,p_purpose         => l_purpose
                                  ,p_ref             => l_ref
                                  ,p_currency_id     => i.currency_id);
                    end if;
                end if;
            end if;
        end loop;
    end;

    -- закрыть счета депозита
    -- депозитный счет, счет начисленных %
    --   если передавать коллекцией можно получить проблему (когда одновременно закрываются 2-а депозита одного клиента)
    procedure close_deposit_account(p_id   in number)
     is
    begin
        for i in (
                select da.*
                  from deal_account da
                      ,accounts a 
                 where da.deal_id = p_id
                   and a.acc = da.account_id
                   and a.ostc = 0
                   and a.ostb = 0
                   and a.ostf = 0
                   and nvl(a.dapp, gl.bdate - 1) < gl.bdate
                   and a.dazs is null
                   and da.account_type_id in (g_main_account_type_id, g_int_account_type_id)
                   and not exists (
                         select null
                           from deal_account da1
                               ,object o
                         where da1.account_id = da.account_id
                           and da1.account_type_id = da.account_type_id      
                           and da1.deal_id = o.id
                           and o.id <> da.deal_id
                           and o.state_id in (g_object_active_state_id, g_object_blocked_state_id, g_object_created_state_id)  ) 
                  ) loop
             -- закрыть счета
             update accounts set
               dazs = gl.bdate
              where acc = i.account_id;      
        end loop;
    end;

    -- закрытие счетов депозитного / начисленных %
    procedure auto_account_deposit_closing(p_date in date)
     is
        l_end_date    date;
    begin
        l_end_date := trunc(nvl(p_date, gl.bdate));
        for i in (select distinct
                         o.id object_id
                    from object o
                        ,deal d
                        ,deal_account da      
                        ,accounts a
                        ,smb_deposit dpt
                   where o.object_type_id in (g_tranche_object_type_id, g_dod_object_type_id)
                     and o.id = d.id
                     and o.id = dpt.id
                     and coalesce(d.close_date, dpt.expiry_date_prolongation, d.expiry_date) <= l_end_date
                     and o.state_id in (g_object_closed_state_id, g_object_deleted_state_id)
                     and d.id = da.deal_id
                     and da.account_type_id in (g_main_account_type_id, g_int_account_type_id)
                     and da.account_id = a.acc
                     and a.dazs is null
                     and a.ostc = 0
                     and a.ostb = 0
                     and a.ostf = 0
                     and nvl(a.dapp, gl.bdate - 1) < gl.bdate
                    ) loop
             begin  
                 logger.log_info(p_procedure_name => $$plsql_unit||'.auto_account_deposit_closing'
                                ,p_log_message    => 'bank date : ' || to_char(gl.bdate, 'yyyy-mm-dd')
                                ,p_object_id      => i.object_id
                                ,p_auxiliary_info => null);
                 savepoint account_dpt_closing;     
                 close_deposit_account(p_id   => i.object_id);
              exception
                      when others then 
                         rollback to account_dpt_closing;  
                         smb_deposit_utl.registration_calc_errors(
                                                       p_object_id   => i.object_id
                                                      ,p_action_type => $$plsql_unit||'.auto_account_deposit_closing'
                                                      ,p_error       => sqlerrm || chr(10)  || dbms_utility.format_error_backtrace());
             end;                     
        end loop;            
    end; 

    procedure deposit_closing (p_id            in number
                              ,p_accrual_date  in date     
                              ,p_close_date    in date
                              ,p_silent_mode   in number default 1) 
     is
        l_deposit_type_code  varchar2(50);
        l_expiry_date        date;
        l_process_id         number;
        l_account_id         number;
        l_comment            varchar2(1000);
    begin
        logger.log_info(p_procedure_name => $$plsql_unit||'.deposit_closing',
                                p_log_message    => null
                               ,p_object_id      => p_id
                               ,p_auxiliary_info => null
                                );
        begin  
          select account_id
            into l_account_id       
            from deal_account a
           where a.deal_id = p_id
             and a.account_type_id = g_main_account_type_id; 
        exception 
           when no_data_found then 
              raise_application_error(-20000, 'Не знайдено депозитний рахунок при закритті депозиту.');
           when too_many_rows then 
              raise_application_error(-20000, 'Знайдено більше 1-го депозитного рахуноку при закритті депозиту.');
           raise;
        end; 
        l_deposit_type_code := object_utl.get_object_type_code(
                                            p_object_type_id => object_utl.read_object(p_object_id => p_id).object_type_id);
        savepoint sp_deposit_closing;                                    
        -- если есть по траншу штраф - (??)
        payment_penalty (p_id => p_id);
        -- начислить %
        accrual_interest(
                       p_deposit_list => number_list(p_id)
                      ,p_start_date   => null
                      ,p_end_date     => p_accrual_date
                      ,p_mode         => 1
                      ,p_silent_mode  => 0);
        -- перевести со счета начисленных на депозитный
        payment_interest(p_deposit_list => number_list(p_id)
                        ,p_silent_mode  => 0);
        -- перевести со счета депозитный на счет для возврата
        payment_deposit(p_deposit_list => number_list(p_id)
                       ,p_silent_mode  => 0);
        -- закрыть договор Транш / По Требованию
           -- установливаем объект Закрытым
        object_utl.set_object_state(
                              p_object_id  => p_id
                             ,p_state_code => 'CLOSED'
                                        ); 
        select nvl(dpt.expiry_date_prolongation, d.expiry_date)
          into l_expiry_date
          from smb_deposit dpt
              ,deal d
         where dpt.id = p_id
           and dpt.id = d.id;
        l_comment := case when l_deposit_type_code = smb_deposit_utl.TRANCHE_OBJECT_TYPE_CODE
                        then case when l_expiry_date <= p_close_date 
                              then 'Закриття траншу'
                              else 'Дострокове повернення траншу'
                             end  
                        else 'Закриття вкладу на вимогу'
                     end;
        deal_utl.set_deal_close_date(
                                        p_deal_id    => p_id
                                       ,p_close_date => p_close_date
                                       ,p_comment    => l_comment);
        -- закрыть счета, если нет других активных траншей по этому клиенту
        -- нужно закрывать на следующий день после всех проводок (???)
        close_deposit_account(p_id => p_id);
        -- создадим процесс закрытия для траншей (как история)
        if l_deposit_type_code = smb_deposit_utl.TRANCHE_OBJECT_TYPE_CODE then
            l_process_id   := process_utl.process_create(
                                      p_proc_type_code    => smb_deposit_utl.PROCESS_CLOSING_TRANCHE
                                     ,p_proc_type_module  => smb_deposit_utl.PROCESS_TRANCHE_MODULE
                                     ,p_process_name      => '[закрытие]'
                                     ,p_process_data      => '<SMBDepositTranche><ActionDate>'||to_char(p_close_date, 'yyyy-mm-dd')||'</ActionDate>'||
                                                             '<Reason>'||l_comment||'</Reason></SMBDepositTranche>'
                                                        );
            update process p
               set p.object_id = p_id
             where p.id = l_process_id;
        end if; 
        -- не понятно нужно ли это (???)
        -- вызов оставил, но не обрабатывается закрытый депозит
        smb_deposit_utl.set_parameter_deposit(p_object_id => p_id);
    exception
        when others then 
           rollback to sp_deposit_closing;
           bars_audit.error($$plsql_unit||'.deposit_closing' || chr(10) ||
                  'object_id    : '   || p_id        || chr(10) ||
                  'accrual_date : '   || to_char(p_accrual_date, 'yyyy-mm-dd') || chr(10) ||
                  'close_date   : '   || to_char(p_close_date, 'yyyy-mm-dd') || chr(10) ||
                   sqlerrm || chr(10) || dbms_utility.format_error_backtrace() ||
                              chr(10) || dbms_utility.format_call_stack());
           smb_deposit_utl.registration_calc_errors(
                                         p_object_id   => p_id
                                        ,p_action_type => $$plsql_unit||'.deposit_closing'
                                        ,p_error       => sqlerrm || chr(10)  || dbms_utility.format_error_backtrace());
           if p_silent_mode = 0 then raise_application_error(-20000, sqlerrm || chr(10)  || dbms_utility.format_error_backtrace()); end if;
    end;
                            
    -- закрытие депозита по сроку действия, только транши (???) в ДпТ expiry_date всегда null
    -- если депозит/счет заблокирован, то делаем начисления + выплаты + устанавливаем новую ставку - выходим без закрытия
    -- проблема в закрытии счетов, в день проводки нельзя закрывать счета
    procedure auto_deposit_closing(p_date in date)
     is
        l_end_date         date;
        l_interest_rate    number;
        l_is_blocking_err  number := 0;  
        
        procedure process_blocking(
                                   p_object_id         in number
                                  ,p_expiry_date       in date
                                  ,p_currency_id       in number
                                  ,p_is_capitalization in number  
                                  )
         is
            l_interest_rate    number;
            l_qty              number;
        begin
            l_is_blocking_err := 1;
            -- начисляем и выплачиваем по i.expiry_date
            -- начислить %
            select count(*)
              into l_qty
              from process p
             where p.object_id = p_object_id
               and p.process_type_id = g_process_processing_blocked;
            
            if l_qty > 0 then
                return;
            end if;      
            accrual_interest(
                           p_deposit_list => number_list(p_object_id)
                          ,p_start_date   => null
                          ,p_end_date     => p_expiry_date - 1
                          ,p_mode         => 1
                          ,p_silent_mode  => 0);
            -- перевести со счета начисленных на депозитный / для возврата
            payment_interest(p_deposit_list => number_list(p_object_id)
                            ,p_mode_payout  => p_is_capitalization
                            ,p_silent_mode  => 0);
            -- новая ставка                
            l_interest_rate := smb_deposit_utl.get_interest_rate_blocked(
                                        p_object_id   => p_object_id 
                                       ,p_date        => p_expiry_date
                                       ,p_currency_id => p_currency_id);
            if l_interest_rate is not null then                           
                -- устанавливаем с даты закрытия
                smb_deposit_utl.set_interest_rate_tranche(
                                     p_object_id     => p_object_id
                                    ,p_interest_rate => l_interest_rate
                                    ,p_valid_from    => p_expiry_date
                                    ,p_comment       => 'closing blocked deposit : '||p_object_id);
            end if;
            tools.hide_hint(
                 process_utl.process_create(
                                      p_proc_type_code    => smb_deposit_utl.PROCESS_PROCESSING_BLOCKED_DPT
                                     ,p_proc_type_module  => smb_deposit_utl.PROCESS_TRANCHE_MODULE
                                     ,p_process_name      => '[обработка заблокированного транша / счета]'
                                     ,p_process_data      => '<SMBDepositTranche><ActionDate>'||to_char(p_expiry_date, 'yyyy-mm-dd')||'</ActionDate>'||
                                                             '<InterestRate>'||l_interest_rate||'</InterestRate></SMBDepositTranche>'
                                     ,p_process_object_id => p_object_id));
        end;
    begin
        l_end_date := trunc(nvl(p_date, gl.bdate));
        -- не нужно устанавливать дату в последний день месяца
        /*
        if (l_end_date = dat_next_u( last_day(l_end_date) + 1, -1)) then
            -- дату устанавливаем в последний день месяца
            l_end_date := last_day(l_end_date);
        end if; */   
        logger.log_info(p_procedure_name => $$plsql_unit||'.auto_deposit_closing'
                                   ,p_log_message    => 'kf        : ' || bc.current_mfo || chr(10) ||
                                                        'bank date : ' || to_char(gl.bdate, 'yyyy-mm-dd') || chr(10) ||
                                                        'date      : ' || to_char(p_date, 'yyyy-mm-dd') || chr(10) ||
                                                        'calc date : ' || to_char(l_end_date, 'yyyy-mm-dd')); 
        -- может через bulk collect (???)
        for i in (select o.id object_id
                        ,t.is_prolongation
                        ,o.object_type_id
                        ,ot.type_code
                        -- заблокиирован транш или счет 
                        ,case when o.state_id = g_object_blocked_state_id or
                                   a.blkd > 0
                                then 1 
                         end is_blocked
                        ,t.currency_id
                        ,nvl(t.expiry_date_prolongation, d.expiry_date) expiry_date
                        ,t.last_accrual_date
                        ,t.is_capitalization
                    from object o
                        ,deal d
                        ,smb_deposit t
                        ,object_type ot
                        ,deal_account da
                        ,accounts a
                   where ot.id = g_tranche_object_type_id
                     and o.object_type_id = g_tranche_object_type_id
                     and o.id = d.id
                     -- -1 день - начисляем %, делаем все выплаты
                     -- день в день - закрываем счета и депозит
                     -- срок закрытия наступил, но был заблокирован счет/транш
                     -- после разблокировки счета, транши привязанные к этому счету будут закрыты, если истек срок 
                     and nvl(t.expiry_date_prolongation, d.expiry_date) <= l_end_date
                     and d.close_date is null
                     and o.id = t.id
                     and o.state_id in ( g_object_active_state_id, g_object_blocked_state_id)
                     and d.id = da.deal_id
                     and da.account_type_id = g_main_account_type_id
                     and a.acc = da.account_id
                    ) loop
            if i.is_prolongation = 1 then
                -- еще будут пролонгации, депозит не обрабатываем
                if smb_deposit_utl.get_remaining_prolongation(p_object_id => i.object_id) > 0 then
                    continue;
                end if;
            end if;
            begin
                l_is_blocking_err := 0;
                savepoint dpt_closing;
                -- в пролонгации ничего не меняем, когда то они закончатся и попадут в этот блок
                -- т.к. срок действия прошел начисления / выплаты % должны продолжаться согласно ТЗ 
                -- устанавливаем новую % ставку, если есть
                if i.is_blocked = 1 then
                    logger.log_info(p_procedure_name => $$plsql_unit||'.auto_deposit_closing blocked'
                                   ,p_log_message    => null
                                   ,p_object_id      => i.object_id); 
                    process_blocking(
                                   p_object_id         => i.object_id
                                  ,p_expiry_date       => i.expiry_date
                                  ,p_currency_id       => i.currency_id
                                  ,p_is_capitalization => i.is_capitalization);
                else     
                    deposit_closing (p_id            => i.object_id
                                    ,p_accrual_date  => l_end_date - 1
                                    ,p_close_date    => l_end_date
                                    ,p_silent_mode   => 0);
                end if;                    
            exception 
                when others then
                      rollback to dpt_closing;
                      -- произошла ошибка с в блоке начислений 
                      --   (блок закрытия пишет ошибки, чтобы не дублировать)
                      if l_is_blocking_err = 1 then
                         smb_deposit_utl.registration_calc_errors(
                                                       p_object_id   => i.object_id
                                                      ,p_action_type => $$plsql_unit||'.auto_deposit_closing'
                                                      ,p_error       => sqlerrm || chr(10)  || dbms_utility.format_error_backtrace());
                      elsif sqlerrm like '%\9301 - Broken limit on account%' then
                          begin  
                              -- установлен лимит по счету, установим новую % ставку для дальнейшего начисления % 
                              savepoint dpt_closing_2;   
                              process_blocking(
                                             p_object_id         => i.object_id
                                            ,p_expiry_date       => i.expiry_date
                                            ,p_currency_id       => i.currency_id
                                            ,p_is_capitalization => i.is_capitalization);
                              exception 
                                  when others then
                                     rollback to dpt_closing_2;
                                     smb_deposit_utl.registration_calc_errors(
                                                                   p_object_id   => i.object_id
                                                                  ,p_action_type => $$plsql_unit||'.auto_deposit_closing'
                                                                  ,p_error       => sqlerrm || chr(10)  || dbms_utility.format_error_backtrace());
                          end;              
                      end if;
                      bars_audit.error($$plsql_unit||'.auto_deposit_closing' || chr(10) ||
                              'object_id       : ' || i.object_id || chr(10) ||
                               sqlerrm || chr(10)  || dbms_utility.format_error_backtrace());
                                                      
            end;                
        end loop;            
    end; 

    -- ручное досрочное закрытие депозита ()
    --  нужно ли менять параметры счетов R011, ... (вызов smb_deposit_utl.set_parameter_deposit)
    procedure manual_deposit_closing(
                                p_id  in number)
     is
        l_object_row               object%rowtype;
        l_deposit_type_code        varchar2(50);
        l_deal_row                 deal%rowtype;
    begin
        if p_id is null then
            raise_application_error(-20000, 'Не вказано ідентифікатор депозиту');
        end if;
        l_object_row := object_utl.read_object(
                                        p_object_id => p_id
                                       ,p_raise_ndf => true);
        l_deposit_type_code := object_utl.get_object_type_code(p_object_type_id => l_object_row.object_type_id);
        if l_deposit_type_code not in (smb_deposit_utl.TRANCHE_OBJECT_TYPE_CODE
                                      ,smb_deposit_utl.ON_DEMAND_OBJECT_TYPE_CODE) then
           raise_application_error(-20000, 'Депозит не є "Строковим депозитом" або "Вкладом на вимогу"');                           
        end if;
        -- депозит должен быть в статусе ACTIVE -- (BLOCKED) (???)
        if l_object_row.state_id <> g_object_active_state_id then 
            raise_application_error(-20000, 'Закриття депозиту заборонено. Депозит в статусі { '||
                                             object_utl.get_object_state_name(p_state_id    => l_object_row.state_id)||' }');
        end if;
        l_deal_row := deal_utl.read_deal(p_deal_id => p_id);
        if l_deal_row.start_date > gl.bdate then
            raise_application_error(-20000, 'Закриття депозиту заборонено. Банківська дата менша ніж дата початку дії траншу');
        end if;
        deposit_closing (p_id            => p_id
                        ,p_accrual_date  => gl.bdate - 1
                        ,p_close_date    => gl.bdate
                        ,p_silent_mode   => 0);
    end;

    -- пролонгация депозита - только транши
    -- когда нужно запускать ??
    --   если транш сегодня заканчивается и у него есть пролонгация
    --    1. не конец месяца
    --       увеличиваем срок действия, меняем % ставку со следующего дня
    --         а. выходим без расчета %  -- наверное этот вариант
    --         б. запускаем расчет %
    --    2. последний день месяца
    --       увеличиваем срок действия, меняем % ставку со следующего дня
    --         а. запускаем расчет %

    procedure auto_deposit_prolongation(p_date in date)
     is
        l_date        date;
        l_expiry_date date;
    begin
        -- выбираем все не закрытые договора с пролонгацией
        l_date := trunc(nvl(p_date, gl.bdate));
        -- не нужно устанавливать дату в последний день месяца
        /*
        if (l_date = dat_next_u( last_day(l_date) + 1, -1)) then
            -- дату устанавливаем в последний день месяца
            l_date := last_day(l_date);
        end if;   */ 
        logger.log_info(p_procedure_name => $$plsql_unit||'.auto_deposit_prolongation start'
                                   ,p_log_message    => 'kf        : ' || bc.current_mfo || chr(10) ||
                                                        'bank date : ' || to_char(gl.bdate, 'yyyy-mm-dd') || chr(10) ||
                                                        'date      : ' || to_char(p_date, 'yyyy-mm-dd') || chr(10) ||
                                                        'calc date : ' || to_char(l_date, 'yyyy-mm-dd')
                                                        ); 
        for i in (select t.id
                        ,d.deal_number 
                        ,nvl(t.expiry_date_prolongation, d.expiry_date) expiry_date
                        ,t.last_accrual_date
                    from smb_deposit t
                        ,deal d
                        ,object o
                        ,customer c -- + policy
                   where t.is_prolongation = 1
                     and t.id = d.id
                     and nvl(t.expiry_date_prolongation, d.expiry_date) <= l_date
                     and d.close_date is null
                     and t.number_prolongation > nvl(t.current_prolongation_number, 0)
                     and d.id = o.id
                     and o.state_id in (g_object_active_state_id, g_object_blocked_state_id) 
                     and o.object_type_id = g_tranche_object_type_id
                     and d.customer_id = c.rnk
                  ) loop
            begin
                savepoint sp_deposit_prolongation_;  
                logger.log_info(p_procedure_name => $$plsql_unit||'.auto_deposit_prolongation'
                               ,p_log_message    => 'object_id : ' || i.id
                               ,p_object_id      => i.id                     
                               ,p_auxiliary_info => null
                                    );
                smb_deposit_utl.set_deposit_prolongation(p_object_id => i.id);
                -- если за выходные накопилось несколько 2 пролонгации
                loop
                    l_expiry_date := null;
                    select max(dpt.expiry_date_prolongation)
                      into l_expiry_date
                      from smb_deposit dpt
                     where dpt.id = i.id
                       and dpt.number_prolongation > nvl(dpt.current_prolongation_number, 0)    
                       and dpt.expiry_date_prolongation <= l_date;
                     if l_expiry_date is null then exit; end if;
                     smb_deposit_utl.set_deposit_prolongation(p_object_id => i.id);
                end loop;       
                -- начисление + выплата %%
                -- начислить %
                    select max(dpt.expiry_date_prolongation)
                      into l_expiry_date
                      from smb_deposit dpt
                     where dpt.id = i.id
                       and dpt.expiry_date_prolongation <= l_date;
                select max(expiry_date)
                  into l_expiry_date
                  from table(smb_deposit_utl.get_prolongation(p_deposit_id => i.id)) x
                 where expiry_date <= l_date; 
                accrual_interest(
                                 p_deposit_list => number_list(i.id)   
                                ,p_start_date   => null
                                ,p_end_date     => l_expiry_date - 1
                                ,p_mode         => 1
                                ,p_silent_mode  => 0);
                -- end if;                                                
                -- перевести со счета начисленных на депозитный
                payment_interest(p_deposit_list => number_list(i.id)
                                ,p_silent_mode  => 0);
                
            exception
               when others then
                    rollback to sp_deposit_prolongation_;
                    smb_deposit_utl.registration_calc_errors(
                                         p_object_id   => i.id
                                        ,p_action_type => $$plsql_unit||'.auto_deposit_prolongation'
                                        ,p_error       => sqlerrm || chr(10)  || dbms_utility.format_error_backtrace());
                    bars_audit.error( $$plsql_unit||'.auto_deposit_prolongation'||chr(10) ||
                                      'Помилка пролонгації # '||i.deal_number || chr(10) ||
                                      sqlerrm || chr(10)  || dbms_utility.format_error_backtrace());
            end;
        end loop;
    end;

    -- капитализация / стандартная выплата начисленных %, капитализация - только для траншей
    procedure auto_payment_accrued_interest(p_date in date)
     is
       /* ****       
          -- капитализация / стандартная выплата начисленных % происходит : (??)
          --  1. всегда в конце месяца/квартала
          --  2. всегда в начале (1-го числа) месяца/квартала (на следующий день после начисления)
          --  3. разнца между (датой начала)/(последней капитиализаций) и периодом капитализации = месяцу/кварталу 
          --     т.е. дата капитализации плавающая, зависит от даты начала действия (если депозит с 05.mm.yyyy то капит. 5 числа месяца/квартала) 
          --     тогда и дата расчета % должна быть в этот день (бред)
          -- как понимать поквартально
          --  1. это 90 дней от начала действия договора
          --  2. это 90 дней от начала года
       * */   
        l_end_date     date;
        l_deposit_list tt_deposit_calculator;
        l_dep_ids_list number_list;
        l_is_first_day number;
    begin
        logger.log_info(p_procedure_name => $$plsql_unit||'.auto_payment_accrued_interest start'
                                   ,p_log_message    => 'kf        : ' || bc.current_mfo || chr(10) ||
                                                        'bank date : ' || to_char(gl.bdate, 'yyyy-mm-dd') || chr(10) ||
                                                        'date      : ' || to_char(p_date, 'yyyy-mm-dd')); 
        l_end_date := trunc(case when p_date is null then gl.bdate else p_date end);
        -- 
        --  ищем предыдущую банковскую дату, если она в прошлом месяце, то это то что нужно
        if last_day(dat_next_u(l_end_date, -1)) + 1 <> trunc(l_end_date, 'month') then
           l_is_first_day := 0;
        else
           -- ежемесячно/ежеквартально
           l_is_first_day := 1;
        end if;
         -- определяем для каких депозитов нужна капитализация / стандартная выплата
        with tObj as(
                  select o.id
                        ,t.is_capitalization
                        ,t.last_accrual_date 
                        ,t.last_payment_date
                        ,d.start_date
                        ,t.frequency_payment
                        ,case when (t.is_capitalization = 1 -- капитализация
                                    or t.frequency_payment <> 3) -- стандартная выплата (1 - месяц / 2 - квартал
                              then 1      
                              else 0
                         end is_payment
                        ,t.is_prolongation 
                        ,da.account_id
                    from object o
                        ,smb_deposit t
                        ,deal d
                        ,deal_account da
                        ,customer c -- + policy
                   where 1 = 1
                     and t.id = o.id  
                     and o.object_type_id in (g_tranche_object_type_id, g_main_account_type_id)
                     and o.id = d.id 
                     and o.state_id in (g_object_active_state_id, g_object_blocked_state_id) 
                     and o.id = d.id
                     and d.id = da.deal_id
                     and da.account_type_id = g_main_account_type_id
                     and d.close_date is null
                     and t.last_accrual_date is not null
                     and d.customer_id = c.rnk)
            select t_deposit_calculator(
                            id                 => t.id
                           ,account_id         => t.account_id 
                           ,start_date         => null
                           ,end_date           => null
                           ,amount_deposit     => null
                           ,amount_for_accrual => null
                           ,interest_rate      => null
                           ,interest_amount    => null
                           ,interest_tail      => null
                           ,accrual_method     => null
                           ,currency_id        => null
                           ,comment_           => case when t.is_capitalization = 1 then '1' else '0' end)
              bulk collect into l_deposit_list
              from(
                   select id
                         ,is_capitalization
                         ,account_id
                     from tObj t
                    where 1 = 1       
                       -- ответ от банкак (??) - в конце месяца, если пришел срок
                       --    для первой оплаты берем последний день предыдущего месяца от даты начала действия депозита
                      and (-- ежемесячно/ежеквартально
                          (   l_is_first_day = 1 
                          and is_payment = 1
                          and ceil(months_between(l_end_date, nvl(t.last_payment_date, trunc(t.start_date, 'month') - 1)))
                              >= case when t.frequency_payment = 2 then 3 else 1 end)
                        or (  t.is_prolongation = 1
                            -- была пролонгация на выходных (???)
                          and exists(
                                     select null
                                       from table(smb_deposit_utl.get_prolongation(p_deposit_id => t.id)) x
                                      where t.last_accrual_date between x.start_date and x.expiry_date
                                        and t.last_accrual_date > nvl(t.last_payment_date, t.start_date))
                           ))) t   
               ;

        logger.log_info(p_procedure_name => $$plsql_unit||'.auto_payment_accrued_interest'
                       ,p_log_message    => 'кол-во документов на выплату : '||l_deposit_list.count() || chr(10) ||
                                            'is_first_day : '|| l_is_first_day    
                                );
        -- проверить когда начислялись %, если нужно то доначислить  
        -- TODO (?)
        -- перевести со счета начисленных на депозитный / для возврата 
        logger.log_info(p_procedure_name => $$plsql_unit||'.auto_payment_accrued_interest start'
                                   ,p_log_message    => 'calc date  : ' || to_char(l_end_date, 'yyyy-mm-dd')); 
        if l_deposit_list.count() <> 0 then
            -- капитализация
            select id 
              bulk collect into l_dep_ids_list
              from table(l_deposit_list)
             where comment_ = '1';
            logger.log_info(p_procedure_name => $$plsql_unit||'.auto_payment_accrued_interest',
                                p_log_message    => 'кол-во документов на капитализацию : '||l_dep_ids_list.count()
                                );
            if l_dep_ids_list.count() <> 0 then
                payment_interest(p_deposit_list => l_dep_ids_list
                                ,p_mode_payout  => 1 -- капитализация
                                 ); 
            end if;                     
            -- стандартная выплата                 
            select id 
              bulk collect into l_dep_ids_list
              from table(l_deposit_list)
             where comment_ = '0';
            logger.log_info(p_procedure_name => $$plsql_unit||'.auto_payment_accrued_interest',
                                p_log_message    => 'кол-во документов на выплату : '||l_dep_ids_list.count()
                                );
            if l_dep_ids_list.count() <> 0 then
                payment_interest(p_deposit_list => l_dep_ids_list
                                 ,p_mode_payout => 0 -- стандартная выплата
                                 ); 
            end if;
        end if;
    end; 
    
    -- попытка перевести деньги со счета для списания на депозитный счет
    -- т.е. если денег не  достаточно на счету для списания, когда БО подтверждал депозит
    -- выполняется по закрытию банковского дня (???)
    procedure transfer_funds_failed_deposit
     is
        l_comment_text varchar2(4000);
    begin
        -- вибираем инвалидные процессы
        for i in (
                  select p.id process_id, p.process_type_id, p.object_id, a.id activity_id
                    from process p
                        ,activity a  
                        ,activity_history h
                        ,object o  
                        ,deal d
                        -- + policy
                        ,customer c
                   where 1 = 1 
                     and p.process_type_id in (g_process_tranche, g_process_on_demand, g_process_replenishment)
                     and p.object_id = o.id 
                     and o.state_id = g_object_created_state_id
                     and p.state_id = process_utl.GC_PROCESS_STATE_FAILURE
                     and p.id = a.process_id
                     and a.state_id = process_utl.ACT_STATE_FAILED
                     and a.id = h.activity_id
                     and h.activity_state_id = process_utl.ACT_STATE_FAILED
                     and o.id = d.id
                     and d.customer_id = c.rnk
                     and h.comment_text like '%'||smb_deposit_utl.ERR_NOT_ENOUGH_MONEY||'%'
                  group by p.id, p.process_type_id, p.object_id, a.id
                  ) loop
                  logger.log_info(p_procedure_name => $$plsql_unit||'.transfer_funds_failed_deposit',
                                p_log_message    => 'deposit_id      : '||i.object_id    || chr(10) ||
                                                    'process_type_id : '||i.process_type_id || chr(10) ||
                                                    'activity_id     : '||i.activity_id );
                  begin                                  
                      process_utl.activity_run(p_activity_id  => i.activity_id
                                              ,p_silent_mode  => true);
                      -- если процесс не в статусе FAILED, то деньги провелись                        
                      -- иначе проверяем ошибку и удаляем депозит
                      l_comment_text := smb_deposit_utl.get_last_error_on_process(p_process_id => i.process_id);
                      logger.log_info(p_procedure_name => $$plsql_unit||'.transfer_funds_failed_deposit',
                                            p_log_message    => 'deposit_id    : '||i.object_id    || chr(10) ||
                                                                'comment_text  : '||l_comment_text );

                      -- ожидаемая ошибка - не достаточно денег на счету
                      -- переводим депозит в удаленный (???)
                      if l_comment_text like '%'||smb_deposit_utl.ERR_NOT_ENOUGH_MONEY||'%' then
                          -- если это не пополнение
                          if i.process_type_id <> g_process_replenishment then
                              -- закрываем депозитные / %% счета 
                              close_deposit_account(p_id   => i.object_id);
                              -- устанавливаем object -> state в DELETED
                              object_utl.set_object_state(
                                                  p_object_id  => i.object_id
                                                 ,p_state_code => 'DELETED'); 
                              -- установить дату закрытия              
                              deal_utl.set_deal_close_date(
                                        p_deal_id    => i.object_id
                                       ,p_close_date => gl.bdate
                                       ,p_comment    => l_comment_text);
                          end if;                   
                          -- устанавливаем process state в DISCARD
                          process_utl.set_process_state_id(
                                            p_process_id  => i.process_id
                                           ,p_value       => process_utl.GC_PROCESS_STATE_DISCARD
                                           );
                          smb_deposit_utl.set_process_info(
                                            p_process_id  => i.process_id
                                           ,p_info        => l_comment_text);
                      else
                          -- деньги первелись все хорошо ?                  
                          null;   
                      end if;
                  end;                         
        end loop;          

    end;
    
    --  блокировка депозитного транша
    --  p_lock_type_id тип блокировки :
    --    1  -  (smb_deposit_utl.LOCK_ARREST_ID)        блокировка в связи с арестом по решению суда/исполнительной службы – не требует использования транзитного счета
    --    2  -  (smb_deposit_utl.LOCK_DPT_ON_CREDIT_ID) блокировка в связи с обеспечением депозита по кредиту – требует использования транзитного счета 
    --                    (предварительно 3739 – который используется при продукте - залог имущественных прав)
    procedure blocking_deposit (
                               p_id         in number 
                              ,p_process_id in number)
     is
        l_object_row           object%rowtype;
        l_blocking_tranche_row smb_deposit_utl.c_tranche_from_xml%rowtype;
        l_amount               number;
        l_account_id           number;
        l_blkd                 number;
        l_register_value       number;
    begin
        smb_deposit_utl.check_deposit_type(
                              p_object_id               => p_id
                             ,p_target_object_type_code => smb_deposit_utl.TRANCHE_OBJECT_TYPE_CODE);
        l_object_row := object_utl.read_object(p_object_id => p_id);
        if l_object_row.state_id <> g_object_active_state_id then
            raise_application_error(-20000, 'Блокування траншу заборонено. Транш  в стані {'||
                                 object_utl.get_object_state_name(p_state_id => l_object_row.state_id)||'}');
        end if;
        l_blocking_tranche_row := smb_deposit_utl.get_tranche_from_xml(p_process_id => p_process_id);
        if l_blocking_tranche_row.lock_tranche_id = smb_deposit_utl.LOCK_ARREST_ID then
            -- какую сумму блокировать (???)
            -- сумму депозита + пополнений, или еще с учетом капитализации 
            --   пока сумму депозита + пополнений
            select sum(case when v.register_type_id = g_reg_trn_principal_type_id then h.amount end) - 
                   -- минус капитализация
                   nvl(sum(case when v.register_type_id = g_reg_trn_paid_int_type_id and t.is_capitalization = 1
                               then h.amount 
                           end), 0)         
              into l_amount
              from smb_deposit t
                  ,register_value v
                  ,register_history h
             where t.id = p_id
               and t.id = v.object_id
               and v.register_type_id in (g_reg_trn_principal_type_id, g_reg_trn_paid_int_type_id) --   капитализация 
               and h.register_value_id = v.id
               and h.is_active = 'Y'
               and h.is_planned = 'N'; -- берем только не плановые суммы и активные
            if l_amount > 0 then
                select da.account_id
                  into l_account_id     
                  from deal_account da
                 where 1 = 1
                   and da.deal_id = p_id
                   and da.account_type_id = g_main_account_type_id;
                -- trigger tiu_blkd11 - занятное чтиво (???)
                --    кратко : 1) при аресте расчет % прекращается (т.е. наверное нужно установить % ставку в 0)
                --           : 2) после снятия ареста вернуть ставку обратно
                --           : 3) что делать если депозит с пролонгацией
                --           : 4) при досрочном закрытии, по штрафное ставке начислять ли % за период ареста  
                l_blkd := 11; -- Заарештувати частково
                update accounts set
                       lim  = lim - l_amount
                      ,blkd = l_blkd
                 where acc = l_account_id
                   and dazs is null;

                l_register_value := null;                       
                -- запишем заблокированную сумму в регистр
                tools.hide_hint(
                    register_utl.cor_register_value(
                                   p_register_value_id => l_register_value
                                  ,p_object_id         => p_id
                                  ,p_register_code     => register_utl.SMB_BLOCKED_AMOUNT_CODE
                                  ,p_plan_value        => l_amount
                                  ,p_value             => l_amount
                                  ,p_date              => l_blocking_tranche_row.action_date
                                  ,p_currency_id       => l_blocking_tranche_row.currency_id
                                  ,p_is_planned        => 'N'));
                
                logger.log_info(p_procedure_name => $$plsql_unit||'.blocking_deposit',
                                p_log_message    => 'deposit_id : '||p_id    || chr(10) ||
                                                    'amount     : '||l_amount|| chr(10) || 
                                                    'blkd       : '||l_blkd);
            end if;   
        end if;
        -- если l_tranche_row.lock_tranche_id = 1 
        --    блокировка в связи с арестом по решению суда/исполнительной службы – не требует использования транзитного счета, 
        --    установить accounts.lim = lim - sum_deposit
        -- установить на сумму депозита + пополнений, или еще с учетом капитализации
        -- если l_tranche_row.lock_tranche_id = 2  то требует использования транзитного счета 
        --    блокировка в связи с обеспечением депозита по кредиту – требует использования транзитного счета 
        --    (предварительно 3739 – который используется при продукте - залог имущественных прав)
    end; 

    --  разблокировка депозитного транша
    procedure unblocking_deposit (p_id         in number
                                 ,p_process_id in number)
     is
        l_object_row             object%rowtype;
        l_amount                 number;
        l_account_id             number;
        l_blkd                   number;
        l_lock_type_id           number;
        l_register_value         number;
        l_expiry_date            date;
        l_unblocking_tranche_row smb_deposit_utl.c_tranche_from_xml%rowtype;
        l_qty                    number;
    begin
        smb_deposit_utl.check_deposit_type(
                              p_object_id               => p_id
                             ,p_target_object_type_code => smb_deposit_utl.TRANCHE_OBJECT_TYPE_CODE);
        l_object_row := object_utl.read_object(p_object_id => p_id);
        if l_object_row.state_id <> g_object_blocked_state_id then
            raise_application_error(-20000, 'Розблокування траншу заборонено. Транш  в стані {'||
                                 object_utl.get_object_state_name(p_state_id => l_object_row.state_id)||'}');
        end if;
        l_unblocking_tranche_row := smb_deposit_utl.get_tranche_from_xml(p_process_id => p_process_id);
        -- выбираем последнюю блокировку по траншу
        select max(lock_type_id) keep (dense_rank first order by x.action_date desc, p.id desc)
          into l_lock_type_id
          from process_type pt
              ,process p
              ,xmltable ('/SMBDepositTranche' passing xmltype(p.process_data) columns
                             action_date            date           path 'ActionDate'
                            ,lock_type_id           number         path 'LockTrancheId') x
         where pt.process_code = smb_deposit_utl.PROCESS_TRANCHE_BLOCKING
           and p.object_id = p_id
           and p.process_type_id = pt.id
           and x.action_date <= l_unblocking_tranche_row.action_date;
        if l_lock_type_id not in (smb_deposit_utl.LOCK_ARREST_ID, smb_deposit_utl.LOCK_DPT_ON_CREDIT_ID) then 
            raise_application_error(-20000, 'Розблокування траншу заборонено. Не знайдено тип блокування');
        end if;   
        if l_lock_type_id = smb_deposit_utl.LOCK_ARREST_ID then
            -- берем заблокированную сумму
            select sum(v.actual_value)
              into l_amount
              from register_value v
             where v.object_id = p_id
               and v.register_type_id = g_reg_blocked_amount_type_id;
            if l_amount > 0 then
                select da.account_id, a.blkd
                  into l_account_id, l_blkd     
                  from deal_account da
                      ,accounts a 
                 where 1 = 1
                   and da.deal_id = p_id
                   and da.account_type_id = g_main_account_type_id
                   and da.account_id = a.acc;
                -- поиск траншей по этому клиенту
                --  может быть заблокировано несколько траншей
                --  если есть другой заблокированный транш
                --  то работаем только с лимитом, блокировку не снимаем 
                select count(*)
                  into l_qty
                  from deal d
                      ,deal d2 
                      ,object o
                 where d.id = p_id
                   and d.customer_id = d2.customer_id
                   and d2.id = o.id
                   and d2.id <> p_id
                   and o.state_id = g_object_blocked_state_id
                   and o.object_type_id = g_tranche_object_type_id;     
                if l_qty = 0 then   
                    l_blkd := 0; -- разблокировать
                end if;
                update accounts a set
                       lim  = a.lim + l_amount
                      ,blkd = l_blkd
                 where a.acc = l_account_id
                   and a.dazs is null;
                l_register_value := null;                       
                -- спишем заблокированную сумму с регистра
                tools.hide_hint(
                    register_utl.cor_register_value(
                                   p_register_value_id => l_register_value
                                  ,p_object_id         => p_id
                                  ,p_register_code     => register_utl.SMB_BLOCKED_AMOUNT_CODE
                                  ,p_plan_value        => -1 * l_amount
                                  ,p_value             => -1 * l_amount
                                  ,p_date              => l_unblocking_tranche_row.action_date
                                  ,p_currency_id       => l_unblocking_tranche_row.currency_id
                                  ,p_is_planned        => 'N'));
                

                logger.log_info(p_procedure_name => $$plsql_unit||'.unblocking_deposit',
                                p_log_message    => 'deposit_id : '||p_id    || chr(10) ||
                                                    'amount     : '||-1 * l_amount|| chr(10) || 
                                                    'blkd       : '||l_blkd);
            end if;   
        end if;
           -- установливаем объект Активным
        object_utl.set_object_state(
                              p_object_id  => p_id
                             ,p_state_code => 'ACTIVE'
                                        );
        -- проверим срок действия транша, если прошел - закрываем
        -- если еще есть пролонгации выходим
        if smb_deposit_utl.get_remaining_prolongation(p_object_id => p_id) > 0 then
            return; 
        end if;
        select nvl(t.expiry_date_prolongation, d.expiry_date)
          into l_expiry_date     
          from smb_deposit t
              ,deal d
         where t.id = p_id
           and t.id = d.id; 
        if l_expiry_date <= l_unblocking_tranche_row.action_date then
            -- закрываем   
            deposit_closing (p_id            => p_id
                            ,p_accrual_date  => l_unblocking_tranche_row.action_date - 1
                            ,p_close_date    => l_unblocking_tranche_row.action_date
                            ,p_silent_mode   => 0);
        end if; 
    end; 

    -- отчет по депозитам Додаток-1                             
    -- p_type_deposit
       -- 1 - Короткострокові (транш), 2 - Довгострокові (ДпТ), 0 - все
    function get_deposit_info(
                              p_start_date   in date
                             ,p_end_date     in date
                             ,p_term_deposit in number default 0
                             ,p_mfo_code     in varchar2 default null
                             ,p_type_deposit in number default 0)
          return tt_smb_report pipelined
     is
        l_cursor                 sys_refcursor;
        l_smb_report             tt_smb_report;
        l_end_date               date := nvl(p_end_date, gl.bdate);
        l_on_demand_kind_type_id number;
    begin
        select max(id)
          into l_on_demand_kind_type_id
          from deal_interest_rate_kind irk
         where irk.kind_code = 'SMB_ON_DEMAND_GENERAL';

        open l_cursor for
        with obj_ as(
                   select --+ monitor ++get_deposit_info++ 
                         o.id
                        ,o.state_id    
                        ,a.kv currency_id 
                        ,d.start_date
                        ,d.expiry_date
                        ,da.account_id
                        ,o.object_type_id
                        ,a.nls
                        ,d.customer_id
                        ,crn.denom
                        ,crn.lcv
                        ,c.nmk
                        ,c.okpo
                        ,os.state_name
                        ,d.branch_id
                        ,mfo.name branch_name
                        ,a.ostc
                        ,a.dapp
                        ,d.deal_number
                        ,a.kf mfo_code
                    from object o
                        ,object_state os
                        ,deal d
                        ,deal_account da
                        ,accounts a
                        ,tabval$global crn
                        ,customer c
                        ,branch b
                        ,branch mfo
                   where 1 = 1
                     and o.object_type_id in (g_tranche_object_type_id, g_dod_object_type_id) 
                     and o.state_id in (g_object_active_state_id, g_object_blocked_state_id)
                     and o.state_id = os.id 
                     and o.id = d.id 
                     and o.id = da.deal_id 
                     and da.account_type_id = g_main_account_type_id
                     and da.account_id = a.acc 
                     and a.kv = crn.kv
                     and d.customer_id = c.rnk
                     and d.branch_id = b.branch
                     and '/'||a.kf||'/' = mfo.branch
                     and (p_mfo_code is null or
                          p_mfo_code = a.kf)
                     and case when p_type_deposit = 0 then 1     
                              when p_type_deposit = 1 and o.object_type_id = g_tranche_object_type_id then 1
                              when p_type_deposit = 2 and o.object_type_id = g_dod_object_type_id then 1
                         end = 1)
        ,tranche as (
                select o.*
                       -- текущая % ставка
                      ,(select max(a.number_value) keep (dense_rank first order by a.value_date desc) 
                        from attribute_value_by_date a    
                       where a.attribute_id = g_trn_attr_interest_rate_id
                         and a.object_id = o.id
                         and a.value_date <= l_end_date) current_interest_rate
                    ,t.is_prolongation
                    ,t.is_replenishment_tranche
                    ,t.prolongation_interest_rate
                    -- сумма на дату начала
                    ,nvl((
                      select sum(h.amount) amount
                        from register_history h
                       where h.register_value_id = v.id
                         and h.is_active = 'Y'
                         and h.is_planned = 'N' -- берем только не плановые суммы и активные
                         and h.value_date <= greatest(start_date, p_start_date)) / o.denom, 0) amount_on_start_date
                     -- сумма на дату окончания
                    ,nvl((
                      select sum(h.amount) amount
                        from register_history h
                       where h.register_value_id = v.id
                         and h.is_active = 'Y'
                         and h.is_planned = 'N' -- берем только не плановые суммы и активные
                         and h.value_date <= l_end_date) / o.denom, 0) amount_on_end_date
                    ,t.general_interest_rate
                    ,t.bonus_interest_rate
                    ,nvl(t.capitalization_interest_rate, 0) + 
                     nvl(t.payment_interest_rate, 0) + 
                     nvl(t.replenishment_interest_rate, 0) interest_rate_add_bonus
                    ,t.amount_tranche / o.denom amount_tranche
                    ,t.expiry_date_prolongation
                  from obj_ o
                      ,register_value v
                      ,smb_deposit t
                where o.object_type_id = g_tranche_object_type_id
                  and  o.id = v.object_id
                  and v.register_type_id = g_reg_trn_principal_type_id
                  and o.id = t.id
                  and case when p_term_deposit = 0 then p_term_deposit
                           when months_between(nvl(t.expiry_date_prolongation, o.expiry_date), start_date) <= 1 then 1
                           when months_between(nvl(t.expiry_date_prolongation, o.expiry_date), start_date) > 12 then 13  -- больше года ставлю 13
                           else ceil(months_between(nvl(t.expiry_date_prolongation, o.expiry_date), start_date) / 3) * 3 -- тут будет 3 6 9 12
                      end = p_term_deposit 
                  )
        ,dod as(
              select x.*
                     -- установлена индивидуальная ставка - берем ее  
                    ,case when is_individual_rate = 1 then   
                              (select max(a.number_value) keep (dense_rank first order by a.value_date desc) 
                                from attribute_value_by_date a    
                               where a.attribute_id = g_dod_attr_interest_rate_id
                                 and a.object_id = x.id
                                 and a.value_date <= l_end_date)
                          else        
                              -- вычисляем от суммы по справочнику           
                              (select min(c.interest_rate) keep (dense_rank first order by c.amount_from desc, o.valid_from desc) 
                                  from deal_interest_option o
                                      ,deposit_on_demand_condition c
                                 where o.rate_kind_id = l_on_demand_kind_type_id 
                                   and c.interest_option_id = o.id 
                                   and c.currency_id = x.currency_id
                                   -- % ставку берем на дату начала действия ДпТ
                                   and o.valid_from <= x.start_date  --- l_end_date
                                   and c.amount_from <= x.amount_on_end_date
                                   and o.is_active = 1)
                     end current_interest_rate
                from( 
                    select o.*
                          ,(o.ostc -
                           nvl( 
                            case when greatest(o.start_date, p_start_date) < o.dapp then
                               (select sum(s.kos - s.dos)    
                                  from saldoa s
                                 where s.acc = o.account_id
                                   and s.fdat > greatest(o.start_date, p_start_date))
                            end, 0)) / o.denom amount_on_start_date
                          ,(o.ostc -
                           nvl( 
                            case when l_end_date < o.dapp then
                               (select sum(s.kos - s.dos)    
                                  from saldoa s
                                 where s.acc = o.account_id
                                   and s.fdat > l_end_date)
                            end, 0)) / o.denom amount_on_end_date
                          ,t.is_individual_rate  
                      from obj_ o
                          ,smb_deposit t
                     where o.object_type_id = g_dod_object_type_id 
                       and o.id = t.id    
                       and p_term_deposit = 0) x)
        select x.*
              ,(select n.value from customerw n where x.customer_id = n.rnk and n.tag = 'NDBO')    contract_number
              ,(select n.value from customerw n where x.customer_id = n.rnk and n.tag = 'DDBO')    contract_date
              -- 1 - Короткострокові, 2 - Довгострокові
              ,case when x.object_type_id = g_tranche_object_type_id then 1 else 2 end is_short_term
              ,case when x.object_type_id = g_tranche_object_type_id 
                    then case when months_between(expiry_date, start_date) <= 1 then 1
                              when months_between(expiry_date, start_date) > 12 then 13  -- больше года ствлю 13
                              else ceil(months_between(expiry_date, start_date) / 3) * 3 -- тут будет 3 6 9 12
                          end 
                end term_deposit
          from(                                                         
            select id, nls account_number, lcv, currency_id, start_date, nvl(expiry_date_prolongation, expiry_date) expiry_date, amount_tranche, state_name, customer_id, okpo, nmk customer_name, branch_id, branch_name
                  ,general_interest_rate, interest_rate_add_bonus, bonus_interest_rate, current_interest_rate, is_prolongation, is_replenishment_tranche, prolongation_interest_rate
                  ,amount_on_start_date, amount_on_end_date, amount_on_end_date - amount_on_start_date difference_amounts, account_id, object_type_id, state_id, deal_number, mfo_code    
              from tranche
            union all
            select id, nls account_number, lcv, currency_id, start_date, expiry_date, null amount_tranche, state_name, customer_id, okpo, nmk customer_name, branch_id, branch_name
                  ,null interest_rate_general, null interest_rate_add_bonus, null interest_rate_bonus, current_interest_rate, null is_prolongation, null is_replenishment_tranche, null prolongation_interest_rate
                  ,amount_on_start_date, amount_on_end_date, amount_on_end_date - amount_on_start_date difference_amounts, account_id, object_type_id, state_id, deal_number, mfo_code
              from dod) x;
        loop
            fetch l_cursor bulk collect into l_smb_report limit 1000;
            exit when l_smb_report.count = 0;
            for i in 1..l_smb_report.count loop
                 pipe row (l_smb_report(i));
            end loop;
        end loop;
        close l_cursor;
        return;
    end;      
    
    function get_auto_close_deposit(p_start_date   in date
                                   ,p_end_date     in date
                                   ,p_deposit_type_id in number)
          return tt_smb_auto_report
     is
        l_result tt_smb_auto_report;
    begin
        select --+ get_auto_close_deposit
               o.id             -- id             
              ,d.deal_number    -- deposit_number 
              ,a.nls            -- account_number 
              ,crn.lcv          -- lcv            
              ,c.nmk            -- customer_name  
              ,c.okpo           -- okpo           
              ,null             -- ref_           
              ,null             -- document_amount
              ,null             -- comment_text   
              ,a.kv             -- currency_id 
              ,b.branch               -- branch_id
              ,b.name          -- branch_name
              ,null
              ,null
          bulk collect into l_result        
          from object o
              ,object_state os
              ,deal d
              ,deal_account da
              ,accounts a
              ,tabval$global crn
              ,customer c
              ,branch b
         where 1 = 1
           and o.object_type_id = p_deposit_type_id
           and o.state_id = g_object_closed_state_id
           and o.state_id = os.id 
           and o.id = d.id 
           and o.id = da.deal_id 
           and da.account_type_id = g_main_account_type_id
           and da.account_id = a.acc 
           and a.kv = crn.kv
           and d.customer_id = c.rnk
           and d.close_date between p_start_date and p_end_date
           and d.branch_id = b.branch;
        return l_result;
    end get_auto_close_deposit; 

    --  отчет 7603 (REP7603.frx)
    function get_auto_accrued_interest(p_start_date   in date
                                      ,p_end_date     in date
                                      ,p_deposit_type_id in number)
          return tt_smb_auto_report
     is
        l_result                 tt_smb_auto_report;
        l_reg_int_amount_type_id number;
    begin     
        l_reg_int_amount_type_id := case when p_deposit_type_id = g_tranche_object_type_id 
                                         then g_reg_trn_int_amount_type_id
                                         else g_reg_dod_int_amount_type_id
                                    end; 
        with accrued_interest as(
                select o.id, h.document_id, sum(h.amount) amount 
                  from register_value v
                      ,register_history h
                      ,object o
                 where v.register_type_id = l_reg_int_amount_type_id
                   and v.id = h.register_value_id
                   and h.value_date between p_start_date and p_end_date
                   and h.is_active = 'Y'
                   and h.is_planned = 'N'
                   and o.id = v.object_id
                   and o.object_type_id = p_deposit_type_id
                   and h.amount > 0
                group by o.id, h.document_id)
          select                
                 ai.id                  -- id             
                ,d.deal_number          -- deposit_number 
                ,a.nls                  -- account_number 
                ,crn.lcv                -- lcv            
                ,c.nmk                  -- customer_name  
                ,c.okpo                 -- okpo           
                ,ai.document_id         -- ref_           
                ,ai.amount / crn.denom  -- document_amount
                ,null                   -- comment_text   
                ,a.kv                   -- currency_id 
                ,b.branch               -- branch_id
                ,b.name          -- branch_name
                ,null
                ,null
            bulk collect into l_result
            from accrued_interest ai
                ,deal d  
                ,deal_account da
                ,accounts a
                ,tabval$global crn
                ,customer c
                ,branch b
           where ai.id = d.id
             and d.id = da.deal_id      
             and da.account_type_id = g_main_account_type_id
             and da.account_id = a.acc
             and a.kv = crn.kv
             and d.customer_id = c.rnk
             and d.branch_id = b.branch; 
       return l_result;
    end get_auto_accrued_interest;

    function get_auto_prolongation(p_start_date   in date
                                  ,p_end_date     in date)
          return tt_smb_auto_report
     is
        l_result                 tt_smb_auto_report;
    begin     
        with prolong_ as(
                  select p.id
                        ,x.start_date
                        ,x.expiry_date
                    from(  
                        select o.id, p.process_data 
                          from process p
                              ,object o
                         where p.process_type_id = g_process_prolongation 
                           and p.object_id = o.id
                           and o.object_type_id = g_tranche_object_type_id
                           and p.state_id = process_utl.GC_PROCESS_STATE_SUCCESS
                        ) p
                        ,xmltable('/SMBDepositProlongation' passing xmltype(p.process_data) columns
                            start_date   date path 'StartDate' 
                           ,expiry_date  date path 'ExpiryDate' ) x
                   where x.start_date between p_start_date and p_end_date         
                        )
            select                
                   o.id             -- id             
                  ,d.deal_number    -- deposit_number 
                  ,a.nls            -- account_number 
                  ,crn.lcv          -- lcv            
                  ,c.nmk            -- customer_name  
                  ,c.okpo           -- okpo           
                  ,null             -- ref_           
                  ,null             -- document_amount
                  ,null             -- comment_text   
                  ,a.kv             -- currency_id 
                  ,b.branch               -- branch_id
                  ,b.name          -- branch_name
                  ,o.start_date
                  ,o.expiry_date
              bulk collect into l_result
              from prolong_ o
                  ,deal d  
                  ,deal_account da
                  ,accounts a
                  ,tabval$global crn
                  ,customer c
                  ,branch b
             where o.id = d.id
               and d.id = da.deal_id      
               and da.account_type_id = g_main_account_type_id
               and da.account_id = a.acc
               and a.kv = crn.kv
               and d.customer_id = c.rnk
               and d.branch_id = b.branch; 

       return l_result;
    end get_auto_prolongation;
   
    function get_auto_interest_payment(p_start_date   in date
                                      ,p_end_date     in date)
          return tt_smb_auto_report
     is   
        l_result                 tt_smb_auto_report;
    begin     
        with accrued_interest as(
                select o.id, h.document_id, sum(h.amount) amount 
                  from register_value v
                      ,register_history h
                      ,object o
                 where v.register_type_id in  (g_reg_trn_paid_int_type_id, g_reg_dod_paid_int_type_id)
                   and v.id = h.register_value_id
                   and h.value_date between p_start_date and p_end_date
                   and h.is_active = 'Y'
                   and h.is_planned = 'N'
                   and o.id = v.object_id
                   and o.object_type_id in (g_tranche_object_type_id, g_dod_object_type_id)
                   and h.amount > 0
                group by o.id, h.document_id)
          select                
                 ai.id                  -- id             
                ,d.deal_number          -- deposit_number 
                ,a.nls                  -- account_number 
                ,crn.lcv                -- lcv            
                ,c.nmk                  -- customer_name  
                ,c.okpo                 -- okpo           
                ,ai.document_id         -- ref_           
                ,ai.amount / crn.denom  -- document_amount
                ,null                   -- comment_text   
                ,a.kv                   -- currency_id 
                ,b.branch               -- branch_id
                ,b.name                 -- branch_name
                ,null
                ,null
            bulk collect into l_result
            from accrued_interest ai
                ,deal d  
                ,deal_account da
                ,accounts a
                ,tabval$global crn
                ,customer c
                ,branch b
           where ai.id = d.id
             and d.id = da.deal_id      
             and da.account_type_id = g_main_account_type_id
             and da.account_id = a.acc
             and a.kv = crn.kv
             and d.customer_id = c.rnk
             and d.branch_id = b.branch; 
       return l_result;
    end get_auto_interest_payment;

    function get_auto_report(
                              p_report_type  in varchar2
                             ,p_start_date   in date
                             ,p_end_date     in date)
          return tt_smb_auto_report pipelined
     is
        l_start_date date := nvl(p_start_date, gl.bdate);
        l_end_date   date := nvl(p_end_date, l_start_date);
        l_report     tt_smb_auto_report;
    begin 
        case p_report_type
           when CLOSED_TRANCHE_REPORT then 
                l_report := get_auto_close_deposit(
                                               p_start_date       => l_start_date
                                              ,p_end_date         => l_end_date
                                              ,p_deposit_type_id => g_tranche_object_type_id);
           when CLOSED_DOD_REPORT then 
                l_report := get_auto_close_deposit(
                                               p_start_date       => l_start_date
                                              ,p_end_date         => l_end_date
                                              ,p_deposit_type_id => g_dod_object_type_id);
           when ACCRUED_INT_TRANCHE_REPORT then
                l_report := get_auto_accrued_interest(
                                               p_start_date       => l_start_date
                                              ,p_end_date         => l_end_date
                                              ,p_deposit_type_id => g_tranche_object_type_id);
           when ACCRUED_INT_DOD_REPORT then
                l_report := get_auto_accrued_interest(
                                               p_start_date       => l_start_date
                                              ,p_end_date         => l_end_date
                                              ,p_deposit_type_id => g_dod_object_type_id);
           when PROLONGATION_TRANCHE_REPORT then 
                l_report := get_auto_prolongation(
                                               p_start_date       => l_start_date
                                              ,p_end_date         => l_end_date);
           when INTEREST_PAYMENT_REPORT then 
                l_report := get_auto_interest_payment(
                                               p_start_date       => l_start_date
                                              ,p_end_date         => l_end_date);
           else l_report := tt_smb_auto_report();                                        
        end case;
        for i in 1..l_report.count loop
            pipe row(l_report(i));
        end loop;
        return;
    end;

    function get_report_3a(p_date in date)
          return tt_smb_report_3a pipelined
     is
        l_date date              := nvl(p_date, gl.bdate);
        l_cursor                 sys_refcursor;
        l_smb_report             tt_smb_report_3a;
        l_on_demand_kind_type_id number;
    begin
        select max(id)
          into l_on_demand_kind_type_id
          from deal_interest_rate_kind irk
         where irk.kind_code = 'SMB_ON_DEMAND_GENERAL';

        open l_cursor for
            with obj_ as( 
                      select -- ++get_smb_report_a3++ 
                             o.id
                            ,o.state_id    
                            ,a.kv currency_id 
                            ,case when t.is_prolongation = 1 
                                    and nvl(t.current_prolongation_number, 0) <> 0 
                                    and l_date > d.expiry_date then
                                  (select nvl(max(x.start_date), d.start_date)
                                     from process prl
                                         ,xmltable('/SMBDepositProlongation' passing xmltype(prl.process_data) columns
                                                                      start_date   date path 'StartDate')(+) x 
                                    where prl.object_id = o.id
                                      and prl.process_type_id = g_process_prolongation   
                                      and prl.state_id = process_utl.GC_PROCESS_STATE_SUCCESS
                                      and x.start_date <= l_date)
                                 else d.start_date
                             end start_date
                            ,case when t.is_prolongation = 1 
                                   and nvl(t.current_prolongation_number, 0) <> 0 
                                   and l_date > d.expiry_date  then
                                  (select nvl(min(x.expiry_date), d.expiry_date)
                                     from process prl
                                         ,xmltable('/SMBDepositProlongation' passing xmltype(prl.process_data) columns
                                                                      expiry_date  date path 'ExpiryDate')(+) x 
                                    where prl.object_id = o.id
                                      and prl.process_type_id = g_process_prolongation   
                                      and prl.state_id = process_utl.GC_PROCESS_STATE_SUCCESS
                                      and x.expiry_date >= l_date)
                                  else d.expiry_date
                             end expiry_date
                            ,a.acc account_id
                            ,o.object_type_id
                            ,a.nls
                            ,d.customer_id
                            ,crn.denom
                            ,crn.lcv
                            ,c.nmk
                            ,c.okpo
                            ,d.branch_id
                            ,b.name branch_name
                            ,a.ostc
                            ,a.dapp
                            ,d.deal_number
                            ,a.kf
                            ,sp.s180
                            ,sp.r011
                        from object o
                            ,deal d
                            ,smb_deposit t
                            ,deal_account da
                            ,accounts a
                            ,tabval$global crn
                            ,customer c
                            ,branch b
                            ,specparam sp
                       where 1 = 1
                         and o.object_type_id in (g_tranche_object_type_id, g_dod_object_type_id) 
                         and o.state_id in (g_object_active_state_id, g_object_blocked_state_id, g_object_closed_state_id)
                         and o.id = d.id
                         and o.id = t.id 
                         and o.id = da.deal_id 
                         and da.account_type_id = g_main_account_type_id
                         and da.account_id = a.acc 
                         and a.kv = crn.kv
                         and d.customer_id = c.rnk
                         and d.branch_id = b.branch
                         and a.acc = sp.acc(+)
                         and l_date between d.start_date and coalesce(t.expiry_date_prolongation, d.expiry_date, l_date))
             select x.kf
                   ,x.ref
                   ,x.fdat document_date
                   ,x.lcv
                   ,x.account_id
                   ,x.nls account_number
                   ,x.id
                   ,x.amount_document
                   ,coalesce(-- установлена индивидуальная ставка - берем ее  
                      (select max(a.number_value) keep (dense_rank first order by a.value_date desc) 
                        from attribute_value_by_date a    
                       where a.attribute_id = g_dod_attr_interest_rate_id
                         and a.object_id = x.id
                         and a.value_date <= l_date)
                      -- вычисляем от суммы по справочнику           
                     ,(select min(c.interest_rate) keep (dense_rank first order by c.amount_from desc, o.valid_from desc) 
                          from deal_interest_option o
                              ,deposit_on_demand_condition c
                         where o.rate_kind_id = l_on_demand_kind_type_id 
                           and c.interest_option_id = o.id 
                           and c.currency_id = x.currency_id
                           -- % ставку берем на дату начала действия ДпТ
                           and o.valid_from <= x.start_date
                           and c.amount_from <= x.amount_on_end_date / x.denom 
                           and o.is_active = 1) )  current_interest_rate
                   ,x.s180
                   ,x.sos
                   ,x.tt
                   ,x.currency_id
                   ,x.start_date
                   ,x.expiry_date
                   ,x.customer_id
                   ,x.r011
               from (            
                    select x.*, o.fdat, o.sos, o.tt, o.s amount_document, o.ref
                          ,(x.ostc -
                             nvl( 
                              case when l_date < x.dapp then
                                 (select sum(s.kos - s.dos)    
                                    from saldoa s
                                   where s.acc = x.account_id
                                     and s.fdat > l_date)
                              end, 0)) amount_on_end_date          
                      from obj_ x
                          ,opldok o
                     where x.object_type_id = g_dod_object_type_id
                       and o.acc = x.account_id
                       and o.fdat = l_date
                       and o.dk = 1
                       ) x
             union all
             select x.kf
                   ,h.document_id ref
                   ,h.value_date document_date
                   ,x.lcv
                   ,x.account_id
                   ,x.nls account_number
                   ,x.id
                   ,h.amount amount_document
                   ,(select max(a.number_value) keep (dense_rank first order by a.value_date desc) 
                       from attribute_value_by_date a    
                      where a.attribute_id = g_trn_attr_interest_rate_id
                        and a.object_id = x.id
                        and a.value_date <= l_date) current_interest_rate
                   ,x.s180    
                   ,o.sos
                   ,o.tt
                   ,x.currency_id 
                   ,x.start_date
                   ,x.expiry_date
                   ,x.customer_id
                   ,x.r011
               from obj_ x
                   ,register_value v
                   ,register_history h
                   ,oper o
              where x.object_type_id = g_tranche_object_type_id
                and x.id = v.object_id
                and v.register_type_id = g_reg_trn_principal_type_id
                and v.id = h.register_value_id
                and h.value_date = l_date
                and h.is_active = 'Y'
                and h.is_planned = 'N'
                and h.document_id = o.ref;
        loop
            fetch l_cursor bulk collect into l_smb_report limit 1000;
            exit when l_smb_report.count = 0;
            for i in 1..l_smb_report.count loop
                   /* 
                    от Виктории Семеновой  - Mon 4/8/2019 10:55 AM 
                    Нужно так :
                    1)    f_srok(datb_ => start_date, date_ => end_date, type_ => 2);  
                    если я правильно поняла, что  start_date  - дата выдачи транша, 
                    end_date  - дата погашения транша 
                    */
                -- для ДпТ ставим 1    
                l_smb_report(i).s180 := case when l_smb_report(i).expiry_date is null then '1'
                                             else
                                               f_srok(datb_ => l_smb_report(i).start_date
                                                     ,date_ => l_smb_report(i).expiry_date
                                                     ,type_ => 2)
                                        end;             
                 -- из письма Тетяна Вірко
                 -- параметр S180 у вибірці невірно визначається по таблиці SPECPARAM, а потрібно його визначати за допомогою функції FS180
                 -- Fs180 (acc_id, null, p_date, /*дата початку дії депозиту*/, 0)
                 /*
                 l_smb_report(i).s180 := Fs180(acc_    => l_smb_report(i).account_id
                                              ,klass_  => null
                                              ,odat_   => l_date
                                              ,bdat_   => l_smb_report(i).start_date
                                              ,oz_kor_ => 0);*/
                 pipe row (l_smb_report(i));
            end loop;
        end loop;
        close l_cursor;
        return;
    end get_report_3a; 

    -- витрина для файла А7 по депозитам (транши) ММСБ
    function get_report_a7(p_date in date)
          return tt_smb_report_a7 pipelined
     is
        l_date date              := nvl(p_date, gl.bdate);
        l_cursor                 sys_refcursor;
        l_smb_report             tt_smb_report_a7;
    begin
        open l_cursor for
            select --+ ++get_report_a7++
                   l_date report_date                   -- Дата на которую формируются остатки
                  ,nvl(t.expiry_date_prolongation, d.expiry_date) expiry_date  -- дата погашения транша
                  ,o.id  deposit_id                     -- ID транша
                  ,d.customer_id                        -- RNK 
                  ,a.acc account_id                     -- ACC
                  ,a.nls account_number                 -- nls
                  ,(select sum(h.amount) amount
                      from register_value v
                          ,register_history h
                     where v.object_id = o.id
                       and v.register_type_id = g_reg_trn_principal_type_id
                       and h.register_value_id = v.id
                       and h.value_date <= l_date
                       and h.is_active = 'Y'
                       and h.is_planned = 'N'
                        ) deposit_amount                  -- сумма транша на дату (номинал)
                   ,c.lcv         currency_name           -- валюта транша
                   ,d.deal_number deposit_number          -- ND номер депозитного договора
                   ,null          s240                    -- s240 (заполняем null далее вычисляем)
                   ,a.kv          currency_id           
              from smb_deposit t
                  ,object o
                  ,deal d
                  ,deal_account da
                  ,accounts a
                  ,tabval$global c
             where t.id = o.id
               and o.object_type_id = g_tranche_object_type_id
               and o.id = d.id
               and d.id = da.deal_id
               and da.account_type_id = g_main_account_type_id
               and da.account_id = a.acc
               and nvl(t.expiry_date_prolongation, d.expiry_date) >= l_date
               and d.start_date <= l_date
               and o.state_id in (g_object_active_state_id, g_object_blocked_state_id, g_object_closed_state_id)
               and a.kv = c.kv;
        loop
            fetch l_cursor bulk collect into l_smb_report limit 1000;
            exit when l_smb_report.count = 0;
            for i in 1..l_smb_report.count loop
                 -- использовать Fs240 14.02.2019 Виктория
                 l_smb_report(i).s240 := fs240(odat_    => l_smb_report(i).report_date
                                              ,acc_     => l_smb_report(i).account_id
                                              ,fdatb_   => null
                                              ,fdate_   => null
                                              ,p_mdate_ => l_smb_report(i).expiry_date
                                              ,p_s240_  => null );
                 pipe row (l_smb_report(i));
            end loop;
        end loop;
        close l_cursor;
        return;
    end;      

    -- витрина для файла E8 по депозитам (транши) ММСБ
    function get_report_e8(p_date in date)
          return tt_smb_report_e8 pipelined
     is
        l_date date              := nvl(p_date, gl.bdate);
        l_cursor                 sys_refcursor;
        l_smb_report             tt_smb_report_e8;
    begin
        open l_cursor for
            select --+ leading (x dbo) ++get_report_e8++
                   x.account_id
                  ,x.account_number
                  ,x.currency_id
                  ,x.currency_name
                  ,dbo.contract_number
                  ,to_date(replace(dbo.contract_date, '/', '.'), 'dd.mm.yyyy')  start_date
                  ,cast(null as date) end_date
                  ,sum(deposit_amount) deposit_amount
                  ,case when sum(deposit_amount) <> 0 
                        then sum(deposit_amount * interest_rate) / sum(deposit_amount)
                   end interest_rate
                  ,x.customer_id
                  ,l_date report_date 
              from(      
                  select  
                         o.id  deposit_id                     -- ID транша
                        ,d.customer_id                        -- RNK 
                        ,a.acc account_id                     -- ACC
                        ,a.nls account_number                 -- nls
                        ,(select sum(h.amount) amount
                            from register_value v
                                ,register_history h
                           where v.object_id = o.id
                             and v.register_type_id = g_reg_trn_principal_type_id
                             and h.register_value_id = v.id
                             and h.value_date <= l_date
                             and h.is_active = 'Y'
                             and h.is_planned = 'N'
                              ) deposit_amount                  -- сумма транша на дату (номинал)
                        ,(select max(a.number_value) keep (dense_rank first order by a.value_date desc) 
                                     from attribute_value_by_date a    
                                    where a.attribute_id  = g_trn_attr_interest_rate_id
                                      and a.object_id = t.id
                                      and a.value_date <= l_date
                         ) interest_rate                        -- % ставка
                         ,c.lcv         currency_name           -- валюта транша
                         ,a.kv          currency_id           
                    from smb_deposit t
                        ,object o
                        ,deal d
                        ,deal_account da
                        ,accounts a
                        ,tabval$global c
                   where t.id = o.id
                     and o.object_type_id = g_tranche_object_type_id
                     and o.id = d.id
                     and d.id = da.deal_id
                     and da.account_type_id = g_main_account_type_id
                     and da.account_id = a.acc
                     and (d.close_date is null or d.close_date > l_date )
                     and d.start_date <= l_date
                     and o.state_id in (g_object_active_state_id, g_object_blocked_state_id, g_object_closed_state_id)
                     and a.kv = c.kv) x
                    ,v_dbo dbo
               where x.customer_id = dbo.rnk
            group by x.customer_id
                    ,x.account_id
                    ,x.account_number
                    ,x.currency_name
                    ,x.currency_id
                    ,dbo.contract_number
                    ,dbo.contract_date;
        loop
            fetch l_cursor bulk collect into l_smb_report limit 1000;
            exit when l_smb_report.count = 0;
            for i in 1..l_smb_report.count loop
                 pipe row (l_smb_report(i));
            end loop;
        end loop;
        close l_cursor;
        return;
    end get_report_e8;

    -- возвращает % ставку для DWH 
    function get_interest_rate(p_id   in number
                              ,p_date in date)
        return number
     is
        l_interest_rate          number;
        l_date                   date  := nvl(p_date, gl.bdate);
        l_start_date             date  := trunc(l_date, 'month');
        l_on_demand_kind_type_id number;
        l_account_id             number;
    begin
        select max(id)
          into l_on_demand_kind_type_id
          from deal_interest_rate_kind irk
         where irk.kind_code = 'SMB_ON_DEMAND_GENERAL';
        -- (???) 
        select  max(account_id)
           into l_account_id
           from deal_account da
          where da.account_type_id = g_main_account_type_id
            and da.deal_id = p_id;

        select max(
               case when is_dod = 1 
                   then -- вычисляем от суммы по справочнику           
                      (select min(c.interest_rate) keep (dense_rank first order by c.amount_from desc, o.valid_from desc) 
                          from deal_interest_option o
                              ,deposit_on_demand_condition c
                         where o.rate_kind_id = l_on_demand_kind_type_id 
                           and c.interest_option_id = o.id 
                           and c.currency_id = x.currency_id
                           -- % ставку берем на дату начала действия ДпТ
                           and o.valid_from <= x.start_date
                           and c.amount_from <= x.amount_on_end_date
                           and o.is_active = 1) 
                   else current_interest_rate
               end )
           into l_interest_rate         
           from(
                select -- транши или индивидуальная ставка
                        case when o.object_type_id = g_tranche_object_type_id or
                                  t.is_individual_rate = 1 then
                           (select max(a.number_value) keep (dense_rank first order by a.value_date desc) 
                               from attribute_value_by_date a    
                              where a.attribute_id in (g_trn_attr_interest_rate_id, g_dod_attr_interest_rate_id)
                                and a.object_id = t.id
                                and a.value_date <= l_date) 
                        end current_interest_rate
                        -- сумма для ДпТ если ставка не индивидуальная
                       ,case when o.object_type_id = g_dod_object_type_id and t.is_individual_rate = 0 
                            then case when (select att.number_value accrual_method
                                              from attribute_value_by_date att    
                                             where att.attribute_id = g_dod_accrual_method_id
                                               and att.object_id = o.id
                                               and att.value_date <= l_date) = 1
                                       -- на конец дня        
                                       then (a.ostc -
                                             nvl( 
                                              case when l_date < a.dapp then
                                                 (select sum(s.kos - s.dos)    
                                                    from saldoa s
                                                   where s.acc = a.acc
                                                     and s.fdat > l_date)
                                              end, 0)) / c.denom
                                       -- по среднему       
                                       else (select sum(amnt)
                                               from (
                                                  select 
                                                          (s.ostf - s.dos + s.kos) *
                                                          (lead(s.fdat - 1, 1, l_date) over (order by s.fdat) -
                                                            greatest(l_start_date, s.fdat) + 1) /
                                                          (l_date - l_start_date + 1) amnt
                                                    from saldoa s
                                                   where s.acc = l_account_id
                                                     and s.fdat between
                                                               (select nvl(max(b.fdat), l_start_date)
                                                                  from saldoa b
                                                                 where b.acc = s.acc
                                                                   and b.fdat <= l_start_date )
                                                             and l_date))
                                       end        
                        end amount_on_end_date 
                       ,case when o.object_type_id = g_dod_object_type_id and
                                  t.is_individual_rate = 0 then 1
                        end is_dod
                       ,a.kv currency_id
                       ,d.start_date 
                  from smb_deposit t
                      ,object o
                      ,deal d
                      ,accounts a
                      ,tabval$global c
                 where t.id = p_id
                   and t.id = d.id
                   and t.id = o.id
                   and a.acc(+) = l_account_id
                   and (d.close_date is null or d.close_date >= l_date)
                   and a.kv = c.kv(+)) x;

        return l_interest_rate;

    end get_interest_rate;                              


    procedure init_params
     is
    begin
        g_main_account_type_id         := attribute_utl.get_attribute_id('DEPOSIT_PRIMARY_ACCOUNT');
        g_int_account_type_id          := attribute_utl.get_attribute_id('DEPOSIT_INTEREST_ACCOUNT');                
        g_reg_trn_int_amount_type_id   := register_utl.read_register_type(
                                                            p_register_code => register_utl.SMB_INTEREST_AMOUNT_CODE
                                                           ,p_raise_ndf    => true).id;
        g_reg_dod_int_amount_type_id   := register_utl.read_register_type(
                                                            p_register_code => register_utl.SMB_DOD_INTEREST_AMOUNT_CODE
                                                           ,p_raise_ndf    => true).id;
        g_reg_trn_principal_type_id    := register_utl.read_register_type(
                                                            p_register_code => register_utl.SMB_PRINCIPAL_AMOUNT_CODE
                                                           ,p_raise_ndf    => true).id;
        g_reg_trn_paid_int_type_id     := register_utl.read_register_type(
                                                            p_register_code => register_utl.SMB_INTEREST_PAID_CODE
                                                           ,p_raise_ndf    => true).id;
        g_reg_dod_paid_int_type_id     := register_utl.read_register_type(
                                                            p_register_code => register_utl.SMB_DOD_INTEREST_PAID_CODE
                                                           ,p_raise_ndf    => true).id;
        g_reg_blocked_amount_type_id   := register_utl.read_register_type(
                                                            p_register_code => register_utl.SMB_BLOCKED_AMOUNT_CODE
                                                           ,p_raise_ndf    => true).id;
        g_reg_dod_principal_type_id    := register_utl.read_register_type(
                                                            p_register_code => register_utl.SMB_DOD_PRINCIPAL_AMOUNT_CODE
                                                           ,p_raise_ndf    => true).id;

        g_process_tranche              := process_utl.get_proc_type_id(
                                                            p_proc_type_code => smb_deposit_utl.PROCESS_TRANCHE_CREATE
                                                           ,p_module_code    => smb_deposit_utl.PROCESS_TRANCHE_MODULE);
        g_process_on_demand            := process_utl.get_proc_type_id(
                                                            p_proc_type_code => smb_deposit_utl.PROCESS_ON_DEMAND_CREATE
                                                           ,p_module_code    => smb_deposit_utl.PROCESS_TRANCHE_MODULE);
        g_process_replenishment        := process_utl.get_proc_type_id(
                                                            p_proc_type_code => smb_deposit_utl.PROCESS_REPLENISH_TRANCHE
                                                           ,p_module_code    => smb_deposit_utl.PROCESS_TRANCHE_MODULE);
        g_process_prolongation         := process_utl.get_proc_type_id(
                                                            p_proc_type_code => smb_deposit_utl.PROCESS_TRANCHE_PROLONGATION
                                                           ,p_module_code    => smb_deposit_utl.PROCESS_TRANCHE_MODULE);
        g_process_processing_blocked   := process_utl.get_proc_type_id(
                                                            p_proc_type_code => smb_deposit_utl.PROCESS_PROCESSING_BLOCKED_DPT
                                                           ,p_module_code    => smb_deposit_utl.PROCESS_TRANCHE_MODULE);

        g_tranche_object_type_id       := object_utl.read_object_type(p_object_type_code => smb_deposit_utl.TRANCHE_OBJECT_TYPE_CODE).id;
        g_dod_object_type_id           := object_utl.read_object_type(p_object_type_code => smb_deposit_utl.ON_DEMAND_OBJECT_TYPE_CODE).id;

        g_trn_attr_interest_rate_id    := attribute_utl.get_attribute_id(smb_deposit_utl.ATTR_SMB_DEPOSIT_TRANCHE_IR);
        g_trn_attribute_penalty_id     := attribute_utl.get_attribute_id(smb_deposit_utl.ATTR_SMB_DEPOSIT_PENALTY_IR);
        g_dod_attr_interest_rate_id    := attribute_utl.get_attribute_id(smb_deposit_utl.ATTR_SMB_DEPOSIT_ON_DEMAND_IR);

        g_object_active_state_id       := object_utl.get_object_state_row(
                                                     p_object_type_id    => g_tranche_object_type_id
                                                    ,p_object_state_code => 'ACTIVE').id;

        g_object_created_state_id      := object_utl.get_object_state_row(
                                                     p_object_type_id    => g_tranche_object_type_id
                                                    ,p_object_state_code => 'CREATED').id;

        g_object_blocked_state_id      := object_utl.get_object_state_row(
                                                     p_object_type_id    => g_tranche_object_type_id
                                                    ,p_object_state_code => 'BLOCKED').id;

        g_object_closed_state_id       := object_utl.get_object_state_row(
                                                     p_object_type_id    => g_tranche_object_type_id
                                                    ,p_object_state_code => 'CLOSED').id; 

        g_object_deleted_state_id      := object_utl.get_object_state_row(
                                                     p_object_type_id    => g_tranche_object_type_id
                                                    ,p_object_state_code => 'DELETED').id; 

        g_dod_accrual_method_id        := attribute_utl.get_attribute_id(smb_deposit_utl.ATTR_SMB_DPT_ON_DEMAND_CALC);

        g_reg_trn_income_tax_type_id   := register_utl.read_register_type(
                                                            p_register_code => register_utl.SMB_INCOME_TAX_CODE
                                                           ,p_raise_ndf    => true).id;
        g_reg_trn_military_tax_type_id := register_utl.read_register_type(
                                                            p_register_code => register_utl.SMB_MILITARY_TAX_CODE
                                                           ,p_raise_ndf    => true).id;

    end;

begin
    init_params();
end;
/
PROMPT *** Create  grants  smb_calculation_deposit ***
grant EXECUTE   on smb_calculation_deposit   to BARS_ACCESS_DEFROLE;
GRANT EXECUTE   on smb_calculation_deposit   to BARSREADER_ROLE;

PROMPT =================================================================================== 
PROMPT *** End *** == Scripts /Sql/BARS/package/smb_calculation_deposit.sql == *** End ***
PROMPT ===================================================================================
