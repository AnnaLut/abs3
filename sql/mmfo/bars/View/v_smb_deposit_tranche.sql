PROMPT ===============================================================================
PROMPT *** Run *** == Scripts /Sql/BARS/View/v_smb_deposit_tranche.sql == *** Run ***
PROMPT =============================================================================== 

PROMPT *** Create  view V_SMB_DEPOSIT_TRANCHE  ***

create or replace force view v_smb_deposit_tranche 
as
with prc_state as(
        select i.list_item_id
              ,i.list_item_name
              ,i.list_item_code   
          from list_type t
              ,list_item i 
         where t.list_code = 'PROCESS_STATE'
           and t.id = i.list_type_id)
select o.id tranche_id
      ,o.state_id
      ,os.state_name
      ,d.customer_id
      ,d.deal_number
      ,d.start_date
      ,d.expiry_date
      ,o.object_type_id deal_type_id
      ,d.product_id
      ,d.curator_id  
      ,t.currency_id 
      ,c.lcv currency
      ,rv.plan_value / c.denom plan_value
      ,rv.actual_value / c.denom actual_value 
      ,t.is_replenishment_tranche 
      ,t.max_sum_tranche / c.denom max_sum_tranche  
      ,t.min_replenishment_amount / c.denom min_replenishment_amount 
      ,t.last_replenishment_date 
      ,t.is_prolongation
      ,t.number_prolongation 
      ,t.prolongation_interest_rate
      ,t.apply_bonus_prolongation
      ,t.frequency_payment 
      ,t.is_capitalization 
      ,t.is_individual_rate 
      ,t.penalty_interest_rate
      ,t.number_tranche_days 
      ,t.last_accrual_date
      ,t.tail_amount
      ,os.state_code
      ,p.id process_id
      ,(select li.list_item_name 
          from list_type lt
              ,list_item li  
         where lt.list_code = 'SMB_DEPOSIT_PAYMENT_TERM'
           and lt.id = li.list_type_id
           and li.list_item_id = t.frequency_payment
                ) frequency_payment_name
      ,case
           when os.state_code in ('BLOCKED', 'CLOSED')
             then os.state_name      
           when p.state_id = 1
               -- возврат из авторизации
               -- т.е был ли процесс в статусе RUNNIG = 2 
               and exists(select null
                            from process_history h1
                           where h1.process_id = p.id
                             and h1.process_state_id = 2) 
              then 'відхилено БО / на редагуванні'
           when p.state_id = 3
              then
                   -- проверяем на activity подтверждение бэк-офиса
                   -- если DONE то недостаточно денег на счету
                 case when    
                       exists(select null
                                from activity a
                                    ,process_workflow pw
                                    ,activity_history ah
                               where a.process_id = p.id
                                 and a.activity_type_id = pw.id 
                                 and pw.activity_code = 'BACK_OFFICE_CONFIRMATION'
                                 and a.id = ah.activity_id  
                                 and ah.activity_state_id = 5 -- DONE
                                 --and x.sys_time >= ah.sys_time   
                                )
                      then 'авторизовано з помилкою'
                      else 'помилка' 
                 end                
        else  
           case prc_state.list_item_code 
              when 'CREATED'   then 'на редагуванні'
              when 'RUNNING'   then 'на авторизації'
              when 'DISCARDED' then 'відхилений'
              when 'FAILED'    then 'помилка'
              when 'DONE'      then 'авторизовано' 
           end 
        end tranche_state_name 
      ,prc_state.list_item_code tranche_state_code
      ,p.state_id tranche_state_id
      ,case
         when os.state_code = 'BLOCKED'
            -- достаем коммент
           then 
             (select max(h.comment_text) keep (dense_rank first order by h.id desc, h.sys_time desc) 
               from process p1
                   ,process_history h
              where p1.object_id = p.object_id 
                and h.process_id  = p1.id
                and p1.process_type_id = (select id from process_type where process_code = 'TRANCHE_BLOCKING' and module_code = 'SMBD'))  
         when p.state_id = 1
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
          -- process в статусе FAILURE      
         when p.state_id = 3
          then
                -- activity в статусе FAILED
               (select max(ah.comment_text)
                       keep (dense_rank first order by ah.id desc, ah.sys_time desc)  
                  from activity a
                      ,activity_history ah
                 where a.process_id = p.id
                   and a.id = ah.activity_id
                   and ah.activity_state_id = 3 
                   and a.state_id = 3
                )
         when p.state_id = 4
          then
             (select max(h.comment_text) keep (dense_rank first order by h.id desc, h.sys_time desc) 
               from process_history h
              where h.process_id  = p.id
                and h.comment_text <> '#FO#')  
         else x.Comment_       
      end comment_text 
     ,d.close_date
  from object o
      ,object_type ot  
      ,deal d  
      ,smb_deposit t
      ,object_state os
      ,register_type rt
      ,register_value rv
      ,customer cust
      ,process p
      ,process_type pt
      ,tabval$global c
      ,prc_state
      ,xmlTable('/SMBDepositTranche' passing xmltype(p.process_data) columns
                  Comment_           varchar2(1000) path 'Comment') x    
 where ot.type_code = 'SMB_DEPOSIT_TRANCHE'
   and o.object_type_id = ot.id
   and o.id = d.id
   and o.id = t.id
   and o.state_id = os.id
   and rt.object_type_id = o.object_type_id
   and rt.register_code = 'SMB_PRINCIPAL_AMOUNT'
   and rv.object_id = o.id
   and rv.register_type_id = rt.id
   and d.customer_id = cust.rnk
   and p.object_id = o.id
   and p.process_type_id = pt.id
   and pt.module_code = 'SMBD'
   and pt.process_code = 'NEW_TRANCHE'
   and p.state_id = prc_state.list_item_id
   and t.currency_id = c.kv 
;

comment on table  v_smb_deposit_tranche                                 is 'депозитные транши' ;
comment on column v_smb_deposit_tranche.tranche_id                      is 'идентификатор депозита';
comment on column v_smb_deposit_tranche.state_id                        is 'идентификатор статуса депозита';
comment on column v_smb_deposit_tranche.state_name                      is 'нименование статуса (створено, видалено, ..)';
comment on column v_smb_deposit_tranche.customer_id                     is 'идентификатор клиента';
comment on column v_smb_deposit_tranche.deal_number                     is 'номер депозита';
comment on column v_smb_deposit_tranche.start_date                      is 'дата начала';
comment on column v_smb_deposit_tranche.expiry_date                     is 'дата окончания';
comment on column v_smb_deposit_tranche.close_date                      is 'дата закрытия';
comment on column v_smb_deposit_tranche.deal_type_id                    is 'тип депозита (можно и не выводить так как только это для траншей)';
comment on column v_smb_deposit_tranche.product_id                      is 'идентификатор продукта';
comment on column v_smb_deposit_tranche.curator_id                      is 'идентификатор пользователя';
comment on column v_smb_deposit_tranche.currency_id                     is 'идентификатор  валюты';
comment on column v_smb_deposit_tranche.currency                        is 'валюта';
comment on column v_smb_deposit_tranche.plan_value                      is 'сумма депозита плановое значение';
comment on column v_smb_deposit_tranche.actual_value                    is 'сумма депозита фактическое значение';
comment on column v_smb_deposit_tranche.is_replenishment_tranche        is 'депозит с пополнением (0, 1)';
comment on column v_smb_deposit_tranche.max_sum_tranche                 is 'макимальная сумма транша';
comment on column v_smb_deposit_tranche.min_replenishment_amount        is 'минимальная сумма пополнения';
comment on column v_smb_deposit_tranche.last_replenishment_date         is 'дата последнего пополнения';
comment on column v_smb_deposit_tranche.is_prolongation                 is 'депозит с пролонгацией (0, 1)';
comment on column v_smb_deposit_tranche.number_prolongation             is 'кол-во пролонгаций';
comment on column v_smb_deposit_tranche.prolongation_interest_rate      is '% ставка при пролонгации';
comment on column v_smb_deposit_tranche.apply_bonus_prolongation        is 'к какой пролонгации применяется % ставка (1 - к первой, 2 - ко всем)';
comment on column v_smb_deposit_tranche.frequency_payment               is 'периодичность выплат';
comment on column v_smb_deposit_tranche.is_capitalization               is 'капитализация (0, 1)';
comment on column v_smb_deposit_tranche.is_individual_rate              is 'установлена индивидуальная ставка (0, 1)';
comment on column v_smb_deposit_tranche.penalty_interest_rate           is 'штрафная % стиавка';
comment on column v_smb_deposit_tranche.number_tranche_days             is 'кол-во дней депозита';
comment on column v_smb_deposit_tranche.last_accrual_date               is 'последняя дата начисления процентов';
comment on column v_smb_deposit_tranche.tail_amount                     is 'остаток от округления "хвост" (нужно ли это поле здесь (?))';
comment on column v_smb_deposit_tranche.state_code                      is 'код статуса депозита';
comment on column v_smb_deposit_tranche.process_id                      is 'идентификатор процесса';
comment on column v_smb_deposit_tranche.frequency_payment_name          is 'наименование периодичность выплат';
comment on column v_smb_deposit_tranche.tranche_state_name              is 'наименование статуса депозита (по процессу)';
comment on column v_smb_deposit_tranche.tranche_state_code              is 'код статуса депозита  (по процессу)';
comment on column v_smb_deposit_tranche.tranche_state_id                is 'идентификатор статуса процесса';
comment on column v_smb_deposit_tranche.comment_text                    is 'комментарий';



PROMPT *** Create  grants  V_SMB_DEPOSIT_TRANCHE ***

grant SELECT  on V_SMB_DEPOSIT_TRANCHE  to BARSREADER_ROLE;
grant SELECT  on V_SMB_DEPOSIT_TRANCHE  to BARS_ACCESS_DEFROLE;

PROMPT ===============================================================================
PROMPT *** End *** == Scripts /Sql/BARS/View/v_smb_deposit_tranche.sql == *** End ***
PROMPT ===============================================================================