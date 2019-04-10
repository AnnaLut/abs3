PROMPT ====================================================================================
PROMPT *** Run *** == Scripts /Sql/BARS/View/V_SMB_DEPOSIT_REPLENISHMENT.sql == *** Run ***
PROMPT ==================================================================================== 

PROMPT *** Create  view V_SMB_DEPOSIT_REPLENISHMENT  ***

create or replace force view v_smb_deposit_replenishment
as
select d.register_history_id
      ,d.register_value_id 
      ,d.value_date
      ,d.amount_deposit amount
      ,d.is_active
      ,d.is_planned
      ,d.sys_time
      ,d.deal_number
      ,nvl(d.action_date, d.start_date_) start_date
      ,d.plan_value 
      ,d.actual_value
      ,d.process_state_name replenish_state
      ,d.process_state_code replenish_state_code
      ,d.state_name replenish_state_name      
      ,case when d.process_code = 'NEW_TRANCHE' 
            then 'основний транш'
            else 'поповнення'
       end type_
      ,d.process_code replenish_type_code 
      ,d.deposit_id object_id
      ,d.process_id
      ,1 is_replenishment_tranche
      ,d.customer_id
      ,d.comment_
      ,case when d.process_code = 'REPLENISH_TRANCHE' and d.process_state_code = 'DISCARDED' then
            (select max(h.comment_text) keep (dense_rank first order by h.id desc)
              from process_history h 
             where h.process_id = d.process_id
               and h.process_state_id = 4)
       end reason
  from(
        select d.*
              ,v.id register_value_id
              ,h.is_active
              ,h.is_planned
              ,v.plan_value / d.denom plan_value 
              ,v.actual_value / d.denom actual_value
              ,h.value_date
          from v_smb_deposit_process d
              ,smb_deposit trn  
              ,register_value v
              ,register_history h
              ,register_type rt
         where d.deposit_id = trn.id
           and d.process_code in ('NEW_TRANCHE', 'REPLENISH_TRANCHE')
           and trn.is_replenishment_tranche = 1
           and v.object_id = d.deposit_id
           and v.id = h.register_value_id
           and h.id = d.register_history_id
           and rt.register_code = 'SMB_PRINCIPAL_AMOUNT'
           and v.register_type_id = rt.id 
) d
;

comment on table  v_smb_deposit_replenishment                                 is 'пополнения';
comment on column v_smb_deposit_replenishment.register_history_id             is 'идентификатор истории по регистрам';
comment on column v_smb_deposit_replenishment.register_value_id               is 'идентификатор регистра';
comment on column v_smb_deposit_replenishment.value_date                      is 'дата пополнения';
comment on column v_smb_deposit_replenishment.amount                          is 'сумма';
comment on column v_smb_deposit_replenishment.is_active                       is 'статус (Y/N)';
comment on column v_smb_deposit_replenishment.is_planned                      is 'плановая сумма (Y/N)';
comment on column v_smb_deposit_replenishment.sys_time                        is 'дата создания';
comment on column v_smb_deposit_replenishment.deal_number                     is 'номер депозита / поплнения';
comment on column v_smb_deposit_replenishment.start_date                      is 'дата начала действия депозита';
comment on column v_smb_deposit_replenishment.plan_value                      is 'плановая сумма депозита';
comment on column v_smb_deposit_replenishment.actual_value                    is 'фактическая сумма депозита';
comment on column v_smb_deposit_replenishment.replenish_state                 is 'наименование состояния процесса';
comment on column v_smb_deposit_replenishment.replenish_state_code            is 'код  состояния процесса';
comment on column v_smb_deposit_replenishment.replenish_state_name            is 'наименование состояния депозита/пополнения';
comment on column v_smb_deposit_replenishment.type_                           is 'тип (основний транш / поповнення)';
comment on column v_smb_deposit_replenishment.replenish_type_code             is 'тип процесса';
comment on column v_smb_deposit_replenishment.object_id                       is 'идентификатор объекта/ депозита';
comment on column v_smb_deposit_replenishment.process_id                      is 'идентификатор процесса';
comment on column v_smb_deposit_replenishment.is_replenishment_tranche        is 'пополнеие (0, 1) оно здесь не нужно';
comment on column v_smb_deposit_replenishment.customer_id                     is 'идентификатор клиента';

PROMPT *** Create  grants  V_SMB_DEPOSIT_REPLENISHMENT ***
grant SELECT  on v_smb_deposit_replenishment  to BARSREADER_ROLE;
grant SELECT  on v_smb_deposit_replenishment  to BARS_ACCESS_DEFROLE;

PROMPT ====================================================================================
PROMPT *** End *** == Scripts /Sql/BARS/View/V_SMB_DEPOSIT_REPLENISHMENT.sql == *** End ***
PROMPT ====================================================================================