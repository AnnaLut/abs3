create or replace package smb_deposit_utl
is

/*
-- выбор счета счет для списания
select a.acc, a.rnk, a.nls, a.nms, a.ostc, a.branch, a.kv
  from accounts a
      ,v_dbo d
where a.nbs in ('2600', '2650')
  and a.dazs is null
 -- and a.ostc <> 0
  and a.kv = :currency_id --980
  and a.rnk = d.rnk
  and a.rnk = :customer_id --135432101
  and not exists (select null
                    from attribute_kind ak
                        ,deal_account da
                   where ak.attribute_code = 'SMB_DEPOSIT_ON_DEMAND_PRIMARY_ACCOUNT'
                     and da.account_id = a.acc
                     and da.account_type_id = ak.id)
                                                ;
--
function check_available(p_nls in varchar2, p_kv in number, p_s in number)
  return boolean is
  l_accnts accounts%rowtype;
  l_result boolean := true;
begin
  l_accnts := account_utl.lock_account(p_nls, p_kv, p_lock_mode => 1);
  if l_accnts.pap = 1 and l_accnts.lim + l_accnts.ostc + p_s * 100 > 0 then
    l_result := false;
  elsif l_accnts.pap = 2 and l_accnts.lim + l_accnts.ostc - p_s * 100 < 0 then
    l_result := false;
  end if;
  return l_result;
end;

*/
    TEST_MODE                       number := 0;
    -- segment of business
    SEGMENT_OF_BUSINESS_CODE        constant varchar2(50) := 'SMB_DEPOSIT';
    -- types
    GENERAL_TYPE                    constant varchar2(50) := 'GENERAL';
    BONUS_TYPE                      constant varchar2(50) := 'BONUS';
    PROLONGATION_TYPE               constant varchar2(50) := 'PROLONGATION';
    CAPITALIZATION_TYPE             constant varchar2(50) := 'CAPITALIZATION';
    PAYMENT_TYPE                    constant varchar2(50) := 'PAYMENT';
    PENALTY_RATE_TYPE               constant varchar2(50) := 'PENALTY_RATE';
    REPLENISHMENT_TYPE              constant varchar2(50) := 'REPLENISHMENT';
    PROLONGATION_BONUS_TYPE         constant varchar2(50) := 'PROLONGATION_BONUS';
    RATE_FOR_BLOCKED_TRANCHE_TYPE   constant varchar2(50) := 'RATE_FOR_BLOCKED_TRANCHE';
    --
    AMOUNT_SETTING_TYPE             constant varchar2(50) := 'TRANCHE_AMOUNT_SETTING';
    REPLENISHMENT_TRANCHE_TYPE      constant varchar2(50) := 'REPLENISHMENT_TRANCHE';
    --
    ON_DEMAND_GENERAL_TYPE          constant varchar2(50) := 'ON_DEMAND_GENERAL';
    -- kind
    GENERAL_KIND_CODE               constant varchar2(50) := 'SMB_GENERAL';
    BONUS_KIND_CODE                 constant varchar2(50) := 'SMB_BONUS';
    PROLONGATION_KIND_CODE          constant varchar2(50) := 'SMB_PROLONGATION';
    CAPITALIZATION_KIND_CODE        constant varchar2(50) := 'SMB_CAPITALIZATION';
    PAYMENT_KIND_CODE               constant varchar2(50) := 'SMB_PAYMENT';
    PENALTY_RATE_KIND_CODE          constant varchar2(50) := 'SMB_PENALTY_RATE';
    REPLENISHMENT_KIND_CODE         constant varchar2(50) := 'SMB_REPLENISHMENT';
    PROLONGATION_BONUS_KIND_CODE    constant varchar2(50) := 'SMB_PROLONGATION_BONUS';
    RATE_FOR_BLK_TRANCHE_KIND_CODE  constant varchar2(50) := 'SMB_RATE_FOR_BLOCKED_TRANCHE';
    --
    ON_DEMAND_GENERAL_KIND_CODE     constant varchar2(50) := 'SMB_ON_DEMAND_GENERAL';
    ON_DEMAND_CALC_TYPE_KIND_CODE   constant varchar2(50) := 'SMB_ON_DEMAND_CALC_TYPE';
    -- суммы траншей
    AMOUNT_SETTING_KIND_CODE        constant varchar2(50) := 'SMB_TRANCHE_AMOUNT_SETTING';
    -- сроки пополнений
    REPLENISHMENT_TRN_KIND_CODE     constant varchar2(50) := 'SMB_REPLENISHMENT_TRANCHE';

    --

    PARENT_OBJECT_TYPE_CODE         constant varchar2(50) := 'DEAL';
    --
    TRANCHE_PRODUCT_CODE            constant varchar2(50) := 'SMB_DEPOSIT_TRANCHE';
    TRANCHE_OBJECT_TYPE_CODE        constant varchar2(50) := 'SMB_DEPOSIT_TRANCHE';

    -- --
    DEPOSIT_ON_DEMAND_TYPE          constant varchar2(50) := 'DEPOSIT_ON_DEMAND';
    DEPOSIT_ON_DEMAND_CALC_TYPE     constant varchar2(50) := 'DEPOSIT_ON_DEMAND_CALC';

    --
    ON_DEMAND_PRODUCT_CODE          constant varchar2(50) := 'SMB_DEPOSIT_ON_DEMAND';
    ON_DEMAND_OBJECT_TYPE_CODE      constant varchar2(50) := 'SMB_DEPOSIT_ON_DEMAND';

    CAPITALIZATION_TERM_ID          constant number       := 1; -- Щомісячно в ТЗ

    -- атрибут для процентной ставки транша
    ATTR_SMB_DEPOSIT_TRANCHE_IR   constant varchar2(50) := 'SMB_DEPOSIT_TRANCHE_INTEREST_RATE';
    -- штрафная ставка
    ATTR_SMB_DEPOSIT_PENALTY_IR   constant varchar2(50) := 'SMB_DEPOSIT_TRANCHE_PENALTY_INTEREST_RATE';
    ATTR_SMB_DEPOSIT_ON_DEMAND_IR constant varchar2(50) := 'SMB_DEPOSIT_ON_DEMAND_INTEREST_RATE';
    -- тип расчета (Середньоденні залишки/Залишок на кінець дня)
    --  может меняться с 1-10 число каждого месяца. храним в атрибутах
    ATTR_SMB_DPT_ON_DEMAND_CALC   constant varchar2(50) := 'SMB_DEPOSIT_ON_DEMAND_CALCULATION_TYPE';

    OBJ_TRANCHE_STATE_ACTIVE        constant varchar2(50) := 'ACTIVE';
    PROCESS_TRANCHE_MODULE          constant varchar2(50) := 'SMBD';
    PROCESS_TRANCHE_CREATE          constant varchar2(50) := 'NEW_TRANCHE';
    PROCESS_REPLENISH_TRANCHE       constant varchar2(50) := 'REPLENISH_TRANCHE';
    PROCESS_TRANCHE_BLOCKING        constant varchar2(50) := 'TRANCHE_BLOCKING';
    PROCESS_TRANCHE_UNBLOCKING      constant varchar2(50) := 'TRANCHE_UNBLOCKING';
    PROCESS_EARLY_RETURN_TRANCHE    constant varchar2(50) := 'EARLY_RETURN_TRANCHE';
    PROCESS_TRANCHE_PROLONGATION    constant varchar2(50) := 'TRANCHE_PROLONGATION';

    PROCESS_REGISTRATION_ERROR      constant varchar2(50) := 'REGISTRATION_ERROR';
    PROCESS_CHANGE_INTEREST_RATE    constant varchar2(50) := 'CHANGE_INTEREST_RATE';
    PROCESS_CLOSING_TRANCHE         constant varchar2(50) := 'CLOSING_TRANCHE';
    PROCESS_PROCESSING_BLOCKED_DPT  constant varchar2(50) := 'PROCESSING_BLOCKED_DEPOSIT';

    ACTIVITY_CONFIRM_CODE           constant varchar2(50) := 'BACK_OFFICE_CONFIRMATION';
    ACT_TRANSFER_TRANCHE            constant varchar2(50) := 'TRANSFER_FUNDS';
    ACT_TRANSFER_REPLENISHMENT      constant varchar2(50) := 'REPLENISH_TRANSFER_FUNDS';
    ACT_RETURN_TRANSFER_FUNDS       constant varchar2(50) := 'RETURN_TRANSFER_FUNDS';
    ACT_TRANCHE_PROLONGATION        constant varchar2(50) := 'TRANCHE_PROLONGATION';

   -- Типы блокировок траншей по депозитам ММСБ
    DEPOSIT_TRANCHE_LOCK_TYPE     constant varchar2(50) := 'SMB_TRANCHE_LOCK_TYPE';
    LOCK_ARREST_TYPE              constant varchar2(50) := 'SMB_LOCK_ARREST';
    LOCK_DPT_ON_CREDIT_TYPE       constant varchar2(50) := 'SMB_LOCK_DPT_ON_CREDIT';
    -- 1) блокировка в связи с арестом по решению суда/исполнительной службы – не требует использования транзитного счета
    LOCK_ARREST_ID                constant number       := 1;
    -- 2) блокировка в связи с обеспечением депозита по кредиту – требует использования транзитного счета
    --      (предварительно 3739 – который используется при продукте - залог имущественных прав)
    LOCK_DPT_ON_CREDIT_ID         constant number       := 2;

    -- процесс для создания депозита по требованию
    PROCESS_ON_DEMAND_CREATE        constant varchar2(50) := 'NEW_ON_DEMAND';
    -- процесс для закрытия депозита по требованию
    PROCESS_ON_DEMAND_CLOSE         constant varchar2(50) := 'CLOSE_ON_DEMAND';
    PROCESS_DOD_CHANGE_CALC_TYPE    constant varchar2(50) := 'CHANGE_CALCULATION_TYPE';
    ACT_DOD_CHANGE_CALC_TYPE        constant varchar2(50) := 'CHANGE_CALCULATION_TYPE';

    PARENT_NODE_TRANCHE             constant varchar2(50) := '/SMBDepositTranche';
    PARENT_NODE_ON_DEMAND           constant varchar2(50) := '/SMBDepositOnDemand';
    PARENT_NODE_PROLONGATION        constant varchar2(50) := '/SMBDepositProlongation';
    PARENT_NODE_IR_TRANCHE          constant varchar2(50) := '/SMBDepositTrancheInterestRate';


    ERR_NOT_ENOUGH_MONEY            constant varchar2(100) := 'Не вистачає коштів на рахунку для списання {';

    -- payment term
    DEPOSIT_PAYMENT_TERM_CODE       constant varchar2(50) := 'SMB_DEPOSIT_PAYMENT_TERM';
    -- payment term
    PAYMENT_TERM_MONTHLY          constant varchar2(50) := 'Щомісячно';
    PAYMENT_TERM_QUARTERLY        constant varchar2(50) := 'Щоквартально';
    PAYMENT_TERM_EOT              constant varchar2(50) := 'В кінці строку';
    PAYMENT_TERM_MONTHLY_ID       constant number       := 1;
    PAYMENT_TERM_QUARTERLY_ID     constant number       := 2;
    PAYMENT_TERM_EOT_ID           constant number       := 3;

--
    DEPOSIT_APPLY_BONUS_PROLONG     constant varchar2(50) := 'SMB_DEPOSIT_APPLY_BONUS_PROL';
    APPLY_ONLY_FIRST_PROLONG        constant varchar2(30) := 'для першої';
    APPLY_FOR_EACH_PROLONG          constant varchar2(30) := 'для кожної';
    APPLY_ONLY_FIRST_PROLONG_ID     constant number       := 1;
    APPLY_FOR_EACH_PROLONG_ID       constant number       := 2;

    -- тип расчета % для ДпТ
    CALC_TYPE_DOD_CODE              constant varchar2(50) := 'CALC_TYPE_ON_DEMAND';
    CALC_TYPE_DOD_END_OF_DAY        constant varchar2(50) := 'Залишок на кінець дня';
    CALC_TYPE_DOD_DAILY_AVERAGE     constant varchar2(50) := 'Середньоденні залишки';
    CALC_TYPE_DOD_END_OF_DAY_ID     constant number       := 1;
    CALC_TYPE_DOD_DAILY_AVERAGE_ID  constant number       := 2;

    G_PROCESS_INFO_FRONT_OFFICE     constant varchar2(4)  := '#FO#';

    cursor c_tranche_from_xml (p_data clob) is
           select  x.Currency_Id
                  ,x.Customer_Id
                  ,x.Start_Date
                  ,x.Expiry_Date
                  ,x.number_tranche_days
                  ,x.Amount_Tranche * c.denom Amount_Tranche
                  ,x.Interest_Rate
                  ,x.Is_Prolongation
                  ,trunc(x.Number_Prolongation) Number_Prolongation
                  ,x.Interest_Rate_Prolongation
                  ,x.Apply_Bonus_Prolongation
                  ,x.Is_Replenishment_Tranche
                  ,x.Max_Sum_Tranche * c.denom Max_Sum_Tranche
                  ,x.Min_Replenishment_Amount * c.denom Min_Replenishment_Amount
                  ,x.Last_Replenishment_Date
                  ,x.Frequency_Payment
                  ,x.Is_Individual_Rate
                  ,x.Individual_Interest_Rate
                  ,x.Is_Capitalization
                  ,x.Comment_
                  ,x.Primary_Account
                  ,x.Debit_Account
                  ,x.Return_Account
                  ,x.Interest_Account
                  ,x.Transit_Account
                  ,x.Branch
                  ,x.Object_Id
                  ,x.Process_Id
                  ,x.Register_History_Id
                  ,x.Deal_Number
                  ,x.action_date
                  ,x.penalty_rate
                  ,x.Additional_Comment
                  ,x.Ref_
                  ,x.interest_rate_capitalization
                  ,x.interest_rate_bonus
                  ,x.interest_rate_replenishment
                  ,x.interest_rate_payment
                  ,x.lock_tranche_id
                  ,x.Capitalization_Term
                  ,x.Is_Not_Enough_Money
                  ,x.last_process_type_id
                  ,c.denom  -- для первода в грн/usd/...
                  ,x.interest_rate_general
                  ,x.is_signed
              from xmltable ('/SMBDepositTranche' passing xmltype(p_data) columns
                     Currency_Id                   number         path 'CurrencyId'
                    ,Customer_Id                   number         path 'CustomerId'
                    ,Start_Date                    date           path 'StartDate'
                    ,Expiry_Date                   date           path 'ExpiryDate'
                    ,number_tranche_days           number         path 'NumberTrancheDays'
                    ,Amount_Tranche                number         path 'AmountTranche'
                    ,Interest_Rate                 number         path 'InterestRate'
                    ,Is_Prolongation               number         path 'IsProlongation'
                    ,Number_Prolongation           number         path 'NumberProlongation'
                    ,Interest_Rate_Prolongation    number         path 'InterestRateProlongation'
                    ,Apply_Bonus_Prolongation      number         path 'ApplyBonusProlongation'
                    ,Is_Replenishment_Tranche      number         path 'IsReplenishmentTranche'
                    ,Max_Sum_Tranche               number         path 'MaxSumTranche'
                    ,Min_Replenishment_Amount      number         path 'MinReplenishmentAmount'
                    ,Last_Replenishment_Date       date           path 'LastReplenishmentDate'
                    ,Frequency_Payment             number         path 'FrequencyPayment'
                    ,Is_Individual_Rate            number         path 'IsIndividualRate'
                    ,Individual_Interest_Rate      number         path 'IndividualInterestRate'
                    ,Is_Capitalization             number         path 'IsCapitalization'
                    ,Comment_                      varchar2(1000) path 'Comment'
                    ,Primary_Account               varchar2(100)  path 'PrimaryAccount'
                    ,Debit_Account                 varchar2(100)  path 'DebitAccount' -- withdraw account
                    ,Return_Account                varchar2(100)  path 'ReturnAccount'
                    ,Interest_Account              varchar2(100)  path 'InterestAccount'
                    ,Transit_Account               varchar2(100)  path 'TransitAccount'
                    ,Branch                        varchar2(100)  path 'Branch'
                    ,Object_Id                     number         path 'ObjectId'
                    ,Process_Id                    number         path 'ProcessId'
                    ,Register_History_Id           number         path 'RegisterHistoryId'
                    ,Deal_Number                   varchar2(100)  path 'DealNumber'
                    ,action_date                   date           path 'ActionDate'
                    ,penalty_rate                  number         path 'PenaltyRate'
                    ,additional_comment            varchar2(1000) path 'AdditionalComment'
                    ,ref_                          number         path 'Ref_'
                    ,interest_rate_capitalization  number         path 'InterestRateCapitalization'
                    ,interest_rate_bonus           number         path 'InterestRateBonus'
                    ,interest_rate_replenishment   number         path 'InterestRateReplenishment'
                    ,interest_rate_payment         number         path 'InterestRatePayment'
                    ,lock_tranche_id               number         path 'LockTrancheId'
                    ,Capitalization_Term           number         path 'CapitalizationTerm'
                    ,Is_Not_Enough_Money           number         path 'IsNotEnoughMoney'
                    ,last_process_type_id          number         path 'LastProcessTypeId'
                    ,Interest_Rate_General         number         path 'InterestRateGeneral'
                    ,is_signed                     number         path 'IsSigned') x
                  ,tabval c
                where x.currency_id = c.kv;

    cursor c_on_demand_from_xml (p_data clob) is
           select  x.Currency_Id
                  ,x.Customer_Id
                  ,x.Start_Date
                  ,x.Expiry_Date
                  ,x.Interest_Rate
                  ,x.Frequency_Payment
                  ,x.Is_Individual_Rate
                  ,x.Individual_Interest_Rate
                  ,x.calculation_type
                  ,x.Comment_
                  ,x.Primary_Account
                  ,x.Debit_Account
                  ,x.Return_Account
                  ,x.Interest_Account
                  ,x.Branch
                  ,x.Object_Id
                  ,x.Process_Id
                  ,Action_Date
                  ,Additional_Comment
                  ,x.Deal_Number
                  ,x.Ref_
                  ,x.Is_Not_Enough_Money
                  ,x.last_process_type_id
                  ,x.is_transfer_day_registration
                  ,c.denom  -- для первода в грн/usd/...
                  ,x.is_signed
              from xmltable ('/SMBDepositOnDemand' passing xmltype(p_data) columns
                     Currency_Id                   number         path 'CurrencyId'
                    ,Customer_Id                   number         path 'CustomerId'
                    ,Start_Date                    date           path 'StartDate'
                    ,Expiry_Date                   date           path 'ExpiryDate'
                    ,Interest_Rate                 number         path 'InterestRate'
                    ,Frequency_Payment             number         path 'FrequencyPayment'
                    ,Is_Individual_Rate            number         path 'IsIndividualRate'
                    ,Individual_Interest_Rate      number         path 'IndividualInterestRate'
                    ,calculation_type              number         path 'CalculationType'
                    ,Comment_                      varchar2(1000) path 'Comment'
                    ,Primary_Account               varchar2(100)  path 'PrimaryAccount'
                    ,Debit_Account                 varchar2(100)  path 'DebitAccount' -- withdraw account
                    ,Return_Account                varchar2(100)  path 'ReturnAccount'
                    ,Interest_Account              varchar2(100)  path 'InterestAccount'
                    ,Branch                        varchar2(100)  path 'Branch'
                    ,Object_Id                     number         path 'ObjectId'
                    ,Process_Id                    number         path 'ProcessId'
                    ,Action_Date                   date           path 'ActionDate'
                    ,Additional_Comment            varchar2(1000) path 'AdditionalComment'
                    ,Deal_Number                   varchar2(100)  path 'DealNumber'
                    ,ref_                          number         path 'Ref_'
                    ,Is_Not_Enough_Money           number         path 'IsNotEnoughMoney'
                    ,last_process_type_id          number         path 'LastProcessTypeId'
                    ,is_transfer_day_registration  number         path 'TransferDayRegistration'
                    ,is_signed                     number         path 'IsSigned') x
                  ,tabval c
                where x.currency_id = c.kv;

    cursor c_deposit_prolongation (p_data clob) is
           select  x.Start_Date
                  ,x.Expiry_Date
                  ,x.action_Date
                  ,x.Number_Tranche_Days
                  ,x.Object_Id
                  ,x.Process_Id
              from xmltable ('/SMBDepositProlongation' passing xmltype(p_data) columns
                     Number_Tranche_Days           number         path 'NumberTrancheDays'
                    ,Start_Date                    date           path 'StartDate'
                    ,Expiry_Date                   date           path 'ExpiryDate'
                    ,action_Date                   date           path 'ActionDate'
                    ,Object_Id                     number         path 'ObjectId'
                    ,Process_Id                    number         path 'ProcessId'
                    ) x;

    cursor c_tranche (p_object_id                 number
                     ,p_object_type_id            number) is
        select o.id
              ,t.currency_id
              ,d.deal_number
              ,d.start_date
              ,d.expiry_date
              ,t.is_replenishment_tranche
              ,t.max_sum_tranche
              ,t.min_replenishment_amount
              ,t.last_replenishment_date
              ,t.last_accrual_date
              ,t.tail_amount
          from object o
              ,deal  d
              ,smb_deposit t
         where 1 = 1
           and o.id = d.id
           and o.object_type_id = p_object_type_id
           and o.id = p_object_id
           and o.id = t.id(+);


    type t_smb_data_for_print is record(
             deal_number                        varchar2(100) -- номер транша/ ДпТ
            ,create_date                        date          -- дата создания
            ,contract_number                    varchar2(100) -- номер ДБО
            ,contract_date                      varchar2(20)  -- дата ДБО
            ,customer_name                      varchar2(100) -- имя клиента
            ,deposit_account                    varchar2(50)  -- Депозитний рахунок
            ,currency_name                      varchar2(50)  -- Валюта Депозитного рахунку
            ,debit_account                      varchar2(50)  -- Рахунок, з якого проводиться розміщення Траншу
            ,amount_deposit                     number        -- Сума Траншу
            ,amount_deposit_in_words            varchar2(200) -- Сума Траншу словами
            ,interest_rate                      number        -- Процента ставка за Траншем
            ,start_date                         date          -- Дата розміщення Траншу
            ,expiry_date                        date          -- Дата повернення Траншу
            ,return_account                     varchar2(50)  -- Реквізити для повернення Траншу
            ,payment_account                    varchar2(50)  -- Реквізити для виплати процентів
            ,frequency_payment                  number        -- Періодичність виплати процентів
                                                              /* 0 -  в кінці строку;
                                                                 1 -  щомісячно;
                                                                 2 -  щоквартально;
                                                                 3 -  щомісячна капіталізація;
                                                                 4 -  щоквартальна капіталізація. */
            ,is_prolongation                    number        -- Пролонгація
            ,number_prolongation                number        -- Кількість пролонгацій
            ,is_replenishment_tranche           number        -- Поповнення Траншу
            ,min_amount_tranche                 number        -- Мінімальна початкова сума Траншу у валюті Траншу
            ,min_amount_tranche_in_words        varchar2(200) -- Мінімальна початкова сума Траншу у валюті Траншу словами
            ,min_amount_replenishment           number        -- Мінімальна сума поповнення Траншу у валюті Траншу
            ,min_amount_replenish_in_words      varchar2(200) -- Мінімальна сума поповнення Траншу у валюті Траншу словами
            ,max_amount_replenishment           number        -- Максимальна сума поповнення Траншу у валюті Траншу
            ,max_amount_replenish_in_words      varchar2(200) -- Максимальна сума поповнення Траншу у валюті Траншу словами
            ,max_amount_tranche                 number        -- Максимально можлива сума Траншу у валюті Траншу
            ,max_amount_tranche_in_words        varchar2(200) -- Максимально можлива сума Траншу у валюті Траншу словами
            ,okpo                               varchar2(50)  -- окпо - инн
            ,user_name                          varchar2(100) -- ПІБ особи Банку, що прийняла заяву
            ,interest_rate_dod                  varchar2(1000)-- Процента ставка за Вкладом на вимогу
            ,calculation_type_dod               number        -- Порядок нарахування відсотків
                                                                 /* 1 - на щоденний залишок коштів
                                                                    2 - на середньоденний залишок коштів */
            ,investor_name                      varchar2(100) -- вкладник  - может отличаться от customer_name
            ,action_date                        date          -- дата создания движения
            ,replenishment_number               varchar2(100) -- номер заяви про поповнення
       );

    type tt_smb_data_for_print is table of t_smb_data_for_print;

    type t_smb_prolongation is record(
             deposit_id     number
            ,start_date     date
            ,expiry_date    date);

    type tt_smb_prolongation is table of t_smb_prolongation;  

    function get_interest_rate(p_data in clob
                              ,p_date in date default null)
       return clob;
    -- процентная ставка для ЗАБЛОКИРОВАНОГО депозита,
    -- у которого закончился срок действия
    function get_interest_rate_blocked(
                                p_object_id    in number
                               ,p_date         in date
                               ,p_currency_id  in number)
       return number;

    cursor c_tranche_interest_rate (p_data clob) is
        select interest_rate_general
              ,interest_rate_bonus
              ,interest_rate_capitalization
              ,interest_rate_payment
              ,interest_rate_prolongation
              ,interest_rate_replenishment
          from xmltable('/SMBDepositTrancheInterestRate' passing xmltype(smb_deposit_utl.get_interest_rate(p_data))
                       columns
                             Interest_Rate_General         number         path 'InterestRateGeneral'
                            ,Interest_Rate_Bonus           number         path 'InterestRateBonus'
                            ,Interest_Rate_Capitalization  number         path 'InterestRateCapitalization'
                            ,Interest_Rate_Payment         number         path 'InterestRatePayment'
                            ,Interest_Rate_Prolongation    number         path 'InterestRateProlongation'
                            ,Interest_Rate_Replenishment   number         path 'InterestRateReplenishment'
                                      );

    type tt_tranche is table of c_tranche_from_xml%rowtype;

    function get_interest_calculation (p_data      in clob
                                      ,p_object_id in number)
        return clob;

    function get_interest_calculation_table (p_data      in clob
                                            ,p_object_id in number)
        return tt_deposit_calculator pipelined;

    function get_interest_rate_on_demand(p_data in clob)
       return clob;

    function get_interest_rate_by_process(p_process_id in number)
       return clob;

    function get_interest_rate_by_object(p_object_id in number)
       return clob;

    -- при пополнении (вызов для UI)
    --   последняя дата когда можно пополнять транш
    function get_last_replenishment_date (
                          p_start_date  in date
                         ,p_end_date    in date)
         return date;

    -- получить последнюю активность по депозиту (транш, пополнеие, ДпТ, удаление ....)
    function get_users_activity(p_process_id in number)
        return varchar2;
    -- последняя ошибка в процессе
    function get_last_error_on_process(p_process_id  in number)
          return varchar2;

    procedure set_inactive_deal_int_option(p_date in date);

    -- проверка на тип депозита
    -- так как ТРАНШ и Депозит по требованию имеют разные типы
    --      для транша его тип должен быть SMB_DEPOSIT_TRANCHE
    --      для ДпТ его тип должен быть SMB_DEPOSIT_ON_DEMAND
    -- для предотвращения "путаницы"
    procedure check_deposit_type(p_object_id               in number
                                ,p_target_object_type_code in varchar2
                                );

    function get_tranche_interest_rate(p_process_data in clob)
       return c_tranche_interest_rate%rowtype;

    function get_tranche_from_xml(p_data in clob)
       return c_tranche_from_xml%rowtype;

    function get_tranche_from_xml(p_process_id  in number)
       return c_tranche_from_xml%rowtype;

    function read_base_tranche(p_object_id     in number)
                return c_tranche_from_xml%rowtype;

    function read_base_on_demand(p_object_id  in number)
                return c_on_demand_from_xml%rowtype;

    function read_deal_interest_rate_type(
                               p_deal_interest_rate_type_id in number
                              ,p_lock                       in boolean default false
                              ,p_raise_ndf                  in boolean default false
                              ) return deal_interest_rate_type%rowtype;

    function read_deal_interest_rate_type(
                               p_deal_interest_rate_type_code in varchar2
                              ,p_lock                         in boolean default false
                              ,p_raise_ndf                    in boolean default false
                              ) return deal_interest_rate_type%rowtype;

    function get_deal_interest_rate_type_id(p_deal_interest_rate_type_code in varchar2)
                                return number;

    function create_deal_interest_rate_type(
                              p_object_type_code varchar2
                             ,p_type_code        varchar2
                             ,p_type_name        varchar2
                              ) return number;

    function read_deal_interest_rate_kind(
                               p_deal_interest_rate_kind_id in number
                              ,p_lock                       in boolean default false
                              ,p_raise_ndf                  in boolean default false
                              ) return deal_interest_rate_kind%rowtype;

    function read_deal_interest_rate_kind(
                               p_deal_interest_rate_kind_code in varchar2
                              ,p_lock                         in boolean default false
                              ,p_raise_ndf                    in boolean default false
                              ) return deal_interest_rate_kind%rowtype;

    function read_tranche(p_object_id in number) return c_tranche%rowtype;

    function get_deal_interest_rate_kind_id(p_deal_interest_rate_kind_code in varchar2)
                                return number;

    function create_deal_interest_rate_kind(
                              p_deal_interest_rate_type_code  varchar2
                             ,p_kind_code                     varchar2
                             ,p_kind_name                     varchar2
                             ,p_applying_condition            varchar2
                             ,p_is_active                     number   default 1
                              ) return number;

    function create_tranche(p_process_id in number) return number;

    procedure set_interest_rate_tranche(
                         p_object_id     in number
                        ,p_interest_rate in number
                        ,p_valid_from    in date
                        ,p_valid_through in date     default null
                        ,p_comment       in varchar2 default null);

    -- создаем атрибут с процентной ставкой для ДпТ
    procedure set_interest_rate_on_demand(
                         p_object_id     in number
                        ,p_interest_rate in number
                        ,p_valid_from    in date
                        ,p_valid_through in date     default null
                        ,p_comment       in varchar2 default null);

    -- установить информацию в process_history о пользователе фронт-офиса
    procedure set_process_info(p_process_id  in number
                              ,p_info        in varchar2 default null);

    procedure set_calc_info_deposit(
                                p_object_id         in number
                               ,p_last_accrual_date in date
                               ,p_tail_amount       in number);

    function get_object_type_tranche return number;

    function get_object_type_on_demand return number;

    procedure cor_tranche(p_process_id   in out number
                         ,p_data         in clob);
    -- for process
    function create_replenish_tranche(p_process_id   in number) return number;

    -- for UI
    procedure cor_replenish_tranche(p_process_id   in out number
                                   ,p_object_id    in number
                                   ,p_data         in clob);


    procedure tranche_authorization(p_process_id in number);

    procedure tranche_confirmation(p_process_id   in number
                                  ,p_is_confirmed in varchar2 default 'Y'
                                  ,p_comment      in varchar2 default null
                                  ,p_error        out varchar2);

    function get_tranche_xml_data(p_process_id  in number) return clob;

    function get_replenish_tranche_xml_data(p_process_id in number
                                          ,p_object_id  in number)
                        return clob;

    function update_value_in_xml(p_data        in clob
                                ,p_tag         in varchar2
                                ,p_value       in varchar2
                                ,p_parent_node in varchar2 default PARENT_NODE_TRANCHE )
                         return clob;

    function update_value_in_xml(p_data        in clob
                                ,p_node_list   in t_dictionary
                                ,p_parent_node in varchar2 default PARENT_NODE_TRANCHE)
            return clob;

    procedure tranche_blocking(p_process_id in number
                              ,p_lock_date  in date
                              ,p_comment    in varchar2
                              ,p_lock_type  in number);

    procedure tranche_unblocking(p_process_id  in number
                                ,p_unlock_date in date
                                ,p_comment     in varchar2);

    function get_returning_tranche_xml(p_process_id in number
                                     ,p_object_id  in number)
                        return clob;

    procedure cor_returning_tranche(p_process_id   in out number
                                   ,p_object_id    in number
                                   ,p_data         in clob);

    -- отправка на авторизацию досрочного возвращения транша
    procedure returning_tranche_auth(p_process_id in number);

    -- авторизация досрочного возвращения транша
    procedure returning_tranche_confirmation(p_process_id   in number
                                            ,p_is_confirmed in varchar2 default 'Y'
                                            ,p_comment      in varchar2 default null);

    -- DEPOSIT ON DEMAND
    -- инфо для депозита по требованию из clob
    function get_on_demand_from_xml(p_data in clob)
       return c_on_demand_from_xml%rowtype;

    -- инфо для депозита по требованию по process_id
    function get_on_demand_from_xml(p_process_id in number)
       return c_on_demand_from_xml%rowtype;

    -- по процессу
    function get_on_demand_xml_data(p_process_id  in number) return clob;

    -- создание или обновление депозита по требованию вызов UI (web)
    procedure cor_on_demand(p_process_id   in out number
                           ,p_data         in clob);

    -- создание ДпТ
    -- вызов происходит из процессов (process_utl)
    function create_deposit_on_demand(p_process_id  in number) return number;

    -- отправить ДпТ на авторизацию
    procedure on_demand_authorization(p_process_id in number);

    -- подтверждение / отклонение БО
    procedure on_demand_confirmation(p_process_id   in number
                                     ,p_is_confirmed in varchar2 default 'Y'
                                     ,p_comment      in varchar2 default null
                                     ,p_error        out varchar2);

    -- получить данные для закрытия ДпТ
    function get_close_on_demand_xml_data(p_process_id in number
                                         ,p_object_id  in number)
                        return clob;

    -- создание или обновление закрытия ДпТ вызов из UI (web)
    procedure cor_close_on_demand(p_process_id   in out number
                                 ,p_object_id    in number
                                 ,p_data         in clob);

    -- отправить закрытие ДпТ на авторизацию
    procedure close_on_demand_authorization(p_process_id in number);

    -- подтверждение / отклонение БО закрытия ДпТ
    procedure close_on_demand_confirmation(p_process_id   in number
                                          ,p_is_confirmed in varchar2 default 'Y'
                                          ,p_comment      in varchar2 default null
                                          ,p_error        out varchar2);

    function get_on_demand_change_calc_xml(p_process_id  in number)
                        return clob;

    procedure change_calculation_type_dod (p_process_id          in number
                                          ,p_calculation_type_id in number
                                          ,p_comment             in varchar2 default null
                                          );

    -- отправить смену метода начисления для ДпТ на авторизацию
    procedure change_calc_type_authorization(p_process_id in number);

    -- подтверждение / отклонение смены метода начисления для ДпТ
    procedure change_calc_type_confirmation(p_process_id   in number
                                           ,p_is_confirmed in varchar2 default 'Y'
                                           ,p_comment      in varchar2 default null
                                           ,p_error        out varchar2);
    -- кол-во оставшихся пролонгации
    --   вызывается перед автоматическим закрытием
    function get_remaining_prolongation (p_object_id in number)
              return number;

    -- пролонгация депозита - только транши
    procedure set_deposit_prolongation(p_object_id in number);

    -- удалить транш (установить статус object в DELETED)
    procedure delete_tranche(p_process_id in number
                            ,p_comment    in varchar2);

    -- удалить пополнение
    procedure delete_replenishment(p_process_id in number
                                  ,p_comment    in varchar2);

    -- удалить транш (установить статус object в DELETED)
    procedure delete_on_demand(p_process_id in number
                              ,p_comment    in varchar2);

    procedure set_process_data (
                           p_process_id in number
                          ,p_data       in clob);

    -- заполняет параметры счетов депозитного и начисленных %% по id депозита
    procedure set_parameter_deposit(p_object_id in number);

    -- запись ошибок при автоматических расчетах
    procedure registration_calc_errors(p_object_id   in number
                                      ,p_action_type in varchar2
                                      ,p_error       in varchar2);

    -- заявление на размещение транша
    function get_tranche_data_for_print(p_deposit_id in number)
             return tt_smb_data_for_print pipelined;

    -- куди відноситься клієнт
    -- до небанківських фінансових установ або суб'єктів господарювання
    -- для визначеття балансового рахунку і об22
    -- на данный момент поиск через NBS (может чсерез customer.sed (???))
    function get_customer_group (p_customer_id in number
                                ,p_is_tranche  in number default 1)
             return number;

    -- получить счет для расходных/доходных счетов банка (%, штраф)
    function get_expense_account(p_object_id         in number
                                ,p_account_type_code in varchar2)
             return number;

    -- заявление на пополнение
    function get_replenish_data_for_print(p_process_id in number)
             return tt_smb_data_for_print pipelined;

    -- Заява про зменшення строку розміщення Траншу
    function get_data_for_closing_tranche(p_deposit_id in number)
             return tt_smb_data_for_print pipelined;

    -- заявление на размещение депозита по требованию
    function get_dod_data_for_print(p_deposit_id in number)
             return tt_smb_data_for_print pipelined;

    -- Заява про закриття Вкладу на вимогу
    function get_data_for_closing_dod(p_deposit_id in number)
             return tt_smb_data_for_print pipelined;

    -- информация о текущей пролонгации
    function get_tranche_prolongation_xml(p_process_id in number)
             return clob;

    -- список пролонгаций
    function get_prolongation(p_deposit_id in number)
             return tt_smb_prolongation pipelined;

end smb_deposit_utl;
/
create or replace package body smb_deposit_utl
is
     xml_tranche_template varchar2(4000) :=
q'#<SMBDepositTranche xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
<CurrencyId></CurrencyId>
<CustomerId></CustomerId>
<StartDate xsi:nil="true"/>
<ExpiryDate xsi:nil="true"/>
<NumberTrancheDays></NumberTrancheDays>
<AmountTranche></AmountTranche>
<InterestRate></InterestRate>
<IsProlongation></IsProlongation>
<NumberProlongation></NumberProlongation>
<InterestRateProlongation></InterestRateProlongation>
<ApplyBonusProlongation></ApplyBonusProlongation>
<IsReplenishmentTranche></IsReplenishmentTranche>
<MaxSumTranche></MaxSumTranche>
<MinReplenishmentAmount></MinReplenishmentAmount>
<LastReplenishmentDate xsi:nil="true"/>
<FrequencyPayment></FrequencyPayment>
<IsIndividualRate></IsIndividualRate>
<IndividualInterestRate></IndividualInterestRate>
<IsCapitalization></IsCapitalization>
<Comment></Comment>
<PrimaryAccount></PrimaryAccount>
<DebitAccount></DebitAccount>
<ReturnAccount></ReturnAccount>
<InterestAccount></InterestAccount>
<TransitAccount></TransitAccount>
<Branch></Branch>
<ObjectId></ObjectId>
<ProcessId></ProcessId>
<RegisterHistoryId></RegisterHistoryId>
<DealNumber></DealNumber>
<ActionDate xsi:nil="true"/>
<PenaltyRate></PenaltyRate>
<AdditionalComment></AdditionalComment>
<Ref_></Ref_>
<InterestRateCapitalization></InterestRateCapitalization>
<InterestRateBonus></InterestRateBonus>
<InterestRateReplenishment></InterestRateReplenishment>
<InterestRatePayment></InterestRatePayment>
<LockTrancheId></LockTrancheId>
<CapitalizationTerm></CapitalizationTerm>
<IsNotEnoughMoney></IsNotEnoughMoney>
<LastProcessTypeId></LastProcessTypeId>
<IsSigned></IsSigned>
</SMBDepositTranche>#';

     xml_On_Demand_template varchar2(4000) :=
q'#<SMBDepositOnDemand xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
<CurrencyId></CurrencyId>
<CustomerId></CustomerId>
<StartDate xsi:nil="true"/>
<ExpiryDate xsi:nil="true"/>
<InterestRate></InterestRate>
<FrequencyPayment></FrequencyPayment>
<IsIndividualRate></IsIndividualRate>
<IndividualInterestRate></IndividualInterestRate>
<CalculationType></CalculationType>
<Comment></Comment>
<PrimaryAccount></PrimaryAccount>
<DebitAccount></DebitAccount>
<ReturnAccount></ReturnAccount>
<InterestAccount></InterestAccount>
<Branch></Branch>
<ObjectId></ObjectId>
<ProcessId></ProcessId>
<DealNumber></DealNumber>
<ActionDate xsi:nil="true"/>
<AdditionalComment></AdditionalComment>
<Ref_></Ref_>
<IsNotEnoughMoney></IsNotEnoughMoney>
<LastProcessTypeId></LastProcessTypeId>
<TransferDayRegistration></TransferDayRegistration>
<IsSigned></IsSigned>
</SMBDepositOnDemand>#';


     xml_deposit_prolongation varchar2(4000) :=
q'#<SMBDepositProlongation xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
<NumberTrancheDays></NumberTrancheDays>
<StartDate></StartDate>
<ExpiryDate></ExpiryDate>
<ObjectId></ObjectId>
<ProcessId></ProcessId>
</SMBDepositProlongation>#';

    function update_value_in_xml(p_data        in clob
                                ,p_tag         in varchar2
                                ,p_value       in varchar2
                                ,p_parent_node in varchar2 default PARENT_NODE_TRANCHE)
            return clob
     is
        l_res clob;
    begin
        if p_data is null then return null; end if;
        select case when xmltype.existsNode(x, p_parent_node||'/'||p_tag) = 0
                     then appendchildxml(x, p_parent_node, xmltype('<'||p_tag||'>'||p_value||'</'||p_tag||'>')).GetClobVal()
                    when    extractValue(x, p_parent_node||'/'||p_tag||'/text()') is null
                      then     updateXML(x, p_parent_node||'/'||p_tag||'[not(text())]', xmltype('<'||p_tag||'>'||p_value||'</'||p_tag||'>')).GetClobVal()
                      else     updateXML(x, p_parent_node||'/'||p_tag||'/text()', p_value).GetClobVal()
               end
          into l_res
          from(
            select xmltype(p_data) x
                 from dual);
        return l_res;
    end;

    function update_value_in_xml(p_data        in clob
                                ,p_node_list   in t_dictionary
                                ,p_parent_node in varchar2 default PARENT_NODE_TRANCHE)
            return clob
     is
        l_data clob := p_data;
    begin
        for i in 1 .. p_node_list.count() loop
            l_data := update_value_in_xml(
                                 p_data        => l_data
                                ,p_tag         => p_node_list(i).key
                                ,p_value       => p_node_list(i).value
                                ,p_parent_node => p_parent_node);
        end loop;
        return l_data;
    end;

    -- нужно переписывать ( рабочий smb_calculation_deposit)
    -- расчет процентов по депозиту типа "Депозитный Калькулятор"
    -- заполняет коллекцию tt_deposit_calculator
    -- p_object_id - на будущее для возможности показать расчет при пополнении депозита
    -- НЕ ИСПОЛЬЗУЕТСЯ
    procedure deposit_calculator(p_data      in clob
                                ,p_dpt_data  in out nocopy tt_deposit_calculator
                                ,p_object_id in number default null
                                )
     is
         -- календарь дат
          cursor c_dates (p_start_date date, p_end_date date, p_is_calc_eom number) is
              select dates.date_
                    ,case when date_ = next_date_ then 1 else 0 end is_calc_date
                from
                 (
                    -- берем все даты за период
                    select p_start_date + level - 1 date_
                      from dual
                    connect by level <= (p_end_date - p_start_date) + 1
                  ) dates,
                  ( -- выбираем расчтеную дату
                   select -- если расчет процентов производится
                          case when level = 1
                                -- в обоих случаях
                                then p_start_date
                              else
                                 case when p_is_calc_eom = 1 -- eom = end of month
                                       --   расчет в конце месяца
                                       then trunc(add_months(p_start_date, level - 1), 'month')
                                       --  через месяц, то берем add_months
                                       else add_months(p_start_date, level - 1 ) + 1
                                 end
                          end date__
                         ,case when p_is_calc_eom = 1
                              --   расчет в конце месяца
                             then last_day(add_months(p_start_date, level - 1))
                              --  через месяц, то берем add_months
                             else add_months(p_start_date, level)
                          end next_date_
                     from dual
                  connect by add_months(trunc(p_start_date, 'mm'), level - 1 ) < p_end_date
                   ) mnts
               where dates.date_ between mnts.date__ and mnts.next_date_;

             --  возвращает набор всех настроек депозита
             --  возвращаемое кол-во записей = 1 + кол-во пролонгаций, если депозит с прологацией
             cursor c_data (p_data clob) is
                select x.*
                      ,min(x.start_date) over()  exclude_start_date -- исключить из расчета 1 день
                      ,max(x.Expiry_Date) over() exclude_end_date   -- исключить из расчета последний день
                  from(
                         select case when Is_Individual_Rate = 1
                                 then Individual_Interest_Rate
                                 else Interest_Rate + nvl(Interest_Rate_Prolongation, 0) *
                                      case when apply_bonus_prolongation = 1 and level = 2 then 1
                                           when apply_bonus_prolongation = 2 and level <> 1 then 1
                                           else 0
                                      end
                             end Interest_Rate
                            ,Start_Date + (level - 1) * number_tranche_days Start_Date
                            ,Expiry_Date + (level - 1) * number_tranche_days Expiry_Date
                            ,number_tranche_days
                            ,Amount_Tranche  * denom  Amount_Tranche -- расчет в копейках
                            ,Is_Prolongation
                            ,Number_Prolongation
                            ,Apply_Bonus_Prolongation
                            ,Is_Individual_Rate
                            ,Interest_Rate Interest_Rate_base
                            ,Interest_Rate_Prolongation
                            ,Individual_Interest_Rate
                            ,denom
                            ,Is_Capitalization
                            ,Capitalization_Term
                        from(
                          select c.denom
                                ,p.Start_Date
                                ,p.Expiry_Date
                                ,p.number_tranche_days
                                ,p.Amount_Tranche
                                ,p.Is_Prolongation
                                ,p.Is_Capitalization
                                ,p.Capitalization_Term
                                ,trunc(p.Number_Prolongation) Number_Prolongation
                                ,p.Apply_Bonus_Prolongation
                                ,p.Is_Individual_Rate
                                ,p.currency_id
                                ,ir.Interest_Rate
                                ,ir.Interest_Rate_General
                                ,ir.Individual_Interest_Rate
                                ,ir.Interest_Rate_Bonus
                                ,ir.Interest_Rate_Capitalization
                                ,ir.Interest_Rate_Payment
                                ,ir.Interest_Rate_Prolongation
                                ,ir.Interest_Rate_Replenishment
                                ,ir.Interest_Rate_Prl_bonus
                            from xmltable ('/SMBDepositTrancheInterestRate' passing xmltype(get_interest_rate(p_data => p_data)) columns
                                               Interest_Rate                 number         path 'InterestRate'
                                              ,Interest_Rate_General         number         path 'InterestRateGeneral'
                                              ,Individual_Interest_Rate      number         path 'IndividualInterestRate'
                                              ,Interest_Rate_Bonus           number         path 'InterestRateBonus'
                                              ,Interest_Rate_Capitalization  number         path 'InterestRateCapitalization'
                                              ,Interest_Rate_Payment         number         path 'InterestRatePayment'
                                              ,Interest_Rate_Prolongation    number         path 'InterestRateProlongation'
                                              ,Interest_Rate_Replenishment   number         path 'InterestRateReplenishment'
                                              ,Interest_Rate_Prl_bonus       number         path 'InterestRateProlongationBonus' ) ir
                                ,xmltable ('/SMBDepositTranche' passing xmltype(p_data) columns
                                               Start_Date                    date           path 'StartDate'
                                              ,Expiry_Date                   date           path 'ExpiryDate'
                                              ,number_tranche_days           number         path 'NumberTrancheDays'
                                              ,Amount_Tranche                number         path 'AmountTranche'
                                              ,Is_Prolongation               number         path 'IsProlongation'
                                              ,Is_Capitalization             number         path 'IsCapitalization'
                                              ,Capitalization_Term           number         path 'CapitalizationTerm'
                                              ,Number_Prolongation           number         path 'NumberProlongation'
                                              ,Apply_Bonus_Prolongation      number         path 'ApplyBonusProlongation'
                                              ,Is_Individual_Rate            number         path 'IsIndividualRate'
                                              ,currency_id                   number         path 'CurrencyId'
                                              ) p
                                ,tabval c
                           where 1 = 1
                             and p.currency_id = c.kv
                           )
                      connect by level <= Is_Prolongation * nvl(Number_Prolongation, 0) + 1) x
                      order by x.Start_Date;

        l_rownum                     number := 1;
        l_calc                       number;             -- расчетная сумма
        l_tail                       number := 0;        -- "хвост" от округления +/- к следующему расчету
        l_prev_date                  date;               -- дата предыдущего расчета  (пока включительно)
        l_curr_date                  date;               -- дата по которую идет расчет (пока включительно)
        l_denom                      number;             -- делитель / множитель перевод в / из копеек
        l_base_year                  number := 365;      -- кол-во дней в году (тупо взял)
        l_amount_deposit             number;             -- сумма на счете может меняться из-за капитализации
        l_accumulated_capitalization number := 0;        -- для учета капитализации (месяц/квартал)
        l_capitalization_term        number;             -- 1 = месяц; 3 - квартал
        l_accumulated                number := 0;             -- накопленная сумма для капитализации
    begin

        for i in c_data (p_data => p_data) loop

            l_denom     := i.denom;
            l_prev_date := i.start_date; -- + 1;
            if l_amount_deposit is null then
                l_amount_deposit := i.Amount_Tranche;
            end if;
            if l_capitalization_term is null and i.Is_Capitalization = 1 then
               l_capitalization_term  := case when i.Capitalization_Term = 1 then 1 else 3 end;
            end if;
            -- идем по календарю
               -- расчет через месяц от даты начала
            for d in c_dates (p_start_date => i.start_date, p_end_date => i.Expiry_Date, p_is_calc_eom => 1) loop
                -- расчет делаем
                --  через месяц / на конец месяца
                --  заканчивается депозит
                --  меняется ставка или сумма депозита
                if d.is_calc_date = 1 or d.date_ = i.Expiry_Date then
                    l_curr_date := d.date_;
                    -- расчет
                    l_calc := l_amount_deposit * (l_curr_date - l_prev_date + 1 -
                                                 -- нужно ли вычитать эти дни ???
                                                 -- минус первый день
                                                 --  case when i.exclude_start_date = l_prev_date then 1 else 0 end -
                                                 -- минус последний день
                                                   case when i.exclude_end_date = l_curr_date then 1 else 0 end
                                                 ) / l_base_year * i.Interest_Rate / 100 + l_tail
                            ;
                    -- формируем "хвост" для следующего расчет
                    l_tail := l_calc - round(l_calc);
                    p_dpt_data.extend();
                    p_dpt_data(p_dpt_data.last)  :=
                                  t_deposit_calculator(
                                          id                 => l_rownum
                                         ,account_id         => null
                                         ,start_date         => l_prev_date
                                         ,end_date           => l_curr_date - case when i.exclude_end_date = l_curr_date then 1 else 0 end
                                         ,amount_deposit     => l_amount_deposit / l_denom --  возвращаем в грн/usd/...
                                         ,amount_for_accrual => l_amount_deposit / l_denom --  возвращаем в грн/usd/...
                                         ,interest_rate      => i.Interest_Rate
                                         ,interest_amount    => round(l_calc) / l_denom    --  возвращаем в грн/usd/...
                                         ,interest_tail      => l_tail
                                         ,accrual_method     => null
                                         ,currency_id        => null
                                         ,comment_           => null);

                    l_prev_date := l_curr_date  + 1;
                    l_accumulated := l_accumulated + round(l_calc);
                    -- проверка на капитализацию происходит
                       -- или в конце месяца / квартала
                       -- или через каждый месяц / квартал от даты начала
                       -- т.е is_calc_date = 1
                    if i.Is_Capitalization = 1 and d.is_calc_date = 1 then
                        l_accumulated_capitalization := l_accumulated_capitalization + 1;
                        -- если делится без остатка, производим капитализацию
                        if mod(l_accumulated_capitalization, l_capitalization_term) = 0 then
                            l_amount_deposit := l_amount_deposit + l_accumulated;
                            l_accumulated := 0;
                            l_accumulated_capitalization := 0;
                        end if;
                    end if;
                    l_rownum := l_rownum + 1;
                end if;
            end loop;
        end loop;

    end deposit_calculator;

    -- получить последнюю активность по депозиту (транш, пополнеие, ДпТ, удаление ....)
    function get_users_activity(p_process_id in number)
        return varchar2
     is
        l_res varchar2(1000);
    begin
        select '<OperatorSysTime>'   ||to_char(max(x.sys_time), 'yyyy-mm-dd"T"hh24:mi:ss')||'</OperatorSysTime>'||
               '<OperatorFullName>'  ||to_char(max(u.fio))||'</OperatorFullName>'||
               '<ControllerSysTime>' ||to_char(max(x.controller_sys_time), 'yyyy-mm-dd"T"hh24:mi:ss')||'</ControllerSysTime>'||
               '<ControllerFullName>'||to_char(max(u1.fio))||'</ControllerFullName>'
          into l_res
          from (
                select max(sys_time) sys_time
                      ,max(user_id) keep (dense_rank last order by h.id) operator_id
                      ,cast(null as date) controller_sys_time
                      ,cast(null as number) controller_id
                  from process_history h
                 where 1 = 1
                   and h.process_id = p_process_id
                   -- фронт офис может только редактировать и удалять (т.е. состояние -  1, 4 (пока ??))
                   and (h.process_state_id = 4
                     or (h.process_state_id = 1   --
                       and (
                           -- много авторизаций, не берем строки со статусом 1 от бэк-офиса
                           exists(select null
                                    from process_history h1
                                   where h1.process_id = p_process_id
                                     and h1.process_state_id = 2
                                     and h1.id < h.id
                                     and (h.id, 1) in
                                           (
                                            select h2.id, lag(h2.process_state_id) over(order by h2.id) state_id
                                              from process_history h2
                                             where h2.process_id = p_process_id
                                               and h2.id <= h.id)
                                           )
                      -- одна авторизация, которая была отклонена
                      or h.id < (
                                  select max(id)
                                    from process_history h1
                                   where h1.process_id = p_process_id
                                     and h1.process_state_id = 2
                                  having count(*) = 1)
                      -- всегда берем самую первую запись со статусом создано
                      -- в окончательном варианте все равно берем max
                      or h.id = (
                                  select min(id)
                                    from process_history h1
                                   where h1.process_id = p_process_id
                                     and h1.process_state_id = 1
                                  )
                      -- на авторизацию не уходило
                      or not exists (
                                  select null
                                    from process_history h1
                                   where h1.process_id = p_process_id
                                     and h1.process_state_id = 2)
                                        ) )
                                            )
                union all
                select sysdate sys_time
                      ,user_id() operator_id
                      ,cast(null as date) controller_sys_time
                      ,cast(null as number) controller_id
                  from dual
                 where p_process_id is null
                union all
                select null
                      ,null
                      ,h.sys_time controller_sys_time
                      ,h.user_id controller_id
                  from activity a
                      ,activity_history h
                 where a.process_id = p_process_id
                   and a.id = h.activity_id
                   and h.activity_state_id <> 1
                 ) x
              ,staff$base u
              ,staff$base u1
         where x.operator_id = u.id(+)
           and x.controller_id = u1.id(+);
        return '<ROOT>'||l_res||'</ROOT>';
    end;

    -- изменить статус is_active => 0 -- не активный
    -- если дата valid_through в прошлом
    procedure set_inactive_deal_int_option(p_date in date)
     is
    begin
        return;
        update deal_interest_option io set
            is_active = 0
           ,sys_time  = sysdate
           ,user_id   = user_id()
         where io.valid_through < p_date
           and io.is_active = 1;
    end;

    -- последняя ошибка в процессе
    -- процесс в статусе FAILURE
    function get_last_error_on_process(p_process_id  in number)
          return varchar2
     is
        l_comment_text varchar2(4000);
    begin
        select max(h.comment_text) keep (dense_rank first order by h.id desc)
          into l_comment_text
          from process p
              ,activity a
              ,activity_history h
              ,process_workflow pw
         where 1 = 1
           and a.process_id = p.id
           and p.id = p_process_id
           and p.state_id = process_utl.GC_PROCESS_STATE_FAILURE
           and a.state_id = process_utl.ACT_STATE_FAILED
           and h.activity_id = a.id
           and h.activity_state_id = process_utl.ACT_STATE_FAILED
           and pw.process_type_id = p.process_type_id
           and a.activity_type_id = pw.id;
        return l_comment_text;
    end;

    -- расчет процентов по депозиту типа Депозитного Калькулятора
    -- возвращает xml
    function get_interest_calculation (p_data      in clob
                                      ,p_object_id in number)
        return clob
     is
      /* -- структура возвращаемого xml
      <Root>
      <TotalInterestAmount></TotalInterestAmount>
      <Rows>
          <Row>
             <StartDate></StartDate>
             <EndDate></EndDate>
             <AmountDeposit></AmountDeposit>
             <InterestRate></InterestRate>
             <InterestAmount></InterestAmount>
          </Row>
      </Rows>
      </Root>
      */
        l_data      clob;
        l_dpt_data  tt_deposit_calculator := tt_deposit_calculator();
    begin
        -- выполняем расчет, заполняем таблицу acr_intn
        deposit_calculator(p_data      => p_data
                          ,p_dpt_data  => l_dpt_data
                          ,p_object_id => p_object_id);

        -- формируем xml
        select xmlelement("Root",
                    xmlforest(
                       sum(x.Interest_Amount) as "TotalInterestAmount"
                       ),
                     xmlelement("Rows"
                      ,xmlagg(
                        xmlelement("Row",
                             xmlforest(
                                       x.start_date      as "StartDate"
                                      ,x.end_date        as "EndDate"
                                      ,x.Amount_Deposit  as "AmountDeposit"
                                      ,x.Interest_Rate   as "InterestRate"
                                      ,x.Interest_Amount as "InterestAmount")
                                 )  order by x.start_date) )).GetClobVal()
          into l_data
          from table(l_dpt_data) x;

        return l_data;
    end;
    -- возвращает table
    function get_interest_calculation_table (p_data      in clob
                                            ,p_object_id in number)
        return tt_deposit_calculator pipelined
     is
        l_dpt_data  tt_deposit_calculator := tt_deposit_calculator();
    begin
        -- выполняем расчет, заполняем коллекцию l_dpt_data
        deposit_calculator(p_data      => p_data
                          ,p_dpt_data  => l_dpt_data
                          ,p_object_id => p_object_id);

        for i in l_dpt_data.first .. l_dpt_data.last loop
             pipe row(l_dpt_data(i));
        end loop;
    end;

    function get_object_type_tranche return number
     is
    begin
       return object_utl.read_object_type(p_object_type_code => TRANCHE_OBJECT_TYPE_CODE).id;
    end;

    function get_object_type_on_demand return number
     is
    begin
       return object_utl.read_object_type(p_object_type_code => ON_DEMAND_OBJECT_TYPE_CODE).id;
    end;

    -- установить информацию в process_history о пользователе фронт-офиса
    procedure set_process_info(p_process_id  in number
                              ,p_info        in varchar2 default null)
     is
    begin
        update process_history h
           set h.comment_text = case when  p_info is not null then p_info else G_PROCESS_INFO_FRONT_OFFICE end
              ,h.sys_time = sysdate
          where h.process_id  = p_process_id
            and h.id = (
                       select max(id)
                         from process_history h1
                        where h1.process_id = p_process_id);
    end;


    function get_interest_rate(p_data in clob
                              ,p_date in date default null)
       return clob
     is
      /* -- структура возвращаемого xml
      <SMBDepositTrancheInterestRate>
      <InterestRate></InterestRate>
      <IndividualInterestRate/>
      <InterestRateBonus></InterestRateBonus>
      <BonusDescription></BonusDescription>
      <InterestRateGeneral></InterestRateGeneral>
      <InterestRatePayment></InterestRatePayment>
      <InterestRateProlongation></InterestRateProlongation>
      <InterestRateReplenishment></InterestRateReplenishment>
      <InterestRateCapitalization></InterestRateCapitalization>
      <InterestRateProlongationBonus></InterestRateProlongationBonus>
      </SMBDepositTrancheInterestRate>
      */

        l_tranche_row    c_tranche_from_xml%rowtype;
        l_res            clob;
        l_object_type_id number;
        l_product_id     number;
        l_date           date;
    begin
        logger.log_info(p_procedure_name => $$plsql_unit||'.get_interest_rate'
                       ,p_log_message    => 'start'
                       ,p_object_id      => null
                       ,p_auxiliary_info => p_data
                        );
        l_tranche_row    := get_tranche_from_xml(p_data => p_data);
        l_date           := nvl(p_date, l_tranche_row.start_date);
        l_object_type_id := get_object_type_tranche();
        l_product_id     := product_utl.read_product(
                                                 p_product_type_id => l_object_type_id
                                                ,p_product_code    => TRANCHE_PRODUCT_CODE
                                                ).id;
        with option_ as(
            select irk.kind_name
                  ,ir.type_code
                  ,irk.kind_code
                  ,o.id option_id
                  ,o.valid_from
                  ,o.valid_through
                  ,o.option_description
              from deal_interest_rate_type ir
                  ,deal_interest_rate_kind irk
                  ,deal_interest_option o
             where ir.id = irk.type_id
               and irk.id = o.rate_kind_id
               and o.is_active = 1
               and ir.object_type_id = l_object_type_id
               and o.product_id = l_product_id
               and o.valid_from <= l_date
               and nvl(o.valid_through, l_date) >= l_date
               and l_tranche_row.is_individual_rate = 0
               )
            select '<SMBDepositTrancheInterestRate>'||
                   case when l_tranche_row.is_individual_rate = 1
                      then
                         '<IndividualInterestRate>'||
                         l_tranche_row.Individual_Interest_Rate ||
                         '</IndividualInterestRate>'
                      else
                         '<InterestRate>' ||
                         sum(case when name_node <> 'InterestRateProlongation' then interest_rate end) ||
                         '</InterestRate>'||
                         listagg('<'||name_node||'>' || interest_rate || '</'||name_node||'>', '')
                             within group (order by name_node) ||
                         max('<BonusDescription>'||option_description||'</BonusDescription>')
                   end ||
                   '</SMBDepositTrancheInterestRate>' interest_rate_list
              into l_res
              from(
                -- берем индивидуальную ставку
                select 'INDIVIDUAL' type_code
                       ,null name_node
                       ,l_tranche_row.Individual_Interest_Rate interest_rate
                       ,'' option_description
                  from dual
                 where l_tranche_row.is_individual_rate = 1
                union all
                -- базовая ставка + бонусная ставка
                select o.type_code
                      ,case when o.type_code = 'GENERAL' then 'InterestRateGeneral'
                            else 'InterestRateBonus'
                       end  name_node
                      ,min(c.interest_rate) keep (dense_rank first order by o.valid_from desc, c.term_from desc, c.amount_from desc) interest_rate
                      ,case when o.type_code = 'BONUS' then
                            min(o.option_description) keep (dense_rank first order by o.valid_from desc, c.term_from desc, c.amount_from desc)
                       end option_description
                  from option_ o
                      ,interest_rate_condition c
                 where o.option_id = c.interest_option_id
                   and c.currency_id = l_tranche_row.currency_id
                   and c.term_from <= l_tranche_row.number_tranche_days
                   and c.amount_from <= l_tranche_row.amount_tranche / 100
                group by o.type_code
                union all
                -- % ставка (+/-) при выплате процентов
                select o.type_code
                      ,'InterestRatePayment' name_node
                      ,min(c.interest_rate) keep (dense_rank first order by o.valid_from desc) interest_rate
                      ,'' option_description
                  from option_ o
                      ,deposit_payment c
                 where o.option_id = c.interest_option_id
                   and c.currency_id = l_tranche_row.currency_id
                   and c.payment_term_id = l_tranche_row.frequency_payment
                   and l_tranche_row.is_capitalization = 0
                group by o.type_code
                union all
                -- % ставка (+/-) при пополнении
                select o.type_code
                      ,'InterestRateReplenishment' name_node
                      ,min(c.interest_rate) keep (dense_rank first order by o.valid_from desc) interest_rate
                      ,'' option_description
                  from option_ o
                      ,deposit_replenishment c
                 where o.option_id = c.interest_option_id
                   and c.currency_id = l_tranche_row.currency_id
                   and nvl(l_tranche_row.is_replenishment_tranche, 0) = c.is_replenishment
                group by o.type_code
                union all
                -- % ставка (+/-) при капитализации
                select o.type_code
                      ,'InterestRateCapitalization' name_node
                      ,min(c.interest_rate) keep (dense_rank first order by o.valid_from desc) interest_rate
                      ,'' option_description
                  from option_ o
                      ,deposit_capitalization c
                 where o.option_id = c.interest_option_id
                   and c.currency_id = l_tranche_row.currency_id
                   and c.payment_term_id = l_tranche_row.frequency_payment
                   and l_tranche_row.is_capitalization = 1
                group by o.type_code
                union all
                -- % ставка (+/-) при пролонгации
                select o.type_code
                      ,'InterestRateProlongation' name_node
                      ,max(c.interest_rate) keep (dense_rank first order by c.amount_from desc, o.valid_from desc) interest_rate
                      ,'' option_description
                  from option_ o
                      ,deposit_prolongation c
                 where o.option_id = c.interest_option_id
                   and c.currency_id = l_tranche_row.currency_id
                   and c.amount_from <= l_tranche_row.number_prolongation
                   and l_tranche_row.is_prolongation = 1
                   and c.apply_to_first = l_tranche_row.apply_bonus_prolongation
                group by o.type_code
                union all
                -- бонусна % ставка (+/-) при пролонгации
                select o.type_code
                      ,'InterestRateProlongationBonus' name_node
                      ,max(c.interest_rate) keep (dense_rank first order by o.valid_from desc) interest_rate
                      ,'' option_description
                  from option_ o
                      ,deposit_prolongation_bonus c
                 where o.option_id = c.interest_option_id
                   and c.currency_id = l_tranche_row.currency_id
                   and c.is_prolongation = l_tranche_row.is_prolongation
                group by o.type_code) x
                ;
        logger.log_info(p_procedure_name => $$plsql_unit||'.get_interest_rate',
                        p_log_message    => 'end'
                       ,p_object_id      => null
                       ,p_auxiliary_info => l_res
                        );

        return l_res;
    end get_interest_rate;

    -- % ставки для заблокованих траншів срок дії яких закінчився
    function get_interest_rate_blocked(
                                p_object_id    in number
                               ,p_date         in date
                               ,p_currency_id  in number)
        return number
     is
        l_date           date;
        l_interest_rate  number;
    begin
        logger.log_info(p_procedure_name => $$plsql_unit||'.get_interest_rate_blocked'
                       ,p_log_message    => 'p_date : '|| to_char(p_date, 'yyyy-mm-dd')
                       ,p_object_id      => p_object_id
                        );
        l_date           := nvl(p_date, gl.bdate);

        with option_ as(
            select o.id option_id
                  ,o.valid_from
              from deal_interest_rate_kind irk
                  ,deal_interest_option o
             where irk.kind_code = RATE_FOR_BLK_TRANCHE_KIND_CODE
               and o.rate_kind_id = irk.id
               and o.is_active = 1
               and o.valid_from <= l_date
               and nvl(o.valid_through, l_date) >= l_date)
        select max(c.interest_rate) keep (dense_rank first order by o.valid_from desc) interest_rate
          into l_interest_rate
          from option_ o
              ,rate_for_blocked_tranche c
         where o.option_id = c.interest_option_id
           and c.currency_id = p_currency_id;

        return l_interest_rate;

    end get_interest_rate_blocked;

     -- штрафная % ставка при досрочном возвращении транша
    function get_penalty_interest_rate(p_data in clob)
       return number
     is
        l_tranche_row      c_tranche_from_xml%rowtype;
        l_res              number;
        l_object_type_id   number;
        l_product_id       number;
        l_ir               number;
    begin
        l_tranche_row    := get_tranche_from_xml(p_data => p_data);
        l_object_type_id := get_object_type_tranche();

        l_product_id     := product_utl.read_product(
                                                 p_product_type_id => l_object_type_id
                                                ,p_product_code    => TRANCHE_PRODUCT_CODE
                                                ).id;

        -- соотношение срока действия транша к досрочной дате возврата
        -- 100 - (дата возврата - дата начала) * 100 / (дата завершения транша - дата начала)
        l_ir := 100 - (least(l_tranche_row.action_date, l_tranche_row.expiry_date) - l_tranche_row.start_date + 1) * 100 / (l_tranche_row.expiry_date - l_tranche_row.start_date + 1);

        with option_ as(
            select irk.kind_name
                  ,ir.type_code
                  ,irk.kind_code
                  ,o.id option_id
                  ,o.valid_from
                  ,o.valid_through
                  ,o.option_description
              from deal_interest_rate_type ir
                  ,deal_interest_rate_kind irk
                  ,deal_interest_option o
             where ir.id = irk.type_id
               and irk.id = o.rate_kind_id
               and irk.kind_code = PENALTY_RATE_KIND_CODE
               and o.is_active = 1
               and ir.object_type_id = l_object_type_id
               and o.product_id = l_product_id
               and o.valid_from <= l_tranche_row.action_date
               and nvl(o.valid_through, l_tranche_row.action_date) >= l_tranche_row.action_date
               )
        -- штрафная ставка
        select min(c.penalty_rate) keep (dense_rank first order by o.valid_from desc, c.rate_from desc) penalty_rate
          into l_res
          from option_ o
              ,rate_for_return_tranche c
         where o.option_id = c.interest_option_id
           and c.currency_id = l_tranche_row.currency_id
           and c.rate_from  <= l_ir;

        logger.log_info(p_procedure_name => $$plsql_unit||'.get_penalty_interest_rate'
                       ,p_log_message    => 'interest rate : '|| l_res
                       ,p_auxiliary_info => p_data
                        );

        return l_res;
    end get_penalty_interest_rate;

    -- не используется
    -- так как зависит от суммы, а счет может пополнятся в любое время
    function get_interest_rate_on_demand(p_data in clob)
       return clob
     is
      /* -- структура возвращаемого xml
      <SMBDepositOnDemandInterestRate>
      <InterestRate></InterestRate>
      <IndividualInterestRate></IndividualInterestRate>
      </SMBDepositOnDemandInterestRate>
      */

        l_on_demand_row          c_on_demand_from_xml%rowtype;
        l_res            clob;
        l_object_type_id number;
        l_product_id     number;
    begin
        l_on_demand_row  := get_on_demand_from_xml(p_data => p_data);
        l_object_type_id := get_object_type_on_demand();
        l_product_id     := product_utl.read_product(
                                                 p_product_type_id => l_object_type_id
                                                ,p_product_code    => ON_DEMAND_PRODUCT_CODE
                                                ).id;
        with option_ as(
            select irk.kind_name
                  ,ir.type_code
                  ,irk.kind_code
                  ,o.id option_id
                  ,o.valid_from
                  ,o.valid_through
                  ,o.option_description
              from deal_interest_rate_type ir
                  ,deal_interest_rate_kind irk
                  ,deal_interest_option o
             where ir.id = irk.type_id
               and irk.id = o.rate_kind_id
               and o.is_active = 1
               and ir.object_type_id = l_object_type_id
               and ir.type_code = smb_deposit_utl.ON_DEMAND_GENERAL_TYPE
               and o.product_id = l_product_id
               and o.valid_from <= l_on_demand_row.start_date
               and nvl(o.valid_through, l_on_demand_row.start_date) >= l_on_demand_row.start_date
                   )
            select '<SMBDepositOnDemandInterestRate>'||
                   '<InterestRate>'  ||
                    case when l_on_demand_row.is_individual_rate = 0 then max(interest_rate) end ||
                   '</InterestRate>' ||
                   '<IndividualInterestRate>'  ||
                    case when l_on_demand_row.is_individual_rate = 1 then max(interest_rate) end ||
                   '</IndividualInterestRate>' ||
                   '</SMBDepositOnDemandInterestRate>' interest_rate_list
              into l_res
              from(
                select o.type_code
                       -- берем ближайшее значение
                      ,min(c.interest_rate) keep (dense_rank first order by o.valid_from desc, c.amount_from desc) interest_rate
                  from option_ o
                      ,deposit_on_demand_condition c
                 where o.option_id = c.interest_option_id
                   and c.currency_id = l_on_demand_row.currency_id
                   and c.amount_from <= 0
                   and l_on_demand_row.is_individual_rate = 0
                group by o.type_code
                union all
                -- берем индивидуальную ставку
                select 'INDIVIDUAL' type_code
                       ,l_on_demand_row.Individual_Interest_Rate interest_rate
                  from dual
                 where l_on_demand_row.is_individual_rate = 1
                ) x
                ;

        return l_res;
    end get_interest_rate_on_demand;

    -- при пополнении (вызов для UI)
    --   последняя дата когда можно пополнять транш
    function get_last_replenishment_date (
                          p_start_date  in date
                         ,p_end_date    in date)
         return date
     is
        l_replenishment_date date;
        l_object_type_id     number;
        l_product_id         number;
    begin
        l_object_type_id := get_object_type_tranche();

        l_product_id     := product_utl.read_product(
                                                 p_product_type_id => l_object_type_id
                                                ,p_product_code    => TRANCHE_PRODUCT_CODE
                                                ).id;
        with option_ as(
            select irk.kind_name
                  ,ir.type_code
                  ,irk.kind_code
                  ,o.id option_id
                  ,o.valid_from
                  ,o.valid_through
                  ,o.option_description
                  ,ir.object_type_id
                  ,o.product_id
              from deal_interest_rate_type ir
                  ,deal_interest_rate_kind irk
                  ,deal_interest_option o
             where ir.id = irk.type_id
               and irk.id = o.rate_kind_id
               and irk.kind_code = REPLENISHMENT_TRN_KIND_CODE
               and o.is_active = 1
               and ir.object_type_id = l_object_type_id
               and o.product_id = l_product_id
               and o.valid_from <= p_start_date
               and nvl(o.valid_through, p_start_date) >= p_start_date -- попадание только p_start_date
               )
        -- дата последнего пополнения
        select --case when nvl(min(c.days_to_close_replenish) keep (dense_rank first order by o.valid_from desc, c.tranche_term desc), 0) = 0
               --    then null
               --    else
                        p_end_date -
                        min(c.days_to_close_replenish) keep (dense_rank first order by c.tranche_term desc, o.valid_from desc )
               --end date_
          into l_replenishment_date
          from option_ o
              ,terms_replenishment_tranche c
         where o.option_id = c.interest_option_id
           and c.tranche_term <= (p_end_date - p_start_date);
        return l_replenishment_date;
    end;
    -- пока без параметров (ошиька 1 на все)
    procedure check_current_branch
     is
    begin
        if length(bc.current_branch_code) < 22 then
            raise_application_error(-20000, 'Не можливо створення операцій по депозиту на рівні РУ');
        end if;
    end;

    -- проверка суммы транша / пополнения на min / max значение
    procedure check_amount_tranche(
                           p_tranche_row c_tranche_from_xml%rowtype
                          ,p_is_tranche  number)
     is
        l_object_type_id     number;
        l_product_id         number;
        l_interest_option_id number;
        l_qty                number;
        l_is_exists          number;
        l_min_value          number;
        l_max_value          number;
    begin
        l_object_type_id := get_object_type_tranche();
        l_product_id     := product_utl.read_product(
                                                 p_product_type_id => l_object_type_id
                                                ,p_product_code    => TRANCHE_PRODUCT_CODE
                                                ).id;
        select -- берем ID по самой "близкой" дате к началу действия транша
               max(o.id) keep (dense_rank first order by valid_from desc) option_id
          into l_interest_option_id
          from deal_interest_rate_type ir
              ,deal_interest_rate_kind irk
              ,deal_interest_option o
         where ir.id = irk.type_id
           and irk.id = o.rate_kind_id
           and o.is_active = 1
           and ir.object_type_id = l_object_type_id
           and o.product_id = l_product_id
           and ir.type_code = AMOUNT_SETTING_TYPE
           and o.valid_from <= p_tranche_row.start_date
           and nvl(o.valid_through, p_tranche_row.start_date) >= p_tranche_row.start_date;
        if l_interest_option_id is null then
            -- не нашли период - выходим
            -- ограничений на дату создания транша нет
            return;
        end if;
        -- если кол-во = 1
        --     проверяем сумму на попадание в диапазон min/max
        --     вне диапазона делаем raise
        -- если кол-во = 0
        --     ограничений нет по данной валюте
        select count(*) qty
              ,min(case
                      when case p_is_tranche
                             when 1 then s.min_sum_tranche
                             when 0 then s.min_replenishment_amount
                           end <= p_tranche_row.amount_tranche / p_tranche_row.denom
                       and nvl(
                           case p_is_tranche
                              when 1 then s.max_sum_tranche
                              when 0 then s.max_replenishment_amount
                           end, p_tranche_row.amount_tranche / p_tranche_row.denom) >= p_tranche_row.amount_tranche / p_tranche_row.denom
                      then 1
                   end) is_exists
               -- вибираем min / max значения для raise. если нужно
              ,min(case p_is_tranche
                      when 1 then s.min_sum_tranche
                      when 0 then s.min_replenishment_amount
                   end) min_sum
              ,max(case p_is_tranche
                     when 1 then s.max_sum_tranche
                     when 0 then s.max_replenishment_amount
                   end) max_sum
          into l_qty, l_is_exists, l_min_value, l_max_value
          from deposit_amount_setting s
         where s.interest_option_id = l_interest_option_id
           and s.currency_id = p_tranche_row.currency_id
                  ;
        -- l_qty       = 0 - ограничений по сумме по данной валюте на дату создания/пополнеия транша НЕТ
        -- l_is_exists = 1 - сумма входит в диапазон
        if l_qty = 0 or l_is_exists = 1 then
            -- выходим
            return;
        end if;
        raise_application_error(-20000, 'Сума '|| case p_is_tranche when 1 then 'траншу ' when 0 then 'поповнення ' end||
                                        'повинна бути '||
                                        case when l_max_value is null
                                            then 'більшою або дорівнювати {'|| l_min_value ||'}'
                                            else 'в діапазоні від {'||l_min_value||'} до {'||l_max_value||'}'
                                        end);
    end;

    -- проверка на тип депозита
    -- так как ТРАНШ и Депозит по требованию имеют разные типы
    --      для транша его тип должен быть SMB_DEPOSIT_TRANCHE
    --      для ДпТ его тип должен быть SMB_DEPOSIT_ON_DEMAND
    -- для предотвращения "путаницы"
    procedure check_deposit_type(p_object_id               in number
                                ,p_target_object_type_code in varchar2
                                )
     is
        l_object_row        object%rowtype;
        l_object_type_id    number;
    begin
        l_object_row := object_utl.read_object(
                                        p_object_id => p_object_id
                                       ,p_raise_ndf => true);

        l_object_type_id :=  object_utl.get_object_type_id(p_object_type_code => p_target_object_type_code);
        if l_object_row.object_type_id <> l_object_type_id then
            raise_application_error(-20000, 'Депозит не є {'||
                                            object_utl.get_object_type_name (
                                                          p_object_type_code => p_target_object_type_code) ||'}');
        end if;
    end;

    -- проверка на типа депозита
    -- по процессу находим его объект
    -- и вызываем check_deposit_type с объектом
    procedure check_deposit_type(p_process_id         in number
                                ,p_target_object_code in varchar2
                                )
     is
    begin
        check_deposit_type(
                   p_object_id               => process_utl.read_process (
                                                      p_process_id => p_process_id
                                                     ,p_raise_ndf    => true).object_id
                  ,p_target_object_type_code => p_target_object_code
                                );
    end;

    -- получить % ставки по процессу
    function get_interest_rate_by_process(p_process_id in number)
       return clob
     is
    begin
        return get_interest_rate(p_data => process_utl.read_process(
                                                         p_process_id => p_process_id
                                                        ,p_raise_ndf  => true).process_data);
    end get_interest_rate_by_process;

    -- получить % ставки по объекту
    function get_interest_rate_by_object(p_object_id in number)
       return clob
     is
    begin
        return get_interest_rate_by_process(p_process_id => read_base_tranche(p_object_id => p_object_id).process_id);
    end get_interest_rate_by_object;

    function read_deal_interest_rate_type(
                               p_deal_interest_rate_type_id in number
                              ,p_lock                       in boolean default false
                              ,p_raise_ndf                  in boolean default false
                              ) return deal_interest_rate_type%rowtype
     is
        l_deal_interest_rate_type_row deal_interest_rate_type%rowtype;
    begin
        if (p_lock) then
            select *
              into l_deal_interest_rate_type_row
              from deal_interest_rate_type ir
             where ir.id = p_deal_interest_rate_type_id
            for update;
        else
            select *
              into l_deal_interest_rate_type_row
              from deal_interest_rate_type ir
             where ir.id = p_deal_interest_rate_type_id;
        end if;

        return l_deal_interest_rate_type_row;
    exception
        when no_data_found then
           if (p_raise_ndf) then
              raise_application_error(-20000, 'Тип процентної ставки з ідентифікатором {' || p_deal_interest_rate_type_id ||'} не знайдений');
           end if;
           return null;
    end read_deal_interest_rate_type;

    function read_deal_interest_rate_type(
                               p_deal_interest_rate_type_code in varchar2
                              ,p_lock                         in boolean default false
                              ,p_raise_ndf                    in boolean default false
                              ) return deal_interest_rate_type%rowtype
     is
        l_deal_interest_rate_type_row deal_interest_rate_type%rowtype;
    begin
        if (p_lock) then
            select *
              into l_deal_interest_rate_type_row
              from deal_interest_rate_type ir
             where ir.type_code = p_deal_interest_rate_type_code
            for update;
        else
            select *
              into l_deal_interest_rate_type_row
              from deal_interest_rate_type ir
             where ir.type_code = p_deal_interest_rate_type_code;
        end if;

        return l_deal_interest_rate_type_row;
    exception
        when no_data_found then
           if (p_raise_ndf) then
              raise_application_error(-20000, 'Тип процентної ставки з кодом {' || p_deal_interest_rate_type_code ||'} не знайдений');
           end if;
           return null;
    end read_deal_interest_rate_type;

    function get_deal_interest_rate_type_id(p_deal_interest_rate_type_code in varchar2)
                                return number
     is
    begin
        return read_deal_interest_rate_type(p_deal_interest_rate_type_code => p_deal_interest_rate_type_code).id;

    end get_deal_interest_rate_type_id;

    function create_deal_interest_rate_type(
                              p_object_type_code varchar2
                             ,p_type_code        varchar2
                             ,p_type_name        varchar2
                              ) return number
     is
        l_object_type_id number;
        l_id             number;
    begin
        l_object_type_id := object_utl.read_object_type(p_object_type_code).id;

        insert into deal_interest_rate_type (id, object_type_id, type_code, type_name)
          values(deal_interest_option_seq.nextVal, l_object_type_id, p_type_code, p_type_name)
          returning id into l_id;
        return l_id;
    end create_deal_interest_rate_type;

    function read_deal_interest_rate_kind(
                               p_deal_interest_rate_kind_id in number
                              ,p_lock                       in boolean default false
                              ,p_raise_ndf                  in boolean default false
                              ) return deal_interest_rate_kind%rowtype
     is
        l_deal_interest_rate_kind_row deal_interest_rate_kind%rowtype;
    begin
        if (p_lock) then
            select *
              into l_deal_interest_rate_kind_row
              from deal_interest_rate_kind ir
             where ir.id = p_deal_interest_rate_kind_id
            for update;
        else
            select *
              into l_deal_interest_rate_kind_row
              from deal_interest_rate_kind ir
             where ir.id = p_deal_interest_rate_kind_id;
        end if;

        return l_deal_interest_rate_kind_row;
    exception
        when no_data_found then
           if (p_raise_ndf) then
              raise_application_error(-20000, 'Вид процентної ставки з ідентифікатором {' || p_deal_interest_rate_kind_id ||'} не знайдений');
           end if;
           return null;
    end read_deal_interest_rate_kind;

    function read_deal_interest_rate_kind(
                               p_deal_interest_rate_kind_code in varchar2
                              ,p_lock                         in boolean default false
                              ,p_raise_ndf                    in boolean default false
                              ) return deal_interest_rate_kind%rowtype
     is
        l_deal_interest_rate_kind_row deal_interest_rate_kind%rowtype;
    begin
        if (p_lock) then
            select *
              into l_deal_interest_rate_kind_row
              from deal_interest_rate_kind ir
             where ir.kind_code = p_deal_interest_rate_kind_code
            for update;
        else
            select *
              into l_deal_interest_rate_kind_row
              from deal_interest_rate_kind ir
             where ir.kind_code = p_deal_interest_rate_kind_code;
        end if;

        return l_deal_interest_rate_kind_row;
    exception
        when no_data_found then
           if (p_raise_ndf) then
              raise_application_error(-20000, 'Вид процентної ставки з кодом {' || p_deal_interest_rate_kind_code ||'} не знайдений');
           end if;
           return null;
    end read_deal_interest_rate_kind;


    function get_deal_interest_rate_kind_id(p_deal_interest_rate_kind_code in varchar2)
                                return number
     is
    begin
        return read_deal_interest_rate_kind(
                               p_deal_interest_rate_kind_code => p_deal_interest_rate_kind_code).id;
    end;

    function create_deal_interest_rate_kind(
                              p_deal_interest_rate_type_code  varchar2
                             ,p_kind_code                     varchar2
                             ,p_kind_name                     varchar2
                             ,p_applying_condition            varchar2
                             ,p_is_active                     number   default 1
                              ) return number
     is
        l_ir_type_id    number;
        l_id            number;
    begin
        l_ir_type_id := read_deal_interest_rate_type(
                               p_deal_interest_rate_type_code => p_deal_interest_rate_type_code
                              ,p_raise_ndf                    => true).id;
        insert into deal_interest_rate_kind(id, type_id, kind_code, kind_name, applying_condition, is_active)
         values(deal_interest_option_seq.nextVal, l_ir_type_id, p_kind_code, p_kind_name, p_applying_condition, p_is_active)
         returning id into l_id;

        return l_id;
    end create_deal_interest_rate_kind;

    procedure set_calc_info_deposit(
                                p_object_id         in number
                               ,p_last_accrual_date in date
                               ,p_tail_amount       in number)
     is
    begin
        update smb_deposit set
                last_accrual_date = p_last_accrual_date
               ,tail_amount       = p_tail_amount
         where id = p_object_id;
    end;

    procedure set_interest_rate_log(p_object_id    in number
                                   ,p_process_data in clob
                                   ,p_date         in date)
     is
        l_process_data       clob;
        l_process_id         number;
    begin
        if p_object_id is null then return; end if;

        l_process_data := p_process_data;
        -- добавим дату с которой действует
        l_process_data := update_value_in_xml(p_data         => l_process_data
                                              ,p_tag         => 'ActionDate'
                                              ,p_value       => to_char(p_date, 'yyyy-mm-dd')
                                              ,p_parent_node => PARENT_NODE_IR_TRANCHE);
        l_process_data := update_value_in_xml(p_data         => l_process_data
                                              ,p_tag         => 'ObjectId'
                                              ,p_value       => p_object_id
                                              ,p_parent_node => PARENT_NODE_IR_TRANCHE);

        l_process_id   := process_utl.process_create(
                                  p_proc_type_code    => PROCESS_CHANGE_INTEREST_RATE
                                 ,p_proc_type_module  => PROCESS_TRANCHE_MODULE
                                 ,p_process_name      => '[IR]'
                                 ,p_process_data      => l_process_data);
        update process p
           set p.object_id = p_object_id
         where p.id = l_process_id;
    end;

    -- добавляем детальную информацию по % ставкам для траншей
    procedure set_interest_rate_detail(
                                 p_process_data     in out clob)
     is
        l_dictionary  t_dictionary;
    begin
        select
               case when Interest_Rate_General is not null then
                     t_dictionary(t_dictionary_item(
                                      key   => 'InterestRateGeneral'
                                     ,value => Interest_Rate_General))
                   else t_dictionary()
               end
               multiset union all
               case when Interest_Rate_Bonus is not null then
                     t_dictionary(t_dictionary_item(
                                      key   => 'InterestRateBonus'
                                     ,value => Interest_Rate_Bonus))
                  else t_dictionary()
               end
               multiset union all
               case when Interest_Rate_Capitalization is not null then
                     t_dictionary(t_dictionary_item(
                                      key   => 'InterestRateCapitalization'
                                     ,value => Interest_Rate_Capitalization))
                  else t_dictionary()
               end
               multiset union all
               case when Interest_Rate_Payment is not null then
                     t_dictionary(t_dictionary_item(
                                      key   => 'InterestRatePayment'
                                     ,value => Interest_Rate_Payment))
                  else t_dictionary()
               end
               multiset union all
               case when Interest_Rate_Prolongation is not null then
                     t_dictionary(t_dictionary_item(
                                      key   => 'InterestRateProlongation'
                                     ,value => Interest_Rate_Prolongation))
                  else t_dictionary()
               end
               multiset union all
               case when Interest_Rate_Replenishment is not null then
                     t_dictionary(t_dictionary_item(
                                      key   => 'InterestRateReplenishment'
                                     ,value => Interest_Rate_Replenishment))
                  else t_dictionary()
               end
               multiset union all
               case when Interest_Rate_Prl_Bonus is not null then
                     t_dictionary(t_dictionary_item(
                                      key   => 'InterestRateProlongationBonus'
                                     ,value => Interest_Rate_Replenishment))
                  else t_dictionary()
               end c
          into l_dictionary
         from xmltable('/SMBDepositTrancheInterestRate' passing xmltype(smb_deposit_utl.get_interest_rate(p_data => p_process_data))
                                columns
                                       Interest_Rate_General         number         path 'InterestRateGeneral'
                                      ,Interest_Rate_Bonus           number         path 'InterestRateBonus'
                                      ,Interest_Rate_Capitalization  number         path 'InterestRateCapitalization'
                                      ,Interest_Rate_Payment         number         path 'InterestRatePayment'
                                      ,Interest_Rate_Prolongation    number         path 'InterestRateProlongation'
                                      ,Interest_Rate_Replenishment   number         path 'InterestRateReplenishment'
                                      ,Interest_Rate_Prl_Bonus       number         path 'InterestRateProlongationBonus'
                                      );
        p_process_data := update_value_in_xml(
                                       p_data        => p_process_data
                                      ,p_node_list   => l_dictionary
                                      ,p_parent_node => PARENT_NODE_TRANCHE);
    end;


    function create_tranche(p_process_id  in number) return number
     is
        l_tranche_row      c_tranche_from_xml%rowtype;
        l_data             clob;
        l_object_id        number;
        l_object_type_id   number;
        l_product_id       number;
        l_register_id      number;
        l_register_hist_id number;
        l_qty              number;
        l_contract_number  varchar2(100);
        l_branch           varchar2(50) := bc.current_branch_code;
    begin
        l_data        := process_utl.read_process(p_process_id).process_data;
        l_tranche_row := get_tranche_from_xml(p_data => l_data);

        check_amount_tranche(
                           p_tranche_row => l_tranche_row
                          ,p_is_tranche => 1);

        l_object_type_id  := get_object_type_tranche();
        l_product_id      := product_utl.read_product(
                                                 p_product_type_id => l_object_type_id
                                                ,p_product_code    => TRANCHE_PRODUCT_CODE
                                                ,p_lock            => true).id;

       select o.contract_number
         into l_contract_number
         from v_dbo o
        where rnk = l_tranche_row.customer_id;
        -- если бранч на уровне РУ, то дополняем 0
        -- l_branch := l_branch || case when length(l_branch) = 8 then '000000/' end;
        l_object_id := deal_utl.create_deal(
                                p_deal_type_code => TRANCHE_OBJECT_TYPE_CODE
                               ,p_deal_number    => null
                               ,p_customer_id    => l_tranche_row.customer_id
                               ,p_product_id     => l_product_id
                               ,p_start_date     => l_tranche_row.start_date
                               ,p_expiry_date    => l_tranche_row.expiry_date
                               ,p_state_code     => null
                               ,p_branch         => l_branch );
        -- по ТЗ мы должны считать ко-во траншей у клиента
        --
        select count(*)
          into l_qty
          from object o
              ,deal d
         where 1 = 1
           and o.object_type_id = l_object_type_id
           and o.id = d.id
           and d.customer_id = l_tranche_row.customer_id;

         -- set deal number mask dbo contract_number/amount tranche
        deal_utl.set_deal_number(
                    p_deal_id     => l_object_id
                   ,p_deal_number => l_contract_number||'/'||l_qty
                    );
        -- пишем номер в xml
        l_data := update_value_in_xml(
                                       p_data        => l_data
                                      ,p_tag         => 'DealNumber'
                                      ,p_value       => l_contract_number||'/'||l_qty
                                      ,p_parent_node => PARENT_NODE_TRANCHE);

        l_data := update_value_in_xml(
                                       p_data        => l_data
                                      ,p_tag         => 'ObjectId'
                                      ,p_value       => to_char(l_object_id)
                                      ,p_parent_node => PARENT_NODE_TRANCHE);

        l_data := update_value_in_xml(
                                       p_data        => l_data
                                      ,p_tag         => 'ProcessId'
                                      ,p_value       => to_char(p_process_id)
                                      ,p_parent_node => PARENT_NODE_TRANCHE);

        l_data := update_value_in_xml(
                                       p_data        => l_data
                                      ,p_tag         => 'Branch'
                                      ,p_value       => l_branch
                                      ,p_parent_node => PARENT_NODE_TRANCHE);

        -- устанавливаем % ставку
        set_interest_rate_tranche(
                         p_object_id     => l_object_id
                        ,p_interest_rate => case when l_tranche_row.is_individual_rate = 1
                                                 then l_tranche_row.individual_interest_rate
                                                 else l_tranche_row.interest_rate
                                            end
                        ,p_valid_from    => trunc(l_tranche_row.start_date));
        -- записываем в регистр плановую сумму транша
        l_register_hist_id := register_utl.cor_register_value(
                                   p_register_value_id => l_register_id
                                  ,p_object_id         => l_object_id
                                  ,p_register_code     => register_utl.SMB_PRINCIPAL_AMOUNT_CODE
                                  ,p_plan_value        => l_tranche_row.amount_tranche
                                  ,p_value             => 0
                                  ,p_date              => trunc(l_tranche_row.start_date)
                                  ,p_currency_id       => l_tranche_row.currency_id
                                  ,p_is_planned        => 'Y');

     /*   if nvl(l_tranche_row.is_replenishment_tranche, 0) = 0 and
           l_tranche_row.last_replenishment_date is not null then
            l_data := update_value_in_xml(
                                       p_data        => l_data
                                      ,p_tag         => 'LastReplenishmentDate'
                                      ,p_value       => ''
                                      ,p_parent_node => PARENT_NODE_TRANCHE);
        end if;*/

        l_data := update_value_in_xml(
                                       p_data        => l_data
                                      ,p_tag         => 'RegisterHistoryId'
                                      ,p_value       => to_char(l_register_hist_id)
                                      ,p_parent_node => PARENT_NODE_TRANCHE);

        set_interest_rate_detail(p_process_data  => l_data);
        -- перечитаем
        l_tranche_row := get_tranche_from_xml(p_data => l_data);
        insert into smb_deposit  (
                   id
                  ,currency_id
                  ,amount_tranche
                  ,is_replenishment_tranche
                  ,max_sum_tranche
                  ,min_replenishment_amount
                  ,last_replenishment_date
                  ,is_prolongation
                  ,number_prolongation
                  ,prolongation_interest_rate
                  ,apply_bonus_prolongation
                  ,frequency_payment
                  ,is_capitalization
                  ,is_individual_rate
                  ,number_tranche_days
                  ,general_interest_rate
                  ,bonus_interest_rate
                  ,capitalization_interest_rate
                  ,payment_interest_rate
                  ,replenishment_interest_rate
                  ,individual_interest_rate
                  )
           values(
                   l_object_id
                  ,l_tranche_row.currency_id
                  ,l_tranche_row.amount_tranche
                  ,l_tranche_row.is_replenishment_tranche
                  ,0
                  ,0
                  ,l_tranche_row.last_replenishment_date
                  ,l_tranche_row.is_prolongation
                  ,case l_tranche_row.is_prolongation when 0 then 0 when 1 then trunc(l_tranche_row.number_prolongation) end
                  ,l_tranche_row.interest_rate_prolongation
                  ,l_tranche_row.apply_bonus_prolongation
                  ,l_tranche_row.frequency_payment
                  ,l_tranche_row.is_capitalization
                  ,l_tranche_row.is_individual_rate
                  ,l_tranche_row.number_tranche_days
                  ,l_tranche_row.interest_rate_general
                  ,l_tranche_row.interest_rate_bonus
                  ,l_tranche_row.interest_rate_capitalization
                  ,l_tranche_row.interest_rate_payment
                  ,l_tranche_row.interest_rate_replenishment
                  ,case when l_tranche_row.is_individual_rate = 0 then 0 else l_tranche_row.individual_interest_rate end
                  );

        set_process_data(
                     p_process_id  => p_process_id
                    ,p_data       => l_data);

        return l_object_id;
    end;

    procedure check_replenishment_amount(p_object_id     in number
                                        ,p_data          in clob
                                        ,p_is_replenish  in number default 0
                                        ,p_is_created    in number default 0)
     is
        l_tranche_row          c_tranche_from_xml%rowtype;
        l_main_tranche_row     c_tranche_from_xml%rowtype;
        l_interest_rate        number;
    begin
        logger.log_info(p_procedure_name => $$plsql_unit||'.check_replenishment_amount',
                        p_log_message    => 'p_is_replenish : ' || p_is_replenish   || chr(10) ||
                                            'p_object_id    : ' || p_object_id  || chr(10) ||
                                            'TEST_MODE      : ' || TEST_MODE
                       ,p_object_id      => p_object_id
                       ,p_auxiliary_info => p_data
                        );
        -- TODO проверить было ли начисление процентов за эту дату
        --if l_tranche.last_accrual_date is not null and l_main_tranche_row.last_replenishment_date <= l_tranche.last_accrual_date then
          -- raise_application_error(-20000, 'За дату  {'|| to_char(l_tranche.last_accrual_date, 'dd.mm.yyyy') || '} були нараховані відсотки по траншу {'||p_object_id||'}');
        --end if;
        -- при создании транша l_main_tranche_row и l_tranche_row будут равны
        if p_is_replenish = 1 then
           -- пополнение, берем основной транш
           l_main_tranche_row := read_base_tranche(p_object_id => p_object_id);
        else
           -- создание транша берем из p_data
           l_main_tranche_row := get_tranche_from_xml(p_data => p_data);
           -- проверяем % ставку
           l_interest_rate     := case when l_main_tranche_row.is_individual_rate = 1
                                    then l_main_tranche_row.individual_interest_rate
                                    else l_main_tranche_row.interest_rate
                               end
                               ;
           if nvl(l_interest_rate, 0) = 0 then
              raise_application_error(-20000, 'Не вказана процентна ставка');
           end if;

        end if;

        if l_main_tranche_row.customer_id is null then
            raise_application_error(-20000, 'Не вказано клієнта');
        end if;
        if nvl(l_main_tranche_row.is_replenishment_tranche, 0) <> 1 then
           -- без пополнения - выходим
           return;
        end if;

        l_tranche_row      := get_tranche_from_xml(p_data => p_data);

        if p_is_replenish = 1 then
            -- пополнение проверяем на диапазон
            if not (l_tranche_row.action_date between l_main_tranche_row.start_date and l_main_tranche_row.last_replenishment_date) then
               raise_application_error(-20000, 'Дата поповнення траншу '|| to_char(l_tranche_row.action_date, '"{"dd.mm.yyyy"}"') ||
                                               ' не входить в діапазон дат поповнення траншу від '||to_char(l_main_tranche_row.start_date, '"{"dd.mm.yyyy"}"')||
                                               ' до '||to_char(l_main_tranche_row.last_replenishment_date, '"{"dd.mm.yyyy"}"'));
            end if;
        else
            if l_tranche_row.last_replenishment_date is null then
                raise_application_error(-20000, 'Не вказано останню дату поповнення траншу.');
            end if;
            -- содание транша, просто проверяем последнюю дату пополнения на попадание в диапазон действия транша
            if not (l_tranche_row.last_replenishment_date between l_tranche_row.start_date and l_tranche_row.expiry_date) then
               raise_application_error(-20000, 'Строк поповнення траншу '|| to_char(l_tranche_row.last_replenishment_date, '"{"dd.mm.yyyy"}"') ||
                                               ' не входить в діапазон дії траншу від {'||to_char(l_tranche_row.start_date, '"{"dd.mm.yyyy"}"')||
                                               ' до '||to_char(l_tranche_row.expiry_date, '"{"dd.mm.yyyy"}"'));
            end if;
        end if;
        -- эти поля убрали из формы ввода (max_sum_tranche, min_replenishment_amount)
        /*
        -- проверка на минимальное значение
        if p_is_replenish = 1  and l_main_tranche_row.min_replenishment_amount > nvl(l_tranche_row.amount_tranche, 0)then
           raise_application_error(-20000, 'Сума поповнення траншу {'||p_object_id||'} повинна бути більшою або дорівнювати {'||
                                            l_main_tranche_row.min_replenishment_amount / 100||'}');
        end if;
        if p_object_id is null then return; end if;
        -- выбираем сумму из регистров
        l_register_value_row := register_utl.read_register_value(p_object_id        => p_object_id
                                                                ,p_register_code    => register_utl.SMB_PRINCIPAL_AMOUNT_CODE);
        l_register_hist_row  := register_utl.read_register_history(
                                                    p_register_history_id => l_tranche_row.register_history_id);
        -- если запись уже создана, то вычитаем старое значение
        if nvl(l_register_value_row.plan_value, 0) - nvl(l_register_hist_row.amount, 0) + nvl(l_tranche_row.amount_tranche, 0) > l_main_tranche_row.max_sum_tranche then
           raise_application_error(-20000, 'Сума поповнень траншів не повинна перевищувати {'||
                                           l_main_tranche_row.max_sum_tranche / l_main_tranche_row.denom||'} для траншу {'||p_object_id||'}');
        end if;
        */
    end;

    procedure update_tranche(p_process_id  in number
                            ,p_data        in clob)
     is
        l_tranche_row          c_tranche_from_xml%rowtype;
        l_old_tranche_row      c_tranche_from_xml%rowtype;
        l_process_row          process%rowtype;
        l_deal_row             deal%rowtype;
        l_register_value_row   register_value%rowtype;
        l_interest_rate        number;
        l_interest_rate_old    number;
        l_is_active            number;
        l_register_hist_id     number;
    begin

        l_process_row     := process_utl.read_process(p_process_id => p_process_id
                                                     ,p_raise_ndf  => true);
        l_tranche_row     := get_tranche_from_xml(p_data => p_data);

        if l_tranche_row.amount_tranche is null then
           raise_application_error(-20000, 'Не вказана сумма траншу');
        end if;

        check_amount_tranche(
                           p_tranche_row => l_tranche_row
                          ,p_is_tranche => 1);

        select max(1)
          into l_is_active
          from object o
              ,object_state os
         where 1 = 1
           and o.id = l_process_row.object_id
           and o.state_id = os.id
           and os.state_code = OBJ_TRANCHE_STATE_ACTIVE;
        if l_is_active > 0 then
            raise_application_error(-20000, 'Редагування заборонено. Транш  {' || l_process_row.object_id || '} авторизований');
        end if;
        l_old_tranche_row := get_tranche_from_xml(p_data => l_process_row.process_data);
        l_deal_row := deal_utl.read_deal(
                                    p_deal_id   => l_process_row.object_id
                                   ,p_lock      => true
                                   ,p_raise_ndf => true);
        if tools.compare(l_deal_row.start_date, l_tranche_row.start_date) <> 0 then
            deal_utl.set_deal_start_date(
                                    p_deal_id    => l_process_row.object_id
                                   ,p_start_date => l_tranche_row.start_date);
        end if;
        if tools.compare(l_deal_row.expiry_date, l_tranche_row.expiry_date) <> 0 then
            deal_utl.set_deal_expiry_date(
                                    p_deal_id     => l_process_row.object_id
                                   ,p_expiry_date => l_tranche_row.expiry_date);
        end if;
        if tools.compare(l_deal_row.curator_id, user_id()) <> 0 then
            deal_utl.set_deal_curator_id(
                                    p_deal_id    => l_process_row.object_id
                                   ,p_curator_id => user_id());
        end if;

        l_process_row.process_data := p_data;
        l_register_value_row := register_utl.read_register_value(p_object_id        => l_process_row.object_id
                                                                ,p_register_code    => register_utl.SMB_PRINCIPAL_AMOUNT_CODE);
        if tools.compare(l_deal_row.start_date, l_tranche_row.start_date) <> 0 or
            l_register_value_row.plan_value <> l_tranche_row.amount_tranche  then
            l_register_hist_id := register_utl.update_register_history(
                                              p_register_history_id    => l_old_tranche_row.register_history_id --l_tranche_row.register_history_id
                                             ,p_value_date             => l_tranche_row.start_date
                                             ,p_amount                 => l_tranche_row.amount_tranche
                                             ,p_is_active              => 'Y'
                                             ,p_date_from              => l_deal_row.start_date
                                             ,p_date_to                => l_deal_row.start_date
                                             ,p_is_planned             => 'Y');

            l_process_row.process_data := update_value_in_xml(
                                                   p_data        => l_process_row.process_data
                                                  ,p_tag         => 'RegisterHistoryId'
                                                  ,p_value       => to_char(l_register_hist_id)
                                                  ,p_parent_node => PARENT_NODE_TRANCHE);
        elsif
            -- при редактировании веб не перечитывает xml
            -- перезапишем RegisterHistoryId
            l_tranche_row.register_history_id <> l_old_tranche_row.register_history_id then
                l_process_row.process_data := update_value_in_xml(
                                             p_data        => l_process_row.process_data
                                            ,p_tag         => 'RegisterHistoryId'
                                            ,p_value       => to_char(l_old_tranche_row.register_history_id)
                                            ,p_parent_node => PARENT_NODE_TRANCHE);
        end if;

        l_interest_rate     := case when l_tranche_row.is_individual_rate = 1
                                    then l_tranche_row.individual_interest_rate
                                    else l_tranche_row.interest_rate
                               end;
        l_interest_rate_old := attribute_utl.get_number_value(
                                    p_object_id      => l_process_row.object_id
                                   ,p_attribute_code => ATTR_SMB_DEPOSIT_TRANCHE_IR
                                   ,p_value_date     => l_deal_row.start_date);

        -- устанавливаем % ставку если менялась дата или сама ставка
        if tools.compare(l_deal_row.start_date, l_tranche_row.start_date) <> 0 or
            l_interest_rate <> l_interest_rate_old then
            set_interest_rate_tranche(
                         p_object_id     => l_process_row.object_id
                        ,p_interest_rate => null
                        ,p_valid_from    => l_deal_row.start_date);
            set_interest_rate_tranche(
                         p_object_id     => l_process_row.object_id
                        ,p_interest_rate => l_interest_rate
                        ,p_valid_from    => l_tranche_row.start_date);
         end if;

        set_interest_rate_detail(p_process_data  => l_process_row.process_data);

        l_tranche_row     := get_tranche_from_xml(p_data => l_process_row.process_data);

        update smb_deposit set
               currency_id                  = l_tranche_row.currency_id
              ,amount_tranche               = l_tranche_row.amount_tranche
              ,is_prolongation              = l_tranche_row.is_prolongation
              ,number_prolongation          = case l_tranche_row.is_prolongation when 0 then 0 when 1 then trunc(l_tranche_row.number_prolongation) end
              ,prolongation_interest_rate   = l_tranche_row.interest_rate_prolongation
              ,apply_bonus_prolongation     = l_tranche_row.apply_bonus_prolongation
              ,is_replenishment_tranche     = l_tranche_row.is_replenishment_tranche
              ,last_replenishment_date      = l_tranche_row.last_replenishment_date
              ,frequency_payment            = l_tranche_row.frequency_payment
              ,is_individual_rate           = l_tranche_row.is_individual_rate
              ,is_capitalization            = l_tranche_row.is_capitalization
              ,number_tranche_days          = l_tranche_row.number_tranche_days
              ,general_interest_rate        = l_tranche_row.interest_rate_general
              ,bonus_interest_rate          = l_tranche_row.interest_rate_bonus
              ,capitalization_interest_rate = l_tranche_row.interest_rate_capitalization
              ,payment_interest_rate        = l_tranche_row.interest_rate_payment
              ,replenishment_interest_rate  = l_tranche_row.interest_rate_replenishment
              ,individual_interest_rate     = case when l_tranche_row.is_individual_rate = 0 then 0 else l_tranche_row.individual_interest_rate end
         where id = l_process_row.object_id;
        -- запишем то же state_id для истории кто редактировал
        process_utl.set_process_state_id(p_process_id => p_process_id
                                        ,p_value      => l_process_row.state_id
                                        ,p_raise_ndf  => false);

        set_process_data(
                         p_process_id  => p_process_id
                        ,p_data       => l_process_row.process_data);

    end;

    -- создаем атрибут с процентной ставкой
    procedure set_interest_rate_tranche(
                         p_object_id     in number
                        ,p_interest_rate in number
                        ,p_valid_from    in date
                        ,p_valid_through in date     default null
                        ,p_comment       in varchar2 default null)
     is
    begin
        attribute_utl.set_value(
                     p_object_id      => p_object_id
                    ,p_attribute_code => ATTR_SMB_DEPOSIT_TRANCHE_IR
                    ,p_value          => p_interest_rate
                    ,p_valid_from     => p_valid_from
                    ,p_valid_through  => p_valid_through
                    ,p_comment        => p_comment);
    end;

    function read_tranche(p_object_id in number) return c_tranche%rowtype
     is
        l_tranche_row   c_tranche%rowtype;
    begin
        for i in c_tranche(p_object_id      => p_object_id
                          ,p_object_type_id => get_object_type_tranche()
                            ) loop
          l_tranche_row := i;
          exit;
        end loop;
        return l_tranche_row;
    end;

    function get_tranche_interest_rate(p_process_data in clob)
       return c_tranche_interest_rate%rowtype
     is
        l_tranche_ir_row  c_tranche_interest_rate%rowtype;
    begin
        for i in c_tranche_interest_rate(p_data => p_process_data) loop
          l_tranche_ir_row := i;
          exit;
        end loop;
        return l_tranche_ir_row;
    end;

    function get_tranche_from_xml(p_data in clob)
       return c_tranche_from_xml%rowtype
     is
        l_tranche_row    c_tranche_from_xml%rowtype;
    begin
        for i in c_tranche_from_xml(p_data => p_data) loop
          l_tranche_row := i;
          exit;
        end loop;
        if l_tranche_row.currency_id is null then
            raise_application_error(-20000, 'Не вказано валюту');
        end if;
        return l_tranche_row;
    end;

    function get_tranche_from_xml(p_process_id  in number)
       return c_tranche_from_xml%rowtype
     is
        l_process_row   process%rowtype;
        l_tranche_row   c_tranche_from_xml%rowtype;
    begin
        l_process_row  := process_utl.read_process(p_process_id => p_process_id
                                                  ,p_lock       => false
                                                  ,p_raise_ndf  => true);

        l_tranche_row := get_tranche_from_xml(p_data => l_process_row.process_data);
        -- при создании транша, мы не знаем его object_id
        -- во всех остальных случаях он известен
        -- если не новый транш
        if not (l_process_row.object_id is null or l_tranche_row.object_id is null) then
           check_deposit_type(p_object_id               => nvl(l_process_row.object_id, l_tranche_row.object_id)
                             ,p_target_object_type_code => TRANCHE_OBJECT_TYPE_CODE
                             );
        end if;
        return l_tranche_row;
    end;

    function read_base_tranche(p_object_id  in number)
                return c_tranche_from_xml%rowtype
     is
        l_process_type_id  number;
        l_process_row      process%rowtype;
    begin
        -- получить по p_object_id родительский процесс (т.е. всю инфу по траншу)
        l_process_type_id := process_utl.get_proc_type_id(
                                            p_proc_type_code => PROCESS_TRANCHE_CREATE
                                           ,p_module_code    => PROCESS_TRANCHE_MODULE);
        select p.*
          into l_process_row
          from process p
         where p.object_id = p_object_id
           and p.process_type_id = l_process_type_id
           and rownum = 1
           ;
        return get_tranche_from_xml(p_data => l_process_row.process_data);
    exception
        when no_data_found then
            return null;
    end ;

    function read_base_on_demand(p_object_id  in number)
                return c_on_demand_from_xml%rowtype
     is
        l_process_type_id  number;
        l_process_row      process%rowtype;
    begin
        -- получить по p_object_id родительский процесс (т.е. всю инфу по траншу)
        l_process_type_id := process_utl.get_proc_type_id(
                                            p_proc_type_code => PROCESS_ON_DEMAND_CREATE
                                           ,p_module_code    => PROCESS_TRANCHE_MODULE);
        select p.*
          into l_process_row
          from process p
         where p.object_id = p_object_id
           and p.process_type_id = l_process_type_id
           and rownum = 1
           ;
        return get_on_demand_from_xml(p_data => l_process_row.process_data);
    exception
        when no_data_found then
            return null;
    end ;


    procedure cor_tranche(p_process_id   in out number
                         ,p_data         in clob)
     is
        l_process_row            process%rowtype;
        l_tranche_row            c_tranche_from_xml%rowtype;
        l_new_tranche_row        c_tranche_from_xml%rowtype;
        l_can_create_flag        char(1 char);
        l_can_create_explanation varchar2(32767 byte);
        l_process_type_id        number;
    begin
        logger.log_info(p_procedure_name => $$plsql_unit||'.cor_tranche',
                        p_log_message    => 'p_process_id : ' || p_process_id || chr(10) ||
                                            'TEST_MODE    : ' ||TEST_MODE
                       ,p_object_id      => null
                       ,p_auxiliary_info => p_data
                        );
        check_current_branch();
        -- если null
        if p_process_id is null then
            -- попытка достать из xml
            l_tranche_row := get_tranche_from_xml(p_data => p_data);
            p_process_id  := l_tranche_row.process_id;
        end if;
        if p_process_id is null then
            check_replenishment_amount(p_object_id  => null
                                      ,p_data       => p_data);
            if l_tranche_row.primary_account is not null then
                raise_application_error(-20000, 'Транш не створений, а депозитний рахунок знайдено !!! (???) '||l_tranche_row.primary_account);
            end if;
            p_process_id := process_utl.process_create(
                                  p_proc_type_code    => PROCESS_TRANCHE_CREATE
                                 ,p_proc_type_module  => PROCESS_TRANCHE_MODULE
                                 ,p_process_name      => 'Транш >>'
                                 ,p_process_data      => p_data
                                 ,p_process_object_id => null);
        else
            l_process_row := process_utl.read_process(p_process_id => p_process_id
                                                     ,p_raise_ndf  => true);
            l_process_type_id := process_utl.get_proc_type_id(
                                                         p_proc_type_code => PROCESS_TRANCHE_CREATE
                                                        ,p_module_code    => PROCESS_TRANCHE_MODULE);
            if l_process_type_id <> l_process_row.process_type_id then
                raise_application_error(-20000, 'Редагування заборонено. Процес {'||p_process_id||'} має тип {'||
                                                 process_utl.get_proc_type_name(
                                                                   p_proc_type_id => l_process_row.process_type_id)
                                                  );
            end if;
            if l_process_row.state_id <> process_utl.GC_PROCESS_STATE_CREATE then
                raise_application_error(-20000, 'Редагування заборонено. Транш  {' || l_process_row.object_id || '} в стані {'||
                                        list_utl.get_item_name( p_list_code => process_utl.GC_PROCESS_STATE
                                                               ,p_item_id   => l_process_row.state_id)||'}');
            end if;
            check_replenishment_amount(p_object_id  => l_process_row.object_id
                                      ,p_data       => p_data);
            smb_deposit_proc.can_create_new_tranche(
                                 p_process_data     => p_data
                                ,p_process_type_id  => process_utl.get_proc_type_id(
                                                                p_proc_type_code => PROCESS_TRANCHE_CREATE
                                                               ,p_module_code    => PROCESS_TRANCHE_MODULE
                                                               ,p_raise_ndf      => true )
                                ,p_can_create_flag  => l_can_create_flag
                                ,p_explanation      => l_can_create_explanation);

            if l_can_create_flag <> 'Y' then
                raise_application_error(-20000, l_can_create_explanation);
            end if;
            l_tranche_row     := get_tranche_from_xml(p_process_id => p_process_id);
            l_new_tranche_row := get_tranche_from_xml(p_data       => p_data);
            if l_new_tranche_row.branch is null then
                raise_application_error(-20000, 'BRANCH IS EMPTY!!!.');
            end if;
            if l_tranche_row.currency_id <> l_new_tranche_row.currency_id then
                raise_application_error(-20000, 'Зміна валюти траншу заборонена.');
            end if;

            update_tranche(p_process_id  => p_process_id
                          ,p_data        => p_data);
            -- пишем историю
             process_utl.set_process_state_id(
                                    p_process_id  => p_process_id
                                   ,p_value     => process_utl.GC_PROCESS_STATE_CREATE);
        end if;
        set_process_info(p_process_id  => p_process_id);
        logger.log_info(p_procedure_name => $$plsql_unit||'.cor_tranche end',
                        p_log_message    => 'p_process_id : ' || p_process_id
                       ,p_object_id      => null
                       ,p_auxiliary_info => null
                        );
    end cor_tranche;

    procedure tranche_authorization(p_process_id in number)
     is
        l_process_row       process%rowtype;
        l_process_type_row  process_type%rowtype;
    begin
        l_process_row      := process_utl.read_process(
                                           p_process_id => p_process_id
                                          ,p_raise_ndf  => true );
        l_process_type_row := process_utl.read_proc_type(p_proc_type_id => l_process_row.process_type_id);
        logger.log_info(p_procedure_name => $$plsql_unit||'.tranche_authorization ['||l_process_type_row.process_code||']',
                        p_log_message    => 'p_process_id : ' || p_process_id );
        check_deposit_type(p_object_id               => l_process_row.object_id
                          ,p_target_object_type_code => TRANCHE_OBJECT_TYPE_CODE
                           );
        process_utl.process_run(p_process_id  => p_process_id);
        set_process_info(p_process_id  => p_process_id);
    end;

    -- проверка счетов в deal_Account
    -- должно быть 2 счета (депозитный и начисленных %)
    -- депозитный
    procedure check_accounts(p_object_id in number)
     is
        l_qty    number;
    begin
        -- проверка счетов в deal_Account
        -- должно быть 2 счета (депозитный и начисленных %)
        -- депозитный
        select count(*)
          into l_qty
          from deal_account d
         where d.deal_id = p_object_id
           and d.account_type_id = attribute_utl.get_attribute_id('DEPOSIT_PRIMARY_ACCOUNT');
        if l_qty = 0 then
            raise_application_error(-20000, 'Не знайдено депозитный рахунок [deal_account] '||p_object_id);
        elsif l_qty > 1 then
            raise_application_error(-20000, 'Знайдено більше одного депозитного рахуноку [deal_account] '||p_object_id);
        end if;
        -- начисленных %
        select count(*)
          into l_qty
          from deal_account d
         where d.deal_id = p_object_id
           and d.account_type_id = attribute_utl.get_attribute_id('DEPOSIT_INTEREST_ACCOUNT');
        if l_qty = 0 then
            raise_application_error(-20000, 'Не знайдено рахунок нарахованих % [deal_account] '||p_object_id);
        elsif l_qty > 1 then
            raise_application_error(-20000, 'Знайдено більше одного рахуноку нарахованих % [deal_account] '||p_object_id);
        end if;
    end;

    procedure tranche_confirmation(p_process_id   in number
                                  ,p_is_confirmed in varchar2 default 'Y'
                                  ,p_comment      in varchar2 default null
                                  ,p_error        out varchar2)
     is
        l_activity_id       number;
        l_process_row       process%rowtype;
        l_tranche_row       c_tranche_from_xml%rowtype;
        l_comment_text      varchar2(4000);
    begin
        logger.log_info(p_procedure_name => $$plsql_unit||'.tranche_confirmation',
                            p_log_message    => 'p_process_id   : ' || p_process_id || chr(10) ||
                                                'p_is_confirmed : ' || p_is_confirmed
                            );

        l_process_row := process_utl.read_process(
                                           p_process_id => p_process_id
                                          ,p_raise_ndf  => true );
        check_deposit_type(p_object_id               => l_process_row.object_id
                          ,p_target_object_type_code => TRANCHE_OBJECT_TYPE_CODE
                           );

        if l_process_row.state_id <> process_utl.GC_PROCESS_STATE_RUN then
             raise_application_error(-20000, case when p_is_confirmed = 'Y' then 'Підтвердження '
                                                  else 'Відправлення на редагування '
                                             end ||' заборонено. '||
                                             'Транш  {' || deal_utl.get_deal_number(p_deal_id => l_process_row.object_id) ||
                                             '} в стані {'|| list_utl.get_item_name( p_list_code => process_utl.GC_PROCESS_STATE
                                                                                    ,p_item_id   => l_process_row.state_id)||'}');
        end if;
        if upper(p_is_confirmed) = 'Y' then
            select a.id
              into l_activity_id
              from process p
                  ,activity a
                  ,process_workflow pw
             where p.id = p_process_id
               and pw.process_type_id = p.process_type_id
               and pw.activity_code = ACTIVITY_CONFIRM_CODE
               and a.process_id = p.id
               and a.activity_type_id = pw.id
               and a.state_id <> process_utl.ACT_STATE_REMOVED;

            process_utl.activity_run(p_activity_id  => l_activity_id
                                    ,p_silent_mode  => true
                                    );
            logger.log_info(p_procedure_name => $$plsql_unit||'.tranche_confirmation after activity',
                            p_log_message    => 'activity_id   : ' || l_activity_id);
            -- перечитаем
            l_process_row := process_utl.read_process(p_process_id => p_process_id);
            -- check status process
            if l_process_row.state_id = process_utl.GC_PROCESS_STATE_FAILURE then

                l_tranche_row := smb_deposit_utl.get_tranche_from_xml(l_process_row.id);
                -- достаем коммент и вызываем исключение
                l_comment_text := get_last_error_on_process(p_process_id => p_process_id);
                -- ожидаемая ошибка - не достаточно денег на счету
                if l_comment_text like '%'||ERR_NOT_ENOUGH_MONEY||'%' then
                   -- возвращаем через параметр иначе все откатится,
                   -- а нам нужнен процесс в статусе FAILED
                   p_error := ERR_NOT_ENOUGH_MONEY||l_tranche_row.debit_account||'}';
                else
                    -- все последующие манипуляции для записи истории (нужно продумать доработку process_utl (???))
                    -- достаем первую активити, делаем "откат" к состоянию CREATED
                    for i in (
                        select a.id
                          from activity a
                          left join activity_dependency ad on a.id = ad.primary_activity_id
                          where  a.process_id = p_process_id
                                 and a.state_id != process_utl.ACT_STATE_REMOVED
                                 and not exists (select 1 from activity_dependency adc where adc.following_activity_id = a.id))
                    loop
                      process_utl.activity_revert(
                                                   p_activity_id => i.id
                                                  ,p_comment   => '#unexpected error#'
                                                ) ;
                    end loop;
                    -- сам процесс устанавливаем в RUN (т.е. на авторизации)
                    process_utl.set_process_state_id(
                                    p_process_id  => p_process_id
                                   ,p_value       => process_utl.GC_PROCESS_STATE_RUN);

                    p_error := l_comment_text;
                end if;
            end if;
            if p_error is null or p_error like ERR_NOT_ENOUGH_MONEY||'%' then
                -- проверим депозитный счет и счет начисленных %
                check_accounts(p_object_id => l_process_row.object_id);
            end if;
        else
            if trim(p_comment) is null then
                raise_application_error(-20000, 'Вкажіть причину відхилення траншу');
            end if;
            process_utl.process_revert(p_process_id  => p_process_id
                                      ,p_comment    => p_comment);
        end if;
    end;

    function get_tranche_xml_data(p_process_id  in number) return clob
     is
        l_process_row process%rowtype;
    begin
       if p_process_id is null then
          l_process_row.process_data := xml_tranche_template;
       else
          l_process_row := process_utl.read_process(p_process_id => p_process_id
                                                   ,p_lock       => false
                                                   ,p_raise_ndf  => true);
          check_deposit_type(p_object_id               => l_process_row.object_id
                            ,p_target_object_type_code => TRANCHE_OBJECT_TYPE_CODE
                             );

       end if;
       return l_process_row.process_data;
    end;

    function get_replenish_tranche_xml_data(p_process_id in number
                                           ,p_object_id  in number)
                        return clob
     is
        l_process_row      process%rowtype;
        l_process_id       number := p_process_id;
        l_process_type_id  number;
        l_main_tranche_row c_tranche_from_xml%rowtype;
    begin
        logger.log_info(p_procedure_name => $$plsql_unit||'.get_replenish_tranche_xml_data',
                        p_log_message    => 'p_process_id : ' || p_process_id || chr(10) ||
                                            'p_object_id  : ' || p_object_id
                       ,p_object_id      => p_object_id
                       ,p_auxiliary_info => l_process_row.process_data
                        );
        if l_process_id is null and p_object_id is null then
            raise_application_error(-20000, 'Транш не знайдено.');
        end if;
        if l_process_id is not null then
            l_process_row := process_utl.read_process(
                                          p_process_id => l_process_id
                                         ,p_raise_ndf  => true);
        end if;
        l_main_tranche_row := read_base_tranche(p_object_id => nvl(l_process_row.object_id, p_object_id));
        check_deposit_type(p_object_id               => l_main_tranche_row.object_id
                          ,p_target_object_type_code => TRANCHE_OBJECT_TYPE_CODE
                           );
        if nvl(l_main_tranche_row.is_replenishment_tranche, 0) <> 1 then
            raise_application_error(-20000, 'Поповнення траншу не передбачено.');
        end if;
        if l_process_id is null then
            -- берем данные из основного транша
            -- и некоторые из них меняем на null (они будут обновлены в процессе попоплнения)
            l_process_row := process_utl.read_process(
                                          p_process_id => l_main_tranche_row.process_id
                                         ,p_raise_ndf  => true);

            check_deposit_type(p_object_id               => l_process_row.object_id
                              ,p_target_object_type_code => TRANCHE_OBJECT_TYPE_CODE
                               );

            l_process_row.process_data := update_value_in_xml(p_data        => l_process_row.process_data
                                                             ,p_tag         => 'ProcessId'
                                                             ,p_value       => ''
                                                             ,p_parent_node => PARENT_NODE_TRANCHE);
            l_process_row.process_data := update_value_in_xml(p_data        => l_process_row.process_data
                                                             ,p_tag         => 'DealNumber'
                                                             ,p_value       => ''
                                                             ,p_parent_node => PARENT_NODE_TRANCHE);
            l_process_row.process_data := update_value_in_xml(p_data        => l_process_row.process_data
                                                             ,p_tag         => 'AmountTranche'
                                                             ,p_value       => ''
                                                             ,p_parent_node => PARENT_NODE_TRANCHE);
            /*
            -- не меняем оставляем xsi:nil="true"
            l_process_row.process_data := update_value_in_xml(p_data        => l_process_row.process_data
                                                             ,p_tag         => 'ActionDate'
                                                             ,p_value       => to_char(gl.bdate, 'yyyy-mm-dd')
                                                             ,p_parent_node => PARENT_NODE_TRANCHE);
            */
            l_process_row.process_data := update_value_in_xml(p_data        => l_process_row.process_data
                                                             ,p_tag         => 'RegisterHistoryId'
                                                             ,p_value       => ''
                                                             ,p_parent_node => PARENT_NODE_TRANCHE);
            l_process_row.process_data := update_value_in_xml(p_data        => l_process_row.process_data
                                                             ,p_tag         => 'IsSigned'
                                                             ,p_value       => '0'
                                                             ,p_parent_node => PARENT_NODE_TRANCHE);
            l_process_row.process_data := update_value_in_xml(p_data        => l_process_row.process_data
                                                             ,p_tag         => 'Ref_'
                                                             ,p_value       => ''
                                                             ,p_parent_node => PARENT_NODE_TRANCHE);
        else
            l_process_type_id := process_utl.get_proc_type_id(
                                                         p_proc_type_code => PROCESS_REPLENISH_TRANCHE
                                                        ,p_module_code    => PROCESS_TRANCHE_MODULE);
            if l_process_type_id <> l_process_row.process_type_id then
                raise_application_error(-20000, 'Процес {'||p_process_id||'} має тип {'||
                                                 process_utl.get_proc_type_name(
                                                                   p_proc_type_id => l_process_row.process_type_id)
                                                  );
            end if;
        end if;
        return l_process_row.process_data;
    end;

    -- for process
    function create_replenish_tranche(p_process_id   in number) return number
     is
        l_tranche_row        c_tranche_from_xml%rowtype;
        l_process_row        process%rowtype;
        l_register_hist_id   number;
        l_register_value_row register_value%rowtype;
        l_qty                number;
    begin
        logger.log_info(p_procedure_name => $$plsql_unit||'.create_replenish_tranche',
                        p_log_message    => 'p_process_id : ' || p_process_id || chr(10) ||
                                            'TEST_MODE    : ' ||TEST_MODE
                       ,p_object_id      => null
                       ,p_auxiliary_info => null
                        );

        l_tranche_row := get_tranche_from_xml(p_process_id => p_process_id);
        l_process_row := process_utl.read_process(p_process_id => p_process_id);
        check_amount_tranche(
                         p_tranche_row => l_tranche_row
                        ,p_is_tranche => 0);
        -- ищем регистр основного транша
        l_register_value_row := register_utl.read_register_value(p_object_id     => l_tranche_row.object_id
                                                                ,p_register_code => register_utl.SMB_PRINCIPAL_AMOUNT_CODE);

        -- все проверки пройдены записываем данные в регистр
        l_register_hist_id := register_utl.cor_register_value(
                                       p_register_value_id => l_register_value_row.id
                                      ,p_object_id         => l_tranche_row.object_id
                                      ,p_register_code     => register_utl.SMB_PRINCIPAL_AMOUNT_CODE
                                      ,p_plan_value        => l_tranche_row.amount_tranche
                                      ,p_value             => 0
                                      ,p_date              => trunc(l_tranche_row.start_date)
                                      ,p_currency_id       => l_tranche_row.currency_id
                                      ,p_is_planned        => 'Y');

        -- создаем номер пополнения транша, номер основного транша + кол-во пополнений в нем (херня, но так хотят)
        -- кол-во пополнений
        select count(*) + 1
          into l_qty
          from process p
         where p.object_id = l_tranche_row.object_id
           and p.process_type_id = l_process_row.process_type_id;
        -- пишем номер в xml
        l_process_row.process_data := update_value_in_xml(
                                       p_data        => l_process_row.process_data
                                      ,p_tag         => 'DealNumber'
                                      ,p_value       => deal_utl.get_deal_number(p_deal_id => l_tranche_row.object_id)||'/'||l_qty
                                      ,p_parent_node => PARENT_NODE_TRANCHE);

        l_process_row.process_data := update_value_in_xml(
                                              p_data        => l_process_row.process_data
                                             ,p_tag         => 'RegisterHistoryId'
                                             ,p_value       => to_char(l_register_hist_id)
                                             ,p_parent_node => PARENT_NODE_TRANCHE);
        l_process_row.process_data := update_value_in_xml(
                                              p_data        => l_process_row.process_data
                                             ,p_tag         => 'ObjectId'
                                             ,p_value       => to_char(l_tranche_row.object_id)
                                             ,p_parent_node => PARENT_NODE_TRANCHE);

        l_process_row.process_data := update_value_in_xml(
                                              p_data        => l_process_row.process_data
                                             ,p_tag         => 'ProcessId'
                                             ,p_value       => to_char(p_process_id)
                                             ,p_parent_node => PARENT_NODE_TRANCHE);

        set_process_data(
                         p_process_id  => p_process_id
                        ,p_data       => l_process_row.process_data);

        return l_tranche_row.object_id;
    end create_replenish_tranche;

    -- for UI
    procedure cor_replenish_tranche(p_process_id   in out number
                                   ,p_object_id    in number
                                   ,p_data         in clob)
     is
        l_process_row            process%rowtype;
        l_process_type_id        number;
        l_can_create_flag        char(1 char);
        l_can_create_explanation varchar2(32767 byte);
        l_register_hist_row      register_history%rowtype;
        l_tranche_row            c_tranche_from_xml%rowtype;
        l_new_tranche_row        c_tranche_from_xml%rowtype;
        l_register_hist_id       number;
    begin
        logger.log_info(p_procedure_name => $$plsql_unit||'.cor_replenish_tranche',
                        p_log_message    => 'p_process_id : ' || p_process_id || chr(10) ||
                                            'p_object_id  : ' || p_object_id  || chr(10) ||
                                            'TEST_MODE    : ' ||TEST_MODE
                       ,p_object_id      => p_object_id
                       ,p_auxiliary_info => p_data
                        );
        check_current_branch();
        if p_process_id is null then
            -- проверка
            check_replenishment_amount(p_object_id    => p_object_id
                                      ,p_data         => p_data
                                      ,p_is_replenish => 1);
            -- создаем процесс
            p_process_id := process_utl.process_create(
                                  p_proc_type_code    => PROCESS_REPLENISH_TRANCHE
                                 ,p_proc_type_module  => PROCESS_TRANCHE_MODULE
                                 ,p_process_name      => 'Поповнення траншу >> {'||p_object_id||'}'
                                 ,p_process_data      => p_data
                                 ,p_process_object_id => null);
        else
            -- в процессах ничего не меняем кроме process_data
            l_process_row := process_utl.read_process(p_process_id => p_process_id);
            -- проверяем какого типа процесс
            l_process_type_id := process_utl.get_proc_type_id(
                                                         p_proc_type_code => PROCESS_REPLENISH_TRANCHE
                                                        ,p_module_code    => PROCESS_TRANCHE_MODULE);
            if l_process_type_id <> l_process_row.process_type_id then
                raise_application_error(-20000, 'Редагування поповнення заборонено. Процес {'||p_process_id||'} має тип {'||
                                                 process_utl.get_proc_type_name(
                                                                   p_proc_type_id => l_process_row.process_type_id)
                                                  );
            end if;
            if l_process_row.state_id <> process_utl.GC_PROCESS_STATE_CREATE then
                raise_application_error(-20000, 'Редагування заборонено. Поповнення траншу  {' || l_process_row.object_id || '} в стані {'||
                                        list_utl.get_item_name( p_list_code => process_utl.GC_PROCESS_STATE
                                                               ,p_item_id   => l_process_row.state_id)||'}');
            end if;
            check_replenishment_amount(p_object_id  => l_process_row.object_id
                                      ,p_data       => p_data
                                      ,p_is_replenish => 1);
            -- проверка счетов
            smb_deposit_proc.can_create_replenish_tranche(
                                 p_process_data     => p_data
                                ,p_process_type_id  => process_utl.get_proc_type_id(
                                                                p_proc_type_code => PROCESS_REPLENISH_TRANCHE
                                                               ,p_module_code    => PROCESS_TRANCHE_MODULE
                                                               ,p_raise_ndf      => true )
                                ,p_can_create_flag  => l_can_create_flag
                                ,p_explanation      => l_can_create_explanation);

            if l_can_create_flag <> 'Y' then
                raise_application_error(-20000, l_can_create_explanation);
            end if;
            l_process_row.process_data := p_data;
            l_tranche_row     := get_tranche_from_xml(p_process_id => p_process_id);
            l_new_tranche_row := get_tranche_from_xml(p_data       => p_data);
            if l_new_tranche_row.branch is null then
                raise_application_error(-20000, 'BRANCH IS EMPTY!!!.');
            end if;
            -- при редактировании веб не перечитывает xml
            -- менять можно много раз сумму и RegisterHistoryId остается все время старое значение
            -- перезапишем если изменилось
            if l_tranche_row.register_history_id <> l_new_tranche_row.register_history_id then
                l_process_row.process_data := update_value_in_xml(
                                                       p_data        => l_process_row.process_data
                                                      ,p_tag         => 'RegisterHistoryId'
                                                      ,p_value       => to_char(l_tranche_row.register_history_id)
                                                      ,p_parent_node => PARENT_NODE_TRANCHE);
            end if;
            l_tranche_row       := get_tranche_from_xml(p_data => l_process_row.process_data);
            check_amount_tranche(
                          p_tranche_row => l_tranche_row
                          ,p_is_tranche => 0);
            l_register_hist_row := register_utl.read_register_history(
                                                            p_register_history_id => l_tranche_row.register_history_id);
            -- менялась ли сумма или дата
            if tools.compare(l_register_hist_row.value_date, l_tranche_row.start_date) <> 0 or
                l_register_hist_row.amount <> l_tranche_row.amount_tranche  then
                l_register_hist_id := register_utl.update_register_history(
                                                  p_register_history_id    => l_tranche_row.register_history_id
                                                 ,p_value_date             => l_tranche_row.start_date
                                                 ,p_amount                 => l_tranche_row.amount_tranche
                                                 ,p_is_active              => 'Y'
                                                 ,p_date_from              => l_tranche_row.start_date
                                                 ,p_date_to                => l_tranche_row.start_date
                                                 ,p_is_planned             => 'Y');

                l_process_row.process_data := update_value_in_xml(
                                                       p_data        => l_process_row.process_data
                                                      ,p_tag         => 'RegisterHistoryId'
                                                      ,p_value       => to_char(l_register_hist_id)
                                                      ,p_parent_node => PARENT_NODE_TRANCHE);
            end if;
            -- пишем историю
            process_utl.set_process_state_id(
                                    p_process_id  => p_process_id
                                   ,p_value     => l_process_row.state_id);
            set_process_data(
                         p_process_id  => p_process_id
                        ,p_data       => l_process_row.process_data);
        end if;
        set_process_info(p_process_id  => p_process_id);
    end;

    procedure tranche_blocking(p_process_id in number
                              ,p_lock_date  in date
                              ,p_comment    in varchar2
                              ,p_lock_type  in number)
     is
        l_process_row      process%rowtype;
        l_process_type_id  number;
    begin
        logger.log_info(p_procedure_name => $$plsql_unit||'.tranche_blocking',
                        p_log_message    => 'p_process_id : ' || p_process_id || chr(10) ||
                                            'lock_date    : ' || to_char(p_lock_date, 'yyyy-mm-dd') || chr(10) ||
                                            'p_comment    : ' || p_comment || chr(10) ||
                                            'p_lock_type  : ' || p_lock_type
                            );

        l_process_row := process_utl.read_process(
                                             p_process_id => p_process_id
                                            ,p_raise_ndf  => true );

        l_process_type_id := process_utl.get_proc_type_id(
                                            p_proc_type_code => PROCESS_TRANCHE_CREATE
                                           ,p_module_code    => PROCESS_TRANCHE_MODULE);

        if l_process_row.process_type_id <> l_process_type_id then
           raise_application_error(-20000, 'Блокування заборонено. Процес {'||p_process_id||'} має тип {'||
                                                 process_utl.get_proc_type_name(
                                                                   p_proc_type_id => l_process_row.process_type_id)
                                                  );
        end if;

        if p_lock_type is null then
            raise_application_error(-20000, 'Вкажіть тип блокування');
        end if;
        -- тип процесса Транш
        l_process_row.process_data := update_value_in_xml(p_data        => l_process_row.process_data
                                                         ,p_tag         => 'ProcessId'
                                                         ,p_value       => ''
                                                         ,p_parent_node => PARENT_NODE_TRANCHE);
        l_process_row.process_data := update_value_in_xml(p_data        => l_process_row.process_data
                                                         ,p_tag         => 'Comment'
                                                         ,p_value       => p_comment
                                                         ,p_parent_node => PARENT_NODE_TRANCHE);
        -- сохраняем
        l_process_row.process_data := update_value_in_xml(p_data        => l_process_row.process_data
                                                         ,p_tag         => 'ActionDate'
                                                         ,p_value       => to_char(p_lock_date, 'yyyy-mm-dd')
                                                         ,p_parent_node => PARENT_NODE_TRANCHE);
        l_process_row.process_data := update_value_in_xml(p_data        => l_process_row.process_data
                                                         ,p_tag         => 'LockTrancheId'
                                                         ,p_value       => p_lock_type
                                                         ,p_parent_node => PARENT_NODE_TRANCHE);

        -- чтобы не создавать переменную "гасим" ее таким вызовоm
        tools.hide_hint( process_utl.process_create(
                              p_proc_type_code    => PROCESS_TRANCHE_BLOCKING
                             ,p_proc_type_module  => PROCESS_TRANCHE_MODULE
                             ,p_process_name      => 'блокування Траншу >>'
                             ,p_process_data      => l_process_row.process_data
                             ,p_process_object_id => null));

        logger.log_info(p_procedure_name => $$plsql_unit||'.tranche_blocking (finished)',
                        p_log_message    => 'p_process_id : ' || p_process_id || chr(10) ||
                                            'lock_date    : ' || to_char(p_lock_date, 'yyyy-mm-dd') || chr(10) ||
                                            'p_comment    : ' || p_comment || chr(10) ||
                                            'p_lock_type  : ' || p_lock_type
                            );
    end;

    procedure tranche_unblocking(p_process_id  in number
                                ,p_unlock_date in date
                                ,p_comment     in varchar2)
     is
        l_process_row      process%rowtype;
        l_process_type_id  number;
    begin
        logger.log_info(p_procedure_name => $$plsql_unit||'.tranche_unblocking',
                        p_log_message    => 'p_process_id  : ' || p_process_id || chr(10) ||
                                            'p_unlock_date : ' || to_char(p_unlock_date, 'yyyy-mm-dd') || chr(10) ||
                                            'p_comment     : ' || p_comment
                            );
        l_process_row := process_utl.read_process(
                                             p_process_id => p_process_id
                                            ,p_raise_ndf  => true );

        l_process_type_id := process_utl.get_proc_type_id(
                                            p_proc_type_code => PROCESS_TRANCHE_CREATE
                                           ,p_module_code    => PROCESS_TRANCHE_MODULE);

        if l_process_row.process_type_id <> l_process_type_id then
           raise_application_error(-20000, 'Розблокування заборонено. Процес {'||p_process_id||'} має тип {'||
                                                 process_utl.get_proc_type_name(
                                                                   p_proc_type_id => l_process_row.process_type_id)
                                                  );
        end if;
        -- тип процесса Транш
        l_process_row.process_data := update_value_in_xml(p_data        => l_process_row.process_data
                                                         ,p_tag         => 'ProcessId'
                                                         ,p_value       => ''
                                                         ,p_parent_node => PARENT_NODE_TRANCHE);
        l_process_row.process_data := update_value_in_xml(p_data        => l_process_row.process_data
                                                         ,p_tag         => 'RegisterHistoryId'
                                                         ,p_value       => ''
                                                         ,p_parent_node => PARENT_NODE_TRANCHE);
        l_process_row.process_data := update_value_in_xml(p_data        => l_process_row.process_data
                                                         ,p_tag         => 'Comment'
                                                         ,p_value       => p_comment
                                                         ,p_parent_node => PARENT_NODE_TRANCHE);
        l_process_row.process_data := update_value_in_xml(p_data        => l_process_row.process_data
                                                         ,p_tag         => 'ActionDate'
                                                         ,p_value       => to_char(p_unlock_date, 'yyyy-mm-dd')
                                                         ,p_parent_node => PARENT_NODE_TRANCHE);

        -- чтобы не создавать переменную "гасим" ее таким вызовоm
        -- при разблокировании транша он закроется если истек срок действия
        tools.hide_hint( process_utl.process_create(
                              p_proc_type_code    => PROCESS_TRANCHE_UNBLOCKING
                             ,p_proc_type_module  => PROCESS_TRANCHE_MODULE
                             ,p_process_name      => 'розблокування Траншу >>'
                             ,p_process_data      => l_process_row.process_data
                             ,p_process_object_id => null));

        logger.log_info(p_procedure_name => $$plsql_unit||'.tranche_unblocking (finished)',
                        p_log_message    => 'p_process_id : ' || p_process_id || chr(10) ||
                                            'p_process_id : ' || to_char(p_unlock_date, 'yyyy-mm-dd') || chr(10) ||
                                            'p_comment    : ' || p_comment
                            );
    end;

    function get_returning_tranche_xml(p_process_id in number
                                      ,p_object_id  in number)
                        return clob
     is
        l_process_row   process%rowtype;
        l_register_row  register_value%rowtype;
        l_tranche_row   c_tranche_from_xml%rowtype;
        l_proc_type_id  number;
        l_proc_state_id number;
        l_process_id    number;
        l_penalty       number;
    begin
        logger.log_info(p_procedure_name => $$plsql_unit||'.get_returning_tranche_xml',
                        p_log_message    => 'p_process_id : ' || p_process_id || chr(10) ||
                                            'p_object_id  : ' || p_object_id
                            );

        l_proc_type_id :=  process_utl.get_proc_type_id(
                                          p_proc_type_code => PROCESS_EARLY_RETURN_TRANCHE
                                         ,p_module_code    => PROCESS_TRANCHE_MODULE
                                         ,p_raise_ndf      => true);
        if p_process_id is not null then
            l_process_row := process_utl.read_process(
                                                 p_process_id => p_process_id
                                                ,p_raise_ndf  => true );
            check_deposit_type(p_object_id               => l_process_row.object_id
                              ,p_target_object_type_code => TRANCHE_OBJECT_TYPE_CODE
                               );

            if l_process_row.process_type_id <> l_proc_type_id then
                raise_application_error(-20000, 'Процес {'||p_process_id||'} не відноситься до "Дострокове повернення траншу ММСБ"');
            end if;
        else
            if p_object_id is null then
                 raise_application_error(-20000, 'Не вказано транш .');
            end if;

            check_deposit_type(p_object_id               => p_object_id
                              ,p_target_object_type_code => TRANCHE_OBJECT_TYPE_CODE
                               );

            -- попытка по объекту найти процесс по досрочном возвращении транша
            select max(p.id)
                  ,max(p.state_id) keep (dense_rank first order by p.id desc)
              into l_process_id, l_proc_state_id
              from process p
             where p.process_type_id = l_proc_type_id
               and p.object_id = p_object_id
               and p.state_id in (process_utl.GC_PROCESS_STATE_CREATE, process_utl.GC_PROCESS_STATE_RUN, process_utl.GC_PROCESS_STATE_SUCCESS);

            l_process_row := process_utl.read_process(
                                             p_process_id => l_process_id
                                            ,p_raise_ndf  => false );
            -- нашли
            if l_process_row.id is not null then
                return l_process_row.process_data;
            end if;
            -- не нашли, берем данные с основного транша
            l_process_row  := process_utl.read_process(
                                                 p_process_id => read_base_tranche(p_object_id => p_object_id).process_id
                                                ,p_raise_ndf  => true );
            l_tranche_row  := get_tranche_from_xml(p_data => l_process_row.process_data);

            -- получить сумму транша с пополнениями
            l_register_row := register_utl.read_register_value(
                                           p_object_id        => p_object_id
                                          ,p_register_code    => register_utl.SMB_PRINCIPAL_AMOUNT_CODE
                                          ,p_raise_ndf        => true
                                          );
            -- транш возвращается на полную сумму
            l_process_row.process_data := update_value_in_xml(p_data        => l_process_row.process_data
                                                             ,p_tag         => 'AmountTranche'
                                                             ,p_value       => l_register_row.actual_value / l_tranche_row.denom
                                                             ,p_parent_node => PARENT_NODE_TRANCHE);
            l_process_row.process_data := update_value_in_xml(p_data        => l_process_row.process_data
                                                             ,p_tag         => 'ObjectId'
                                                             ,p_value       => to_char(p_object_id)
                                                             ,p_parent_node => PARENT_NODE_TRANCHE);

            l_process_row.process_data := update_value_in_xml(p_data        => l_process_row.process_data
                                                             ,p_tag         => 'ProcessId'
                                                             ,p_value       => ''
                                                             ,p_parent_node => PARENT_NODE_TRANCHE);
            l_process_row.process_data := update_value_in_xml(p_data        => l_process_row.process_data
                                                             ,p_tag         => 'RegisterHistoryId'
                                                             ,p_value       => ''
                                                             ,p_parent_node => PARENT_NODE_TRANCHE);

            l_process_row.process_data := update_value_in_xml(p_data        => l_process_row.process_data
                                                             ,p_tag         => 'Comment'
                                                             ,p_value       => ''
                                                             ,p_parent_node => PARENT_NODE_TRANCHE);

            l_process_row.process_data := update_value_in_xml(p_data        => l_process_row.process_data
                                                             ,p_tag         => 'ActionDate'
                                                             ,p_value       => to_char(sysdate, 'yyyy-mm-dd')
                                                             ,p_parent_node => PARENT_NODE_TRANCHE);

            l_process_row.process_data := update_value_in_xml(p_data        => l_process_row.process_data
                                                             ,p_tag         => 'IsSigned'
                                                             ,p_value       => '0'
                                                             ,p_parent_node => PARENT_NODE_TRANCHE);
            l_process_row.process_data := update_value_in_xml(p_data        => l_process_row.process_data
                                                             ,p_tag         => 'Ref_'
                                                             ,p_value       => null
                                                             ,p_parent_node => PARENT_NODE_TRANCHE);

            l_penalty := get_penalty_interest_rate(p_data => l_process_row.process_data);
            l_process_row.process_data := update_value_in_xml(p_data        => l_process_row.process_data
                                                             ,p_tag         => 'PenaltyRate'
                                                             ,p_value       => l_penalty
                                                             ,p_parent_node => PARENT_NODE_TRANCHE);
            if l_tranche_row.return_account is null then
                l_process_row.process_data := update_value_in_xml(p_data        => l_process_row.process_data
                                                                 ,p_tag         => 'ReturnAccount'
                                                                 ,p_value       => l_tranche_row.debit_account
                                                                 ,p_parent_node => PARENT_NODE_TRANCHE);

            end if;
        end if;
        return l_process_row.process_data;
    end;

    -- for UI
    procedure cor_returning_tranche(p_process_id   in out number
                                   ,p_object_id    in number
                                   ,p_data         in clob)
     is
        l_tranche_row               c_tranche_from_xml%rowtype;
        l_tranche_row_old           c_tranche_from_xml%rowtype;
        l_process_row               process%rowtype;
        l_can_create_flag           char(1 char);
        l_can_create_explanation    varchar2(32767 byte);
        l_penalty_interest_rate_old number;
    begin
        logger.log_info(p_procedure_name => $$plsql_unit||'.cor_returning_tranche',
                        p_log_message    => 'p_process_id : ' || p_process_id
                       ,p_object_id      => p_object_id
                       ,p_auxiliary_info => p_data
                        );
        check_current_branch();
        l_tranche_row  := get_tranche_from_xml(p_data => p_data);
        if p_process_id is null and l_tranche_row.process_id is null then
            -- создаем процесс
            p_process_id := process_utl.process_create(
                                  p_proc_type_code    => PROCESS_EARLY_RETURN_TRANCHE
                                 ,p_proc_type_module  => PROCESS_TRANCHE_MODULE
                                 ,p_process_name      => 'Дострокове повернення траншу >> {'||p_object_id||'}'
                                 ,p_process_data      => p_data
                                 ,p_process_object_id => null);
            if l_tranche_row.penalty_rate is not null then
                  -- создаем атрибут со штрафной ставкой
                  attribute_utl.set_value(
                               p_object_id      => p_object_id
                              ,p_attribute_code => ATTR_SMB_DEPOSIT_PENALTY_IR
                              ,p_value          => l_tranche_row.penalty_rate
                              ,p_valid_from     => l_tranche_row.action_date
                              ,p_valid_through  => null
                              ,p_comment        => null);
            end if;
        else
            p_process_id := nvl(p_process_id, l_tranche_row.process_id);
            -- обновление
            -- проверяем возможность обновления
            smb_deposit_proc.can_create_return_tranche(
                                 p_process_data     => p_data
                                ,p_process_type_id  => process_utl.get_proc_type_id(
                                                                p_proc_type_code => PROCESS_EARLY_RETURN_TRANCHE
                                                               ,p_module_code    => PROCESS_TRANCHE_MODULE
                                                               ,p_raise_ndf      => true )
                                ,p_can_create_flag  => l_can_create_flag
                                ,p_explanation      => l_can_create_explanation);
            if l_can_create_flag <> 'Y' then
                raise_application_error(-20000, l_can_create_explanation);
            end if;

            l_tranche_row_old  := get_tranche_from_xml(p_process_id => p_process_id);
            l_penalty_interest_rate_old := attribute_utl.get_number_value(
                                              p_object_id      => p_object_id
                                             ,p_attribute_code => ATTR_SMB_DEPOSIT_PENALTY_IR
                                             ,p_value_date     => l_tranche_row.action_date);
            -- устанавливаем штрафную ставку если менялась дата или сама ставка
            if tools.compare(l_tranche_row_old.action_date, l_tranche_row.action_date) <> 0 or
               tools.compare(l_tranche_row.penalty_rate, l_penalty_interest_rate_old) <> 0 then
                  attribute_utl.set_value(
                               p_object_id      => p_object_id
                              ,p_attribute_code => ATTR_SMB_DEPOSIT_PENALTY_IR
                              ,p_value          => cast(null as number)
                              ,p_valid_from     => l_tranche_row_old.action_date
                              ,p_valid_through  => null
                              ,p_comment        => null);
                  attribute_utl.set_value(
                               p_object_id      => p_object_id
                              ,p_attribute_code => ATTR_SMB_DEPOSIT_PENALTY_IR
                              ,p_value          => l_tranche_row.penalty_rate
                              ,p_valid_from     => l_tranche_row.action_date
                              ,p_valid_through  => null
                              ,p_comment        => null);
            end if;
            -- запишем то же state_id для истории кто редактировал
            l_process_row := process_utl.read_process(p_process_id => p_process_id
                                                     ,p_lock       => false
                                                     ,p_raise_ndf  => false);
            process_utl.set_process_state_id(p_process_id => p_process_id
                                            ,p_value      => l_process_row.state_id
                                            ,p_raise_ndf  => false);
            set_process_data (
                           p_process_id  => l_tranche_row.process_id
                          ,p_data       => p_data);
        end if;
        set_process_info(p_process_id  => p_process_id);
    end;

    -- отправка на авторизацию досрочного возвращения транша
    procedure returning_tranche_auth(p_process_id in number)
     is
        l_process_row       process%rowtype;
        l_process_type_id   number;
    begin
        logger.log_info(p_procedure_name => $$plsql_unit||'.returning_tranche_auth',
                        p_log_message    => 'p_process_id : ' || p_process_id
                        );
        l_process_row     := process_utl.read_process(
                                           p_process_id => p_process_id
                                          ,p_raise_ndf  => true );
        l_process_type_id := process_utl.get_proc_type_id(
                                                         p_proc_type_code => PROCESS_EARLY_RETURN_TRANCHE
                                                        ,p_module_code    => PROCESS_TRANCHE_MODULE);
        if l_process_type_id <> l_process_row.process_type_id then
            raise_application_error(-20000, 'Відправлення на авторизацію дострокового повернення заборонено. Процес {'||
                                             p_process_id||'} має тип {'||
                                             process_utl.get_proc_type_name(
                                                               p_proc_type_id => l_process_row.process_type_id)
                                            );
        end if;
        tranche_authorization(p_process_id => p_process_id);
    end;

    -- авторизация досрочного возвращения транша
    procedure returning_tranche_confirmation(p_process_id   in number
                                            ,p_is_confirmed in varchar2 default 'Y'
                                            ,p_comment      in varchar2 default null
                                            )
     is
        l_activity_id       number;
        l_process_row       process%rowtype;
        l_comment_text      varchar2(4000);
    begin
        l_process_row := process_utl.read_process(p_process_id => p_process_id);

        check_deposit_type(p_object_id               => l_process_row.object_id
                          ,p_target_object_type_code => TRANCHE_OBJECT_TYPE_CODE
                           );
        if l_process_row.state_id <> process_utl.GC_PROCESS_STATE_RUN then
             raise_application_error(-20000, case when p_is_confirmed = 'Y' then 'Підтвердження '
                                                  else 'Відправлення на редагування '
                                             end ||' заборонено. '||
                                             'Транш  {' || l_process_row.object_id || '} в стані {'||
                                                list_utl.get_item_name( p_list_code => process_utl.GC_PROCESS_STATE
                                                                       ,p_item_id   => l_process_row.state_id)||'}');
        end if;
        if upper(p_is_confirmed) = 'Y' then
            select a.id
              into l_activity_id
              from process p
                  ,activity a
                  ,process_workflow pw
             where p.id = p_process_id
               and pw.process_type_id = p.process_type_id
               and pw.activity_code = ACTIVITY_CONFIRM_CODE
               and a.process_id = p.id
               and a.activity_type_id = pw.id
               and a.state_id <> process_utl.ACT_STATE_REMOVED;

            process_utl.activity_run(p_activity_id  => l_activity_id
                                    ,p_silent_mode  => false
                                    );
            -- перечитаем
            l_process_row := process_utl.read_process(p_process_id => p_process_id);
            -- check status process
            if l_process_row.state_id = process_utl.GC_PROCESS_STATE_FAILURE then
                l_comment_text := get_last_error_on_process(p_process_id => p_process_id);
                -- вызываем исключение
                raise_application_error(-20002, l_comment_text);
            end if;
        else
            if trim(p_comment) is null then
                raise_application_error(-20000, 'Вкажіть причину відхилення');
            end if;
            process_utl.process_revert(p_process_id  => p_process_id
                                      ,p_comment    => p_comment);
        end if;
    end;

    -- инфо для депозита по требованию из clob
    function get_on_demand_from_xml(p_data in clob)
       return c_on_demand_from_xml%rowtype
     is
        l_on_demand_row    c_on_demand_from_xml%rowtype;
    begin
        for i in c_on_demand_from_xml(p_data => p_data) loop
          l_on_demand_row := i;
          exit;
        end loop;
        if l_on_demand_row.currency_id is null then
            raise_application_error(-20000, 'Не вказано валюту');
        end if;
        return l_on_demand_row;
    end;

    -- инфо для депозита по требованию по process_id
    function get_on_demand_from_xml(p_process_id in number)
       return c_on_demand_from_xml%rowtype
     is
        l_process_row   process%rowtype;
    begin
        l_process_row  := process_utl.read_process(p_process_id => p_process_id
                                                  ,p_lock       => false
                                                  ,p_raise_ndf  => true);
        check_deposit_type(p_object_id               => l_process_row.object_id
                          ,p_target_object_type_code => ON_DEMAND_OBJECT_TYPE_CODE
                           );

        return get_on_demand_from_xml(p_data => l_process_row.process_data);
    end;

    -- инфо для депозита по требованию по процессу
    function get_on_demand_xml_data(p_process_id  in number) return clob
     is
        l_process_row      process%rowtype;
    begin
       if p_process_id is null then
          l_process_row.process_data := xml_on_demand_template;
       else
          l_process_row := process_utl.read_process(p_process_id => p_process_id
                                                   ,p_lock       => false
                                                   ,p_raise_ndf  => true);
          check_deposit_type(p_object_id               => l_process_row.object_id
                            ,p_target_object_type_code => ON_DEMAND_OBJECT_TYPE_CODE
                             );
       end if;
       return l_process_row.process_data;
    end get_on_demand_xml_data;

    -- создаем атрибут с процентной ставкой для ДпТ
    procedure set_interest_rate_on_demand(
                         p_object_id     in number
                        ,p_interest_rate in number
                        ,p_valid_from    in date
                        ,p_valid_through in date     default null
                        ,p_comment       in varchar2 default null)
     is
    begin
        attribute_utl.set_value(
                     p_object_id      => p_object_id
                    ,p_attribute_code => ATTR_SMB_DEPOSIT_ON_DEMAND_IR
                    ,p_value          => p_interest_rate
                    ,p_valid_from     => p_valid_from
                    ,p_valid_through  => p_valid_through
                    ,p_comment        => p_comment);

    end;

    -- создаем атрибут с типом расчета для ДпТ
    procedure set_calculation_type_on_demand(
                         p_object_id        in number
                        ,p_calculation_type in number
                        ,p_valid_from       in date
                        ,p_valid_through    in date     default null
                        ,p_comment          in varchar2 default null)
     is
    begin
        attribute_utl.set_value(
                     p_object_id      => p_object_id
                    ,p_attribute_code => ATTR_SMB_DPT_ON_DEMAND_CALC
                    ,p_value          => p_calculation_type
                    ,p_valid_from     => p_valid_from
                    ,p_valid_through  => p_valid_through
                    ,p_comment        => p_comment);

    end;

    -- обновляем ДпТ
    procedure update_deposit_on_demand(p_process_id  in number
                                      ,p_data        in clob)
     is
        l_on_demand_row        c_on_demand_from_xml%rowtype;
        l_process_row          process%rowtype;
        l_deal_row             deal%rowtype;
        l_interest_rate        number;
        l_old_value            number;
        l_is_active            number;
    begin

        l_process_row       := process_utl.read_process(p_process_id => p_process_id
                                                   ,p_raise_ndf  => true);
        l_on_demand_row     := get_on_demand_from_xml(p_data => p_data);
        -- сумму не проверяем
        /*
        if l_on_demand_row.amount_deposit is null then
           raise_application_error(-20000, 'Не вказана сумма депозиту');
        end if;
        */
        select max(1)
          into l_is_active
          from object o
              ,object_state os
         where 1 = 1
           and o.id = l_process_row.object_id
           and o.state_id = os.id
           and os.state_code = OBJ_TRANCHE_STATE_ACTIVE;

        if l_is_active > 0 then
            raise_application_error(-20000, 'Редагування заборонено. Депозит  {' || l_on_demand_row.deal_number || '} авторизований');
        end if;
        l_process_row.process_data := p_data;
        l_deal_row := deal_utl.read_deal(
                                    p_deal_id   => l_process_row.object_id
                                   ,p_lock      => true
                                   ,p_raise_ndf => true);
        if tools.compare(l_deal_row.start_date, l_on_demand_row.start_date) <> 0 then
            deal_utl.set_deal_start_date(
                                    p_deal_id    => l_process_row.object_id
                                   ,p_start_date => l_on_demand_row.start_date);
        end if;
        if tools.compare(l_deal_row.expiry_date, l_on_demand_row.expiry_date) <> 0 then
            deal_utl.set_deal_expiry_date(
                                    p_deal_id     => l_process_row.object_id
                                   ,p_expiry_date => l_on_demand_row.expiry_date);
        end if;
        if tools.compare(l_deal_row.curator_id, user_id()) <> 0 then
            deal_utl.set_deal_curator_id(
                                    p_deal_id    => l_process_row.object_id
                                   ,p_curator_id => user_id());
        end if;

        -- суммы не устанавливаем в регистр, так как пополняют через АБС
        -- устанавливаем только индивидуальную % ставку
        l_interest_rate     := case when l_on_demand_row.is_individual_rate = 1
                                    then l_on_demand_row.individual_interest_rate
                                    else null -- l_on_demand_row.interest_rate
                               end;
        if nvl(l_interest_rate, 0) = 0 and l_on_demand_row.is_individual_rate = 1 then
            raise_application_error(-20000, 'Не вказана % ставка депозиту');
        end if;

        l_old_value := attribute_utl.get_number_value(
                                    p_object_id      => l_process_row.object_id
                                   ,p_attribute_code => ATTR_SMB_DEPOSIT_ON_DEMAND_IR
                                   ,p_value_date     => l_deal_row.start_date);

        -- устанавливаем % ставку если менялась дата или сама ставка
        if tools.compare(l_deal_row.start_date, l_on_demand_row.start_date) <> 0 or
            nvl(l_interest_rate, 0) <> nvl(l_old_value, 0) then
            set_interest_rate_on_demand(
                         p_object_id     => l_process_row.object_id
                        ,p_interest_rate => null
                        ,p_valid_from    => l_deal_row.start_date);
            set_interest_rate_on_demand(
                         p_object_id     => l_process_row.object_id
                        ,p_interest_rate => l_interest_rate
                        ,p_valid_from    => l_on_demand_row.start_date);
        end if;
        l_old_value := attribute_utl.get_number_value(
                                    p_object_id      => l_process_row.object_id
                                   ,p_attribute_code => ATTR_SMB_DPT_ON_DEMAND_CALC
                                   ,p_value_date     => l_deal_row.start_date);
        -- меняем тип расчета, если нужно
        if tools.compare(l_deal_row.start_date, l_on_demand_row.start_date) <> 0 or
            l_on_demand_row.calculation_type <> l_old_value then

            set_calculation_type_on_demand(
                           p_object_id        => l_process_row.object_id
                          ,p_calculation_type => null
                          ,p_valid_from       => l_deal_row.start_date);

            set_calculation_type_on_demand(
                           p_object_id        => l_process_row.object_id
                          ,p_calculation_type => l_on_demand_row.calculation_type
                          ,p_valid_from       => trunc(l_on_demand_row.start_date));
        end if;

        update smb_deposit set
               currency_id                  = l_on_demand_row.currency_id
              ,frequency_payment            = l_on_demand_row.frequency_payment
              ,is_individual_rate           = l_on_demand_row.is_individual_rate
              ,individual_interest_rate     = case when l_on_demand_row.is_individual_rate = 0 then 0 else l_on_demand_row.individual_interest_rate end
              ,calculation_type             = l_on_demand_row.calculation_type
         where id = l_process_row.object_id;
        -- запишем то же state_id для истории кто редактировал
        process_utl.set_process_state_id(p_process_id => p_process_id
                                        ,p_value      => l_process_row.state_id
                                        ,p_raise_ndf  => false);

        set_process_data (
                      p_process_id => p_process_id
                     ,p_data       => p_data);

    end;

    -- создание или обновление ДпТ вызов из UI (web)
    procedure cor_on_demand(p_process_id   in out number
                           ,p_data         in clob)
     is
        l_process_row            process%rowtype;
        l_on_demand_row          c_on_demand_from_xml%rowtype;
        l_new_on_demand_row      c_on_demand_from_xml%rowtype;
        l_can_create_flag        char(1 char);
        l_can_create_explanation varchar2(32767 byte);
        l_process_type_id        number;
    begin
        logger.log_info(p_procedure_name => $$plsql_unit||'.cor_on_demand',
                        p_log_message    => 'p_process_id : ' || p_process_id || chr(10) ||
                                            'TEST_MODE    : ' ||TEST_MODE
                       ,p_object_id      => null
                       ,p_auxiliary_info => p_data
                        );
        check_current_branch();
        -- если null
        if p_process_id is null then
            -- попытка достать из xml
            l_on_demand_row := get_on_demand_from_xml(p_data => p_data);
            p_process_id    := l_on_demand_row.process_id;
        end if;

        if p_process_id is null then
            if l_on_demand_row.primary_account is not null then
                raise_application_error(-20000, 'Вкалад на вимогу не створений, а депозитний рахунок знайдено !!! (???) '||l_on_demand_row.primary_account);
            end if;
            p_process_id := process_utl.process_create(
                                  p_proc_type_code    => PROCESS_ON_DEMAND_CREATE
                                 ,p_proc_type_module  => PROCESS_TRANCHE_MODULE
                                 ,p_process_name      => 'на вимогу >>'
                                 ,p_process_data      => p_data
                                 ,p_process_object_id => null);
        else

            l_process_row := process_utl.read_process(p_process_id => p_process_id
                                                     ,p_raise_ndf  => true);

            l_on_demand_row := get_on_demand_from_xml(p_data => p_data);

            l_process_type_id := process_utl.get_proc_type_id(
                                                         p_proc_type_code => PROCESS_ON_DEMAND_CREATE
                                                        ,p_module_code    => PROCESS_TRANCHE_MODULE);
            if l_process_type_id <> l_process_row.process_type_id then
                raise_application_error(-20000, 'Редагування заборонено. Процес {'||p_process_id||'} має тип {'||
                                                 process_utl.get_proc_type_name(
                                                                   p_proc_type_id => l_process_row.process_type_id)
                                                  );
            end if;
            if l_process_row.state_id <> process_utl.GC_PROCESS_STATE_CREATE then
                raise_application_error(-20000, 'Редагування заборонено. Депозит  {' || l_on_demand_row.deal_number || '} в стані {'||
                                        list_utl.get_item_name( p_list_code => process_utl.GC_PROCESS_STATE
                                                               ,p_item_id   => l_process_row.state_id)||'}');
            end if;

            smb_deposit_proc.can_create_new_on_demand(
                                 p_process_data     => p_data
                                ,p_process_type_id  => process_utl.get_proc_type_id(
                                                                p_proc_type_code => PROCESS_ON_DEMAND_CREATE
                                                               ,p_module_code    => PROCESS_TRANCHE_MODULE
                                                               ,p_raise_ndf      => true )
                                ,p_can_create_flag  => l_can_create_flag
                                ,p_explanation      => l_can_create_explanation);

            if l_can_create_flag <> 'Y' then
                raise_application_error(-20000, l_can_create_explanation);
            end if;
            l_on_demand_row     := get_on_demand_from_xml(p_process_id => p_process_id);
            l_new_on_demand_row := get_on_demand_from_xml(p_data       => p_data);
            if l_new_on_demand_row.branch is null then
                raise_application_error(-20000, 'BRANCH IS EMPTY!!!.');
            end if;
            if l_on_demand_row.currency_id <> l_new_on_demand_row.currency_id then
                raise_application_error(-20000, 'Зміна валюти депозиту на вимогу заборонена.');
            end if;
            update_deposit_on_demand(p_process_id  => p_process_id
                                    ,p_data        => p_data);
        end if;
        set_process_info(p_process_id  => p_process_id);
    end cor_on_demand;

    -- создание ДпТ
    -- вызов происходит из процессов (process_utl)
    function create_deposit_on_demand(p_process_id  in number) return number
     is
        l_on_demand_row    c_on_demand_from_xml%rowtype;
        l_data             clob;
        l_object_id        number;
        l_object_type_id   number;
        l_product_id       number;
        l_qty              number;
        l_contract_number  varchar2(100);
        l_branch           varchar2(50) := bc.current_branch_code;
    begin
        l_data          := process_utl.read_process(p_process_id).process_data;
        l_on_demand_row := get_on_demand_from_xml(p_data => l_data);

        l_object_type_id  := get_object_type_on_demand();
        l_product_id      := product_utl.read_product(
                                                 p_product_type_id => l_object_type_id
                                                ,p_product_code    => ON_DEMAND_PRODUCT_CODE
                                                ,p_lock            => true).id;

        select o.contract_number
          into l_contract_number
          from v_dbo o
         where rnk = l_on_demand_row.customer_id;
        -- если бранч на уровне РУ, то долняем 0
        --l_branch := l_branch || case when length(l_branch) = 8 then '000000/' end;

        l_object_id := deal_utl.create_deal(
                                p_deal_type_code => ON_DEMAND_OBJECT_TYPE_CODE
                               ,p_deal_number    => null
                               ,p_customer_id    => l_on_demand_row.customer_id
                               ,p_product_id     => l_product_id
                               ,p_start_date     => l_on_demand_row.start_date
                               ,p_expiry_date    => null
                               ,p_state_code     => null
                               ,p_branch         => l_branch);
        -- по ТЗ мы должны считать ко-во траншей у клиента
        --
        select count(*)
          into l_qty
          from object o
              ,deal d
         where 1 = 1
           and o.object_type_id = l_object_type_id
           and o.id = d.id
           and d.customer_id = l_on_demand_row.customer_id;

         -- set deal number mask dbo contract_number/amount tranche
        deal_utl.set_deal_number(
                    p_deal_id     => l_object_id
                   ,p_deal_number => l_contract_number||'/'||l_qty
                    );
        -- пишем номер в xml
        l_data := update_value_in_xml(
                                       p_data        => l_data
                                      ,p_tag         => 'DealNumber'
                                      ,p_value       => l_contract_number||'/'||l_qty
                                      ,p_parent_node => PARENT_NODE_ON_DEMAND);

        l_data := update_value_in_xml(
                                       p_data        => l_data
                                      ,p_tag         => 'ObjectId'
                                      ,p_value       => to_char(l_object_id)
                                      ,p_parent_node => PARENT_NODE_ON_DEMAND);

        l_data := update_value_in_xml(
                                       p_data        => l_data
                                      ,p_tag         => 'ProcessId'
                                      ,p_value       => to_char(p_process_id)
                                      ,p_parent_node => PARENT_NODE_ON_DEMAND);

        l_data := update_value_in_xml(
                                       p_data        => l_data
                                      ,p_tag         => 'Branch'
                                      ,p_value       => l_branch
                                      ,p_parent_node => PARENT_NODE_ON_DEMAND);

        -- устанавливаем только индивидуальную % ставку
        set_interest_rate_on_demand(
                         p_object_id     => l_object_id
                        ,p_interest_rate => case when l_on_demand_row.is_individual_rate = 1
                                                 then l_on_demand_row.individual_interest_rate
                                                 else null
                                            end
                        ,p_valid_from    => trunc(l_on_demand_row.start_date));
        -- записываем тип расчета
        set_calculation_type_on_demand(
                         p_object_id        => l_object_id
                        ,p_calculation_type => l_on_demand_row.calculation_type
                        ,p_valid_from    => trunc(l_on_demand_row.start_date));

        insert into smb_deposit  (
                   id
                  ,currency_id
                  ,amount_tranche
                  ,is_replenishment_tranche
                  ,is_prolongation
                  ,frequency_payment
                  ,is_capitalization
                  ,is_individual_rate
                  ,individual_interest_rate
                  ,calculation_type
                  )
           values(
                   l_object_id
                  ,l_on_demand_row.currency_id
                  ,null
                  ,0
                  ,0
                  ,l_on_demand_row.frequency_payment
                  ,0
                  ,l_on_demand_row.is_individual_rate
                  ,case when l_on_demand_row.is_individual_rate = 0 then 0 else l_on_demand_row.individual_interest_rate end
                  ,l_on_demand_row.calculation_type
                  );
        -- суммы не устанавливаем в регистр, так как пополняют через АБС
        set_process_data (
                       p_process_id => p_process_id
                      ,p_data       => l_data);

        return l_object_id;
    end;

    -- отправить ДпТ на авторизацию
    procedure on_demand_authorization(p_process_id in number)
     is
        l_process_row       process%rowtype;
        l_process_type_id   number;
    begin
        logger.log_info(p_procedure_name => $$plsql_unit||'.on_demand_authorization',
                        p_log_message    => 'p_process_id   : ' || p_process_id );

        l_process_row := process_utl.read_process(
                                           p_process_id => p_process_id
                                          ,p_raise_ndf  => true );

        check_deposit_type(p_object_id               => l_process_row.object_id
                          ,p_target_object_type_code => ON_DEMAND_OBJECT_TYPE_CODE
                           );
        l_process_type_id := process_utl.get_proc_type_id(
                                                         p_proc_type_code => PROCESS_ON_DEMAND_CREATE
                                                        ,p_module_code    => PROCESS_TRANCHE_MODULE);
        if l_process_type_id <> l_process_row.process_type_id then
            raise_application_error(-20000, 'Відправлення на авторизацію заборонено. Процес {'||
                                             p_process_id||'} має тип {'||
                                             process_utl.get_proc_type_name(
                                                               p_proc_type_id => l_process_row.process_type_id)
                                            );
        end if;

        process_utl.process_run(p_process_id  => p_process_id);
        set_process_info(p_process_id  => p_process_id);
    end;

    -- подтверждение / отклонение БО
    procedure on_demand_confirmation(p_process_id   in number
                                     ,p_is_confirmed in varchar2 default 'Y'
                                     ,p_comment      in varchar2 default null
                                     ,p_error        out varchar2)
     is
        l_activity_id       number;
        l_process_row       process%rowtype;
        l_on_demand_row     c_on_demand_from_xml%rowtype;
        l_comment_text      varchar2(4000);
    begin
        logger.log_info(p_procedure_name => $$plsql_unit||'.on_demand_confirmation',
                            p_log_message    => 'p_process_id   : ' || p_process_id || chr(10) ||
                                                'p_is_confirmed : ' || p_is_confirmed
                            );

        l_process_row := process_utl.read_process(
                                           p_process_id => p_process_id
                                          ,p_raise_ndf  => true );

        check_deposit_type(p_object_id               => l_process_row.object_id
                          ,p_target_object_type_code => ON_DEMAND_OBJECT_TYPE_CODE
                           );
        if l_process_row.state_id <> process_utl.GC_PROCESS_STATE_RUN then
             raise_application_error(-20000, case when p_is_confirmed = 'Y' then 'Підтвердження '
                                                  else 'Відправлення на редагування '
                                             end ||' заборонено. '||
                                             'Вклад на вимогу  {' || deal_utl.get_deal_number(p_deal_id => l_process_row.object_id) ||
                                             '} в стані {'|| list_utl.get_item_name( p_list_code => process_utl.GC_PROCESS_STATE
                                                                                    ,p_item_id   => l_process_row.state_id)||'}');
        end if;
        if upper(p_is_confirmed) = 'Y' then
            select a.id
              into l_activity_id
              from process p
                  ,activity a
                  ,process_workflow pw
             where p.id = p_process_id
               and pw.process_type_id = p.process_type_id
               and pw.activity_code = ACTIVITY_CONFIRM_CODE
               and a.process_id = p.id
               and a.activity_type_id = pw.id
               and a.state_id <> process_utl.ACT_STATE_REMOVED;

            logger.log_info(p_procedure_name => $$plsql_unit||'.on_demand_confirmation => Y',
                            p_log_message    => 'p_process_id  : ' || p_process_id  || chr(10) ||
                                                'l_activity_id : ' || l_activity_id
                            );

            process_utl.activity_run(p_activity_id  => l_activity_id
                                    ,p_silent_mode  => true
                                    );
            -- перечитаем
            l_process_row := process_utl.read_process(p_process_id => p_process_id);
            -- check status process
            -- или ошибка или транш остался в статусе  running
            if l_process_row.state_id = process_utl.GC_PROCESS_STATE_FAILURE then

                l_on_demand_row := smb_deposit_utl.get_on_demand_from_xml(l_process_row.id);
                -- достаем коммент и вызываем исключение
                l_comment_text := get_last_error_on_process(p_process_id => p_process_id);
                -- ожидаемая ошибка - не достаточно денег на счету
                if l_comment_text like '%'||ERR_NOT_ENOUGH_MONEY||'%' then
                   -- возвращаем через параметр иначе все откатится,
                   -- а нам нужнен процесс в статусе FAILED
                   p_error := ERR_NOT_ENOUGH_MONEY||l_on_demand_row.debit_account||'}';
                else
                    -- все последующие манипуляции для записи истории (нужно продумать доработку process_utl (???))
                    -- достаем первую активити, делаем "откат" к состоянию CREATED
                    for i in (
                        select a.id
                          from activity a
                          left join activity_dependency ad on a.id = ad.primary_activity_id
                          where  a.process_id = p_process_id
                                 and a.state_id != process_utl.ACT_STATE_REMOVED
                                 and not exists (select 1 from activity_dependency adc where adc.following_activity_id = a.id))
                    loop
                      process_utl.activity_revert(
                                                   p_activity_id => i.id
                                                  ,p_comment   => '#unexpected error#'
                                                ) ;
                    end loop;
                    -- сам процесс устанавливаем в RUN (т.е. на авторизации)
                    --
                    process_utl.set_process_state_id(
                                    p_process_id  => p_process_id
                                   ,p_value       => process_utl.GC_PROCESS_STATE_RUN);

                    p_error := l_comment_text;
                end if;
            end if;
            if p_error is null or p_error like ERR_NOT_ENOUGH_MONEY||'%' then
                -- проверим депозитный счет и счет начисленных %
                check_accounts(p_object_id => l_process_row.object_id);
            end if;
        else
            logger.log_info(p_procedure_name => $$plsql_unit||'.on_demand_confirmation => N',
                            p_log_message    => 'p_process_id : ' || p_process_id || chr(10) ||
                                                'p_comment    : ' || p_comment
                            );

            if trim(p_comment) is null then
                raise_application_error(-20000, 'Вкажіть причину відхилення вкладу на вимогу');
            end if;
            process_utl.process_revert(p_process_id  => p_process_id
                                      ,p_comment    => p_comment);
        end if;
    end;

    -- получить данные для закрытия ДпТ
    function get_close_on_demand_xml_data(p_process_id in number
                                         ,p_object_id  in number)
                        return clob
     is
        l_process_row        process%rowtype;
        l_process_id         number := p_process_id;
        l_process_type_id    number;
        l_main_on_demand_row c_on_demand_from_xml%rowtype;
    begin
        logger.log_info(p_procedure_name => $$plsql_unit||'.get_close_on_demand_xml_data',
                        p_log_message    => 'p_process_id : ' || p_process_id || chr(10) ||
                                            'p_object_id  : ' || p_object_id  || chr(10) ||
                                            'TEST_MODE    : ' ||TEST_MODE
                       ,p_object_id      => null
                       ,p_auxiliary_info => null
                        );

        if p_object_id is null then
            raise_application_error(-20000, 'Вклад на вимогу не знайдено.');
        end if;

        check_deposit_type(p_object_id               => p_object_id
                          ,p_target_object_type_code => ON_DEMAND_OBJECT_TYPE_CODE
                           );

        if l_process_id is null then

            -- попытка найти процесс для объекта - процесс закрытия CLOSE_ON_DEMAND
            begin
                select p.*
                  into l_process_row
                  from process p
                      ,process_type pt
                 where pt.process_code = PROCESS_ON_DEMAND_CLOSE
                   and pt.module_code = PROCESS_TRANCHE_MODULE
                   and pt.id = p.process_type_id
                   and p.object_id = p_object_id
                   and p.state_id in (process_utl.GC_PROCESS_STATE_CREATE, process_utl.GC_PROCESS_STATE_RUN, process_utl.GC_PROCESS_STATE_SUCCESS )
                   and rownum = 1;
            exception
                when no_data_found then null;
            end;
            -- не нашли идем по основному объекту
            if l_process_row.id is null then
                -- берем данные из основного ДпТ
                -- и некоторые из них меняем на null (они будут обновлены в процессе попоплнения)
                l_main_on_demand_row :=  read_base_on_demand(p_object_id => p_object_id);
                l_process_row := process_utl.read_process(
                                              p_process_id => l_main_on_demand_row.process_id
                                             ,p_raise_ndf  => true);

                l_process_row.process_data := update_value_in_xml(p_data  => l_process_row.process_data
                                                                 ,p_tag   => 'ProcessId'
                                                                 ,p_value => ''
                                                                 ,p_parent_node => PARENT_NODE_ON_DEMAND);
                l_process_row.process_data := update_value_in_xml(p_data        => l_process_row.process_data
                                                                 ,p_tag         => 'IsSigned'
                                                                 ,p_value       => '0'
                                                                 ,p_parent_node => PARENT_NODE_ON_DEMAND);

            end if;
        else
           l_process_row := process_utl.read_process(p_process_id => p_process_id
                                                    ,p_lock       => false
                                                    ,p_raise_ndf  => true);

           l_process_type_id := process_utl.get_proc_type_id(
                                                         p_proc_type_code => PROCESS_ON_DEMAND_CLOSE
                                                        ,p_module_code    => PROCESS_TRANCHE_MODULE);

           if l_process_type_id <> l_process_row.process_type_id then
               raise_application_error(-20000, 'Процес {'||p_process_id||'} має тип {'||
                                                process_utl.get_proc_type_name(
                                                                   p_proc_type_id => l_process_row.process_type_id)
                                                  );
           end if;
        end if;
        logger.log_info(p_procedure_name => $$plsql_unit||'.get_close_on_demand_xml_data',
                        p_log_message    => 'p_process_id : ' || p_process_id || chr(10) ||
                                            'p_object_id  : ' || p_object_id
                       ,p_object_id      => p_object_id
                       ,p_auxiliary_info => l_process_row.process_data
                        );

        return l_process_row.process_data;
    end;

    -- создание или обновление ДпТ вызов из UI (web)
    procedure cor_close_on_demand(p_process_id   in out number
                                 ,p_object_id    in number
                                 ,p_data         in clob)
     is
        l_process_row            process%rowtype;
        l_deal_row               deal%rowtype;
        l_object_row             object%rowtype;
        l_on_demand_row          c_on_demand_from_xml%rowtype;
        l_can_create_flag        char(1 char);
        l_can_create_explanation varchar2(32767 byte);
        l_process_type_id        number;
    begin
        logger.log_info(p_procedure_name => $$plsql_unit||'.cor_close_on_demand',
                        p_log_message    => 'p_process_id : ' || p_process_id || chr(10) ||
                                            'p_object_id  : ' || p_object_id
                       ,p_object_id      => null
                       ,p_auxiliary_info => p_data
                        );
        l_process_row.id := p_process_id;
        -- если null raise
        if p_object_id is null then
            raise_application_error(-20000, 'Не вказано вклад на вимогу');
        end if;
        -- проверяем объект на принадлежность к ДпТ
        check_deposit_type(p_object_id               => p_object_id
                          ,p_target_object_type_code => ON_DEMAND_OBJECT_TYPE_CODE
                           );

        -- попытка найти процесс для объекта - процесс закрытия CLOSE_ON_DEMAND
        if l_process_row.id is null then
            begin
                -- в коком состоянии депозит
                l_object_row := object_utl.read_object(p_object_id => p_object_id);
                if object_utl.get_object_state_code(p_state_id => l_object_row.state_id) <> 'ACTIVE' then
                    l_deal_row := deal_utl.read_deal(p_deal_id => p_object_id);
                    raise_application_error(-20000,  'Закриття вкладу на вимогу заборонено. Вклад на вимогу  {' || l_deal_row.deal_number ||
                                                     '} в стані {'||
                                                     object_utl.get_object_state_name(p_state_id => l_object_row.state_id)||'}');
                end if;
                -- если он на авторизации/авторизирован то исключение
                select p.*
                  into l_process_row
                  from process p
                      ,process_type pt
                 where pt.process_code = PROCESS_ON_DEMAND_CLOSE
                   and pt.module_code = PROCESS_TRANCHE_MODULE
                   and pt.id = p.process_type_id
                   and p.object_id = p_object_id
                   and p.state_id in (process_utl.GC_PROCESS_STATE_RUN, process_utl.GC_PROCESS_STATE_SUCCESS )
                   and rownum = 1;
                -- тут бы по хорошему проверить process_state_id (???)
                raise_application_error(-20000, 'Закриття вкладу на вимогу активовано.'|| chr(10) ||
                                                case when l_process_row.state_id = process_utl.GC_PROCESS_STATE_CREATE
                                                     then 'Потрібно передати на авторизацію.'
                                                     when l_process_row.state_id = process_utl.GC_PROCESS_STATE_RUN
                                                     then 'Потрібно авторизувати бек-офісом.'
                                                     when l_process_row.state_id = process_utl.GC_PROCESS_STATE_RUN
                                                      then 'Підтверджено бек-офісом.'
                                                end
                                                );
            exception
                when no_data_found then
                    select max(p.id)
                      into l_process_row.id
                      from process p
                          ,process_type pt
                     where pt.process_code = PROCESS_ON_DEMAND_CLOSE
                       and pt.module_code = PROCESS_TRANCHE_MODULE
                       and pt.id = p.process_type_id
                       and p.object_id = p_object_id
                       and p.state_id = process_utl.GC_PROCESS_STATE_CREATE;
            end;
        end if;

        if l_process_row.id is null then
            p_process_id := process_utl.process_create(
                                  p_proc_type_code    => PROCESS_ON_DEMAND_CLOSE
                                 ,p_proc_type_module  => PROCESS_TRANCHE_MODULE
                                 ,p_process_name      => 'закриття на вимогу >>'
                                 ,p_process_data      => p_data
                                 ,p_process_object_id => null);
        else
            p_process_id  := l_process_row.id;
            l_process_row := process_utl.read_process(p_process_id => l_process_row.id
                                                     ,p_raise_ndf  => true);


            l_on_demand_row := get_on_demand_from_xml(p_data => p_data);

            l_process_type_id := process_utl.get_proc_type_id(
                                                         p_proc_type_code => PROCESS_ON_DEMAND_CLOSE
                                                        ,p_module_code    => PROCESS_TRANCHE_MODULE);

            if l_process_type_id <> l_process_row.process_type_id then
                raise_application_error(-20000, 'Редагування заборонено. Процес {'||p_process_id||'} має тип {'||
                                                 process_utl.get_proc_type_name(
                                                                   p_proc_type_id => l_process_row.process_type_id)
                                                  );
            end if;
            if l_process_row.state_id <> process_utl.GC_PROCESS_STATE_CREATE then
                raise_application_error(-20000, 'Редагування заборонено. Депозит  {' || l_on_demand_row.deal_number || '} в стані {'||
                                        list_utl.get_item_name( p_list_code => process_utl.GC_PROCESS_STATE
                                                               ,p_item_id   => l_process_row.state_id)||'}');
            end if;
            -- после редактирования проверка
            smb_deposit_proc.can_create_close_on_demand(
                                 p_process_data     => p_data
                                ,p_process_type_id  => l_process_type_id
                                ,p_can_create_flag  => l_can_create_flag
                                ,p_explanation      => l_can_create_explanation);

            if l_can_create_flag <> 'Y' then
                raise_application_error(-20000, l_can_create_explanation);
            end if;
            -- запишем то же state_id для истории кто редактировал
            process_utl.set_process_state_id(p_process_id => p_process_id
                                            ,p_value      => l_process_row.state_id
                                            ,p_raise_ndf  => false);
            set_process_data (
                       p_process_id => p_process_id
                      ,p_data       => p_data);
        end if;
        set_process_info(p_process_id  => p_process_id);
    end cor_close_on_demand;

    -- отправить закрытие ДпТ на авторизацию
    procedure close_on_demand_authorization(p_process_id in number)
     is
        l_process_row       process%rowtype;
        l_process_type_id   number;
    begin
        logger.log_info(p_procedure_name => $$plsql_unit||'.close_on_demand_authorization',
                        p_log_message    => 'p_process_id : ' || p_process_id
                       ,p_object_id      => null );

        l_process_row := process_utl.read_process(
                                           p_process_id => p_process_id
                                          ,p_raise_ndf  => true );

        check_deposit_type(p_object_id               => l_process_row.object_id
                          ,p_target_object_type_code => ON_DEMAND_OBJECT_TYPE_CODE
                           );

        l_process_type_id := process_utl.get_proc_type_id(
                                                         p_proc_type_code => PROCESS_ON_DEMAND_CLOSE
                                                        ,p_module_code    => PROCESS_TRANCHE_MODULE);
        if l_process_type_id <> l_process_row.process_type_id then
            raise_application_error(-20000, 'Відправлення на авторизацію заборонено. Процес {'||
                                             p_process_id||'} має тип {'||
                                             process_utl.get_proc_type_name(
                                                               p_proc_type_id => l_process_row.process_type_id)
                                            );
        end if;

        process_utl.process_run(p_process_id  => p_process_id);
        set_process_info(p_process_id  => p_process_id);
    end;


    -- подтверждение / отклонение БО закрытия ДпТ
    procedure close_on_demand_confirmation(p_process_id   in number
                                          ,p_is_confirmed in varchar2 default 'Y'
                                          ,p_comment      in varchar2 default null
                                          ,p_error        out varchar2)
     is
        l_activity_id       number;
        l_process_row       process%rowtype;
        l_comment_text      varchar2(4000);
    begin
        l_process_row := process_utl.read_process(
                                           p_process_id => p_process_id
                                          ,p_raise_ndf  => true );

        check_deposit_type(p_object_id               => l_process_row.object_id
                          ,p_target_object_type_code => ON_DEMAND_OBJECT_TYPE_CODE
                           );
        if l_process_row.state_id <> process_utl.GC_PROCESS_STATE_RUN then
             raise_application_error(-20000, case when p_is_confirmed = 'Y' then 'Підтвердження '
                                                  else 'Відправлення на редагування '
                                             end ||' заборонено. '||
                                             'Закриття вкладу на вимогу  {' || deal_utl.get_deal_number(p_deal_id => l_process_row.object_id) ||
                                             '} в стані {'|| list_utl.get_item_name( p_list_code => process_utl.GC_PROCESS_STATE
                                                                                    ,p_item_id   => l_process_row.state_id)||'}');
        end if;
        if upper(p_is_confirmed) = 'Y' then
            select a.id
              into l_activity_id
              from process p
                  ,activity a
                  ,process_workflow pw
             where p.id = p_process_id
               and pw.process_type_id = p.process_type_id
               and pw.activity_code = ACTIVITY_CONFIRM_CODE
               and a.process_id = p.id
               and a.activity_type_id = pw.id
               and a.state_id <> process_utl.ACT_STATE_REMOVED;

            logger.log_info(p_procedure_name => $$plsql_unit||'.close_on_demand_confirmation => Y',
                            p_log_message    => 'p_process_id  : ' || p_process_id  || chr(10) ||
                                                'l_activity_id : ' || l_activity_id
                            );

            process_utl.activity_run(p_activity_id  => l_activity_id
                                    ,p_silent_mode  => false
                                    );
            -- перечитаем
            l_process_row := process_utl.read_process(p_process_id => p_process_id);
            -- check status process
            if l_process_row.state_id = process_utl.GC_PROCESS_STATE_FAILURE then

                -- достаем коммент и вызываем исключение
                l_comment_text := get_last_error_on_process(p_process_id => p_process_id);
                -- вызываем исключение
                p_error := l_comment_text;
                raise_application_error(-20002, l_comment_text);
            end if;
        else
            logger.log_info(p_procedure_name => $$plsql_unit||'.close_on_demand_confirmation => N',
                            p_log_message    => 'p_process_id : ' || p_process_id || chr(10) ||
                                                'p_comment    : ' || p_comment
                            );

            if trim(p_comment) is null then
                raise_application_error(-20000, 'Вкажіть причину відхилення закриття вкладу на вимогу');
            end if;
            process_utl.process_revert(p_process_id  => p_process_id
                                      ,p_comment    => p_comment);
        end if;
    end;

    function get_on_demand_change_calc_xml(p_process_id  in number)
                        return clob
     is
        l_process_data        clob;
        l_process_row         process%rowtype;
        l_can_save            number;
        l_process_id          number;
    begin
        if p_process_id is null then
            raise_application_error(-20000, 'Не вказано вклад на вимогу');
        end if;
        l_process_row := process_utl.read_process(
                                           p_process_id => p_process_id
                                          ,p_raise_ndf  => true );

        logger.log_info(p_procedure_name => $$plsql_unit||'.get_on_demand_change_calc_xml',
                            p_log_message    => 'process_id  : ' || p_process_id
                           ,p_object_id      => l_process_row.object_id
                            );

        check_deposit_type(p_object_id               => l_process_row.object_id
                          ,p_target_object_type_code => ON_DEMAND_OBJECT_TYPE_CODE
                           );

        begin
            select p.id
              into l_process_id
              from process p
                  ,process_type pt
             where pt.process_code = PROCESS_DOD_CHANGE_CALC_TYPE
               and pt.module_code = PROCESS_TRANCHE_MODULE
               and pt.id = p.process_type_id
               and p.object_id = l_process_row.object_id
               and p.state_id in (process_utl.GC_PROCESS_STATE_RUN, process_utl.GC_PROCESS_STATE_CREATE)
               and rownum = 1;
            l_can_save := 0;
        exception
            when no_data_found then l_can_save := 1;
        end;
        l_process_id   := nvl(l_process_id, p_process_id);
        l_process_data := smb_deposit_utl.get_on_demand_xml_data(
                                   p_process_id => l_process_id);
        l_process_data := update_value_in_xml(p_data => l_process_data
                                             ,p_tag         => 'CAN_SAVE'
                                             ,p_value       => l_can_save
                                             ,p_parent_node => PARENT_NODE_ON_DEMAND);
        if l_can_save = 1 then
            l_process_data := update_value_in_xml(p_data => l_process_data
                                                 ,p_tag         => 'ProcessId'
                                                 ,p_value       => ''
                                                 ,p_parent_node => PARENT_NODE_ON_DEMAND);
        end if;
        return l_process_data;
    end;

    -- смена метода начисления для ДпТ
    procedure change_calculation_type_dod (p_process_id          in number
                                          ,p_calculation_type_id in number
                                          ,p_comment             in varchar2 default null
                                          )
     is
        l_process_row         process%rowtype;
        l_object_row          object%rowtype;
        l_on_demand_row       c_on_demand_from_xml%rowtype;
        l_process_id          number;
        l_calculation_type_id number;
        l_calculation_name    varchar2(500);
        l_main_on_demand_row  c_on_demand_from_xml%rowtype;
    begin
        logger.log_info(p_procedure_name => $$plsql_unit||'.change_calculation_type_dod',
                            p_log_message    => 'p_process_id  : ' || p_process_id
                            );

        if not gl.bDATE between trunc(gl.bDATE, 'month') and trunc(gl.bDATE, 'month') + 9 then
            raise_application_error(-20000, 'Метод нарахування відсотків можливо міняти тільки з 1 по 10 число кожного місяця');
        end if;

        if p_process_id is null then
            raise_application_error(-20000, 'Не вказано вклад на вимогу');
        end if;
        if nvl(p_calculation_type_id, 0) not in (1, 2) then
            raise_application_error(-20000, 'Не вказано метод нарахування відсотків');
        end if;
        if p_comment is null then
            raise_application_error(-20000, 'Не вказано причину зміни методу нарахування відсотків');
        end if;

        -- проверка возможности приметить данный тип расчета
        select min(c.calculation_type_id) keep (dense_rank first order by o.valid_from desc)
          into l_calculation_type_id
          from deal_interest_rate_kind k
              ,deal_interest_option o
              ,deposit_on_demand_calc_type c
         where k.kind_code = ON_DEMAND_CALC_TYPE_KIND_CODE
           and o.rate_kind_id = k.id
           and o.id = c.interest_option_id
           and o.is_active = 1
           and o.valid_from <= gl.bDATE;

        if l_calculation_type_id is not null and
           l_calculation_type_id <> 0 and
           l_calculation_type_id <> p_calculation_type_id then
            select max(x.item_name)
              into l_calculation_name
              from table(smb_deposit_ui.get_calculation_type_list()) x
             where x.item_id = l_calculation_type_id;
            raise_application_error(-20000, 'Метод нарахування повинен бути {'||l_calculation_name ||'}');
        end if;

        l_process_row := process_utl.read_process(
                                           p_process_id => p_process_id
                                          ,p_raise_ndf  => true );

        logger.log_info(p_procedure_name => $$plsql_unit||'.change_calculation_type_dod',
                            p_log_message    => 'object_id  : ' || l_process_row.object_id
                            );
        check_deposit_type(p_object_id               => l_process_row.object_id
                          ,p_target_object_type_code => ON_DEMAND_OBJECT_TYPE_CODE
                           );

        l_main_on_demand_row := read_base_on_demand(p_object_id => l_process_row.object_id);
        if l_main_on_demand_row.calculation_type = p_calculation_type_id then
            raise_application_error(-20000, 'Зміна заборонена. На данний момент вибраний метод є активним.');
        end if;

        l_object_row    := object_utl.read_object(
                                               p_object_id => l_process_row.object_id
                                              ,p_raise_ndf => true);

        l_on_demand_row := get_on_demand_from_xml(l_process_row.id);
        if object_utl.get_object_state_code(p_state_id => l_object_row.state_id) <> 'ACTIVE' then
            raise_application_error(-20000,  'Зміна методу нарахування % заборонено. Вклад на вимогу  {' || l_on_demand_row.deal_number ||
                                             '} в стані {'||
                                             object_utl.get_object_state_name(p_state_id => l_object_row.state_id)||'}');
        end if;

        -- делаем проверку на существование не подтвержденного процесса PROCESS_DOD_CHANGE_CALC_TYPE
        -- если есть выдать ошибку
        begin
            select p.id
              into l_process_id
              from process p
                  ,process_type pt
             where pt.process_code = PROCESS_DOD_CHANGE_CALC_TYPE
               and pt.module_code = PROCESS_TRANCHE_MODULE
               and pt.id = p.process_type_id
               and p.object_id = l_process_row.object_id
               and p.state_id = process_utl.GC_PROCESS_STATE_RUN
               and rownum = 1;
            -- нашли делаем raise, без IF
            raise_application_error(-20000, 'На данний момент вже існує створений процес по зміні методу нарахування і знаходиться на авторизації.');
        -- не нашли все нормально
        exception
           when no_data_found then null;
        end;

        -- ищем отклоненный процесс для PROCESS_DOD_CHANGE_CALC_TYPE
        -- в данном случаем ищем процесс в статусе CREATE
        -- если есть перечитать l_process_row
        l_process_id := null;
        begin
            select p.id
              into l_process_id
              from process p
                  ,process_type pt
             where pt.process_code = PROCESS_DOD_CHANGE_CALC_TYPE
               and pt.module_code = PROCESS_TRANCHE_MODULE
               and pt.id = p.process_type_id
               and p.object_id = l_process_row.object_id
               and p.state_id = process_utl.GC_PROCESS_STATE_CREATE
               and rownum = 1;
            -- нашли
            l_process_row := process_utl.read_process(
                                               p_process_id => l_process_id
                                              ,p_raise_ndf  => true );
        -- не нашли все нормально
        exception
           when no_data_found then null;
        end;
        if l_process_id is null then
            -- не меняем процесс, он существует
            l_process_row.process_data := update_value_in_xml(p_data        => l_process_row.process_data
                                                             ,p_tag         => 'ProcessId'
                                                             ,p_value       => ''
                                                             ,p_parent_node => PARENT_NODE_ON_DEMAND);
        end if;
        l_process_row.process_data := update_value_in_xml(p_data        => l_process_row.process_data
                                                         ,p_tag         => 'ActionDate'
                                                         ,p_value       => to_char(gl.bDATE, 'yyyy-mm-dd')
                                                         ,p_parent_node => PARENT_NODE_ON_DEMAND);

        l_process_row.process_data := update_value_in_xml(p_data        => l_process_row.process_data
                                                         ,p_tag         => 'CalculationType'
                                                         ,p_value       => p_calculation_type_id
                                                         ,p_parent_node => PARENT_NODE_ON_DEMAND);
        l_process_row.process_data := update_value_in_xml(p_data        => l_process_row.process_data
                                                         ,p_tag         => 'Comment'
                                                         ,p_value       => p_comment
                                                         ,p_parent_node => PARENT_NODE_ON_DEMAND);

        -- создаем процесс
        if l_process_id is null then
            l_process_id := process_utl.process_create(
                                      p_proc_type_code    => PROCESS_DOD_CHANGE_CALC_TYPE
                                     ,p_proc_type_module  => PROCESS_TRANCHE_MODULE
                                     ,p_process_name      => 'зміна методу нарахування % >>'
                                     ,p_process_data      => l_process_row.process_data
                                     ,p_process_object_id => null);
            --перечитываем данные по созданному процессу
            l_process_row := process_utl.read_process(
                                               p_process_id => l_process_id
                                              ,p_raise_ndf  => true );

            l_process_row.process_data := update_value_in_xml(p_data        => l_process_row.process_data
                                                             ,p_tag         => 'ProcessId'
                                                             ,p_value       => l_process_id
                                                             ,p_parent_node => PARENT_NODE_ON_DEMAND);
        else
            -- запишем то же state_id для истории кто редактировал
            process_utl.set_process_state_id(p_process_id => l_process_id
                                            ,p_value      => l_process_row.state_id
                                            ,p_raise_ndf  => false);
        end if;

        update process p set
              object_id    = l_on_demand_row.object_id
         where p.id = l_process_id;

        smb_deposit_utl.set_process_data (
                           p_process_id => l_process_id
                          ,p_data       => l_process_row.process_data
                          );

        set_process_info(p_process_id  => l_process_id);
    end;

    procedure change_calc_type_authorization(p_process_id in number)
     is
        l_process_id   number;
        l_process_row  process%rowtype;
    begin
        if p_process_id is null then
            raise_application_error(-20000, 'Не вказано вклад на вимогу');
        end if;
        l_process_row := process_utl.read_process(
                                           p_process_id => p_process_id
                                          ,p_raise_ndf  => true );

        logger.log_info(p_procedure_name => $$plsql_unit||'.change_calc_type_authorization',
                            p_log_message    => 'process_id  : ' || p_process_id
                           ,p_object_id      => l_process_row.object_id
                            );

        check_deposit_type(p_object_id               => l_process_row.object_id
                          ,p_target_object_type_code => ON_DEMAND_OBJECT_TYPE_CODE
                           );
        -- делаем проверку на существование не подтвержденного процесса PROCESS_DOD_CHANGE_CALC_TYPE
        -- если есть выдать ошибку
        begin
            select p.id
              into l_process_id
              from process p
                  ,process_type pt
             where pt.process_code = PROCESS_DOD_CHANGE_CALC_TYPE
               and pt.module_code = PROCESS_TRANCHE_MODULE
               and pt.id = p.process_type_id
               and p.object_id = l_process_row.object_id
               and p.state_id = process_utl.GC_PROCESS_STATE_RUN
               and rownum = 1;
            -- нашли делаем raise, без IF
            raise_application_error(-20000, 'На данний момент вже існує створений процес по зміні методу нарахування і знаходиться на авторизації.');
        -- не нашли все нормально
        exception
           when no_data_found then null;
        end;

        -- ищем процесс для PROCESS_DOD_CHANGE_CALC_TYPE
        -- в статусе CREATE
        -- если есть перечитать l_process_row
        l_process_id := null;
        begin
            select p.id
              into l_process_id
              from process p
                  ,process_type pt
             where pt.process_code = PROCESS_DOD_CHANGE_CALC_TYPE
               and pt.module_code = PROCESS_TRANCHE_MODULE
               and pt.id = p.process_type_id
               and p.object_id = l_process_row.object_id
               and p.state_id = process_utl.GC_PROCESS_STATE_CREATE
               and rownum = 1;
            -- нашли
            l_process_row := process_utl.read_process(
                                               p_process_id => l_process_id
                                              ,p_raise_ndf  => true );
        exception
           when no_data_found then
             raise_application_error(-20000, 'Не знайдено процес для авторизації по зміні методу нарахування.');
        end;
        -- сразу запускам процесс на авторизацию (пока так потом наверное нужно создать отдельную процедуру)
        process_utl.process_run(p_process_id => l_process_id);
        set_process_info(p_process_id  => l_process_id);
    end;

    -- подтверждение / отклонение смены метода начисления для ДпТ
    procedure change_calc_type_confirmation(p_process_id   in number
                                           ,p_is_confirmed in varchar2 default 'Y'
                                           ,p_comment      in varchar2 default null
                                           ,p_error        out varchar2)
     is
        l_activity_id       number;
        l_process_row       process%rowtype;
        l_on_demand_row     c_on_demand_from_xml%rowtype;
        l_deal_row          deal%rowtype;
        l_process_type_id  number;
        l_main_on_demand_row c_on_demand_from_xml%rowtype;
    begin
        l_process_row := process_utl.read_process(
                                           p_process_id => p_process_id
                                          ,p_raise_ndf  => true );

        check_deposit_type(p_object_id               => l_process_row.object_id
                          ,p_target_object_type_code => ON_DEMAND_OBJECT_TYPE_CODE
                           );
        l_process_type_id := process_utl.get_proc_type_id(
                                            p_proc_type_code => PROCESS_DOD_CHANGE_CALC_TYPE
                                           ,p_module_code    => PROCESS_TRANCHE_MODULE);

        if l_process_type_id <> l_process_row.process_type_id then
             raise_application_error(-20000, 'Процес повинен мати тип '||
                                             process_utl.get_proc_type_name (
                                                             p_proc_type_id => l_process_type_id
                                                             ));
        end if;

        if l_process_row.state_id <> process_utl.GC_PROCESS_STATE_RUN then
             raise_application_error(-20000, case when p_is_confirmed = 'Y' then 'Підтвердження '
                                                  else 'Відправлення на редагування '
                                             end ||' заборонено. '||
                                             'Зміни методу нарахування вкладу на вимогу  {' || deal_utl.get_deal_number(p_deal_id => l_process_row.object_id) ||
                                             '} в стані {'|| list_utl.get_item_name( p_list_code => process_utl.GC_PROCESS_STATE
                                                                                    ,p_item_id   => l_process_row.state_id)||'}');
        end if;
        if upper(p_is_confirmed) = 'Y' then
            select a.id
              into l_activity_id
              from process p
                  ,activity a
                  ,process_workflow pw
             where p.id = p_process_id
               and pw.process_type_id = p.process_type_id
               and pw.activity_code = ACTIVITY_CONFIRM_CODE
               and a.process_id = p.id
               and a.activity_type_id = pw.id
               and a.state_id <> process_utl.ACT_STATE_REMOVED;

            logger.log_info(p_procedure_name => $$plsql_unit||'.change_calс_type_confirmation => Y',
                            p_log_message    => 'p_process_id  : ' || p_process_id  || chr(10) ||
                                                'l_activity_id : ' || l_activity_id
                            );
            -- запускаем активити для истории
            process_utl.activity_run(p_activity_id  => l_activity_id
                                    ,p_silent_mode  => false
                                    );
            l_on_demand_row := smb_deposit_utl.get_on_demand_from_xml(l_process_row.id);
            -- после активити создаем движение по изменению метода начисления
            -- возможен вариант создания ДпТ до 10 числа
            -- и изменить метод начисления (допустим 9-го), тогда устанавливаем дату создани ДпТ, а не 1-е число
            l_deal_row := deal_utl.read_deal(p_deal_id => l_process_row.object_id);
            -- меняем тип в атрибутах
            set_calculation_type_on_demand(
                               p_object_id        => l_process_row.object_id
                              ,p_calculation_type => l_on_demand_row.calculation_type
                              ,p_valid_from       => greatest(l_deal_row.start_date, trunc(gl.bDATE, 'month')));
            -- запишем текущее значение в родительский процесс

            l_main_on_demand_row := read_base_on_demand(p_object_id => l_process_row.object_id);
            -- берем родительский процесс
            l_process_row := process_utl.read_process(
                                               p_process_id => l_main_on_demand_row.process_id
                                              ,p_raise_ndf  => true );
            -- предыдущее значение добавим (????)
            l_process_row.process_data := update_value_in_xml(
                                                          p_data        => l_process_row.process_data
                                                         ,p_tag         => 'OldCalculationType'
                                                         ,p_value       => l_main_on_demand_row.calculation_type
                                                         ,p_parent_node => PARENT_NODE_ON_DEMAND);

            l_process_row.process_data := update_value_in_xml(
                                                          p_data        => l_process_row.process_data
                                                         ,p_tag         => 'CalculationType'
                                                         ,p_value       => l_on_demand_row.calculation_type
                                                         ,p_parent_node => PARENT_NODE_ON_DEMAND);
            update smb_deposit set
                   calculation_type = l_on_demand_row.calculation_type
             where id = l_process_row.object_id;
            smb_deposit_utl.set_process_data (
                           p_process_id => l_main_on_demand_row.process_id
                          ,p_data       => l_process_row.process_data
                          );
        else
            logger.log_info(p_procedure_name => $$plsql_unit||'.change_calс_type_confirmation => N',
                            p_log_message    => 'p_process_id : ' || p_process_id || chr(10) ||
                                                'p_comment    : ' || p_comment
                            );

            if trim(p_comment) is null then
                raise_application_error(-20000, 'Вкажіть причину відхилення зміни методу нарахування вкладу на вимогу');
            end if;
            process_utl.process_revert(p_process_id  => p_process_id
                                      ,p_comment    => p_comment);
        end if;
    end;

    function get_prolongation_from_xml(p_data in clob)
       return c_deposit_prolongation%rowtype
     is
        l_prolongation_row c_deposit_prolongation%rowtype;
    begin
        for i in c_deposit_prolongation(p_data => p_data) loop
          l_prolongation_row := i;
          exit;
        end loop;
        return l_prolongation_row;
    end;

    function get_prolongation_from_xml(p_process_id  in number)
       return c_deposit_prolongation%rowtype
     is
        l_process_row      process%rowtype;
        l_prolongation_row c_deposit_prolongation%rowtype;
    begin
        l_process_row  := process_utl.read_process(p_process_id => p_process_id
                                                  ,p_lock       => false
                                                  ,p_raise_ndf  => true);
        l_prolongation_row := get_prolongation_from_xml(p_data => l_process_row.process_data);
        return l_prolongation_row;
    end;

    -- кол-во оставшихся пролонгации
    --   вызывается перед автоматическим закрытием
    function get_remaining_prolongation (p_object_id in number)
              return number
     is
        l_prolong_proc_type_id number;
        l_tranche_row          c_tranche_from_xml%rowtype;
        l_qty                  number;
    begin
        l_tranche_row := read_base_tranche(p_object_id => p_object_id);
        if nvl(l_tranche_row.is_prolongation, 0) <> 1 then
            return 0;
        end if;
        l_prolong_proc_type_id := process_utl.get_proc_type_id(
                                            p_proc_type_code => PROCESS_TRANCHE_PROLONGATION
                                           ,p_module_code    => PROCESS_TRANCHE_MODULE);
        -- кол-во пролонгаций
        select count(*)
          into l_qty
          from process p
         where p.process_type_id = l_prolong_proc_type_id
           and p.object_id = p_object_id;

        return nvl(l_tranche_row.number_prolongation - l_qty, 0);
    end;

    -- пролонгация депозита - только транши
    procedure set_deposit_prolongation(p_object_id in number)
     is
        l_tranche_row                c_tranche_from_xml%rowtype;
        l_object_row                 object%rowtype;
        l_prolong_proc_type_id       number;
        l_qty                        number; -- кол-во пролонгаций
        l_process_row                process%rowtype;
        l_data                       clob;
        l_new_expiry_date            date;
        l_prev_date                  date;
        l_interest_rate              number;
        l_interest_rate_prolongation number;
        l_main_process_data          clob;
        l_ir_process_data            clob;
    begin
        check_deposit_type(p_object_id               => p_object_id
                          ,p_target_object_type_code => TRANCHE_OBJECT_TYPE_CODE
                           );
        l_tranche_row := read_base_tranche(p_object_id => p_object_id);

        if nvl(l_tranche_row.is_prolongation, 0) <> 1 then
            return;
        end if;

        l_object_row  := object_utl.read_object(
                                               p_object_id => p_object_id
                                              ,p_raise_ndf => true);

        if object_utl.get_object_state_code(p_state_id => l_object_row.state_id) not in ('ACTIVE', 'BLOCKED') then
            raise_application_error(-20000,  'Пролонгація заборонено. Транш  {' || l_tranche_row.deal_number ||
                                             '} в стані {'||
                                             object_utl.get_object_state_name(p_state_id => l_object_row.state_id)||'}');
        end if;
        l_prolong_proc_type_id := process_utl.get_proc_type_id(
                                            p_proc_type_code => PROCESS_TRANCHE_PROLONGATION
                                           ,p_module_code    => PROCESS_TRANCHE_MODULE);
        -- кол-во обработанных пролонгаций
        select count(*)
          into l_qty
          from process p
         where p.process_type_id = l_prolong_proc_type_id
           and p.object_id = p_object_id;

        logger.log_info(p_procedure_name => $$plsql_unit||'.deposit_prolongation'
                       ,p_log_message    => 'number_prolongation    : ' || l_tranche_row.number_prolongation || chr(10) ||
                                            'processed prolongation : ' || l_qty
                       ,p_object_id      => p_object_id
                       ,p_auxiliary_info => null
                            );
        -- если все пролонгации выполнены, выходим "тихо"
        -- этот транш нужно закрывать, если он не заблокирован
        if l_qty >= l_tranche_row.number_prolongation then
            -- если заблокирован, установить новую ставку
            return;
        end if;

        -- даты в теле транша не меняем
        l_process_row       := process_utl.read_process(p_process_id => l_tranche_row.process_id);
        -- новая дата окончания
        l_new_expiry_date   := l_tranche_row.expiry_date + (l_qty + 1) * (l_tranche_row.number_tranche_days);
        l_main_process_data := l_process_row.process_data;
        select nvl(d.expiry_date_prolongation, l_tranche_row.expiry_date)
          into l_prev_date
          from smb_deposit d
         where d.id = p_object_id;

        -- новая ставка
        --  на дату окончания последней пролонгации
        l_ir_process_data := get_interest_rate(p_data => l_main_process_data
                                              ,p_date => l_prev_date);

        select Interest_Rate, Interest_Rate_Prolongation
              into l_interest_rate, l_interest_rate_prolongation
            from xmltable ('/SMBDepositTrancheInterestRate' passing xmltype(l_ir_process_data) columns
                                Interest_Rate                 number         path 'InterestRate'
                               ,Interest_Rate_Prolongation    number         path 'InterestRateProlongation');

        -- получаем пустой xml
        l_data := xml_deposit_prolongation;
        l_data := update_value_in_xml(
                                       p_data        => l_data
                                      ,p_node_list   => t_dictionary (
                                                          t_dictionary_item(
                                                              key   => 'StartDate'
                                                             ,value => to_char(l_prev_date, 'yyyy-mm-dd'))
                                                          -- записываем дату окончания действия пролонгации, она же дата окончания действия транша
                                                         ,t_dictionary_item(
                                                              key   => 'ExpiryDate'
                                                             ,value => to_char(l_new_expiry_date, 'yyyy-mm-dd'))
                                                         ,t_dictionary_item(
                                                              key   => 'ActionDate'
                                                             ,value => to_char(gl.bdate , 'yyyy-mm-dd'))
                                                         ,t_dictionary_item(
                                                              key   => 'InterestRateProlongation'
                                                             ,value => l_interest_rate_prolongation)
                                                         ,t_dictionary_item(
                                                              key   => 'ObjectId'
                                                             ,value => p_object_id) )
                                      ,p_parent_node => PARENT_NODE_PROLONGATION);

        --  создаем процесс для пролонгации (история)
        l_process_row.id := process_utl.process_create(
                                  p_proc_type_code    => PROCESS_TRANCHE_PROLONGATION
                                 ,p_proc_type_module  => PROCESS_TRANCHE_MODULE
                                 ,p_process_name      => 'Пролонгация >>'
                                 ,p_process_data      => l_data
                                 ,p_process_object_id => null);

        -- перечитаем
        l_process_row := process_utl.read_process(p_process_id => l_process_row.id);

        -- запишем ProcessId
        l_process_row.process_data := update_value_in_xml(
                                       p_data        => l_process_row.process_data
                                      ,p_tag         => 'ProcessId'
                                      ,p_value       => l_process_row.id
                                      ,p_parent_node => PARENT_NODE_PROLONGATION);

        update process p set
               p.object_id = p_object_id
         where p.id = l_process_row.id;

        update smb_deposit d set
               d.current_prolongation_number = l_qty + 1
              ,d.expiry_date_prolongation = l_new_expiry_date
         where d.id = p_object_id;

        set_process_data (
                           p_process_id => l_process_row.id
                          ,p_data       => l_process_row.process_data
                          );
        -- пустышка, для выполнения полного цикла
        process_utl.process_run(p_process_id => l_process_row.id);
        -- установить новые параметры по счетам депозита с учетом пролонгации
        -- пока убрал
        -- нужно ли менять параметры, по сути тело депозита не меняли (???)
        set_parameter_deposit(p_object_id => p_object_id);

        -- изменить % ставку, если не индивидуальная
        if nvl(l_tranche_row.is_individual_rate, 0) = 0 then
            -- поиск бонусной ставки за пролонгацию
            -- если это первая берем из тела депозита
            -- ищем предпоследнюю пролонгацию
            select nvl(max(interest_rate_prolongation) keep (dense_rank first order by x.start_date desc)
                      -- если это первая пролонгация
                      ,case when l_qty = 0 then l_tranche_row.interest_rate_prolongation end)
                   into l_interest_rate_prolongation
              from process p
                  ,xmltable ('/SMBDepositProlongation' passing xmltype(p.process_data) columns
                                    start_date                 date    path 'StartDate'
                                   ,interest_rate_prolongation number  path 'InterestRateProlongation') x
             where p.process_type_id = l_prolong_proc_type_id
               and p.object_id = p_object_id
               and l_qty > 0
               and x.start_date < l_prev_date;

            l_interest_rate := l_interest_rate +
                                   nvl(
                                    case
                                       -- было более 1 пролонгации с типом "для першої", бонус не применяем
                                       when l_qty >= 1 and l_tranche_row.apply_bonus_prolongation = APPLY_ONLY_FIRST_PROLONG_ID
                                         then 0
                                         -- во всех остальных случаях бонус применяем
                                       else l_interest_rate_prolongation
                                    end, 0);
            -- устанавливаем с "завтра"
            set_interest_rate_tranche(
                                 p_object_id     => p_object_id
                                ,p_interest_rate => nvl(l_interest_rate, 0)
                                ,p_valid_from    => l_prev_date
                                ,p_comment       => 'process prolongation : '||l_process_row.id);
            -- запишем новую % ставку
            set_interest_rate_log(p_object_id    => p_object_id
                                 ,p_process_data => l_ir_process_data
                                 ,p_date         => gl.bdate);

        end if;
    end;

    -- удалить транш (установить статус object в DELETED)
    procedure delete_tranche(p_process_id in number
                            ,p_comment    in varchar2)
     is
        l_process_row     process%rowtype;
        l_tranche_row     c_tranche_from_xml%rowtype;
        l_object_row      object%rowtype;
        l_process_type_id number;
    begin
        if p_comment is null then
            raise_application_error(-20000, 'Вкажіть причину видалення траншу.');
        end if;
        l_process_row := process_utl.read_process(p_process_id => p_process_id);
        check_deposit_type(p_object_id               => l_process_row.object_id
                          ,p_target_object_type_code => TRANCHE_OBJECT_TYPE_CODE
                           );
        l_tranche_row := read_base_tranche(p_object_id => l_process_row.object_id);
        if l_process_row.state_id <> process_utl.GC_PROCESS_STATE_CREATE then
            raise_application_error(-20000, 'Видалення заборонено. Транш  {' || l_tranche_row.deal_number || '} в стані {'||
                                      list_utl.get_item_name( p_list_code => process_utl.GC_PROCESS_STATE
                                                               ,p_item_id   => l_process_row.state_id)||'}');
        end if;
        l_process_type_id := process_utl.get_proc_type_id(
                                                 p_proc_type_code => PROCESS_TRANCHE_CREATE
                                                ,p_module_code    => PROCESS_TRANCHE_MODULE);
        if l_process_type_id <> l_process_row.process_type_id then
                raise_application_error(-20000, 'Видалення заборонено. Процес {'||p_process_id||'} має тип {'||
                                                 process_utl.get_proc_type_name(
                                                                   p_proc_type_id => l_process_row.process_type_id) );
        end if;
        -- тот ли процесс нам передали
        if l_tranche_row.process_id <> p_process_id then
            raise_application_error(-20000, 'Процес {' || p_process_id || '} не є процесом депозитного траншу');

        end if;
        l_object_row := object_utl.read_object(p_object_id => l_process_row.object_id);
        if object_utl.get_object_state_code(p_state_id => l_object_row.state_id) <> 'CREATED' then
            raise_application_error(-20000,  'Видалення заборонено. Транш  {' || l_tranche_row.deal_number ||
                                             '} в стані {'||
                                             object_utl.get_object_state_name(p_state_id => l_object_row.state_id)||'}');
        end if;
       -- устанавливаем object state в DELETED
        object_utl.set_object_state(
                          p_object_id  => l_process_row.object_id
                         ,p_state_code => 'DELETED');
        -- устанавливаем process state в DISCARD
        process_utl.process_remove(p_process_id => p_process_id);
        -- добавить причину удаления
        set_process_info(p_process_id  => p_process_id
                        ,p_info        => p_comment);
    end;

    -- удалить пополнение
    procedure delete_replenishment(p_process_id in number
                                  ,p_comment    in varchar2)
     is
        l_process_row       process%rowtype;
        l_tranche_row       c_tranche_from_xml%rowtype;
        l_main_tranche_row  c_tranche_from_xml%rowtype;
        l_object_row        object%rowtype;
        l_process_type_id   number;
    begin
        if p_comment is null then
            raise_application_error(-20000, 'Вкажіть причину видалення поповнення.');
        end if;
        l_process_row := process_utl.read_process(p_process_id => p_process_id);
        check_deposit_type(p_object_id               => l_process_row.object_id
                          ,p_target_object_type_code => TRANCHE_OBJECT_TYPE_CODE
                           );

        l_tranche_row := get_tranche_from_xml(p_data => l_process_row.process_data);
        if l_process_row.state_id <> process_utl.GC_PROCESS_STATE_CREATE then
            raise_application_error(-20000, 'Видалення поповнення заборонено. Поповнення траншу  {' || l_tranche_row.deal_number || '} в стані {'||
                                      list_utl.get_item_name( p_list_code => process_utl.GC_PROCESS_STATE
                                                               ,p_item_id   => l_process_row.state_id)||'}');
        end if;
        l_process_type_id := process_utl.get_proc_type_id(
                                                 p_proc_type_code => PROCESS_REPLENISH_TRANCHE
                                                ,p_module_code    => PROCESS_TRANCHE_MODULE);
        if l_process_type_id <> l_process_row.process_type_id then
                raise_application_error(-20000, 'Видалення поповнення заборонено. Процес {'||p_process_id||'} має тип {'||
                                                 process_utl.get_proc_type_name(
                                                                   p_proc_type_id => l_process_row.process_type_id) );
        end if;
        -- тот ли процесс нам передали
        if l_tranche_row.process_id <> p_process_id then
            raise_application_error(-20000, 'Процес {' || p_process_id || '} не є процесом поповнення траншу');

        end if;
        l_object_row        := object_utl.read_object(p_object_id => l_process_row.object_id);
        l_main_tranche_row  := read_base_tranche(p_object_id => l_process_row.object_id);
        if object_utl.get_object_state_code(p_state_id => l_object_row.state_id) not in ('ACTIVE', 'BLOCKED') then
            raise_application_error(-20000,  'Видалення поповнення заборонено. Транш  {' || l_main_tranche_row.deal_number ||
                                             '} в стані {'||
                                             object_utl.get_object_state_name(p_state_id => l_object_row.state_id)||'}');
        end if;
        -- устанавливаем process state в DISCARD
        process_utl.process_remove(p_process_id => p_process_id);
        -- добавить причину удаления
        set_process_info(p_process_id  => p_process_id
                        ,p_info        => p_comment);
    end;

    -- удалить депозит по требованию (установить статус object в DELETED)
    procedure delete_on_demand(p_process_id in number
                              ,p_comment    in varchar2)
     is
        l_process_row     process%rowtype;
        l_on_demand_row   c_on_demand_from_xml%rowtype;
        l_object_row      object%rowtype;
    begin
        if p_comment is null then
            raise_application_error(-20000, 'Вкажіть причину видалення вкладу на вимогу.');
        end if;
        l_process_row := process_utl.read_process(p_process_id => p_process_id);
        check_deposit_type(p_object_id               => l_process_row.object_id
                          ,p_target_object_type_code => ON_DEMAND_OBJECT_TYPE_CODE
                           );
        l_on_demand_row := read_base_on_demand(p_object_id => l_process_row.object_id);
        if l_process_row.state_id <> process_utl.GC_PROCESS_STATE_CREATE then
            raise_application_error(-20000, 'Видалення заборонено. Депозит на вимогу  {' || l_on_demand_row.deal_number || '} в стані {'||
                                      list_utl.get_item_name( p_list_code => process_utl.GC_PROCESS_STATE
                                                               ,p_item_id   => l_process_row.state_id)||'}');
        end if;
        -- тот ли процесс нам передали
        if l_on_demand_row.process_id <> p_process_id then
            raise_application_error(-20000, 'Процес {' || p_process_id || '} не є процесом депозиту на вимогу');

        end if;
        l_object_row := object_utl.read_object(p_object_id => l_process_row.object_id);
        if object_utl.get_object_state_code(p_state_id => l_object_row.state_id) <> 'CREATED' then
            raise_application_error(-20000,  'Видалення заборонено. Депозиту на вимогу  {' || l_on_demand_row.deal_number ||
                                             '} в стані {'||
                                             object_utl.get_object_state_name(p_state_id => l_object_row.state_id)||'}');
        end if;
       -- устанавливаем object state в DELETED
        object_utl.set_object_state(
                          p_object_id  => l_process_row.object_id
                         ,p_state_code => 'DELETED');
        -- устанавливаем process state в DISCARD
        process_utl.process_remove(p_process_id => p_process_id);
        -- добавить причину удаления
        set_process_info(p_process_id  => p_process_id
                        ,p_info        => p_comment);
    end;

    -- обновление в одном месте. TODO добавить лог изменений
    procedure set_process_data (
                           p_process_id in number
                          ,p_data       in clob
                          )
     is
        l_process_row process%rowtype;
        l_tmp_        number;
        l_user_id     number;
        l_oper_type        varchar2(1); -- 'I' insert 'U' - update
    begin
        l_process_row := process_utl.read_process(p_process_id => p_process_id);
        -- запишем в любом случае
        process_utl.set_process_data(
                                     p_process_id  => p_process_id
                                    ,p_value       => p_data
                                    ,p_raise_ndf   => false);
        --процесс еще в создании (будут заполнены счета и обновится object_id)
        if l_process_row.object_id is null then
            return;
        end if;

        --  ищем разницу между новым и старым xml через minus
        select count(*)
          into l_tmp_
          from(
              select dbms_lob.substr(p_data, 4000, 1)
                from dual
              minus
              select dbms_lob.substr(l_process_row.process_data, 4000, 1)
                from dual);
        -- данные менялись - запишем
        if l_tmp_ > 0 then
            select count(*)
              into l_tmp_
              from smb_deposit_log l
             where l.object_id  = l_process_row.object_id
               and l.process_id = p_process_id;

            l_oper_type := case when l_tmp_ = 0 then 'I' else 'U' end;
            l_tmp_      := smb_deposit_log_seq.nextval;
            l_user_id   := user_id();
            insert into smb_deposit_log(
                        id
                       ,object_id
                       ,process_id
                       ,operation_type
                       ,process_data
                       ,local_bank_date
                       ,global_bank_date
                       ,user_id)
                values (l_tmp_
                       ,l_process_row.object_id
                       ,p_process_id
                       ,l_oper_type
                       ,p_data
                       ,coalesce(gl.bd, glb_bankdate)
                       ,glb_bankdate
                       ,l_user_id);
        end if;
    end;

    -- заполняет параметры счетов депозитного и начисленных %% по id депозита
    -- p_object_id - депозит
    procedure set_parameter_deposit(p_object_id in number)
     is
        -- COBUDPUMMSB-156
        l_nbs_dpt                    varchar2(10);
        l_nbs_int                    varchar2(10);
        l_dpt_account_id             number;
        l_int_account_id             number;
        l_start_date                 date;
        l_end_date                   date;
        l_object_row                 object%rowtype;
        l_main_account_type_id       number;
        l_prolongation_proc_type_id  number;
        l_object_active_state_id     number;
        l_object_blocked_state_id    number;
        l_object_type_on_demand      number;

          procedure set_parameter(p_nbs_dpt        in varchar2
                                 ,p_nbs_int        in varchar2
                                 ,p_dpt_account_id in number
                                 ,p_int_account_id in number
                                 ,p_start_date     in date
                                 ,p_end_date       in date )
           is
              l_r011        varchar2(1);
              l_r013        varchar2(1);
              l_s180        varchar2(1);
              l_s181        varchar2(1);
          begin
              -- для ДпТ ставим 1
              l_s180 := case when p_end_date is null then '1'
                            else f_srok(datb_ => p_start_date, date_ => p_end_date, type_ => 2)
                        end;
              -- хардкод - письмо от Вікторія Семенова
              l_r011 := case when p_nbs_int is null
                          then
                            case p_nbs_dpt
                               when '2610' then '1'
                               when '2651' then '4'
                               when '2600' then '3'
                               when '2650' then '3'
                            end
                          else
                            case
                               when p_nbs_dpt = '2610' and p_nbs_int = '2618' then '1'
                               when p_nbs_dpt = '2651' and p_nbs_int = '2658' then '4'
                               when p_nbs_dpt = '2600' and p_nbs_int = '2608' then '3'
                               when p_nbs_dpt = '2650' and p_nbs_int = '2658' then '3'
                            end
                        end;
              -- письмо от Семеновой Виктории Mon 4/8/2019 5:09 PM          
              -- подтверждаем для депозитов ММСБ на счетах 2600 и 2650 параметр R013=9  и R011=3          
              l_r013 := case when p_nbs_int is null and p_nbs_dpt in ('2650', '2600') then '9' end;
              l_s181 := case when p_end_date is null then '1' 
                             else case when p_end_date - p_start_date + 1 <= 365 then '1' else '2' end 
                        end;
              -- так как процедура вызывается 2-а раза для депозитного счета и счета начисленных %%,
              -- то использую nvl(p_int_account_id, p_dpt_account_id) чтобы 2-а раза не писать одно и то же (жесть)
              --- Для ДпТ устанавливаем s240 = 'I'
              if l_object_type_on_demand = l_object_row.object_type_id then
                 accreg.setAccountSParam(nvl(p_int_account_id, p_dpt_account_id), 'S240', 'I');
              end if;
              accreg.setAccountSParam(nvl(p_int_account_id, p_dpt_account_id), 'R011', l_r011);
              accreg.setAccountSParam(nvl(p_int_account_id, p_dpt_account_id), 'R013', l_r013);
              accreg.setAccountSParam(nvl(p_int_account_id, p_dpt_account_id), 'S180', l_s180);
              accreg.setAccountSParam(nvl(p_int_account_id, p_dpt_account_id), 'S181', l_s181);
          end;

    begin
        logger.log_info(p_procedure_name => $$plsql_unit||'.set_parameter_deposit'
                       ,p_log_message    => null
                       ,p_object_id      => p_object_id );

        l_object_row                := object_utl.read_object(p_object_id => p_object_id);
        l_main_account_type_id      := attribute_utl.get_attribute_id('DEPOSIT_PRIMARY_ACCOUNT');
        l_prolongation_proc_type_id := process_utl.get_proc_type_id(
                                                        p_proc_type_code => smb_deposit_utl.PROCESS_TRANCHE_PROLONGATION
                                                       ,p_module_code    => smb_deposit_utl.PROCESS_TRANCHE_MODULE);
        l_object_active_state_id    := object_utl.get_object_state_row(
                                                        p_object_type_id    => l_object_row.object_type_id
                                                       ,p_object_state_code => 'ACTIVE').id;
        l_object_blocked_state_id   := object_utl.get_object_state_row(
                                                        p_object_type_id    => l_object_row.object_type_id
                                                       ,p_object_state_code => 'BLOCKED').id;
        l_object_type_on_demand := get_object_type_on_demand;
        -- по ID депозита находим счет, по этому счету находим все депозиты + пролонгации по ним
        --  берем максимальную разность периода действия для S180
        -- для ДпТ у нас нет даты окончания, какое значение для S180 (???)
        with obj_ as(
             select o.id
                   ,da.account_id
               from (
                    select x.account_id
                      from deal_account x
                     where x.deal_id = p_object_id
                       and x.account_type_id = l_main_account_type_id
                       ) x
                   ,deal_account da
                   ,smb_deposit d
                   ,object o
              where x.account_id = da.account_id
                and da.account_type_id = l_main_account_type_id
                and da.deal_id = d.id
                and d.id = o.id
                and o.state_id in (l_object_active_state_id, l_object_blocked_state_id))
           -- берем пролонгации
          ,prolong_ as(
             select o.id
                   ,o.account_id
                   ,x.start_date
                   ,x.expiry_date
               from obj_ o
                   ,process p
                   ,xmlTable('/SMBDepositProlongation' passing xmltype(p.process_data) columns
                        number_tranche_days        number path 'NumberTrancheDays'
                       ,start_date                 date   path 'StartDate'
                       ,expiry_date                date   path 'ExpiryDate')(+) x
              where 1 = 1
                and o.id = p.object_id
                and p.process_type_id = l_prolongation_proc_type_id
                    )
        select a.nbs nbs_dpt
              ,b.nbs nbs_int
              ,a.acc dpt_account_id
              ,b.acc int_account_id
              ,max(x.start_date)  keep (dense_rank first order by x.expiry_date - x.start_date desc, x.start_date desc) start_date
              ,max(x.expiry_date) keep (dense_rank first order by x.expiry_date - x.start_date desc, x.start_date desc) expiry_date
          into l_nbs_dpt, l_nbs_int, l_dpt_account_id, l_int_account_id, l_start_date, l_end_date
          from(
                select x.*, 1 is_
                  from prolong_ x
                union all
                select o.id, o.account_id, d.start_date, d.expiry_date, 0 is_
                  from obj_ o
                      ,deal d
                 where o.id = d.id
                   and not exists (select null from prolong_ p where p.id = o.id)
                   )
                 x
                ,accounts a
                ,int_accn i
                ,accounts b
         where x.account_id = a.acc
           and a.acc = i.acc(+)
           and i.id(+) = 1
           and i.acra = b.acc(+)
        group by a.nbs
                ,b.nbs
                ,a.acc
                ,b.acc;

        logger.log_info(p_procedure_name => $$plsql_unit||'.set_parameter_deposit --'
                       ,p_log_message    => 'nbs_dpt : '|| l_nbs_dpt || chr(10) ||
                                            'nbs_int : '|| l_nbs_int
                       ,p_object_id      => p_object_id );

        --для депозитного счета
        set_parameter(p_nbs_dpt        => l_nbs_dpt
                     ,p_nbs_int        => null
                     ,p_dpt_account_id => l_dpt_account_id
                     ,p_int_account_id => null
                     ,p_start_date     => l_start_date
                     ,p_end_date       => l_end_date);

        --для счета %%
        set_parameter(p_nbs_dpt        => l_nbs_dpt
                     ,p_nbs_int        => l_nbs_int
                     ,p_dpt_account_id => l_dpt_account_id
                     ,p_int_account_id => l_int_account_id
                     ,p_start_date     => l_start_date
                     ,p_end_date       => l_end_date);
    exception
         when no_data_found then null;
    end set_parameter_deposit;

    -- лог ошибок
    procedure registration_calc_errors(p_object_id   in number
                                      ,p_action_type in varchar2
                                      ,p_error       in varchar2)
     is
        pragma autonomous_transaction;
        l_process_data       clob;
        l_process_id         number;
    begin
        if p_object_id is null then return; end if;
        l_process_data := '<SMBDepositError>'||
                          '<ActionDate>'||to_char(sysdate, 'yyyy-mm-dd"T"hh24:mi:ss')||'</ActionDate>'||
                          '<ErrorType>'||p_action_type||'</ErrorType>'||
                          '<Branch>'||bc.current_branch_code||'</Branch>'||
                          '<data>'||p_error||'</data>'||
                          '</SMBDepositError>';
        l_process_id   := process_utl.process_create(
                                  p_proc_type_code    => PROCESS_REGISTRATION_ERROR
                                 ,p_proc_type_module  => PROCESS_TRANCHE_MODULE
                                 ,p_process_name      => '[ERROR]'
                                 ,p_process_data      => l_process_data
                                 ,p_process_object_id => p_object_id);
        commit;
    end;

    -- куди відноситься клієнт
    -- до небанківських фінансових установ або суб'єктів господарювання
    -- для визначеття балансового рахунку і об22
    -- на данный момент поиск через NBS (может чсерез customer.sed (???))
    function get_customer_group (p_customer_id in number
                                ,p_is_tranche  in number default 1)
             return number
     is
        l_deal_group_id                number;
        l_nonbanking_fin_customer_flag number;
    begin
        select count(*)
        into   l_nonbanking_fin_customer_flag
        from   accounts a
        where  a.rnk = p_customer_id and
               a.nbs in ('2651', '2650') and
               a.dazs is null and
               rownum = 1;

        l_deal_group_id := list_utl.get_item_id('DEAL_BALANCE_GROUP',
                                                case when l_nonbanking_fin_customer_flag = 1 then
                                                      case when p_is_tranche = 1
                                                           then 'DEPOSIT_FOR_NONBANK_FIN_INST'
                                                           else 'CURR_ACC_FOR_NONBANK_FIN_INST'
                                                      end
                                                     else
                                                      case when p_is_tranche = 1
                                                            then 'DEPOSIT_FOR_COMPANIES'
                                                            else 'CURRENT_ACCOUNTS_FOR_COMPANIES'
                                                      end
                                                 end);
        return l_deal_group_id;
    end;

    -- получить счет для расходных/доходных счетов банка (%, штраф)
    function get_expense_account(p_object_id         in number
                                ,p_account_type_code in varchar2)
             return number
     is
        l_currency_id           number;
        l_product_id            number;
        l_group_id              number;
        l_branch                varchar2(100);
        l_baseval$              number := gl.baseval;
        l_customer_id           number;
        l_object_type_id        number;
        l_mfo                   varchar2(30);
        l_balance_account       varchar2(30);
        l_ob22_code             varchar2(30);
        l_account_id            number;
    begin
        select case when dpt.currency_id = l_baseval$ then dpt.currency_id end
              ,d.product_id
              ,d.branch_id || case when length(d.branch_id) = 8 then '000000/' end
              ,d.customer_id
              ,o.object_type_id
          into l_currency_id, l_product_id, l_branch, l_customer_id, l_object_type_id
          from smb_deposit dpt
              ,deal d
              ,object o
         where dpt.id = p_object_id
           and dpt.id = d.id
           and dpt.id = o.id;

        l_group_id := attribute_utl.get_number_value(p_object_id, 'DEAL_BALANCE_GROUP');
        if l_group_id is null then
           l_group_id :=  get_customer_group (p_customer_id => l_customer_id
                                             ,p_is_tranche  => case when l_object_type_id = get_object_type_tranche then 1 else 0 end);
        end if;
        l_mfo  := bc.extract_mfo(l_branch);

        select max(balance_account)
                 keep (dense_rank first order by s.deal_group_id nulls first
                                                ,s.currency_id nulls first
                                                ,s.product_id nulls first)
              ,max(ob22_code)
                 keep (dense_rank first order by s.deal_group_id nulls first
                                                ,s.currency_id nulls first
                                                ,s.product_id nulls first)
          into l_balance_account, l_ob22_code
          from attribute_kind k
              ,deal_balance_account_settings s
         where 1 = 1
           and k.attribute_code = p_account_type_code
           and k.id = s.account_type_id
           and (s.currency_id = l_currency_id or l_currency_id is null)
           and (s.deal_group_id = l_group_id or l_group_id is null)
           and (s.product_id = l_product_id or l_product_id is null);

        select max(a.acc) keep (dense_rank first order by length(a.branch) desc, a.daos desc)
          into l_account_id
          from accounts a
         where a.ob22 = l_ob22_code
           and a.nbs = l_balance_account
           and a.dazs is null
           and l_branch like a.branch ||'%'
           and a.kf = l_mfo;

        return l_account_id;
    exception
         when no_data_found
            then return null;
    end get_expense_account;

    -- заявление на размещение транша
    function get_tranche_data_for_print(p_deposit_id in number)
             return tt_smb_data_for_print pipelined
     is
        l_process_type_id               number;
        l_amount_settings_kind_type_id  number;
        l_cursor                        sys_refcursor;
        l_smb_info                      tt_smb_data_for_print;
    begin
        l_process_type_id := process_utl.get_proc_type_id(
                                            p_proc_type_code => PROCESS_TRANCHE_CREATE
                                           ,p_module_code    => PROCESS_TRANCHE_MODULE);
        select max(id)
          into l_amount_settings_kind_type_id
          from deal_interest_rate_kind irk
         where irk.kind_code = AMOUNT_SETTING_KIND_CODE;
        open l_cursor for
            with r as (
                    select o.valid_from
                          ,o.valid_through
                          ,s.*
                      from deal_interest_option o
                          ,deposit_amount_setting s
                     where o.rate_kind_id = l_amount_settings_kind_type_id
                       and o.id = s.interest_option_id
                       and o.is_active = 1)
            select x.deal_number
                  ,x.create_date
                  ,x.contract_number
                  ,x.contract_date
                  ,x.nmk
                  ,x.deposit_account
                  ,x.currency_name
                  ,x.debit_account
                  ,x.amount_tranche / x.denom amount_tranche
                  ,f_sumpr(nSum_ => x.amount_tranche
                          ,nCcyCode_ => x.currency_id
                          ,strGender_ => x.gender) amount_tranche_in_words
                  ,x.interest_rate
                  ,x.start_date
                  ,x.expiry_date
                  ,x.return_account
                  ,x.payment_account
                  ,x.frequency_payment
                  ,x.is_prolongation
                  ,x.number_prolongation
                  ,x.is_replenishment_tranche
                  ,x.min_amount_tranche
                  ,case when x.min_amount_tranche is not null then
                       f_sumpr(nSum_ => x.min_amount_tranche * x.denom
                              ,nCcyCode_ => x.currency_id
                              ,strGender_ => x.gender)
                   end min_amount_tranche_in_words
                  ,x.min_amount_replenishment
                  ,case when x.min_amount_replenishment is not null then
                       f_sumpr(nSum_ => x.min_amount_replenishment * x.denom
                              ,nCcyCode_ => x.currency_id
                              ,strGender_ => x.gender)
                   end min_amount_replenish_in_words
                  ,x.max_amount_replenishment
                  ,case when x.max_amount_replenishment is not null then
                       f_sumpr(nSum_ => x.max_amount_replenishment * x.denom
                              ,nCcyCode_ => x.currency_id
                              ,strGender_ => x.gender)
                   end max_amount_replenish_in_words
                  ,x.max_amount_tranche
                  ,case when x.max_amount_tranche is not null then
                       f_sumpr(nSum_ => x.max_amount_tranche * x.denom
                              ,nCcyCode_ => x.currency_id
                              ,strGender_ => x.gender)
                   end max_amount_tranche_in_words
                  ,x.okpo
                  ,x.user_name
                  ,null interest_rate_dod
                  ,null calculation_type_dod
                  ,x.investor_name
                  ,null action_date
                  ,null replenishment_number
              from(
                  select d.deal_number
                        ,trunc(h.sys_time) create_date
                        ,dbo.contract_number
                        ,dbo.contract_date
                        ,dbo.nmk
                        ,x.deposit_account
                        ,c.name currency_name
                        ,x.debit_account
                        ,dpt.amount_tranche amount_tranche
                        ,case when dpt.is_individual_rate = 1
                              then dpt.individual_interest_rate
                              else x.interest_rate
                         end interest_rate
                        ,d.start_date
                        ,d.expiry_date
                        ,x.return_account
                        ,case when dpt.is_capitalization = 1
                              then x.deposit_account
                              else x.return_account
                         end payment_account
                        ,case when dpt.frequency_payment = 3 then 0
                              else dpt.is_capitalization * 2 + dpt.frequency_payment
                         end frequency_payment
                        ,dpt.is_prolongation
                        ,dpt.number_prolongation
                        ,dpt.is_replenishment_tranche
                        ,(select max(r.min_sum_tranche)
                                    keep (dense_rank first order by r.valid_from desc, r.min_sum_tranche desc)
                            from r
                           where 1 = 1
                             and r.currency_id = dpt.currency_id
                             and r.min_sum_tranche <= dpt.amount_tranche / c.denom
                             and r.valid_from <= d.start_date
                             and nvl(r.valid_through, d.start_date) >= d.start_date)
                         min_amount_tranche
                        ,(select max(r.max_sum_tranche)
                                 keep (dense_rank first order by r.valid_from desc, r.min_sum_tranche desc)
                            from r
                           where 1 = 1
                             and r.currency_id = dpt.currency_id
                             and r.min_sum_tranche <= dpt.amount_tranche / c.denom
                             and r.valid_from <= d.start_date
                             and nvl(r.valid_through, d.start_date) >= d.start_date)
                         max_amount_tranche
                        ,case when dpt.is_replenishment_tranche = 1 then
                           (select max(r.min_replenishment_amount)
                                    keep (dense_rank first order by r.valid_from desc, r.min_sum_tranche desc)
                              from r
                             where 1 = 1
                               and r.currency_id = dpt.currency_id
                               and r.min_sum_tranche <= dpt.amount_tranche / c.denom
                               and r.valid_from <= d.start_date
                               and nvl(r.valid_through, d.start_date) >= d.start_date
                               )
                         end min_amount_replenishment
                        ,case when dpt.is_replenishment_tranche = 1 then
                           (select max(r.max_replenishment_amount)
                                    keep (dense_rank first order by r.valid_from desc, r.min_sum_tranche desc)
                              from r
                             where 1 = 1
                               and r.currency_id = dpt.currency_id
                               and r.min_sum_tranche <= dpt.amount_tranche / c.denom
                               and r.valid_from <= d.start_date
                               and nvl(r.valid_through, d.start_date) >= d.start_date
                               )
                         end max_amount_replenishment
                        ,dbo.okpo
                        ,s.fio user_name
                        ,h.user_id
                        ,p.process_type_id
                        ,c.gender
                        ,c.denom
                        ,dpt.currency_id
                        ,coalesce(
                             corp.nmku
                            ,f_get_cust_h(p_rnk => d.customer_id
                                         ,p_tag => 'nmk'
                                         ,p_dat => d.start_date)) investor_name
                    from smb_deposit dpt
                        ,deal d
                        ,v_dbo dbo
                        ,process p
                        ,xmltable ('/SMBDepositTranche' passing xmltype(p.process_data) columns
                                   deposit_account               varchar2(100)  path 'PrimaryAccount'
                                  ,debit_account                 varchar2(100)  path 'DebitAccount'
                                  ,return_account                varchar2(100)  path 'ReturnAccount'
                                  ,interest_rate                 number         path 'InterestRate'
                                   ) x
                        ,tabval$global c
                        ,(select h.process_id
                                ,max(h.sys_time) keep (dense_rank first order by h.id) sys_time
                                ,max(h.user_id) keep (dense_rank first order by h.id) user_id
                           from process_history h
                          group by h.process_id  ) h
                        ,staff$base s
                        ,corps corp
                   where dpt.id = p_deposit_id
                     and dpt.id = d.id
                     and d.customer_id = dbo.rnk
                     and p.object_id = dpt.id
                     and p.process_type_id = l_process_type_id
                     and dpt.currency_id = c.kv
                     and p.id = h.process_id
                     and h.user_id = s.id
                     and d.customer_id = corp.rnk(+)) x;
        loop
            fetch l_cursor bulk collect into l_smb_info;  -- limit не используем возвращается не более 1-ой записи
            exit when l_smb_info.count = 0;
            for i in 1..l_smb_info.count loop
                 pipe row (l_smb_info(i));
            end loop;
        end loop;
        close l_cursor;
        return;
    end get_tranche_data_for_print;

    -- заявление на пополнение
    function get_replenish_data_for_print(p_process_id in number)
             return tt_smb_data_for_print pipelined
     is
        l_process_type_id               number;
        l_repl_process_type_id          number;
        l_cursor                        sys_refcursor;
        l_smb_info                      tt_smb_data_for_print;
    begin
        l_process_type_id      := process_utl.get_proc_type_id(
                                            p_proc_type_code => PROCESS_TRANCHE_CREATE
                                           ,p_module_code    => PROCESS_TRANCHE_MODULE);
        l_repl_process_type_id := process_utl.get_proc_type_id(
                                            p_proc_type_code => PROCESS_REPLENISH_TRANCHE
                                           ,p_module_code    => PROCESS_TRANCHE_MODULE);

        open l_cursor for
            select d.deal_number
                  ,trunc(h.sys_time) create_date
                  ,dbo.contract_number
                  ,dbo.contract_date
                  ,dbo.nmk
                  ,dpt.deposit_account
                  ,c.name currency_name
                  ,dpt.debit_account
                  ,rep.amount_tranche amount_tranche
                  ,f_sumpr(nSum_      => rep.amount_tranche * c.denom
                          ,nCcyCode_  => t.currency_id
                          ,strGender_ => c.gender) amount_tranche_in_words
                  ,null interest_rate
                  ,d.start_date
                  ,d.expiry_date
                  ,dpt.return_account
                  ,null payment_account
                  ,null frequency_payment
                  ,null is_prolongation
                  ,null number_prolongation
                  ,null is_replenishment_tranche
                  ,null min_amount_tranche
                  ,null min_amount_tranche_in_words
                  ,null min_amount_replenishment
                  ,null min_amount_replenish_in_words
                  ,null max_amount_replenishment
                  ,null max_amount_replenish_in_words
                  ,null max_amount_tranche
                  ,null max_amount_tranche_in_words
                  ,dbo.okpo
                  ,s.fio user_name
                  ,null interest_rate_dod
                  ,null calculation_type_dod
                  ,coalesce(
                       corp.nmku
                      ,f_get_cust_h(p_rnk => d.customer_id
                                   ,p_tag => 'nmk'
                                   ,p_dat => d.start_date)) investor_name
                  ,rep.action_date
                  ,rep.replenishment_number
              from process r
                  ,process p
                  ,deal d
                  ,smb_deposit t
                  ,xmlTable('/SMBDepositTranche' passing xmltype(r.process_data) columns
                             action_date             date           path 'ActionDate'
                            ,amount_tranche          number         path 'AmountTranche'
                            ,replenishment_number    varchar2(100)  path 'DealNumber'
                              ) rep
                  ,xmlTable('/SMBDepositTranche' passing xmltype(p.process_data) columns
                             deposit_account         varchar2(100)  path 'PrimaryAccount'
                            ,debit_account           varchar2(100)  path 'DebitAccount'
                            ,return_account          varchar2(100)  path 'ReturnAccount'
                              ) dpt
                  ,(select h.process_id
                          ,max(h.sys_time) keep (dense_rank first order by h.id) sys_time
                          ,max(h.user_id) keep (dense_rank first order by h.id) user_id
                     from process_history h
                    group by h.process_id  ) h
                  ,v_dbo dbo
                  ,corps corp
                  ,tabval$global c
                  ,staff$base s
             where r.process_type_id = l_repl_process_type_id
               and r.id = p_process_id
               and r.object_id = p.object_id
               and p.process_type_id = l_process_type_id
               and p.object_id = d.id
               and d.id = t.id
               and h.process_id = r.id
               and d.customer_id = corp.rnk(+)
               and d.customer_id = dbo.rnk
               and t.currency_id = c.kv
               and h.user_id = s.id;
        loop
            fetch l_cursor bulk collect into l_smb_info;  -- limit не используем возвращается не более 1-ой записи
            exit when l_smb_info.count = 0;
            for i in 1..l_smb_info.count loop
                 pipe row (l_smb_info(i));
            end loop;
        end loop;
        close l_cursor;
        return;
    end get_replenish_data_for_print;

    -- Заява про зменшення строку розміщення Траншу
    function get_data_for_closing_tranche(p_deposit_id in number)
             return tt_smb_data_for_print pipelined
     is
        l_process_type_id               number;
        l_ret_process_type_id          number;
        l_cursor                        sys_refcursor;
        l_smb_info                      tt_smb_data_for_print;
    begin
        l_process_type_id      := process_utl.get_proc_type_id(
                                            p_proc_type_code => PROCESS_TRANCHE_CREATE
                                           ,p_module_code    => PROCESS_TRANCHE_MODULE);
        l_ret_process_type_id := process_utl.get_proc_type_id(
                                            p_proc_type_code => smb_deposit_utl.PROCESS_EARLY_RETURN_TRANCHE
                                           ,p_module_code    => PROCESS_TRANCHE_MODULE);

        open l_cursor for
            select d.deal_number
                  ,trunc(h.sys_time) create_date
                  ,dbo.contract_number
                  ,dbo.contract_date
                  ,dbo.nmk
                  ,dpt.deposit_account
                  ,c.name currency_name
                  ,dpt.debit_account
                  ,null amount_tranche
                  ,null amount_tranche_in_words
                  ,rtr.penalty_rate interest_rate
                  ,d.start_date
                  ,d.expiry_date
                  ,dpt.return_account
                  ,case when t.is_capitalization = 1
                          then dpt.deposit_account
                          else dpt.return_account
                   end payment_account
                  ,null frequency_payment
                  ,null is_prolongation
                  ,null number_prolongation
                  ,null is_replenishment_tranche
                  ,null min_amount_tranche
                  ,null min_amount_tranche_in_words
                  ,null min_amount_replenishment
                  ,null min_amount_replenish_in_words
                  ,null max_amount_replenishment
                  ,null max_amount_replenish_in_words
                  ,null max_amount_tranche
                  ,null max_amount_tranche_in_words
                  ,dbo.okpo
                  ,s.fio user_name
                  ,null interest_rate_dod
                  ,null calculation_type_dod
                  ,coalesce(
                       corp.nmku
                      ,f_get_cust_h(p_rnk => d.customer_id
                                   ,p_tag => 'nmk'
                                   ,p_dat => d.start_date)) investor_name
                  ,rtr.action_date
                  ,null replenishment_number
              from process r
                  ,process p
                  ,deal d
                  ,smb_deposit t
                  ,(select h.process_id
                          ,max(h.sys_time) keep (dense_rank first order by h.id) sys_time
                          ,max(h.user_id) keep (dense_rank first order by h.id) user_id
                     from process_history h
                    group by h.process_id  ) h
                  ,xmlTable('/SMBDepositTranche' passing xmltype(r.process_data) columns
                             action_date             date           path 'ActionDate'
                            ,penalty_rate            number         path 'PenaltyRate'
                              ) rtr
                  ,xmlTable('/SMBDepositTranche' passing xmltype(p.process_data) columns
                             deposit_account         varchar2(100)  path 'PrimaryAccount'
                            ,debit_account           varchar2(100)  path 'DebitAccount'
                            ,return_account          varchar2(100)  path 'ReturnAccount'
                              ) dpt
                  ,corps corp
                  ,v_dbo dbo
                  ,tabval$global c
                  ,staff$base s
             where r.process_type_id = l_ret_process_type_id
               and r.object_id = p_deposit_id
               and r.state_id in (process_utl.GC_PROCESS_STATE_CREATE, process_utl.GC_PROCESS_STATE_RUN, process_utl.GC_PROCESS_STATE_SUCCESS)
               and p.process_type_id = l_process_type_id
               and r.object_id = p.object_id
               and r.id = h.process_id
               and p.object_id = d.id
               and d.id = t.id
               and d.customer_id = corp.rnk(+)
               and d.customer_id = dbo.rnk
               and t.currency_id = c.kv
               and h.user_id = s.id;
        loop
            fetch l_cursor bulk collect into l_smb_info;  -- limit не используем возвращается не более 1-ой записи
            exit when l_smb_info.count = 0;
            for i in 1..l_smb_info.count loop
                 pipe row (l_smb_info(i));
            end loop;
        end loop;
        close l_cursor;
        return;
    end get_data_for_closing_tranche;

    -- заявление на размещение депозита по требованию
    function get_dod_data_for_print(p_deposit_id in number)
             return tt_smb_data_for_print pipelined
     is
        l_process_type_id          number;
        l_on_demand_kind_type_id   number;
        l_cursor                   sys_refcursor;
        l_smb_info                 tt_smb_data_for_print;
    begin
        l_process_type_id := process_utl.get_proc_type_id(
                                            p_proc_type_code => PROCESS_ON_DEMAND_CREATE
                                           ,p_module_code    => PROCESS_TRANCHE_MODULE);
        select max(id)
          into l_on_demand_kind_type_id
          from deal_interest_rate_kind irk
         where irk.kind_code = ON_DEMAND_GENERAL_KIND_CODE;
         open l_cursor for
            select x.deal_number
                  ,x.create_date
                  ,x.contract_number
                  ,x.contract_date
                  ,x.nmk
                  ,x.deposit_account
                  ,x.currency_name
                  ,x.debit_account
                  ,null amount_tranche
                  ,null amount_tranche_in_words
                  ,null interest_rate
                  ,x.start_date
                  ,null expiry_date
                  ,x.return_account
                  ,x.payment_account
                  ,x.frequency_payment
                  ,null is_prolongation
                  ,null number_prolongation
                  ,null is_replenishment_tranche
                  ,null min_amount_tranche
                  ,null min_amount_tranche_in_words
                  ,null min_amount_replenishment
                  ,null min_amount_replenish_in_words
                  ,null max_amount_replenishment
                  ,null max_amount_replenish_in_words
                  ,null max_amount_tranche
                  ,null max_amount_tranche_in_words
                  ,x.okpo
                  ,x.user_name
                  ,x.interest_rate_dod
                  ,x.calculation_type_dod
                  ,x.investor_name
                  ,null action_date
                  ,null replenishment_number
              from(
                    select d.deal_number
                          ,trunc(h.sys_time) create_date
                          ,dbo.contract_number
                          ,dbo.contract_date
                          ,dbo.nmk
                          ,x.deposit_account
                          ,c.name currency_name
                          ,x.debit_account
                          ,null amount_tranche
                          ,null interest_rate
                          ,d.start_date
                          ,d.expiry_date
                          ,null return_account
                          ,x.return_account payment_account
                          ,1 frequency_payment
                          ,dbo.okpo
                          ,s.fio user_name
                          ,h.user_id
                          ,p.process_type_id
                          ,c.gender
                          ,c.denom
                          ,dpt.currency_id
                          ,case when dpt.is_individual_rate = 1
                                then to_char(dpt.individual_interest_rate, 'fm99G999G990D00', 'NLS_NUMERIC_CHARACTERS='', ''')||'%'
                                else
                                   (select listagg('від '||to_char(c.amount_from, 'fm999G999G999G999G999G990D00', 'NLS_NUMERIC_CHARACTERS='', ''')||
                                                   ' - ' ||to_char(c.interest_rate, 'fm99G999G990D00', 'NLS_NUMERIC_CHARACTERS='', ''')||'%', chr(10)) within group (order by c.amount_from) x
                                    from deal_interest_option o
                                        ,deposit_on_demand_condition c
                                   where o.rate_kind_id = l_on_demand_kind_type_id
                                     and o.id = c.interest_option_id
                                     and o.is_active = 1
                                     and c.currency_id = dpt.currency_id
                                     and o.valid_from <= d.start_date
                                     and nvl(o.valid_through, d.start_date) >= d.start_date)
                           end interest_rate_dod
                          ,dpt.calculation_type calculation_type_dod
                          ,coalesce(
                             corp.nmku
                            ,f_get_cust_h(p_rnk => d.customer_id
                                         ,p_tag => 'nmk'
                                         ,p_dat => d.start_date)) investor_name
                      from smb_deposit dpt
                          ,deal d
                          ,v_dbo dbo
                          ,process p
                          ,xmltable ('/SMBDepositOnDemand' passing xmltype(p.process_data) columns
                                     deposit_account               varchar2(100)  path 'PrimaryAccount'
                                    ,debit_account                 varchar2(100)  path 'DebitAccount'
                                    ,return_account                varchar2(100)  path 'ReturnAccount'
                                    ,interest_rate                 number         path 'InterestRate'
                                     ) x
                          ,tabval$global c
                          ,(select h.process_id
                                  ,max(h.sys_time) keep (dense_rank first order by h.id) sys_time
                                  ,max(h.user_id) keep (dense_rank first order by h.id) user_id
                             from process_history h
                            group by h.process_id  ) h
                          ,staff$base s
                          ,corps corp
                     where dpt.id = p_deposit_id
                       and dpt.id = d.id
                       and d.customer_id = dbo.rnk
                       and p.object_id = dpt.id
                       and p.process_type_id = l_process_type_id
                       and dpt.currency_id = c.kv
                       and p.id = h.process_id
                       and h.user_id = s.id
                       and d.customer_id = corp.rnk(+)) x;
        loop
            fetch l_cursor bulk collect into l_smb_info; -- limit не используем возвращается не более 1-ой записи
            exit when l_smb_info.count = 0;
            for i in 1..l_smb_info.count loop
                 pipe row (l_smb_info(i));
            end loop;
        end loop;
        close l_cursor;
        return;
    end get_dod_data_for_print;

    -- Заява про закриття Вкладу на вимогу
    function get_data_for_closing_dod(p_deposit_id in number)
             return tt_smb_data_for_print pipelined
     is
        l_process_type_id          number;
        l_close_process_type_id    number;
        l_on_demand_kind_type_id   number;
        l_cursor                   sys_refcursor;
        l_smb_info                 tt_smb_data_for_print;
    begin
        l_process_type_id       := process_utl.get_proc_type_id(
                                            p_proc_type_code => PROCESS_ON_DEMAND_CREATE
                                           ,p_module_code    => PROCESS_TRANCHE_MODULE);
        l_close_process_type_id := process_utl.get_proc_type_id(
                                            p_proc_type_code => smb_deposit_utl.PROCESS_ON_DEMAND_CLOSE
                                           ,p_module_code    => PROCESS_TRANCHE_MODULE);


        open l_cursor for
            select d.deal_number
                  ,trunc(h.sys_time) create_date
                  ,dbo.contract_number
                  ,dbo.contract_date
                  ,dbo.nmk
                  ,dpt.deposit_account
                  ,c.name currency_name
                  ,null debit_account
                  ,null amount_tranche
                  ,null amount_tranche_in_words
                  ,null interest_rate
                  ,d.start_date
                  ,d.expiry_date
                  ,dpt.return_account
                  ,dpt.return_account payment_account
                  ,null frequency_payment
                  ,null is_prolongation
                  ,null number_prolongation
                  ,null is_replenishment_tranche
                  ,null min_amount_tranche
                  ,null min_amount_tranche_in_words
                  ,null min_amount_replenishment
                  ,null min_amount_replenish_in_words
                  ,null max_amount_replenishment
                  ,null max_amount_replenish_in_words
                  ,null max_amount_tranche
                  ,null max_amount_tranche_in_words
                  ,dbo.okpo
                  ,s.fio user_name
                  ,null interest_rate_dod
                  ,null calculation_type_dod
                  ,coalesce(
                       corp.nmku
                      ,f_get_cust_h(p_rnk => d.customer_id
                                   ,p_tag => 'nmk'
                                   ,p_dat => d.start_date)) investor_name
                  ,rtr.action_date
                  ,null replenishment_number
              from process r
                  ,process p
                  ,deal d
                  ,smb_deposit t
                  ,(select h.process_id
                          ,max(h.sys_time) keep (dense_rank first order by h.id) sys_time
                          ,max(h.user_id) keep (dense_rank first order by h.id) user_id
                     from process_history h
                    group by h.process_id  ) h
                  ,xmlTable('/SMBDepositOnDemand' passing xmltype(r.process_data) columns
                             action_date             date           path 'ActionDate'
                              ) rtr
                  ,xmlTable('/SMBDepositOnDemand' passing xmltype(p.process_data) columns
                             deposit_account         varchar2(100)  path 'PrimaryAccount'
                            ,return_account          varchar2(100)  path 'ReturnAccount'
                              ) dpt
                  ,corps corp
                  ,v_dbo dbo
                  ,tabval$global c
                  ,staff$base s
             where r.process_type_id = l_close_process_type_id
               and r.object_id = p_deposit_id
               and r.state_id in (process_utl.GC_PROCESS_STATE_CREATE, process_utl.GC_PROCESS_STATE_RUN, process_utl.GC_PROCESS_STATE_SUCCESS)
               and p.process_type_id = l_process_type_id
               and r.object_id = p.object_id
               and r.id = h.process_id
               and p.object_id = d.id
               and d.id = t.id
               and d.customer_id = corp.rnk(+)
               and d.customer_id = dbo.rnk
               and t.currency_id = c.kv
               and h.user_id = s.id;
        loop
            fetch l_cursor bulk collect into l_smb_info; -- limit не используем возвращается не более 1-ой записи
            exit when l_smb_info.count = 0;
            for i in 1..l_smb_info.count loop
                 pipe row (l_smb_info(i));
            end loop;
        end loop;
        close l_cursor;
        return;
    end get_data_for_closing_dod;


    -- информация о текущей пролонгации
    function get_tranche_prolongation_xml(p_process_id in number)
             return clob
     is
        l_root_name    varchar2(50) := 'SMBDepositTrancheProlongation';
        l_process_row  process%rowtype;
        l_data         varchar2(1000);
        l_attr_ir      number;
    begin
        if p_process_id is null then
            return '<'||l_root_name||'/>';
        end if;
        l_attr_ir := attribute_utl.get_attribute_id(smb_deposit_utl.ATTR_SMB_DEPOSIT_TRANCHE_IR);
        l_process_row := process_utl.read_process(p_process_id => p_process_id
                                                 ,p_lock       => false
                                                 ,p_raise_ndf  => true);
        check_deposit_type(p_object_id               => l_process_row.object_id
                          ,p_target_object_type_code => TRANCHE_OBJECT_TYPE_CODE);

        select case when d.is_prolongation = 1 and d.current_prolongation_number is not null
                    then '<'||l_root_name||'>'||
                         '<ProlongationNumber>' || d.current_prolongation_number || '</ProlongationNumber>'||
                         '<ExpiryDate>'|| to_char(d.expiry_date_prolongation, 'yyyy-mm-dd') ||'</ExpiryDate>'||
                         '<InterestRate>'|| (select max(a.number_value) keep (dense_rank first order by a.value_date desc)
                                               from attribute_value_by_date a
                                              where a.attribute_id = l_attr_ir
                                                and a.object_id = d.id
                                                and a.value_date <= d.expiry_date_prolongation)||
                         '</InterestRate></'||l_root_name||'>'
                    else '<'||l_root_name||'/>'
               end
          into l_data
          from smb_deposit d
         where d.id = l_process_row.object_id;

        return l_data;
    end get_tranche_prolongation_xml;

    -- список пролонгаций
    function get_prolongation(p_deposit_id in number)
             return tt_smb_prolongation pipelined
     is
        l_prolong_proc_type_id   number;
        l_cursor                 sys_refcursor;
        l_smb_prolongation       tt_smb_prolongation;
    begin
        l_prolong_proc_type_id := process_utl.get_proc_type_id(
                                            p_proc_type_code => PROCESS_TRANCHE_PROLONGATION
                                           ,p_module_code    => PROCESS_TRANCHE_MODULE);
        open l_cursor for
        select dpt.id
              ,x.start_date
              ,x.expiry_date 
          from smb_deposit dpt
              ,process p
              ,xmltable ('/SMBDepositProlongation' passing xmltype(p.process_data) columns
                     Start_Date                    date           path 'StartDate'
                    ,Expiry_Date                   date           path 'ExpiryDate') x
         where dpt.id = p_deposit_id
           and dpt.is_prolongation = 1    
           and p.object_id = dpt.id
           and p.process_type_id = l_prolong_proc_type_id;
        loop
            fetch l_cursor bulk collect into l_smb_prolongation;
            exit when l_smb_prolongation.count = 0;
            for i in 1..l_smb_prolongation.count loop
                 pipe row (l_smb_prolongation(i));
            end loop;
        end loop;
        close l_cursor;
        return;
    end;

end smb_deposit_utl;
/
PROMPT *** Create  grants  SMB_DEPOSIT_UTL ***
grant EXECUTE   on SMB_DEPOSIT_UTL   to BARS_ACCESS_DEFROLE;
grant EXECUTE   on SMB_DEPOSIT_UTL   to BARSREADER_ROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** ========= Scripts /Sql/BARS/package/SMB_DEPOSIT_UTL.sql ===== *** End ***
PROMPT ===================================================================================== 
