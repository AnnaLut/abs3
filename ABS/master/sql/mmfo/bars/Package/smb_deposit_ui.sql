PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/package/smb_deposit_ui.sql ===== *** Run ***
PROMPT ===================================================================================== 


create or replace package smb_deposit_ui
is
    -- segment of business
    SEGMENT_OF_BUSINESS_CODE        constant varchar2(50) := 'SMB_DEPOSIT';    
    --

    ROOT_TAG_OPEN               constant varchar2(20) := '<ROOT>';
    ROOT_TAG_CLOSE              constant varchar2(20) := '</ROOT>';  
    
    
    type tt_deal_interest_rate_kind is table of deal_interest_rate_kind%rowtype;

    type t_prolongation_dict is record (
        numberprolongation     number 
       ,interest_rate          number 
       ,ApplyBonusProlongation number
       ,name_                  varchar2(100));

    type tt_prolongation_dict is table of t_prolongation_dict;

    function get_interest_calculation (p_data      in clob
                                      ,p_object_id in number)
        return clob;

    function get_interest_calculation_table (p_data      in clob
                                            ,p_object_id in number)
        return tt_deposit_calculator;

    function get_payment_term_list return t_lookup pipelined;
    
    function get_capitalization_term_list return t_lookup pipelined;
    -- виды пролонгаций (для першої / для кожної)
    function get_prolongation_list return t_lookup pipelined;

    -- справочник для выбора пролонгации
    function get_prolongation_dict(p_start_date  in date
                                  ,p_currency_id in number) 
              return tt_prolongation_dict pipelined;

    function get_tranche_lock_type_list return t_lookup pipelined;

    -- тип начислени % для ДпТ    
    function get_calculation_type_list(p_date in date default null) 
             return t_lookup pipelined;

    -- тип начислени % для ДпТ справочник с +1 запись   
    function get_calculation_type_dict return t_lookup pipelined;

    function check_type(p_type varchar2) return varchar2;
    
    function get_types_xml return clob;
    
    function get_kinds_xml return clob;
    
    function get_options_xml return clob;

    function get_data_on_demand_xml(p_id              in number default null
                                   ,p_is_wrap_to_root in number default 1 ) 
         return clob; 
    
    function get_data_xml(p_type       in varchar2 default null 
                         ,p_option_id  in number   default null) 
         return clob;
    
    function get_general_xml(p_option_id       in number default null
                            ,p_is_wrap_to_root in number default 0) 
         return clob;

    function get_bonus_xml(p_option_id       in number default null
                          ,p_is_wrap_to_root in number default 0) 
         return clob; 

    function get_payment_xml(p_option_id       in number default null
                            ,p_is_wrap_to_root in number default 0) 
         return clob; 

    function get_capitalization_xml(p_option_id       in number default null
                                   ,p_is_wrap_to_root in number default 0) 
         return clob;

    function get_replenishment_xml(p_option_id       in number default null
                                  ,p_is_wrap_to_root in number default 0) 
         return clob ;

    function get_prolongation_xml(p_option_id       in number default null
                                 ,p_is_wrap_to_root in number default 0) 
         return clob;          

    function get_prolongation_bonus_xml(p_option_id       in number default null
                                       ,p_is_wrap_to_root in number default 0) 
         return clob;

    function get_penalty_rates_xml(p_option_id       in number default null
                                  ,p_is_wrap_to_root in number default 0) 
         return clob; 

    function get_deposit_amount_setting_xml(p_option_id       in number default null
                                           ,p_is_wrap_to_root in number default 0) 
         return clob; 

    function get_replenishment_tranche_xml(p_option_id       in number default null
                                          ,p_is_wrap_to_root in number default 0) 
         return clob;

    function get_rate_for_blocked_trn_xml(p_option_id       in number default null
                                         ,p_is_wrap_to_root in number default 0) 
         return clob;
                        
    function get_tranche_product return number;
    
    function get_on_demand_product return number;
    
    procedure set_data(p_data      in clob
                      ,p_type      in varchar2
                      ,p_error     out varchar2
                      ,p_option_id out number);

    procedure set_data_deposit_on_demand(p_data      in clob
                                        ,p_error     out varchar2
                                        ,p_id        out number
                                        ,p_type      in varchar2 default null);

    procedure set_deposit_on_demand(p_deposit in  tt_deposit_option
                                   ,p_id      out number
                                   ,p_type    in varchar2);
    
    procedure set_option(p_deposit_option in  tt_deposit_option
                        ,p_type           in  varchar2
                        ,p_option_id      out number);

    procedure cor_tranche(p_process_id   in out number
                         ,p_data         in clob);

    procedure cor_replenish_tranche(p_process_id   in out number
                                   ,p_object_id    in number   
                                   ,p_data         in clob);
    
    procedure tranche_authorization(p_process_id in number);
                         
    procedure tranche_confirmation(p_process_id   in number
                                  ,p_is_confirmed in varchar2 default 'Y'
                                  ,p_comment      in varchar2 default null
                                  ,p_error        out varchar2);

    function get_tranche_xml_data(p_process_id  in number) return clob;
    
    function get_replenish_tanche_xml_data(p_process_id in number
                                          ,p_object_id  in number) 
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
    -- возвращает расчетную процентную ставку по траншу                                        
    function get_interest_rate_tranche(p_data in clob
                                      ,p_date in date default null)
       return clob;

    -- возвращает расчетную процентную ставку по ДпТ
    function get_interest_rate_on_demand(p_data in clob)
       return clob;

    function get_on_demand_xml_data(p_process_id  in number) return clob;

    procedure cor_on_demand(p_process_id   in out number
                           ,p_data         in clob);

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

    -- смена метода начисления для ДпТ                                          
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

    -- удалить транш (установить статус object в DELETED)
    procedure delete_tranche(p_process_id in number
                            ,p_comment    in varchar2);

    -- удалить пополнение 
    procedure delete_replenishment(p_process_id in number
                                  ,p_comment    in varchar2);

    -- удалить транш (установить статус object в DELETED)
    procedure delete_on_demand(p_process_id in number
                              ,p_comment    in varchar2);

    function get_users_activity(p_process_id in number)
        return varchar2;

    function get_last_replenishment_date (
                          p_start_date  in date             
                         ,p_end_date    in date)
         return date;

    -- информация о текущей пролонгации
    function get_tranche_prolongation_xml(p_process_id in number)
             return clob;

end;
/
create or replace package body smb_deposit_ui
is
    cursor c_get_data(p_type varchar2, p_data clob) is
       with x as( 
              select 'ROOT/'||p_type||'/KINDS/KIND' kind_path
                    ,'KIND/OPTIONS/OPTION' option_path
                    ,'OPTION/CONDITIONS/CONDITION' condition_path
                    ,xmltype(p_data) xml_data
                from dual
         )
        select t_deposit_option(
                 id                 => o.option_id
                ,product_id         => o.product_id
                ,rate_kind_id       => k.rate_kind_id
                ,valid_from         => o.valid_from
                ,valid_through      => o.valid_through
                ,is_active          => o.is_active
                ,option_description => o.option_description
                ,user_id            => null
                ,sys_time           => null
                ,list_condition => 
                  cast(collect(
                        t_deposit_condition(
                              id                         => case when p_type = smb_deposit_utl.DEPOSIT_ON_DEMAND_CALC_TYPE 
                                                                 then o.calculation_id
                                                                 else c.condition_id
                                                            end
                             ,interest_option_id         => o.option_id
                             ,currency_id                => c.currency_id
                             ,term_unit                  => c.term_unit
                             ,term_from                  => c.term_from
                             ,amount_from                => c.amount_from
                             ,interest_rate              => c.interest_rate
                             ,payment_term_id            => c.payment_term_id 
                              -- deposit_prolongation
                             ,apply_to_first             => c.apply_to_first
                              -- rate_for_return_tranche
                             ,rate_from                  => c.rate_from
                             ,penalty_rate               => c.penalty_rate
                              -- deposit_amount_setting
                             ,min_sum_tranche            => c.min_sum_tranche
                             ,max_sum_tranche            => c.max_sum_tranche
                             ,min_replenishment_amount   => c.min_replenishment_amount
                             ,max_replenishment_amount   => c.max_replenishment_amount 
                              -- terms_replenishment_tranche
                             ,tranche_term                => c.tranche_term
                             ,days_to_close_replenish     => c.days_to_close_replenish
                             ,product_id                  => c.condition_product_id                                
                             ,calculation_type_id         => o.calculation_type_id
                              -- deposit_replenishment
                             ,is_replenishment            => case when kind_code = smb_deposit_utl.REPLENISHMENT_KIND_CODE then nvl(c.is_replenishment, 1) end
                             ,is_prolongation             => c.is_prolongation
                        )  
                  ) as tt_deposit_condition) 
                  ) dpt_  
          from x
              ,xmlTable(x.kind_path passing  x.xml_data
                         columns
                          rate_kind_id  number          path 'ID'
                         ,kind_name     varchar2(100)   path 'KIND_NAME'
                         ,kind_code     varchar2(100)   path 'KIND_CODE'
                         ,option_xml    XMLType         path 'OPTIONS/OPTION'
                        ) k
              ,xmlTable('/OPTION' passing k.option_xml
                    columns
                       option_id           number          path 'ID'
                      ,valid_from          date            path 'VALID_FROM'
                      ,valid_through       date            path 'VALID_THROUGH' 
                      ,is_active           number          path 'IS_ACTIVE' 
                      ,option_description  varchar2(100)   path 'OPTION_DESCRIPTION'
                      ,product_id          number          path 'PRODUCT_ID'
                      -- костыль (для типа расчета), т.к. ui не может сделать из этого xml один грид
                      ,calculation_type_id number          path 'CALCULATION_TYPE_ID' 
                      ,calculation_id      number          path 'ID_' 
                      ,condition_xml       XMLType         path 'CONDITIONS/CONDITION'                   
                       )(+) o
              ,xmlTable('/CONDITION' passing o.condition_xml
                    columns
                       condition_id             number       path 'ID'
                      ,currency_id              number       path 'CURRENCY_ID'
                      ,term_unit                number       path 'TERM_UNIT'
                      ,term_from                number       path 'TERM_FROM'
                      ,amount_from              number       path 'AMOUNT_FROM'
                      ,interest_rate            number       path 'INTEREST_RATE'
                      ,payment_term_id          number       path 'PAYMENT_TERM_ID'
                      ,apply_to_first           number       path 'APPLY_TO_FIRST'
                      ,rate_from                number       path 'RATE_FROM'
                      ,penalty_rate             number       path 'PENALTY_RATE'
                      ,min_sum_tranche          number       path 'MIN_SUM_TRANCHE'
                      ,max_sum_tranche          number       path 'MAX_SUM_TRANCHE'
                      ,min_replenishment_amount number       path 'MIN_REPLENISHMENT_AMOUNT'
                      ,max_replenishment_amount number       path 'MAX_REPLENISHMENT_AMOUNT'
                      ,tranche_term             number       path 'TRANCHE_TERM'
                      ,days_to_close_replenish  number       path 'DAYS_TO_CLOSE_REPLENISH'
                      ,condition_product_id     number       path 'PRODUCT_ID'
                      ,is_replenishment         number       path 'IS_REPLENISHMENT'
                      ,is_prolongation          number       path 'IS_PROLONGATION'
                        )(+) c            
          where 1 = 1       
         group by rate_kind_id
                ,option_id
                ,valid_from
                ,valid_through
                ,is_active
                ,option_description    
                ,product_id
                ,kind_code;

    cursor c_data_xml (p_type_code varchar2
                      ,p_option_id number) is
     select '<'||p_type_code||'>'||
            xmlelement("KINDS",
                xmlelement("KIND",
                  xmlforest(
                     t.type_code
                    ,k.id
                    ,k.type_id
                    ,k.kind_code
                    ,k.kind_name
                    ,k.is_active 
                    ,xmlagg(
                        case when d.id is not null then
                           xmlelement("OPTION",
                            xmlforest(
                               d.id
                              ,d.product_id
                              ,to_char(d.valid_from, 'yyyy-mm-dd') valid_from 
                              ,to_char(d.valid_through, 'yyyy-mm-dd') valid_through
                              ,d.is_active
                              ,d.option_description
                              ,d.user_id
                              ,to_char(d.sys_time, 'yyyy-mm-dd"T"hh24:mi:ss') sys_time
                              ,case when p_type_code in (smb_deposit_utl.GENERAL_TYPE, smb_deposit_utl.BONUS_TYPE) then
                                       (select xmlagg(
                                                xmlelement("CONDITION",
                                                 xmlforest(x.id 
                                                          ,x.interest_option_id 
                                                          ,x.currency_id
                                                          ,x.term_unit
                                                          ,x.term_from
                                                          ,x.amount_from
                                                          ,x.interest_rate  
                                                          ,c.lcv currency)
                                                     ) order by x.currency_id
                                                               ,x.term_unit
                                                               ,x.term_from
                                                               ,x.amount_from )
                                          from interest_rate_condition x
                                              ,tabval$global c   
                                         where x.interest_option_id = d.id
                                           and x.currency_id = c.kv)
                                    when p_type_code = smb_deposit_utl.PAYMENT_TYPE then
                                       (select xmlagg(
                                                xmlelement("CONDITION",
                                                 xmlforest(x.id
                                                          ,x.interest_option_id
                                                          ,x.currency_id    
                                                          ,x.payment_term_id
                                                          ,x.interest_rate
                                                          ,c.lcv currency  
                                                          ,case x.payment_term_id 
                                                                when smb_deposit_utl.PAYMENT_TERM_MONTHLY_ID then smb_deposit_utl.PAYMENT_TERM_MONTHLY
                                                                when smb_deposit_utl.PAYMENT_TERM_QUARTERLY_ID then smb_deposit_utl.PAYMENT_TERM_QUARTERLY
                                                                when smb_deposit_utl.PAYMENT_TERM_EOT_ID then smb_deposit_utl.PAYMENT_TERM_EOT
                                                           end payment_term )
                                                     )  order by x.currency_id
                                                                ,x.payment_term_id      
                                                                 )
                                          from deposit_payment x
                                              ,tabval$global c   
                                         where x.interest_option_id = d.id
                                           and x.currency_id = c.kv)
                                    when p_type_code = smb_deposit_utl.CAPITALIZATION_TYPE then       
                                       (select xmlagg(
                                                xmlelement("CONDITION",
                                                 xmlforest(x.id
                                                          ,x.interest_option_id
                                                          ,x.currency_id    
                                                          ,x.payment_term_id
                                                          ,x.interest_rate
                                                          ,c.lcv currency  
                                                          ,case x.payment_term_id 
                                                                when smb_deposit_utl.PAYMENT_TERM_MONTHLY_ID then smb_deposit_utl.PAYMENT_TERM_MONTHLY
                                                                when smb_deposit_utl.PAYMENT_TERM_QUARTERLY_ID then smb_deposit_utl.PAYMENT_TERM_QUARTERLY
                                                           end payment_term )
                                                     ) order by x.currency_id    
                                                               ,x.payment_term_id )
                                          from deposit_capitalization x
                                              ,tabval$global c   
                                         where x.interest_option_id = d.id
                                           and x.currency_id = c.kv)
                                    when p_type_code = smb_deposit_utl.PROLONGATION_TYPE then                                                                                  
                                       (select xmlagg(
                                                xmlelement("CONDITION",
                                                 xmlforest(x.id
                                                          ,x.interest_option_id
                                                          ,x.currency_id  
                                                          ,x.amount_from
                                                          ,x.interest_rate
                                                          ,x.apply_to_first  
                                                          ,c.lcv currency
                                                          ,case x.apply_to_first
                                                                when smb_deposit_utl.APPLY_ONLY_FIRST_PROLONG_ID then smb_deposit_utl.APPLY_ONLY_FIRST_PROLONG 
                                                                when smb_deposit_utl.APPLY_FOR_EACH_PROLONG_ID then smb_deposit_utl.APPLY_FOR_EACH_PROLONG
                                                           end apply_to_first_name )  
                                                     )    order by x.currency_id  
                                                                  ,x.amount_from)
                                          from deposit_prolongation x
                                              ,tabval$global c   
                                         where x.interest_option_id = d.id
                                           and x.currency_id = c.kv) 
                                    when p_type_code = smb_deposit_utl.REPLENISHMENT_TYPE then       
                                       (select xmlagg(
                                                xmlelement("CONDITION",
                                                 xmlforest(x.id
                                                          ,x.interest_option_id
                                                          ,x.currency_id
                                                          ,x.interest_rate
                                                          ,c.lcv currency 
                                                          ,x.is_replenishment)
                                                     )    order by x.currency_id)                  
                                          from deposit_replenishment x
                                              ,tabval$global c   
                                         where x.interest_option_id = d.id
                                           and x.currency_id = c.kv)
                                    when p_type_code = smb_deposit_utl.PENALTY_RATE_TYPE then
                                       (select xmlagg(
                                                xmlelement("CONDITION",
                                                 xmlforest(x.id
                                                          ,x.interest_option_id
                                                          ,x.currency_id  
                                                          ,x.rate_from
                                                          ,x.penalty_rate
                                                          ,c.lcv currency )  
                                                     ) order by x.currency_id  
                                                               ,x.rate_from)                  
                                          from rate_for_return_tranche x
                                              ,tabval$global c   
                                         where x.interest_option_id = d.id
                                           and x.currency_id = c.kv)
                                    when p_type_code = smb_deposit_utl.AMOUNT_SETTING_TYPE then
                                       (select xmlagg(
                                                xmlelement("CONDITION",
                                                     xmlforest(
                                                           x.id 
                                                          ,x.interest_option_id
                                                          ,x.currency_id
                                                          ,x.min_sum_tranche
                                                          ,x.max_sum_tranche
                                                          ,x.min_replenishment_amount
                                                          ,x.max_replenishment_amount  
                                                          ,c.lcv currency)
                                                        ) order by x.currency_id
                                                                  ,x.min_sum_tranche
                                                                  ,x.max_sum_tranche )
                                          from deposit_amount_setting x
                                              ,tabval$global c   
                                         where x.interest_option_id = d.id
                                           and x.currency_id = c.kv)
                                    when p_type_code = smb_deposit_utl.REPLENISHMENT_TRANCHE_TYPE then
                                       (select xmlagg(
                                                 xmlelement("CONDITION",
                                                  xmlforest(x.id 
                                                           ,x.interest_option_id
                                                           ,x.tranche_term
                                                           ,x.days_to_close_replenish
                                                                )
                                                        ) order by x.interest_option_id
                                                                  ,x.tranche_term) 
                                          from terms_replenishment_tranche x
                                         where x.interest_option_id = d.id) 
                                    when p_type_code = smb_deposit_utl.PROLONGATION_BONUS_TYPE then
                                       (select xmlagg(
                                                xmlelement("CONDITION",
                                                 xmlforest(x.id
                                                          ,x.interest_option_id
                                                          ,x.currency_id  
                                                          ,x.is_prolongation
                                                          ,x.interest_rate
                                                          ,c.lcv currency )  
                                                     ) order by x.currency_id  
                                                               ,x.is_prolongation)
                                          from deposit_prolongation_bonus x
                                              ,tabval$global c   
                                         where x.interest_option_id = d.id
                                           and x.currency_id = c.kv)
                                    when p_type_code = smb_deposit_utl.RATE_FOR_BLOCKED_TRANCHE_TYPE then
                                       (select xmlagg(
                                                xmlelement("CONDITION",
                                                 xmlforest(x.id
                                                          ,x.interest_option_id
                                                          ,x.currency_id  
                                                          ,x.interest_rate
                                                          ,c.lcv currency )  
                                                     ) order by x.currency_id)
                                          from rate_for_blocked_tranche x
                                              ,tabval$global c   
                                         where x.interest_option_id = d.id
                                           and x.currency_id = c.kv)
                               end "CONDITIONS"                                            
                           ) ) 
                        end  order by d.valid_from desc)"OPTIONS" )  
                    ,case when max(d.id) is null then xmlelement("OPTIONS", null) end
                    )).getClobVal()||
             '</'||p_type_code||'>' val
        from deal_interest_rate_type t
            ,deal_interest_rate_kind k
            ,deal_interest_option d
       where t.id = k.type_id
         and k.id = d.rate_kind_id(+)
         and t.type_code = p_type_code
         and (d.id = p_option_id or p_option_id is null)
      group by t.type_code
              ,k.id
              ,k.type_id
              ,k.kind_code
              ,k.kind_name
              ,k.is_active  
      order by k.type_id;   
                  

    function get_interest_calculation (p_data      in clob
                                      ,p_object_id in number)
        return clob
     is
    begin
        return smb_deposit_utl.get_interest_calculation (
                                       p_data      => p_data
                                      ,p_object_id => p_object_id);
    end;

    function get_interest_calculation_table (p_data      in clob
                                            ,p_object_id in number)
        return tt_deposit_calculator
     is
        l_dpt_data tt_deposit_calculator;
    begin
        select t_deposit_calculator(
                      id                 => x.id
                     ,account_id         => x.account_id 
                     ,start_date         => x.start_date
                     ,end_date           => x.end_date
                     ,amount_deposit     => x.amount_deposit
                     ,amount_for_accrual => x.amount_for_accrual
                     ,interest_rate      => x.Interest_Rate
                     ,interest_amount    => x.interest_amount
                     ,interest_tail      => x.interest_tail
                     ,accrual_method     => x.accrual_method
                     ,currency_id        => null
                     ,comment_           => x.comment_ )
           bulk collect into l_dpt_data    
          from table(       
                 smb_deposit_utl.get_interest_calculation_table(
                                         p_data      => p_data
                                        ,p_object_id => p_object_id)) x;
        return l_dpt_data;
    end;


    function get_payment_term_list return t_lookup pipelined 
     is
    begin
        for i in (
                    select t_lookup_item(
                                    item_id   => li.list_item_id
                                   ,item_code => li.list_item_code
                                   ,item_name => li.list_item_name) lst        
                      from list_type lt
                          ,list_item li  
                     where lt.list_code = smb_deposit_utl.DEPOSIT_PAYMENT_TERM_CODE
                       and lt.id = li.list_type_id) loop
            pipe row(i.lst);           
        end loop;                       
        return;
    end;

    function get_capitalization_term_list return t_lookup pipelined
     is
    begin
        for i in (
                    select t_lookup_item(
                                    item_id   => li.list_item_id
                                   ,item_code => li.list_item_code
                                   ,item_name => li.list_item_name) lst        
                      from list_type lt
                          ,list_item li  
                     where lt.list_code = smb_deposit_utl.DEPOSIT_PAYMENT_TERM_CODE
                       and lt.id = li.list_type_id
                       and li.list_item_code <> 'PAYMENT_TERM_EOT') loop
            pipe row(i.lst);           
        end loop;
        return;
    end;

    function get_prolongation_list return t_lookup pipelined
     is
    begin
        for i in (
                    select t_lookup_item(
                                    item_id   => li.list_item_id
                                   ,item_code => li.list_item_code
                                   ,item_name => li.list_item_name) lst        
                      from list_type lt
                          ,list_item li  
                     where lt.list_code = smb_deposit_utl.DEPOSIT_APPLY_BONUS_PROLONG
                       and lt.id = li.list_type_id) loop
            pipe row(i.lst);           
        end loop;  
        return;                     
    end; 

    function get_prolongation_dict(p_start_date  in date
                                  ,p_currency_id in number) 
               return tt_prolongation_dict pipelined
     is
        l_object_type_id number;
        l_product_id     number;
        l_dict           t_prolongation_dict;
    begin
        l_object_type_id := smb_deposit_utl.get_object_type_tranche();
        l_product_id     := product_utl.read_product(
                                                 p_product_type_id => l_object_type_id
                                                ,p_product_code    => smb_deposit_utl.TRANCHE_PRODUCT_CODE
                                                ).id;
        for i in (
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
                   and o.valid_from <= p_start_date
                   and nvl(o.valid_through, p_start_date) >= p_start_date
                   and irk.kind_code = 'SMB_PROLONGATION'
                   )
                    -- данные для выбора параметров пролонгации  
                    select x.amount_from
                          ,x.interest_rate
                          ,x.apply_bonus_prolongation
                          ,(select li.list_item_name        
                              from list_type lt
                                  ,list_item li  
                             where lt.list_code = smb_deposit_utl.DEPOSIT_APPLY_BONUS_PROLONG
                               and lt.id = li.list_type_id
                               and li.list_item_id = x.apply_bonus_prolongation) lst
                      from( 
                            select c.amount_from
                                  ,max(c.interest_rate) keep (dense_rank first order by o.valid_from desc) interest_rate
                                  ,max(c.apply_to_first) keep (dense_rank first order by o.valid_from desc) apply_bonus_prolongation
                              from option_ o
                                  ,deposit_prolongation c
                             where o.option_id = c.interest_option_id
                               and c.currency_id = p_currency_id
                            group by c.amount_from) x
               ) loop
            l_dict.numberprolongation     := i.amount_from;
            l_dict.interest_rate          := i.interest_rate;
            l_dict.ApplyBonusProlongation := i.apply_bonus_prolongation;
            l_dict.name_                  := i.lst;   
            pipe row(l_dict);
        end loop; 
        return;                      
    end; 

    function get_tranche_lock_type_list return t_lookup pipelined
     is
        l_qty number := 0;     
    begin
        -- добавил для поиска ошибки на стороне заказчика (???)
        logger.log_info(p_procedure_name => $$plsql_unit||'.get_tranche_lock_type_list start',
                        p_log_message    => null
                        );
        for i in (
                    select t_lookup_item(
                                    item_id   => li.list_item_id
                                   ,item_code => li.list_item_code
                                   ,item_name => li.list_item_name) lst        
                      from list_type lt
                          ,list_item li  
                     where lt.list_code = smb_deposit_utl.DEPOSIT_TRANCHE_LOCK_TYPE
                       and lt.id = li.list_type_id) loop
            pipe row(i.lst);
            l_qty := l_qty + 1;
        end loop;                       
        logger.log_info(p_procedure_name => $$plsql_unit||'.get_tranche_lock_type_list end',
                        p_log_message    => 'amount : ' || l_qty
                        );
        return;                
    end; 

    -- тип начислени % для ДпТ    
    function get_calculation_type_list(p_date in date default null) 
          return t_lookup pipelined
     is
    begin
        for i in (
                    select t_lookup_item(
                                    item_id   => li.list_item_id
                                   ,item_code => li.list_item_code
                                   ,item_name => li.list_item_name) lst        
                      from list_type lt
                          ,list_item li  
                     where lt.list_code = smb_deposit_utl.CALC_TYPE_DOD_CODE
                       and lt.id = li.list_type_id) loop
            pipe row(i.lst);           
        end loop; 
        return;                      
    end; 

    -- тип начислени % для ДпТ справочник с +1 запись   
    function get_calculation_type_dict return t_lookup pipelined
     is
    begin
        for i in (  select t_lookup_item(
                                    item_id   => 0
                                   ,item_code => 'CALC_TYPE_ALL'
                                   ,item_name => 'Довільний метод нарахування') lst
                      from dual                   
                    union all                   
                    select t_lookup_item(
                                    item_id   => li.list_item_id
                                   ,item_code => li.list_item_code
                                   ,item_name => li.list_item_name) lst        
                      from list_type lt
                          ,list_item li  
                     where lt.list_code = smb_deposit_utl.CALC_TYPE_DOD_CODE
                       and lt.id = li.list_type_id) loop
            pipe row(i.lst);           
        end loop;
        return;                       
    end; 

             
    function get_tranche_product return number
     is
        l_row_object object_type%rowtype;
    begin
        l_row_object := object_utl.read_object_type(smb_deposit_utl.TRANCHE_OBJECT_TYPE_CODE);
        return product_utl.read_product(
                                p_product_type_id => l_row_object.id
                               ,p_product_code    => smb_deposit_utl.TRANCHE_PRODUCT_CODE).id;
    end get_tranche_product; 
    
    function get_on_demand_product return number
     is
        l_row_object object_type%rowtype;
    begin
        l_row_object := object_utl.read_object_type(smb_deposit_utl.ON_DEMAND_OBJECT_TYPE_CODE);
        return product_utl.read_product(
                                p_product_type_id => l_row_object.id
                               ,p_product_code    => smb_deposit_utl.ON_DEMAND_PRODUCT_CODE).id;
    end get_on_demand_product;
    
    function get_types 
        return string_list
     is
    begin    
        return string_list(
                   smb_deposit_utl.GENERAL_TYPE
                  ,smb_deposit_utl.BONUS_TYPE          
                  ,smb_deposit_utl.PROLONGATION_TYPE
                  ,smb_deposit_utl.CAPITALIZATION_TYPE 
                  ,smb_deposit_utl.PAYMENT_TYPE 
                  ,smb_deposit_utl.PENALTY_RATE_TYPE
                  ,smb_deposit_utl.AMOUNT_SETTING_TYPE
                  ,smb_deposit_utl.REPLENISHMENT_TRANCHE_TYPE 
                  ,smb_deposit_utl.REPLENISHMENT_TYPE
                  ,smb_deposit_utl.PROLONGATION_BONUS_TYPE
                  ,smb_deposit_utl.RATE_FOR_BLOCKED_TRANCHE_TYPE
                  );
    end;                                    

    function check_type(p_type varchar2) return varchar2
     is
    begin
       return case when p_type member of get_types() 
                   then p_type 
              end;
    end; 
    
    function get_types_xml return clob
     is
        l_data clob;
    begin
        select xmlelement("ROOT",
                xmlelement("TYPES",
                xmlagg(
                    xmlelement("TYPE",
                      xmlforest(
                         t.id
                        ,t.object_type_id 
                        ,t.type_code
                        ,t.type_name )  
                             ) 
                        )  ) ).getClobVal()
          into l_data               
          from deal_interest_rate_type t
        order by t.id ;
        return l_data;
    end get_types_xml; 
    
    function get_kinds_xml return clob
     is
        l_data clob;
    begin
        select xmlelement("ROOT",
                xmlelement("KINDS",
                  xmlagg(
                    xmlelement("KIND",
                      xmlforest(
                         t.type_code
                        ,t.type_name
                        ,k.id
                        ,k.type_id
                        ,k.kind_code
                        ,k.kind_name
                        ,k.is_active ))))).getClobVal()
          into l_data               
          from deal_interest_rate_type t
             ,deal_interest_rate_kind k
         where t.id = k.type_id     
        order by t.id ;
        return l_data;
    end get_kinds_xml;
    
    function get_options_xml return clob
     is
        l_data clob;
    begin
        select xmlelement("ROOT",
                xmlelement("KINDS",
                  xmlagg(
                    xmlelement("KIND",
                      xmlforest(
                         t.type_code
                        ,t.type_name
                        ,k.id
                        ,k.type_id
                        ,k.kind_code
                        ,k.kind_name
                        ,k.is_active
                        ,xmlagg(
                           xmlelement("OPTION",
                            xmlforest(
                               d.id ID
                              ,d.product_id
                              ,d.rate_kind_id
                              ,to_char(d.valid_from, 'yyyy-mm-dd') valid_from 
                              ,to_char(d.valid_through, 'yyyy-mm-dd') valid_through
                              ,d.is_active
                              ,d.option_description
                              ,d.user_id
                              ,to_char(d.sys_time, 'yyyy-mm-dd"T"hh24:mi:ss') sys_time
                              )) order by d.valid_from desc) "OPTIONS")
                        )))).getClobVal()
          into l_data              
          from deal_interest_rate_type t
              ,deal_interest_rate_kind k
              ,deal_interest_option d
         where t.id = k.type_id
           and d.rate_kind_id = k.id 
        group by t.type_code 
                ,t.type_name
                ,k.id
                ,k.type_id
                ,k.kind_code
                ,k.kind_name
                ,k.is_active
        order by t.id;      
        return l_data;
    end get_options_xml; 
    
    function get_data_xml(p_type       in varchar2 default null
                         ,p_option_id  in number   default null) return clob
     is
    begin
        return ROOT_TAG_OPEN ||
               case when p_type = smb_deposit_utl.GENERAL_TYPE or p_type is null then  
                  get_general_xml(p_option_id => p_option_id)
               end ||
               case when p_type = smb_deposit_utl.BONUS_TYPE or p_type is null then
                  get_bonus_xml(p_option_id => p_option_id)
               end ||
               case when p_type = smb_deposit_utl.PAYMENT_TYPE or p_type is null then
                  get_payment_xml(p_option_id => p_option_id)  
               end ||
               case when p_type = smb_deposit_utl.CAPITALIZATION_TYPE or p_type is null then
                  get_capitalization_xml(p_option_id => p_option_id)  
               end ||
               case when p_type = smb_deposit_utl.PROLONGATION_TYPE or p_type is null then
                  get_prolongation_xml(p_option_id => p_option_id)
               end ||
               case when p_type = smb_deposit_utl.PENALTY_RATE_TYPE or p_type is null then
                  get_penalty_rates_xml(p_option_id => p_option_id)
               end ||
               case when p_type = smb_deposit_utl.AMOUNT_SETTING_TYPE or p_type is null then
                  get_deposit_amount_setting_xml(p_option_id => p_option_id)
               end ||
               case when p_type = smb_deposit_utl.REPLENISHMENT_TRANCHE_TYPE or p_type is null then
                  get_replenishment_tranche_xml(p_option_id => p_option_id)
               end ||
               case when p_type = smb_deposit_utl.REPLENISHMENT_TYPE or p_type is null then
                  get_replenishment_xml(p_option_id => p_option_id)
               end ||
               case when p_type = smb_deposit_utl.PROLONGATION_BONUS_TYPE or p_type is null then
                  get_prolongation_bonus_xml(p_option_id => p_option_id)
               end ||
               case when p_type = smb_deposit_utl.RATE_FOR_BLOCKED_TRANCHE_TYPE or p_type is null then
                  get_rate_for_blocked_trn_xml(p_option_id => p_option_id)
               end ||
               ROOT_TAG_CLOSE;
    end get_data_xml; 
    
    procedure set_data(p_data      in clob
                      ,p_type      in varchar2
                      ,p_error     out varchar2
                      ,p_option_id out number)
     is
      l_types      string_list;
      l_data       tt_deposit_option;
      l_limit      number := 500;
    begin
        logger.log_info(p_procedure_name => $$plsql_unit||'.set_data',
                        p_log_message    => 'p_option_id : ' || p_option_id
                       ,p_object_id      => null
                       ,p_auxiliary_info => p_data
                        );

        p_error := null;    
        l_types := case when check_type(p_type) is not null 
                        then string_list(p_type)
                        else get_types
                   end;
        for i in 1..l_types.count() loop
            savepoint save_data; 
            open c_get_data(p_type => l_types(i), p_data => p_data);
            loop
               fetch c_get_data
               bulk collect into l_data limit l_limit;
               exit when l_data.count = 0;
               set_option(p_deposit_option => l_data
                         ,p_type           => l_types(i)
                         ,p_option_id      => p_option_id);
            end loop;
            close c_get_data;
        end loop;
        logger.log_info(p_procedure_name => $$plsql_unit||'.set_data (finished)',
                        p_log_message    => 'p_option_id : ' || p_option_id
                       ,p_object_id      => null
                        );
    exception
        when others then
           rollback to save_data;
           close c_get_data;
           if sqlcode = -00001 then
              p_error := 'Данные с такими значениями уже существуют.'||chr(10);
           end if;
           p_error := p_error||sqlerrm||' '||dbms_utility.format_error_backtrace;     
    end set_data; 
    
    function get_xml_by_type(p_type            in varchar2
                            ,p_option_id       in number default null
                            ,p_is_wrap_to_root in number default 0)
         return clob
     is
        l_clob clob; 
    begin
        if check_type(p_type) is not null then
            open c_data_xml(p_type_code => p_type
                           ,p_option_id => p_option_id);
            fetch c_data_xml into l_clob;
            close c_data_xml;
        end if;
        return case when p_is_wrap_to_root = 1 then ROOT_TAG_OPEN end|| 
               l_clob ||
               case when p_is_wrap_to_root = 1 then ROOT_TAG_CLOSE end;
    exception
        when others then
         close c_data_xml;
         raise;              
    end;
    
    function get_general_xml(p_option_id       in number default null
                            ,p_is_wrap_to_root in number default 0) 
         return clob 
     is
    begin
        return get_xml_by_type(p_type            => smb_deposit_utl.GENERAL_TYPE
                              ,p_option_id       => p_option_id 
                              ,p_is_wrap_to_root => p_is_wrap_to_root);
    end get_general_xml;

    function get_bonus_xml(p_option_id       in number default null
                          ,p_is_wrap_to_root in number default 0) 
         return clob 
     is
    begin
        return get_xml_by_type(p_type            => smb_deposit_utl.BONUS_TYPE
                              ,p_option_id       => p_option_id 
                              ,p_is_wrap_to_root => p_is_wrap_to_root);
    end get_bonus_xml;

    function get_payment_xml(p_option_id       in number default null
                            ,p_is_wrap_to_root in number default 0) 
         return clob 
     is
    begin
        return get_xml_by_type(p_type            => smb_deposit_utl.PAYMENT_TYPE
                              ,p_option_id       => p_option_id 
                              ,p_is_wrap_to_root => p_is_wrap_to_root);
    end get_payment_xml;

    function get_capitalization_xml(p_option_id       in number default null
                                   ,p_is_wrap_to_root in number default 0) 
         return clob 
     is
    begin
        return get_xml_by_type(p_type            => smb_deposit_utl.CAPITALIZATION_TYPE
                              ,p_option_id       => p_option_id 
                              ,p_is_wrap_to_root => p_is_wrap_to_root);
    end get_capitalization_xml;

    function get_prolongation_xml(p_option_id       in number default null
                                 ,p_is_wrap_to_root in number default 0) 
         return clob 
     is
    begin
        return get_xml_by_type(p_type            => smb_deposit_utl.PROLONGATION_TYPE
                              ,p_option_id       => p_option_id 
                              ,p_is_wrap_to_root => p_is_wrap_to_root);
    end get_prolongation_xml;

    function get_prolongation_bonus_xml(p_option_id       in number default null
                                       ,p_is_wrap_to_root in number default 0) 
         return clob 
     is
    begin
        return get_xml_by_type(p_type            => smb_deposit_utl.PROLONGATION_BONUS_TYPE
                              ,p_option_id       => p_option_id 
                              ,p_is_wrap_to_root => p_is_wrap_to_root);
    end get_prolongation_bonus_xml;

    function get_replenishment_xml(p_option_id       in number default null
                                  ,p_is_wrap_to_root in number default 0) 
         return clob 
     is
    begin
        return get_xml_by_type(p_type            => smb_deposit_utl.REPLENISHMENT_TYPE
                              ,p_option_id       => p_option_id 
                              ,p_is_wrap_to_root => p_is_wrap_to_root);
    end get_replenishment_xml;

    function get_penalty_rates_xml(p_option_id       in number default null
                                  ,p_is_wrap_to_root in number default 0) 
         return clob 
     is
    begin
        return get_xml_by_type(p_type            => smb_deposit_utl.PENALTY_RATE_TYPE
                              ,p_option_id       => p_option_id 
                              ,p_is_wrap_to_root => p_is_wrap_to_root);
    end get_penalty_rates_xml;

    function get_rate_for_blocked_trn_xml(p_option_id       in number default null
                                         ,p_is_wrap_to_root in number default 0) 
         return clob 
     is
    begin
        return get_xml_by_type(p_type            => smb_deposit_utl.RATE_FOR_BLOCKED_TRANCHE_TYPE
                              ,p_option_id       => p_option_id 
                              ,p_is_wrap_to_root => p_is_wrap_to_root);
    end get_rate_for_blocked_trn_xml;


    function get_deposit_amount_setting_xml(p_option_id       in number default null
                                           ,p_is_wrap_to_root in number default 0) 
         return clob
     is
    begin
        return get_xml_by_type(p_type            => smb_deposit_utl.AMOUNT_SETTING_TYPE
                              ,p_option_id       => p_option_id 
                              ,p_is_wrap_to_root => p_is_wrap_to_root);
    end get_deposit_amount_setting_xml;      


    function get_replenishment_tranche_xml(p_option_id       in number default null
                                          ,p_is_wrap_to_root in number default 0) 
         return clob
     is
    begin
        return get_xml_by_type(p_type            => smb_deposit_utl.REPLENISHMENT_TRANCHE_TYPE
                              ,p_option_id       => p_option_id 
                              ,p_is_wrap_to_root => p_is_wrap_to_root);
    end get_replenishment_tranche_xml; 

    -- сохранить историю
    procedure set_hist_condition(
                  p_kind_id         in number
                 ,p_option_id       in number
                 ,p_condition_id    in number
                 ,p_deposit_option  in tt_deposit_option default null
                 ,p_oper_type       in varchar2 -- 'I' insert 'U' - update
                                )
     is
        l_id               number;
        l_local_bank_date  date := coalesce(gl.bd, glb_bankdate);
        l_global_bank_date date := glb_bankdate;
        l_user_id          number; 
        l_kind_row         deal_interest_rate_kind%rowtype;
    begin
        l_kind_row := smb_deposit_utl.read_deal_interest_rate_kind(p_deal_interest_rate_kind_id => p_kind_id);
        l_id := smb_deposit_condition_log_seq.nextval;
        l_user_id := user_id();
        insert into smb_deposit_condition_log(
                    id, 
                    rate_kind_id, 
                    option_id, 
                    condition_id, 
                    operation_type, 
                    condition_data, 
                    local_bank_date, 
                    global_bank_date, 
                    user_id, 
                    sys_time)
        with dpt_data as (
             select x.*, p_option_id option$id, p_condition_id condition$id
                from table(p_deposit_option) x)
        select l_id
              ,p_kind_id
              ,p_option_id
              ,p_condition_id
              ,p_oper_type
              ,'<ROOT>'||x.condition_data||'</ROOT>'
              ,l_local_bank_date
              ,l_global_bank_date
              ,l_user_id
              ,sysdate
         from( 
              select '<OPTION>'||
                     xmlforest(
                         to_char(o.valid_from, 'yyyy-mm-dd') valid_from 
                        ,to_char(o.valid_through, 'yyyy-mm-dd') valid_through
                        ,o.is_active
                        ,o.option_description)||
                     '</OPTION>' condition_data
                -- обработка deal_interest_option o        
                from dpt_data o
               where o.option$id = p_option_id 
                 and p_condition_id is null
              union all
              -- interest_rate_condition
              select '<CONDITION>'||
                     -- так как xmlforest не генерит поля с null, то будут записаны поля только с данными
                     xmlforest( x.currency_id              
                               ,x.term_unit                
                               ,x.term_from                
                               ,x.amount_from              
                               ,x.interest_rate            
                               ,x.payment_term_id          
                               ,x.apply_to_first           
                               ,x.rate_from                
                               ,x.penalty_rate             
                               ,x.min_sum_tranche          
                               ,x.max_sum_tranche          
                               ,x.min_replenishment_amount 
                               ,x.max_replenishment_amount 
                               ,x.tranche_term             
                               ,x.days_to_close_replenish  
                               ,x.product_id               
                               ,x.calculation_type_id      
                               ,x.is_replenishment)||
                     '</CONDITION>' condition_data  
                from dpt_data o
                    ,table(o.list_condition) x
               where o.option$id = p_option_id 
                 and o.condition$id = p_condition_id
                 and p_condition_id is not null) x; 
    end;                            

    procedure set_interest_option (
            p_id                  in out number
           ,p_product_id          in     number
           ,p_rate_kind_id        in     number
           ,p_valid_from          in     date
           ,p_valid_through       in     date  
           ,p_is_active           in     number default 1
           ,p_option_description  in     varchar2
           ,p_user_id             in     number
           ,p_deposit_option      in     tt_deposit_option default null
           )
     is
        l_row        deal_interest_option%rowtype;
        l_oper_type  varchar2(1);
    begin
        if p_id is null then
             l_oper_type := 'I';
             p_id := deal_interest_option_seq.nextVal;
             insert into deal_interest_option (id, product_id, rate_kind_id, valid_from, valid_through, is_active, option_description, user_id )
             values(p_id, coalesce(p_product_id, get_tranche_product()), p_rate_kind_id, p_valid_from, p_valid_through, nvl(p_is_active, 1), p_option_description, p_user_id);
        else
           select *
             into l_row     
             from deal_interest_option
            where id = p_id;
           if tools.compare(l_row.valid_from, p_valid_from) <> 0 or
              tools.compare(l_row.valid_through, p_valid_through) <> 0 or
              tools.compare(l_row.is_active, p_is_active) <> 0 or
              tools.compare(l_row.option_description, p_option_description) <> 0 then
               update deal_interest_option o set
                    product_id          = coalesce(p_product_id, get_tranche_product())
                   ,rate_kind_id        = p_rate_kind_id
                   ,valid_from          = p_valid_from
                   ,valid_through       = p_valid_through
                   ,is_active           = p_is_active
                   ,option_description  = p_option_description
                   ,user_id             = p_user_id
                   ,sys_time            = sysdate
                where o.id = p_id;
               l_oper_type := 'U'; 
           end if; 
        end if;   
        if l_oper_type is not null then
             set_hist_condition(
                  p_kind_id         => p_rate_kind_id
                 ,p_option_id       => p_id
                 ,p_condition_id    => null
                 ,p_deposit_option  => p_deposit_option
                 ,p_oper_type       => l_oper_type
                 );
        end if;         

    end set_interest_option;
    
    procedure set_interest_condition(
                    p_id                  in number
                   ,p_interest_option_id  in number                
                   ,p_currency_id         in number
                   ,p_term_unit           in number
                   ,p_term_from           in number
                   ,p_amount_from         in number
                   ,p_interest_rate       in number
                   ,p_deposit_option      in tt_deposit_option default null)
     is
        l_row       interest_rate_condition%rowtype;
        l_oper_type varchar2(1);
    begin
        if p_id is null then  
            l_oper_type := 'I';           
            l_row.id := deal_interest_option_seq.nextVal;
            insert into interest_rate_condition(id, interest_option_id, currency_id, term_unit, term_from, amount_from, interest_rate)
            values (l_row.id, p_interest_option_id, p_currency_id, p_term_unit
                   ,p_term_from, p_amount_from, p_interest_rate);
        else
           select *
             into l_row
             from interest_rate_condition
            where id = p_id;
           if tools.compare(l_row.currency_id, p_currency_id) <> 0 or
              tools.compare(l_row.term_unit, p_term_unit) <> 0 or
              tools.compare(l_row.term_from, p_term_from) <> 0 or
              tools.compare(l_row.amount_from, p_amount_from) <> 0 or
              tools.compare(l_row.interest_rate, p_interest_rate) <> 0 then
                update interest_rate_condition ir set 
                     interest_option_id = p_interest_option_id                
                    ,currency_id        = p_currency_id
                    ,term_unit          = p_term_unit
                    ,term_from          = p_term_from
                    ,amount_from        = p_amount_from
                    ,interest_rate      = p_interest_rate
                 where ir.id = p_id;
                l_oper_type := 'U';
           end if;     
        end if;            
        if l_oper_type is not null then    
            set_hist_condition(
                  p_kind_id         => case when p_deposit_option is not null then p_deposit_option(1).rate_kind_id end
                 ,p_option_id       => p_interest_option_id
                 ,p_condition_id    => l_row.id
                 ,p_deposit_option  => p_deposit_option
                 ,p_oper_type       => l_oper_type
                 );
        end if;         
    end set_interest_condition;                            

    procedure set_payment(
                p_id                  in number
               ,p_interest_option_id  in number
               ,p_currency_id         in number                
               ,p_payment_term_id     in number
               ,p_interest_rate       in number
               ,p_deposit_option      in tt_deposit_option default null
               )
     is
        l_row       deposit_payment%rowtype;  
        l_oper_type varchar2(1);     
    begin
        if p_id is null then  
           l_oper_type := 'I';
           l_row.id := deal_interest_option_seq.nextVal;
           insert into deposit_payment(id, interest_option_id, currency_id, payment_term_id, interest_rate)
            values (l_row.id, p_interest_option_id, p_currency_id, p_payment_term_id, p_interest_rate);
        else
           select *
             into l_row     
             from deposit_payment
            where id = p_id;
           if tools.compare(l_row.currency_id, p_currency_id) <> 0 or
              tools.compare(l_row.payment_term_id, p_payment_term_id) <> 0 or
              tools.compare(l_row.interest_rate, p_interest_rate) <> 0 then
               update deposit_payment p set 
                 interest_option_id = p_interest_option_id
                ,currency_id        = p_currency_id      
                ,payment_term_id    = p_payment_term_id
                ,interest_rate      = p_interest_rate
               where p.id = p_id;
               l_oper_type := 'U';
           end if;
        end if;                
        if l_oper_type is not null then    
            set_hist_condition(
                  p_kind_id         => case when p_deposit_option is not null then p_deposit_option(1).rate_kind_id end
                 ,p_option_id       => p_interest_option_id
                 ,p_condition_id    => l_row.id
                 ,p_deposit_option  => p_deposit_option
                 ,p_oper_type       => l_oper_type
                 );
        end if;         
    end set_payment;

    procedure set_capitalization(
                p_id                  in number
               ,p_interest_option_id  in number
               ,p_currency_id         in number                
               ,p_payment_term_id     in number
               ,p_interest_rate       in number
               ,p_deposit_option      in tt_deposit_option default null
               )
     is
        l_row       deposit_capitalization%rowtype;
        l_oper_type varchar2(1); 
    begin
        if p_id is null then  
           l_oper_type := 'I';
           l_row.id := deal_interest_option_seq.nextVal;
           insert into deposit_capitalization(id, interest_option_id, currency_id, payment_term_id, interest_rate)
            values (l_row.id, p_interest_option_id, p_currency_id, p_payment_term_id, p_interest_rate);
        else
           select *
             into l_row
             from deposit_capitalization
            where id = p_id; 
           if tools.compare(l_row.currency_id, p_currency_id) <> 0 or
              tools.compare(l_row.payment_term_id, p_payment_term_id) <> 0 or
              tools.compare(l_row.interest_rate, p_interest_rate) <> 0 then
               update deposit_capitalization p set 
                 interest_option_id = p_interest_option_id
                ,currency_id        = p_currency_id      
                ,payment_term_id    = p_payment_term_id
                ,interest_rate      = p_interest_rate
               where p.id = p_id;
               l_oper_type := 'U';
           end if;
        end if;                
        if l_oper_type is not null then    
            set_hist_condition(
                  p_kind_id         => case when p_deposit_option is not null then p_deposit_option(1).rate_kind_id end
                 ,p_option_id       => p_interest_option_id
                 ,p_condition_id    => l_row.id
                 ,p_deposit_option  => p_deposit_option
                 ,p_oper_type       => l_oper_type
                 );
        end if;         
    end set_capitalization;

    procedure set_replenishment(
                p_id                  in number
               ,p_interest_option_id  in number
               ,p_currency_id         in number                
               ,p_interest_rate       in number
               ,p_is_replenishment    in number
               ,p_deposit_option      in tt_deposit_option default null
               )
     is
        l_row       deposit_replenishment%rowtype;
        l_oper_type varchar2(1); 
    begin
        if p_id is null then  
           l_oper_type := 'I';
           l_row.id := deal_interest_option_seq.nextVal;
           insert into deposit_replenishment(id, interest_option_id, currency_id, interest_rate, is_replenishment)
            values (l_row.id, p_interest_option_id, p_currency_id, p_interest_rate, p_is_replenishment);
        else
           select *
             into l_row     
             from deposit_replenishment
            where id = p_id; 
           if tools.compare(l_row.currency_id, p_currency_id) <> 0 or
              tools.compare(l_row.interest_rate, p_interest_rate) <> 0 or
              tools.compare(l_row.is_replenishment, p_is_replenishment) <> 0 then
               update deposit_replenishment p set 
                 interest_option_id = p_interest_option_id
                ,currency_id        = p_currency_id      
                ,interest_rate      = p_interest_rate
                ,is_replenishment   = p_is_replenishment
               where p.id = p_id;
               l_oper_type := 'U';
           end if;
        end if;
        if l_oper_type is not null then    
            set_hist_condition(
                  p_kind_id         => case when p_deposit_option is not null then p_deposit_option(1).rate_kind_id end
                 ,p_option_id       => p_interest_option_id
                 ,p_condition_id    => l_row.id
                 ,p_deposit_option  => p_deposit_option
                 ,p_oper_type       => l_oper_type
                 );
        end if;         
    end set_replenishment;

    procedure set_prolongation(
                p_id                  in number
               ,p_interest_option_id  in number
               ,p_currency_id         in number                
               ,p_amount_from         in number
               ,p_interest_rate       in number
               ,p_apply_to_first      in number
               ,p_deposit_option      in tt_deposit_option default null
               )
     is
        l_row       deposit_prolongation%rowtype;
        l_oper_type varchar2(1); 
    begin
        if p_id is null then
           l_oper_type := 'I';
           l_row.id    := deal_interest_option_seq.nextVal;  
           insert into deposit_prolongation(id, interest_option_id, currency_id, amount_from, interest_rate, apply_to_first)
            values (l_row.id, p_interest_option_id, p_currency_id, p_amount_from, p_interest_rate, p_apply_to_first);
        else
           select *
             into l_row
             from deposit_prolongation 
            where id = p_id; 
           if tools.compare(l_row.currency_id, p_currency_id) <> 0 or
              tools.compare(l_row.amount_from, p_amount_from) <> 0 or
              tools.compare(l_row.interest_rate, p_interest_rate) <> 0 or
              tools.compare(l_row.apply_to_first, p_apply_to_first) <> 0 then
               update deposit_prolongation p set 
                 interest_option_id = p_interest_option_id
                ,currency_id        = p_currency_id      
                ,amount_from        = p_amount_from
                ,interest_rate      = p_interest_rate
                ,apply_to_first     = p_apply_to_first
               where p.id = p_id;
               l_oper_type := 'U';
           end if;    
        end if;                
        if l_oper_type is not null then    
            set_hist_condition(
                  p_kind_id         => case when p_deposit_option is not null then p_deposit_option(1).rate_kind_id end
                 ,p_option_id       => p_interest_option_id
                 ,p_condition_id    => l_row.id
                 ,p_deposit_option  => p_deposit_option
                 ,p_oper_type       => l_oper_type
                 );
        end if;         
    end set_prolongation;

    procedure set_prolongation_bonus(
                p_id                  in number
               ,p_interest_option_id  in number
               ,p_currency_id         in number                
               ,p_is_prolongation     in number
               ,p_interest_rate       in number
               ,p_deposit_option      in tt_deposit_option default null
               )
     is
        l_row       deposit_prolongation_bonus%rowtype;
        l_oper_type varchar2(1); 
    begin
        if p_id is null then
           l_oper_type := 'I';
           l_row.id    := deal_interest_option_seq.nextVal;  
           insert into deposit_prolongation_bonus(id, interest_option_id, currency_id, is_prolongation, interest_rate)
            values (l_row.id, p_interest_option_id, p_currency_id, p_is_prolongation, p_interest_rate);
        else
           select *
             into l_row
             from deposit_prolongation_bonus 
            where id = p_id; 
           if tools.compare(l_row.currency_id, p_currency_id) <> 0 or
              tools.compare(l_row.is_prolongation, p_is_prolongation) <> 0 or
              tools.compare(l_row.interest_rate, p_interest_rate) <> 0 then
               update deposit_prolongation_bonus p set 
                 interest_option_id = p_interest_option_id
                ,currency_id        = p_currency_id      
                ,is_prolongation        = p_is_prolongation
                ,interest_rate      = p_interest_rate
               where p.id = p_id;
               l_oper_type := 'U';
           end if;    
        end if;                
        if l_oper_type is not null then    
            set_hist_condition(
                  p_kind_id         => case when p_deposit_option is not null then p_deposit_option(1).rate_kind_id end
                 ,p_option_id       => p_interest_option_id
                 ,p_condition_id    => l_row.id
                 ,p_deposit_option  => p_deposit_option
                 ,p_oper_type       => l_oper_type
                 );
        end if;         
    end set_prolongation_bonus;

    procedure set_penalty_rate(
                p_id                  in number
               ,p_interest_option_id  in number
               ,p_currency_id         in number                
               ,p_rate_from           in number
               ,p_penalty_rate        in number
               ,p_deposit_option      in tt_deposit_option default null
               )
     is
        l_row       rate_for_return_tranche%rowtype;
        l_oper_type varchar2(1); 
    begin
        if p_id is null then  
           l_oper_type := 'I';
           l_row.id    := deal_interest_option_seq.nextVal;
           insert into rate_for_return_tranche(id, interest_option_id, currency_id, rate_from, penalty_rate)
            values (l_row.id, p_interest_option_id, p_currency_id, p_rate_from, p_penalty_rate);
        else
           select *
             into l_row
             from rate_for_return_tranche
            where id = p_id; 
           if tools.compare(l_row.currency_id, p_currency_id) <> 0 or
              tools.compare(l_row.rate_from, p_rate_from) <> 0 or
              tools.compare(l_row.penalty_rate, p_penalty_rate) <> 0 then
               update rate_for_return_tranche p set 
                 interest_option_id = p_interest_option_id
                ,currency_id        = p_currency_id      
                ,rate_from          = p_rate_from
                ,penalty_rate       = p_penalty_rate
               where p.id = p_id;
               l_oper_type := 'U';
           end if;    
        end if;                
        if l_oper_type is not null then    
            set_hist_condition(
                  p_kind_id         => case when p_deposit_option is not null then p_deposit_option(1).rate_kind_id end
                 ,p_option_id       => p_interest_option_id
                 ,p_condition_id    => l_row.id
                 ,p_deposit_option  => p_deposit_option
                 ,p_oper_type       => l_oper_type
                 );
        end if;         
    end set_penalty_rate;

    procedure set_rate_for_blocked_tranche(
                p_id                  in number
               ,p_interest_option_id  in number
               ,p_currency_id         in number                
               ,p_interest_rate       in number
               ,p_deposit_option      in tt_deposit_option default null
               )
     is
        l_row       rate_for_blocked_tranche%rowtype;
        l_oper_type varchar2(1); 
    begin
        if p_id is null then  
           l_oper_type := 'I';
           l_row.id    := deal_interest_option_seq.nextVal;
           insert into rate_for_blocked_tranche(id, interest_option_id, currency_id, interest_rate)
            values (l_row.id, p_interest_option_id, p_currency_id, p_interest_rate);
        else
           select *
             into l_row
             from rate_for_blocked_tranche
            where id = p_id; 
           if tools.compare(l_row.currency_id, p_currency_id) <> 0 or
              tools.compare(l_row.interest_rate, p_interest_rate) <> 0 then
               update rate_for_blocked_tranche p set 
                 interest_option_id = p_interest_option_id
                ,currency_id        = p_currency_id      
                ,interest_rate      = p_interest_rate
               where p.id = p_id;
               l_oper_type := 'U';
           end if;    
        end if;                
        if l_oper_type is not null then    
            set_hist_condition(
                  p_kind_id         => case when p_deposit_option is not null then p_deposit_option(1).rate_kind_id end
                 ,p_option_id       => p_interest_option_id
                 ,p_condition_id    => l_row.id
                 ,p_deposit_option  => p_deposit_option
                 ,p_oper_type       => l_oper_type
                 );
        end if;         
    end set_rate_for_blocked_tranche;

    procedure set_amount_setting(
                p_id                       in number
               ,p_interest_option_id       in number
               ,p_currency_id              in number
               ,p_min_sum_tranche          in number
               ,p_max_sum_tranche          in number
               ,p_min_replenishment_amount in number
               ,p_max_replenishment_amount in number
               ,p_deposit_option      in tt_deposit_option default null
               )
     is
        l_row       deposit_amount_setting%rowtype;
        l_oper_type varchar2(1); 
    begin
        if p_id is null then  
           l_oper_type := 'I';
           l_row.id    := deal_interest_option_seq.nextVal;
           insert into deposit_amount_setting(id, interest_option_id, currency_id, min_sum_tranche, max_sum_tranche, 
                                              min_replenishment_amount, max_replenishment_amount)
            values (l_row.id, p_interest_option_id, p_currency_id,
                    p_min_sum_tranche, p_max_sum_tranche, p_min_replenishment_amount, p_max_replenishment_amount);
        else
           select *
             into l_row
            from deposit_amount_setting         
           where id = p_id;
           if tools.compare(l_row.currency_id, p_currency_id) <> 0 or
              tools.compare(l_row.min_sum_tranche, p_min_sum_tranche) <> 0 or
              tools.compare(l_row.max_sum_tranche, p_max_sum_tranche) <> 0 or
              tools.compare(l_row.min_replenishment_amount, p_min_replenishment_amount) <> 0 or
              tools.compare(l_row.max_replenishment_amount, p_max_replenishment_amount ) <> 0 then
               update deposit_amount_setting p set 
                    interest_option_id       = p_interest_option_id
                   ,currency_id              = p_currency_id
                   ,min_sum_tranche          = p_min_sum_tranche 
                   ,max_sum_tranche          = p_max_sum_tranche 
                   ,min_replenishment_amount = p_min_replenishment_amount 
                   ,max_replenishment_amount = p_max_replenishment_amount 
               where p.id = p_id;
               l_oper_type := 'U';
           end if;    
        end if;                
        if l_oper_type is not null then    
            set_hist_condition(
                  p_kind_id         => case when p_deposit_option is not null then p_deposit_option(1).rate_kind_id end
                 ,p_option_id       => p_interest_option_id
                 ,p_condition_id    => l_row.id
                 ,p_deposit_option  => p_deposit_option
                 ,p_oper_type       => l_oper_type
                 );
        end if;         
    end set_amount_setting;

    procedure set_replenishment_tranche(
                p_id                       in number
               ,p_interest_option_id       in number
               ,p_tranche_term             in number
               ,p_days_to_close_replenish  in number
               ,p_deposit_option           in tt_deposit_option default null
               )
     is
        l_row       terms_replenishment_tranche%rowtype;       
        l_oper_type varchar2(1);
    begin
        if p_id is null then  
           l_oper_type := 'I';
           l_row.id    := deal_interest_option_seq.nextVal;
           insert into terms_replenishment_tranche(id, interest_option_id, tranche_term, days_to_close_replenish)
            values (l_row.id, p_interest_option_id, p_tranche_term, p_days_to_close_replenish);
        else
           select * 
             into l_row  
             from terms_replenishment_tranche
            where id = p_id;
           if l_row.tranche_term <> round(p_tranche_term) or
              l_row.days_to_close_replenish <> round(p_days_to_close_replenish) then   
               update terms_replenishment_tranche p set 
                    interest_option_id       = p_interest_option_id
                   ,tranche_term             = round(p_tranche_term)
                   ,days_to_close_replenish  = round(p_days_to_close_replenish)
               where p.id = p_id;
               l_oper_type := 'U';
           end if;    
        end if;                
        if l_oper_type is not null then    
            set_hist_condition(
                  p_kind_id         => case when p_deposit_option is not null then p_deposit_option(1).rate_kind_id end
                 ,p_option_id       => p_interest_option_id
                 ,p_condition_id    => l_row.id
                 ,p_deposit_option  => p_deposit_option
                 ,p_oper_type       => l_oper_type
                 );
        end if;         
    end set_replenishment_tranche;
    
    
    procedure set_option(p_deposit_option in  tt_deposit_option
                        ,p_type           in  varchar2
                        ,p_option_id      out number  )
     is
        l_user_id   number;
        l_option_id number;
        l_dpt_data  tt_deposit_option;
    begin
        l_user_id := sys_context('bars_global','user_id');
        for i in 1..p_deposit_option.count() loop 
            l_option_id := p_deposit_option(i).id;
            if p_deposit_option(i).valid_from is null and 
               p_deposit_option(i).valid_through is null and
               p_deposit_option(i).is_active is null 
               then
              continue;
            end if;
            l_dpt_data := tt_deposit_option(p_deposit_option(i));
            set_interest_option(
                            p_id                       => l_option_id
                           ,p_product_id               => p_deposit_option(i).product_id
                           ,p_rate_kind_id             => p_deposit_option(i).rate_kind_id
                           ,p_valid_from               => p_deposit_option(i).valid_from
                           ,p_valid_through            => p_deposit_option(i).valid_through  
                           ,p_is_active                => p_deposit_option(i).is_active
                           ,p_option_description       => p_deposit_option(i).option_description
                           ,p_user_id                  => l_user_id
                           ,p_deposit_option           => l_dpt_data
                                );
                                
            if p_option_id is null and p_deposit_option(i).id is null then
               p_option_id  := l_option_id; 
            end if;
            for j in 1..p_deposit_option(i).list_condition.count() loop
                if coalesce(p_deposit_option(i).list_condition(j).currency_id, 
                            p_deposit_option(i).list_condition(j).interest_rate, 
                            p_deposit_option(i).list_condition(j).tranche_term  ) is null then
                  continue;
                end if;
                l_dpt_data(1).list_condition := tt_deposit_condition(p_deposit_option(i).list_condition(j));
                if p_type in (smb_deposit_utl.GENERAL_TYPE, smb_deposit_utl.BONUS_TYPE) then
                    set_interest_condition(
                                p_id                       => p_deposit_option(i).list_condition(j).id 
                               ,p_interest_option_id       => l_option_id 
                               ,p_currency_id              => p_deposit_option(i).list_condition(j).currency_id
                               ,p_term_unit                => p_deposit_option(i).list_condition(j).term_unit
                               ,p_term_from                => p_deposit_option(i).list_condition(j).term_from
                               ,p_amount_from              => p_deposit_option(i).list_condition(j).amount_from
                               ,p_interest_rate            => p_deposit_option(i).list_condition(j).interest_rate
                               ,p_deposit_option           => l_dpt_data);
                elsif p_type = smb_deposit_utl.PROLONGATION_TYPE then
                    set_prolongation(
                                p_id                       => p_deposit_option(i).list_condition(j).id
                               ,p_interest_option_id       => l_option_id
                               ,p_currency_id              => p_deposit_option(i).list_condition(j).currency_id
                               ,p_amount_from              => p_deposit_option(i).list_condition(j).amount_from
                               ,p_interest_rate            => p_deposit_option(i).list_condition(j).interest_rate
                               ,p_apply_to_first           => p_deposit_option(i).list_condition(j).apply_to_first
                               ,p_deposit_option           => l_dpt_data
                               );
                elsif p_type = smb_deposit_utl.PAYMENT_TYPE then
                    set_payment(
                                p_id                       => p_deposit_option(i).list_condition(j).id
                               ,p_interest_option_id       => l_option_id
                               ,p_currency_id              => p_deposit_option(i).list_condition(j).currency_id                
                               ,p_payment_term_id          => p_deposit_option(i).list_condition(j).payment_term_id
                               ,p_interest_rate            => p_deposit_option(i).list_condition(j).interest_rate
                               ,p_deposit_option           => l_dpt_data
                               );
                elsif p_type = smb_deposit_utl.CAPITALIZATION_TYPE then
                    set_capitalization(
                                p_id                       => p_deposit_option(i).list_condition(j).id
                               ,p_interest_option_id       => l_option_id
                               ,p_currency_id              => p_deposit_option(i).list_condition(j).currency_id                
                               ,p_payment_term_id          => p_deposit_option(i).list_condition(j).payment_term_id
                               ,p_interest_rate            => p_deposit_option(i).list_condition(j).interest_rate
                               ,p_deposit_option           => l_dpt_data
                               );
                elsif p_type = smb_deposit_utl.REPLENISHMENT_TYPE then
                    set_replenishment(
                                p_id                       => p_deposit_option(i).list_condition(j).id
                               ,p_interest_option_id       => l_option_id
                               ,p_currency_id              => p_deposit_option(i).list_condition(j).currency_id
                               ,p_interest_rate            => p_deposit_option(i).list_condition(j).interest_rate
                               ,p_is_replenishment         => p_deposit_option(i).list_condition(j).is_replenishment
                               ,p_deposit_option           => l_dpt_data
                               );
                elsif p_type = smb_deposit_utl.PENALTY_RATE_TYPE then
                    set_penalty_rate(
                                p_id                       => p_deposit_option(i).list_condition(j).id
                               ,p_interest_option_id       => l_option_id
                               ,p_currency_id              => p_deposit_option(i).list_condition(j).currency_id                
                               ,p_rate_from                => p_deposit_option(i).list_condition(j).rate_from
                               ,p_penalty_rate             => p_deposit_option(i).list_condition(j).penalty_rate
                               ,p_deposit_option           => l_dpt_data
                               );
                elsif p_type = smb_deposit_utl.AMOUNT_SETTING_TYPE then
                    set_amount_setting(
                                p_id                       => p_deposit_option(i).list_condition(j).id
                               ,p_interest_option_id       => l_option_id
                               ,p_currency_id              => p_deposit_option(i).list_condition(j).currency_id
                               ,p_min_sum_tranche          => p_deposit_option(i).list_condition(j).min_sum_tranche
                               ,p_max_sum_tranche          => p_deposit_option(i).list_condition(j).max_sum_tranche
                               ,p_min_replenishment_amount => p_deposit_option(i).list_condition(j).min_replenishment_amount
                               ,p_max_replenishment_amount => p_deposit_option(i).list_condition(j).max_replenishment_amount
                               ,p_deposit_option           => l_dpt_data
                               );
                elsif p_type = smb_deposit_utl.REPLENISHMENT_TRANCHE_TYPE then
                    set_replenishment_tranche(
                                p_id                       => p_deposit_option(i).list_condition(j).id
                               ,p_interest_option_id       => l_option_id
                               ,p_tranche_term             => p_deposit_option(i).list_condition(j).tranche_term 
                               ,p_days_to_close_replenish  => p_deposit_option(i).list_condition(j).days_to_close_replenish
                               ,p_deposit_option           => l_dpt_data
                               );
                elsif p_type = smb_deposit_utl.REPLENISHMENT_TRANCHE_TYPE then
                    set_replenishment_tranche(
                                p_id                       => p_deposit_option(i).list_condition(j).id
                               ,p_interest_option_id       => l_option_id
                               ,p_tranche_term             => p_deposit_option(i).list_condition(j).tranche_term 
                               ,p_days_to_close_replenish  => p_deposit_option(i).list_condition(j).days_to_close_replenish
                               ,p_deposit_option           => l_dpt_data
                               );
                elsif p_type = smb_deposit_utl.PROLONGATION_BONUS_TYPE then
                    set_prolongation_bonus(
                                p_id                       => p_deposit_option(i).list_condition(j).id
                               ,p_interest_option_id       => l_option_id
                               ,p_currency_id              => p_deposit_option(i).list_condition(j).currency_id
                               ,p_is_prolongation          => p_deposit_option(i).list_condition(j).is_prolongation
                               ,p_interest_rate            => p_deposit_option(i).list_condition(j).interest_rate
                               ,p_deposit_option           => l_dpt_data
                               );
                elsif p_type = smb_deposit_utl.RATE_FOR_BLOCKED_TRANCHE_TYPE then
                    set_rate_for_blocked_tranche(
                                p_id                       => p_deposit_option(i).list_condition(j).id
                               ,p_interest_option_id       => l_option_id
                               ,p_currency_id              => p_deposit_option(i).list_condition(j).currency_id
                               ,p_interest_rate            => p_deposit_option(i).list_condition(j).interest_rate
                               ,p_deposit_option           => l_dpt_data
                               );
                end if; 
            end loop;
        end loop;                     
    end set_option; 

    function get_data_dod_xml(p_type            in varchar2
                             ,p_type2           in varchar2                      
                             ,p_id              in number default null
                             ,p_is_wrap_to_root in number default 1 ) 
         return clob
     is
        l_clob   clob;
    begin
         select case when p_is_wrap_to_root = 1 then ROOT_TAG_OPEN end||
                '<'||p_type||'>'||
                xmlelement("KINDS",
                    xmlelement("KIND",
                      xmlforest(
                         t.type_code
                        ,k.id
                        ,k.type_id
                        ,k.kind_code
                        ,k.kind_name
                        ,k.is_active 
                        ,xmlagg(
                            case when d.id is not null then
                               xmlelement("OPTION",
                                xmlforest(
                                   d.id
                                  ,d.product_id
                                  ,to_char(d.valid_from, 'yyyy-mm-dd') valid_from 
                                  ,to_char(d.valid_through, 'yyyy-mm-dd') valid_through
                                  ,d.is_active
                                  ,d.option_description
                                  ,d.user_id
                                  ,to_char(d.sys_time, 'yyyy-mm-dd"T"hh24:mi:ss') sys_time
                                  -- костыль UI не может xml запихнуть в один грид
                                  ,case when p_type = smb_deposit_utl.DEPOSIT_ON_DEMAND_CALC_TYPE then
                                       x.calculation_type_id
                                   end calculation_type_id      
                                  -- костыль UI не может xml запихнуть в один грид 
                                  ,case when p_type = smb_deposit_utl.DEPOSIT_ON_DEMAND_CALC_TYPE then
                                       x.id
                                   end id_
                                  ,case when p_type = smb_deposit_utl.DEPOSIT_ON_DEMAND_TYPE then
                                          (select xmlagg(
                                                    xmlelement("CONDITION",
                                                     xmlforest(x.id 
                                                              ,x.interest_option_id 
                                                              ,x.currency_id
                                                              ,x.amount_from
                                                              ,x.interest_rate
                                                              ,x.user_id
                                                              ,to_char(x.sys_time, 'yyyy-mm-dd"T"hh24:mi:ss') sys_time  
                                                              ,c.lcv currency)
                                                         ) order by x.currency_id
                                                                   ,x.amount_from
                                                                   ,x.interest_rate)
                                              from deposit_on_demand_condition x
                                                  ,tabval$global c   
                                             where x.interest_option_id = d.id
                                               and x.currency_id = c.kv)
                                  end "CONDITIONS"                                            
                               ) )
                            end order by d.valid_from desc)"OPTIONS" )  
                        ,case when max(d.id) is null then xmlelement("OPTIONS", null) end
                        )).getClobVal()||
                 '</'||p_type||'>'||
                 case when p_is_wrap_to_root = 1 then ROOT_TAG_CLOSE end val
            into l_clob     
            from deal_interest_rate_type t
                ,deal_interest_rate_kind k
                ,deal_interest_option d
                ,deposit_on_demand_calc_type x
           where t.id = k.type_id
             and k.id = d.rate_kind_id(+)
             and t.type_code = p_type2
             and (d.id = p_id or p_id is null)
             and d.id = x.interest_option_id(+)
          group by t.type_code
                  ,k.id
                  ,k.type_id
                  ,k.kind_code
                  ,k.kind_name
                  ,k.is_active  
          order by k.type_id;

        return l_clob;
    exception
        when no_data_found then return null;    
    end;
    
    function get_data_on_demand_xml(p_id              in number default null
                                   ,p_is_wrap_to_root in number default 1 ) 
         return clob
     is
    begin
        return ROOT_TAG_OPEN ||
               get_data_dod_xml(p_type            => smb_deposit_utl.DEPOSIT_ON_DEMAND_TYPE
                               ,p_type2           => smb_deposit_utl.ON_DEMAND_GENERAL_TYPE
                               ,p_id              => p_id
                               ,p_is_wrap_to_root => 0 ) ||
               get_data_dod_xml(p_type            => smb_deposit_utl.DEPOSIT_ON_DEMAND_CALC_TYPE
                               ,p_type2           => smb_deposit_utl.DEPOSIT_ON_DEMAND_CALC_TYPE
                               ,p_id              => p_id
                               ,p_is_wrap_to_root => 0 ) ||
               ROOT_TAG_CLOSE ;
    end get_data_on_demand_xml; 

    procedure set_interest_rate_on_demand (
                            p_id                  in out number
                           ,p_interest_option_id  in     number
                           ,p_currency_id         in     number
                           ,p_amount_from         in     number
                           ,p_interest_rate       in     number
                           ,p_user_id             in     number
                           ,p_deposit_option      in tt_deposit_option default null
                           )
     is
        l_is_update  number;
        l_oper_type varchar2(1);
    begin
        if p_id is null then
             l_oper_type := 'I';
             p_id        := deal_interest_option_seq.nextVal;
             insert into deposit_on_demand_condition (id, interest_option_id, currency_id, amount_from, interest_rate, user_id )
             values(p_id, p_interest_option_id, p_currency_id, p_amount_from, p_interest_rate, p_user_id);
             
        else
             -- попытка найти такую запись
             -- если запись найдена, то не обновляем
             select count(*)
               into l_is_update
               from deposit_on_demand_condition o
              where o.id = p_id
                and o.interest_option_id = p_interest_option_id
                and o.currency_id        = p_currency_id 
                and o.amount_from        = p_amount_from
                and o.interest_rate      = p_interest_rate; 
             if l_is_update = 0 then   
                 update deposit_on_demand_condition o set
                      interest_option_id  = p_interest_option_id
                     ,currency_id         = p_currency_id 
                     ,amount_from         = p_amount_from
                     ,interest_rate       = p_interest_rate
                     ,user_id             = p_user_id
                     ,sys_time            = sysdate
                  where o.id = p_id;
                  l_oper_type := 'U';
             end if; 
        end if;
        if l_oper_type is not null then    
            set_hist_condition(
                  p_kind_id         => case when p_deposit_option is not null then p_deposit_option(1).rate_kind_id end
                 ,p_option_id       => p_interest_option_id
                 ,p_condition_id    => p_id
                 ,p_deposit_option  => p_deposit_option
                 ,p_oper_type       => l_oper_type
                 );
        end if;         
    end set_interest_rate_on_demand;

    procedure set_calc_type_on_demand (
                                p_id                  in out number
                               ,p_interest_option_id  in number
                               ,p_calculation_type_id in number
                               ,p_user_id             in number
                               ,p_deposit_option      in tt_deposit_option default null
                               )
     is
        l_is_update  number;
        l_oper_type  varchar2(1);
    begin
        if p_id is null then
             l_oper_type := 'I';
             p_id        := deal_interest_option_seq.nextVal;
             insert into deposit_on_demand_calc_type (id, interest_option_id, calculation_type_id, user_id )
             values(p_id, p_interest_option_id, p_calculation_type_id, p_user_id);
        else
             -- попытка найти такую запись
             -- если запись найдена, то не обновляем
             select count(*)
               into l_is_update
               from deposit_on_demand_calc_type o
              where o.id = p_id
                and o.interest_option_id  = p_interest_option_id
                and o.calculation_type_id = p_calculation_type_id; 
             if l_is_update = 0 then   
                 update deposit_on_demand_calc_type o set
                      interest_option_id  = p_interest_option_id
                     ,calculation_type_id = p_calculation_type_id
                     ,user_id             = p_user_id
                     ,sys_time            = sysdate
                  where o.id = p_id;
                  l_oper_type := 'U';
             end if; 
        end if;   
        if l_oper_type is not null then    
            set_hist_condition(
                  p_kind_id         => case when p_deposit_option is not null then p_deposit_option(1).rate_kind_id end
                 ,p_option_id       => p_interest_option_id
                 ,p_condition_id    => p_id
                 ,p_deposit_option  => p_deposit_option
                 ,p_oper_type       => l_oper_type
                 );
        end if;         
    end set_calc_type_on_demand; 


    procedure set_deposit_on_demand(p_deposit in  tt_deposit_option
                                   ,p_id      out number
                                   ,p_type    in varchar2)
     is
        l_user_id   number;
        l_option_id number;
        l_dpt_data  tt_deposit_option;
    begin
        l_user_id := sys_context('bars_global','user_id');
        for i in 1..p_deposit.count() loop    
            l_option_id := p_deposit(i).id;
            if p_deposit(i).valid_from is null and
               p_deposit(i).is_active is null
               then
              continue;
            end if;            
            l_dpt_data := tt_deposit_option(p_deposit(i));
            set_interest_option(
                            p_id                       => l_option_id
                           ,p_product_id               => get_on_demand_product()
                           ,p_rate_kind_id             => p_deposit(i).rate_kind_id
                           ,p_valid_from               => p_deposit(i).valid_from
                           ,p_valid_through            => p_deposit(i).valid_through  
                           ,p_is_active                => p_deposit(i).is_active
                           ,p_option_description       => p_deposit(i).option_description
                           ,p_user_id                  => l_user_id
                           ,p_deposit_option           => l_dpt_data
                                );
            for j in 1..p_deposit(i).list_condition.count() loop    
                if coalesce(p_deposit(i).list_condition(j).currency_id 
                           ,p_deposit(i).list_condition(j).interest_rate
                           ,p_deposit(i).list_condition(j).amount_from
                           ,p_deposit(i).list_condition(j).calculation_type_id) is null then
                  continue;
                end if;
                p_id := p_deposit(i).list_condition(j).id;
                l_dpt_data(1).list_condition := tt_deposit_condition(p_deposit(i).list_condition(j));
                case when p_type = smb_deposit_utl.DEPOSIT_ON_DEMAND_TYPE then
                      set_interest_rate_on_demand (
                                  p_id                  => p_id
                                 ,p_interest_option_id  => l_option_id
                                 ,p_currency_id         => p_deposit(i).list_condition(j).currency_id
                                 ,p_amount_from         => p_deposit(i).list_condition(j).amount_from
                                 ,p_interest_rate       => p_deposit(i).list_condition(j).interest_rate
                                 ,p_user_id             => l_user_id
                                 ,p_deposit_option      => l_dpt_data
                                 );
                     when p_type = smb_deposit_utl.DEPOSIT_ON_DEMAND_CALC_TYPE then
                      set_calc_type_on_demand (
                                  p_id                  => p_id
                                 ,p_interest_option_id  => l_option_id
                                 ,p_calculation_type_id => p_deposit(i).list_condition(j).calculation_type_id
                                 ,p_user_id             => l_user_id
                                 ,p_deposit_option      => l_dpt_data
                                 );
                end case;               
            end loop;   
        end loop; 
    end set_deposit_on_demand; 

    procedure set_data_deposit_on_demand(p_data      in clob
                                        ,p_error     out varchar2
                                        ,p_id        out number
                                        ,p_type      in varchar2 default null)
     is
      l_types    string_list := string_list(smb_deposit_utl.DEPOSIT_ON_DEMAND_TYPE, smb_deposit_utl.DEPOSIT_ON_DEMAND_CALC_TYPE);
      l_data     tt_deposit_option;
      l_limit    number := 500;
    begin
        logger.log_info(p_procedure_name => $$plsql_unit||'.set_data_deposit_on_demand(',
                        p_log_message    => 'p_option_id : ' || p_id
                       ,p_object_id      => null
                       ,p_auxiliary_info => p_data
                        );      
        p_error := null;    
        if p_type is not null and 
           p_type in (smb_deposit_utl.DEPOSIT_ON_DEMAND_TYPE, smb_deposit_utl.DEPOSIT_ON_DEMAND_CALC_TYPE) then
            l_types := string_list(p_type);
        end if;
        for i in 1..l_types.count() loop
            savepoint save_data; 
            open c_get_data(p_type => l_types(i), p_data => p_data);
            loop
               fetch c_get_data
               bulk collect into l_data limit l_limit;
               exit when l_data.count = 0;
               set_deposit_on_demand(p_deposit => l_data
                                    ,p_id      => p_id
                                    ,p_type    => l_types(i));
            end loop;
            close c_get_data;
        end loop;
    exception
        when others then
           rollback to save_data;
           close c_get_data;
           if sqlcode = -00001 then
              p_error := 'Данные с такими значениями уже существуют.'||chr(10);
           end if;
           p_error := p_error||sqlerrm||' '||dbms_utility.format_error_backtrace;     
    end set_data_deposit_on_demand;

    procedure cor_tranche(p_process_id   in out number
                         ,p_data         in clob)
     is
    begin
        smb_deposit_utl.cor_tranche(p_process_id   => p_process_id 
                                   ,p_data         => p_data);
    end cor_tranche;

    procedure cor_replenish_tranche(p_process_id   in out number
                                   ,p_object_id    in number   
                                   ,p_data         in clob)
     is
    begin
        smb_deposit_utl.cor_replenish_tranche(
                                    p_process_id => p_process_id 
                                   ,p_object_id  => p_object_id   
                                   ,p_data       => p_data);
    end;                               

    procedure tranche_authorization(p_process_id in number)
     is
    begin
        smb_deposit_utl.tranche_authorization(p_process_id => p_process_id);
    end;
    
    procedure tranche_confirmation(p_process_id   in number
                                  ,p_is_confirmed in varchar2 default 'Y'
                                  ,p_comment      in varchar2 default null
                                  ,p_error        out varchar2)
     is
    begin
       smb_deposit_utl.tranche_confirmation(p_process_id   => p_process_id
                                           ,p_is_confirmed => p_is_confirmed
                                           ,p_comment      => p_comment
                                           ,p_error        => p_error);
    end;                               
    
    function get_tranche_xml_data(p_process_id  in number) return clob
     is
    begin
      return smb_deposit_utl.get_tranche_xml_data(p_process_id => p_process_id);
    end;     

    procedure tranche_blocking(p_process_id in number
                              ,p_lock_date  in date
                              ,p_comment    in varchar2
                              ,p_lock_type  in number)
     is
    begin
        smb_deposit_utl.tranche_blocking(
                               p_process_id => p_process_id
                              ,p_lock_date  => p_lock_date
                              ,p_comment    => p_comment
                              ,p_lock_type  => p_lock_type);
    end;                           

    procedure tranche_unblocking(p_process_id  in number
                                ,p_unlock_date in date
                                ,p_comment     in varchar2)
     is
    begin
        smb_deposit_utl.tranche_unblocking(
                               p_process_id  => p_process_id
                              ,p_unlock_date => p_unlock_date
                              ,p_comment     => p_comment);
    end;                           
   
    function get_replenish_tanche_xml_data(p_process_id in number
                                          ,p_object_id  in number) 
                        return clob
     is
    begin
        return smb_deposit_utl.get_replenish_tranche_xml_data(
                                           p_process_id => p_process_id 
                                          ,p_object_id  => p_object_id);
    end;                    

    function get_returning_tranche_xml(p_process_id in number
                                      ,p_object_id  in number)
                        return clob
     is
    begin
        return smb_deposit_utl.get_returning_tranche_xml(
                                      p_process_id => p_process_id
                                     ,p_object_id  => p_object_id);    
    end;                    

    procedure cor_returning_tranche(p_process_id   in out number
                                   ,p_object_id    in number
                                   ,p_data         in clob)
     is
    begin
        smb_deposit_utl.cor_returning_tranche(
                                    p_process_id   => p_process_id
                                   ,p_object_id    => p_object_id
                                   ,p_data         => p_data);

    end;                                   

    procedure returning_tranche_auth(p_process_id in number)
     is
    begin
        smb_deposit_utl.returning_tranche_auth(p_process_id => p_process_id);
    end;
    
    procedure returning_tranche_confirmation(p_process_id   in number
                                            ,p_is_confirmed in varchar2 default 'Y'
                                            ,p_comment      in varchar2 default null)
     is
    begin
       smb_deposit_utl.returning_tranche_confirmation(
                                            p_process_id   => p_process_id
                                           ,p_is_confirmed => p_is_confirmed
                                           ,p_comment      => p_comment);
    end;                               

    -- возвращает расчетную процентную ставку по траншу                                        
    function get_interest_rate_tranche(p_data in clob
                                      ,p_date in date default null)
       return clob
     is
    begin
        return smb_deposit_utl.get_interest_rate(p_data => p_data);
    end;

    -- возвращает расчетную процентную ставку по ДтП
    function get_interest_rate_on_demand(p_data in clob)
       return clob
     is
    begin
        return smb_deposit_utl.get_interest_rate_on_demand(p_data => p_data);
    end;

    function get_on_demand_xml_data(p_process_id  in number) return clob
     is
    begin
      return smb_deposit_utl.get_on_demand_xml_data(p_process_id => p_process_id);
    end;     

    procedure cor_on_demand(p_process_id   in out number
                           ,p_data         in clob)
     is
    begin
        smb_deposit_utl.cor_on_demand(p_process_id   => p_process_id 
                                     ,p_data         => p_data);
    end cor_on_demand;

    -- отправить ДпТ на авторизацию
    procedure on_demand_authorization(p_process_id in number)
     is
    begin
        smb_deposit_utl.on_demand_authorization(p_process_id => p_process_id);
    end; 

    -- подтверждение / отклонение БО
    procedure on_demand_confirmation(p_process_id   in number
                                     ,p_is_confirmed in varchar2 default 'Y'
                                     ,p_comment      in varchar2 default null
                                     ,p_error        out varchar2)
     is
    begin
       smb_deposit_utl.on_demand_confirmation(
                                   p_process_id   => p_process_id
                                  ,p_is_confirmed => p_is_confirmed
                                  ,p_comment      => p_comment
                                  ,p_error        => p_error);

    end; 

    -- получить данные для закрытия ДпТ
    function get_close_on_demand_xml_data(p_process_id in number
                                         ,p_object_id  in number)
                        return clob
     is
    begin
        return  smb_deposit_utl.get_close_on_demand_xml_data(
                                   p_process_id => p_process_id 
                                  ,p_object_id  => p_object_id);
    end get_close_on_demand_xml_data;                    

    -- создание или обновление закрытия ДпТ вызов из UI (web)
    procedure cor_close_on_demand(p_process_id   in out number
                                 ,p_object_id    in number                   
                                 ,p_data         in clob)
     is
    begin
        smb_deposit_utl.cor_close_on_demand(p_process_id => p_process_id
                           ,p_object_id  => p_object_id 
                           ,p_data       => p_data);
    end cor_close_on_demand;                             

    -- отправить закрытие ДпТ на авторизацию
    procedure close_on_demand_authorization(p_process_id in number)
     is
    begin
        smb_deposit_utl.close_on_demand_authorization(p_process_id => p_process_id);
    end;

    -- подтверждение / отклонение БО закрытия ДпТ
    procedure close_on_demand_confirmation(p_process_id   in number
                                          ,p_is_confirmed in varchar2 default 'Y'
                                          ,p_comment      in varchar2 default null
                                          ,p_error        out varchar2)
     is
    begin
        smb_deposit_utl.close_on_demand_confirmation(
                                           p_process_id   => p_process_id
                                          ,p_is_confirmed => p_is_confirmed
                                          ,p_comment      => p_comment
                                          ,p_error        => p_error);
    end;

    function get_on_demand_change_calc_xml(p_process_id  in number)
                        return clob
     is
    begin
        return  smb_deposit_utl.get_on_demand_change_calc_xml(
                                   p_process_id => p_process_id);
    end get_on_demand_change_calc_xml;

    procedure change_calculation_type_dod (p_process_id          in number
                                          ,p_calculation_type_id in number
                                          ,p_comment             in varchar2 default null
                                          )
     is
    begin
        smb_deposit_utl.change_calculation_type_dod (
                                           p_process_id          => p_process_id
                                          ,p_calculation_type_id => p_calculation_type_id
                                          ,p_comment             => p_comment
                                          );
    end;

    -- отправить смену метода начисления для ДпТ на авторизацию                                          
    procedure change_calc_type_authorization(p_process_id in number)
     is
    begin
        smb_deposit_utl.change_calc_type_authorization( 
                                            p_process_id   => p_process_id);

    end;


    -- подтверждение / отклонение смены метода начисления для ДпТ
    procedure change_calc_type_confirmation(p_process_id   in number
                                           ,p_is_confirmed in varchar2 default 'Y'
                                           ,p_comment      in varchar2 default null
                                           ,p_error        out varchar2)
     is
    begin
        smb_deposit_utl.change_calc_type_confirmation(
                                            p_process_id   => p_process_id
                                           ,p_is_confirmed => p_is_confirmed
                                           ,p_comment      => p_comment
                                           ,p_error        => p_error);

    end;

    -- удалить транш (установить статус object в DELETED)
    procedure delete_tranche(p_process_id in number
                            ,p_comment    in varchar2)
     is
    begin
        smb_deposit_utl.delete_tranche(p_process_id => p_process_id
                                      ,p_comment    => p_comment);
    end;

    -- удалить пополнение 
    procedure delete_replenishment(p_process_id in number
                                  ,p_comment    in varchar2)
     is
    begin
        smb_deposit_utl.delete_replenishment(p_process_id => p_process_id
                                            ,p_comment    => p_comment);
    end;


    -- удалить депозит по требованию (установить статус object в DELETED)
    procedure delete_on_demand(p_process_id in number
                              ,p_comment    in varchar2)
     is
    begin
        smb_deposit_utl.delete_on_demand(p_process_id => p_process_id
                                        ,p_comment    => p_comment);
    end;

    function get_users_activity(p_process_id in number)
        return varchar2
     is
    begin
        return smb_deposit_utl.get_users_activity(p_process_id => p_process_id);
    end;   

    function get_last_replenishment_date (
                          p_start_date  in date             
                         ,p_end_date    in date)
         return date
     is
    begin
        return smb_deposit_utl.get_last_replenishment_date (
                                    p_start_date => p_start_date
                                   ,p_end_date   => p_end_date);
    end;   

    -- информация о текущей пролонгации
    function get_tranche_prolongation_xml(p_process_id in number)
             return clob
     is
    begin
        return smb_deposit_utl.get_tranche_prolongation_xml(p_process_id => p_process_id);
    end;   

 
end;
/
PROMPT *** Create  grants  SMB_DEPOSIT_UI ***
grant EXECUTE   on SMB_DEPOSIT_UI   to BARS_ACCESS_DEFROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/package/smb_deposit_ui.sql ===== *** End ***
PROMPT ===================================================================================== 
