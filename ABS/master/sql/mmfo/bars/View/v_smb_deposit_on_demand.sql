PROMPT ================================================================================
PROMPT *** Run *** == Scripts /Sql/BARS/View/v_smb_deposit_on_demand.sql == *** Run ***
PROMPT ================================================================================ 

PROMPT *** Create  view V_SMB_DEPOSIT_ON_DEMAND  ***

create or replace force view v_smb_deposit_on_demand 
as
with prc_state as(
        select i.list_item_id
              ,i.list_item_name
              ,i.list_item_code   
          from list_type t
              ,list_item i 
         where t.list_code = 'PROCESS_STATE'
           and t.id = i.list_type_id)
select 
       o.id deposit_id
      ,o.state_id
      ,os.state_name
      ,d.customer_id
      ,d.deal_number
      ,d.start_date
      ,d.expiry_date
      ,d.deal_type_id
      ,d.product_id
      ,d.curator_id  
      ,dpt.currency_id 
      ,c.lcv currency
      ,a.ostc / c.denom plan_value
      ,a.ostc / c.denom actual_value 
      ,os.state_code
      ,p.id process_id
      ,(select li.list_item_name 
          from list_type lt
              ,list_item li  
         where lt.list_code = 'SMB_DEPOSIT_PAYMENT_TERM'
           and lt.id = li.list_type_id
           and li.list_item_id = t.frequency_payment
                ) frequency_payment_name
      ,case when p.state_id = 1
               -- возврат из авторизации
               -- т.е был ли процесс в статусе RUNNIG = 2 
               and exists(select null
                            from process_history h1
                           where h1.process_id = p.id
                             and h1.process_state_id = 2) 
              then 'відхилено БО / на редагуванні'
        else  
           case prc_state.list_item_code 
              when 'CREATED'   then 'на редагуванні'
              when 'RUNNING'   then 'на авторизації'
              when 'DISCARDED' then 'відхилений'
              when 'FAILED'    then 'помилка'
              when 'DONE'      then 'авторизовано' 
           end 
        end deposit_state_name 
      ,prc_state.list_item_code deposit_state_code
      ,p.state_id deposit_state_id
      ,t.calculation_Type
      ,(select x.item_name 
          from table(smb_deposit_ui.get_calculation_type_list()) x
         where x.item_id = t.calculation_Type
                ) calculation_Type_name
      ,case when p.state_id = 1
               -- возврат из авторизации
               -- т.е был ли процесс в статусе RUNNIG = 2 
               and exists(select null
                            from process_history h1
                           where h1.process_id = p.id
                             and h1.process_state_id = 2)
         -- значит у нас есть activity в статусе REMOVED = 4
         -- достаем последний коммент                 
          then (select max(ah.comment_text)
                       keep (dense_rank first order by ah.sys_time desc)
                  from activity a
                      ,activity_history ah
                      ,activity_dependency ad
                 where a.process_id = p.id
                   and a.id = ah.activity_id
                   and a.id = ad.primary_activity_id
                   -- берем первую activity учитывая dependency
                   and not exists(select  null 
                                    from activity_dependency ad2 
                                   where ad2.following_activity_id = a.id)      
                 )
         when p.state_id = 4
          then
             (select max(h.comment_text) keep (dense_rank first order by h.id desc, h.sys_time desc) 
               from process_history h
              where h.process_id  = p.id
                and h.comment_text <> '#FO#')  
          else t.Comment_       
      end comment_text
     ,d.close_date
  from( select o.*    
          from object o
              ,object_type ot
         where ot.type_code = 'SMB_DEPOSIT_ON_DEMAND'
           and o.object_type_id = ot.id) o        
      ,deal d
      ,deal_account da
      ,accounts a          
      ,object_state os
      ,customer cust
      ,process p
      ,process_type pt
      ,smb_deposit dpt
      ,tabval$global c 
      ,prc_state  
      ,xmltable ('/SMBDepositOnDemand' passing xmltype(p.process_data) columns
                     Frequency_Payment             number         path 'FrequencyPayment'
                    ,Calculation_Type              number         path 'CalculationType'
                    ,Comment_                      varchar2(1000) path 'Comment') t
 where 1 = 1
   and o.id = d.id
   and o.state_id = os.id
   and d.id = da.deal_id(+)
   and da.account_type_id(+) = attribute_utl.get_attribute_id('DEPOSIT_PRIMARY_ACCOUNT')
   and da.account_id = a.acc(+) 
   and d.customer_id = cust.rnk
   and p.object_id = o.id
   and p.process_type_id = pt.id
   and pt.module_code = 'SMBD'
   and pt.process_code = 'NEW_ON_DEMAND'
   and p.state_id = prc_state.list_item_id
   and o.id = dpt.id 
   and dpt.currency_id = c.kv
;

comment on table  v_smb_deposit_on_demand                                 is 'депозиты по требованию' ;
comment on column v_smb_deposit_on_demand.deposit_id                      is 'идентификатор депозита';
comment on column v_smb_deposit_on_demand.state_id                        is 'идентификатор статуса депозита';
comment on column v_smb_deposit_on_demand.state_name                      is 'нименование статуса (створено, видалено, ..)';
comment on column v_smb_deposit_on_demand.customer_id                     is 'идентификатор клиента';
comment on column v_smb_deposit_on_demand.deal_number                     is 'номер депозита';
comment on column v_smb_deposit_on_demand.start_date                      is 'дата начала';
comment on column v_smb_deposit_on_demand.expiry_date                     is 'дата окончания';
comment on column v_smb_deposit_on_demand.close_date                      is 'дата закрытия';
comment on column v_smb_deposit_on_demand.deal_type_id                    is 'тип депозита (можно и не выводить так как только это по требованию)';
comment on column v_smb_deposit_on_demand.product_id                      is 'идентификатор продукта';
comment on column v_smb_deposit_on_demand.curator_id                      is 'идентификатор пользователя';
comment on column v_smb_deposit_on_demand.currency_id                     is 'идентификатор  валюты';
comment on column v_smb_deposit_on_demand.currency                        is 'валюта';
comment on column v_smb_deposit_on_demand.plan_value                      is 'сумма депозита плановое значение';
comment on column v_smb_deposit_on_demand.actual_value                    is 'сумма депозита фактическое значение';
comment on column v_smb_deposit_on_demand.state_code                      is 'код статуса депозита';
comment on column v_smb_deposit_on_demand.process_id                      is 'идентификатор процесса';
comment on column v_smb_deposit_on_demand.frequency_payment_name          is 'наименование периодичность выплат';
comment on column v_smb_deposit_on_demand.deposit_state_name              is 'наименование статуса депозита (по процессу)';
comment on column v_smb_deposit_on_demand.deposit_state_code              is 'код статуса депозита  (по процессу)';
comment on column v_smb_deposit_on_demand.deposit_state_id                is 'идентификатор статуса процесса';
comment on column v_smb_deposit_on_demand.calculation_type                is 'идентификатор типа расчета';
comment on column v_smb_deposit_on_demand.calculation_type_name           is 'наименование типа расчета (Залишок на кінець дня/Середньоденні залишки)';
comment on column v_smb_deposit_on_demand.comment_text                    is 'комментарий';


PROMPT *** Create  grants  V_SMB_DEPOSIT_ON_DEMAND ***

grant SELECT  on V_SMB_DEPOSIT_ON_DEMAND  to BARSREADER_ROLE;
grant SELECT  on V_SMB_DEPOSIT_ON_DEMAND  to BARS_ACCESS_DEFROLE;

PROMPT ================================================================================
PROMPT *** End *** == Scripts /Sql/BARS/View/v_smb_deposit_on_demand.sql == *** End ***
PROMPT ================================================================================