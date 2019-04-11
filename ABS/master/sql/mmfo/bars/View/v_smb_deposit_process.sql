PROMPT ==============================================================================
PROMPT *** Run *** == Scripts /Sql/BARS/View/V_SMB_DEPOSIT_PROCESS.sql == *** Run ***
PROMPT ============================================================================== 

PROMPT *** Create  view V_SMB_DEPOSIT_PROCESS  ***

create or replace force view v_smb_deposit_process 
as
with prc_state as(
        select i.list_item_id
              ,i.list_item_name
              ,i.list_item_code   
          from list_type t
              ,list_item i 
         where t.list_code = 'PROCESS_STATE'
           and t.id = i.list_type_id)
 ,prc_hist_ as (
        -- берем последнюю историю по процессу
        select h.process_id
              ,max(b.fio  )    keep (dense_rank first order by h.id desc) fio
              ,max(h.sys_time) keep (dense_rank first order by h.id desc) sys_time
              ,max(h.user_id)  keep (dense_rank first order by h.id desc) user_id
              ,max(h.id) process_history_id   
          from process_history h
              ,staff$base b
         where b.id = h.user_id      
        group by h.process_id)        
  ,obj_ as (
       -- собираем инфо по объектам и процессам         
        select o.id deposit_id
              ,d.start_date
              ,d.expiry_date
              ,d.close_date
              ,d.customer_id
              ,p.id process_id
              ,p.state_id process_state_id
              ,p.process_data
              ,h.sys_time
              ,h.user_id
              ,h.fio
              ,pt.process_code
              ,pt.process_name
              ,ps.list_item_code process_state_code
              ,ps.list_item_name process_state_name
              ,os.state_code object_state_code
              ,os.state_name object_state_name
              ,ot.type_code deposit_type_code
              ,ot.type_name deposit_type_name
              ,h.process_history_id
              ,d.branch_id
              ,cst.okpo
              ,cst.nmk
              ,n.value contract_number
              ,t.expiry_date_prolongation
          from 
               object_type ot      
              ,object o
              ,object_state os
              ,smb_deposit t    
              ,process p
              ,process_type pt
              ,prc_state ps
              ,deal d
              ,prc_hist_ h
              ,customer cst
              ,customerw n
         where 1 = 1
           and ot.type_code in ('SMB_DEPOSIT_TRANCHE', 'SMB_DEPOSIT_ON_DEMAND')
           and o.object_type_id = ot.id
           and p.object_id = o.id
           and o.state_id = os.id
           and pt.module_code = 'SMBD'
           and o.id = t.id
           and p.process_type_id = pt.id
           and ps.list_item_id = p.state_id
           and o.id = d.id
           and p.id = h.process_id
           and d.customer_id = cst.rnk
           and cst.rnk = n.rnk
           and n.tag = 'NDBO')
select 
       o.deposit_id
      ,o.contract_number
      ,o.okpo --dbo.okpo
      ,o.start_date
      ,o.expiry_date
      ,o.close_date
      ,o.customer_id
      ,o.process_id
      ,o.Deal_Number || ' ' ||c.lcv deal_number_name
      ,case o.process_code
          when 'NEW_TRANCHE'             then 'розміщення траншу'
          when 'REPLENISH_TRANCHE'       then 'поповнення траншу'
          when 'EARLY_RETURN_TRANCHE'    then 'дострокове повернення траншу'
          when 'NEW_ON_DEMAND'           then 'відкриття вкладу на вимогу'
          when 'CLOSE_ON_DEMAND'         then 'закриття вкладу на вимогу'
          when 'CHANGE_CALCULATION_TYPE' then 'зміна методу нарахування'
       end transaction_type
      ,case 
            when o.object_state_code = 'BLOCKED'
             then 'заблоковано'
            when o.object_state_code = 'CLOSED'
             then 'закрито'   
            else 
               case when o.process_state_code = 'CREATED'
                     -- состояние процесса в этом случае может иметь 2-статуса
                     -- 1 - только создан
                     -- 2 - отклонен бэк-офисом   
                         and exists(
                                      select null
                                        from process_history h1
                                       where h1.process_id = o.process_id
                                         and h1.process_state_id = 2 
                                         and h1.id < o.process_history_id)
                    then         
                        -- повторное редактирование после возврата с БО
                                         case when exists(
                                                        select null
                                                          from dual
                                                         where (o.process_history_id, 1) in 
                                                           (
                                                            select h1.id, lag(h1.process_state_id) over(order by h1.id) state_id
                                                              from process_history h1
                                                             where h1.process_id = o.process_id
                                                               and h1.id <= o.process_history_id)
                                                           )      
                                             then 'на редагуванні'
                                             else 'відхилено БО / на редагуванні'
                                         end       
                  when o.process_state_code = 'CREATED'   then 'створено'                                                                             
                  when o.process_state_code = 'RUNNING'   then 'на авторизації'
                  when o.process_state_code = 'DISCARDED' then 'відхилений'
                  when o.process_state_code = 'FAILED'
                     -- ошибка может быть 2-х видов
                     -- 1 - бэк-офис подтвердил, но недостаточно денег на счете - это нормально
                     -- 2 - хз     
                     then 
                           -- проверяем на activity подтверждение бэк-офиса
                           -- если DONE то недостаточно денег на счету
                         case when    
                               exists(select null
                                        from activity a
                                            ,process_workflow pw
                                            ,activity_history ah
                                       where a.process_id = o.process_id
                                         and a.activity_type_id = pw.id 
                                         and pw.activity_code = 'BACK_OFFICE_CONFIRMATION'
                                         and a.id = ah.activity_id  
                                         and ah.activity_state_id = 5 -- DONE
                                         and o.sys_time >= ah.sys_time   
                                        )
                              then 'авторизовано з помилкою'
                              else 'помилка' 
                         end                            
                  when o.process_state_code = 'DONE'      then 'авторизовано'
               end         
       end state_name 
      ,o.sys_time
      ,o.user_id
      ,o.fio
      ,o.process_code
      ,o.process_name
      ,o.process_state_code
      ,o.process_state_id      
      ,o.process_state_name
      ,o.object_state_code
      ,o.object_state_name
      ,o.deposit_type_code
      ,o.deposit_type_name
      ,o.process_history_id
      ,o.Deal_Number
      ,o.Start_Date_
      ,o.action_date
      ,o.currency_id
      ,c.lcv
      ,o.nmk customer_name
      ,case when deposit_type_code = 'SMB_DEPOSIT_ON_DEMAND' 
         then null
         else Amount_tranche  
       end amount_deposit
      ,o.register_history_id
      ,c.denom
      ,o.Primary_Account account_number
      ,case when o.deposit_type_code = 'SMB_DEPOSIT_TRANCHE' then
          (select min(a.number_value) keep (dense_rank first order by a.value_date desc) interest_rate
             from attribute_kind ak
                 ,attribute_value_by_date a    
            where 1 = 1
              and ak.attribute_code = 'SMB_DEPOSIT_TRANCHE_INTEREST_RATE'
              and ak.id = a.attribute_id
              and a.object_id = o.deposit_id
              and a.value_date <= o.start_date) 
       end interest_rate
      ,o.branch_id
      ,(select li.list_item_name 
          from list_type lt
              ,list_item li  
         where lt.list_code = 'SMB_DEPOSIT_PAYMENT_TERM'
           and lt.id = li.list_type_id
           and li.list_item_id = o.frequency_payment
                ) frequency_payment_name
      ,(select a.ostc / c.denom  
          from deal_account da
              ,attribute_kind ak   
              ,accounts a
         where da.deal_id = o.deposit_id
           and ak.attribute_code = 'DEPOSIT_PRIMARY_ACCOUNT'
           and da.account_type_id = ak.id 
           and a.acc = da.account_id ) total_amount_deposit
      ,case when o.object_state_code <> 'BLOCKED' then 0
            when nvl(expiry_date_prolongation, expiry_date) < trunc(sysdate) then 1
       end is_expired_and_blocked
      ,o.comment_
  from (           
        select o.*
              ,x.deal_number
              ,x.start_date_
              ,x.action_date 
              ,x.currency_id
              ,x.amount_tranche
              ,x.register_history_id
              ,x.Primary_Account
              ,x.Frequency_Payment
              ,nvl(x.additional_comment, x.comment_) comment_
          from obj_ o
              ,xmltable ('/SMBDepositTranche' passing xmltype(o.process_data) columns
                        Deal_Number         varchar2(100)  path 'DealNumber'
                       ,Start_Date_         date           path 'StartDate'
                       ,action_date         date           path 'ActionDate' 
                       ,currency_id         number         path 'CurrencyId'
                       ,Amount_tranche      number         path 'AmountTranche'
                       ,Register_History_Id number         path 'RegisterHistoryId'
                       ,Primary_Account     varchar2(100)  path 'PrimaryAccount'
                       ,Frequency_Payment   number         path 'FrequencyPayment'
                       ,additional_comment  varchar2(1000) path 'AdditionalComment'
                       ,comment_            varchar2(1000) path 'Comment' 
                 ) x
         where 1 = 1
           and o.process_code in ('NEW_TRANCHE', 'REPLENISH_TRANCHE', 'EARLY_RETURN_TRANCHE') 
        union all
        select o.*
              ,x.deal_number
              ,x.start_date_
              ,x.action_date 
              ,x.currency_id
              ,null Amount_tranche
              ,cast(null as number) register_history_id
              ,x.Primary_Account
              ,x.Frequency_Payment
              ,nvl(x.additional_comment, x.comment_) comment_
          from obj_ o
              ,xmltable ('/SMBDepositOnDemand' passing xmltype(o.process_data) columns
                            Deal_Number         varchar2(100)  path 'DealNumber'
                           ,Start_Date_         date           path 'StartDate'
                           ,action_date         date           path 'ActionDate' 
                           ,currency_id         number         path 'CurrencyId'
                           ,Primary_Account     varchar2(100)  path 'PrimaryAccount'
                           ,Frequency_Payment   number         path 'FrequencyPayment'
                           ,additional_comment  varchar2(1000) path 'AdditionalComment'
                           ,comment_            varchar2(1000) path 'Comment'  
                     ) x
         where 1 = 1 
           and o.process_code in ('NEW_ON_DEMAND', 'CLOSE_ON_DEMAND', 'CHANGE_CALCULATION_TYPE')
    ) o
    ,tabval$global c
 where o.currency_id = c.kv
;
                    
PROMPT *** Create  grants  V_SMB_DEPOSIT_PROCESS ***
grant SELECT  on v_smb_deposit_process  to BARSREADER_ROLE;
grant SELECT  on v_smb_deposit_process  to BARS_ACCESS_DEFROLE;

PROMPT ==============================================================================
PROMPT *** End *** == Scripts /Sql/BARS/View/V_SMB_DEPOSIT_PROCESS.sql == *** End ***
PROMPT ==============================================================================