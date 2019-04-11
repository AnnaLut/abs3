PROMPT =============================================================================
PROMPT *** Run *** == Scripts /Sql/BARS/View/V_SMB_PROCESS_DETAIL.sql == *** Run ***
PROMPT ============================================================================= 

PROMPT *** Create  view v_smb_process_detail  ***

create or replace force view v_smb_process_detail 
as
with prc_state as(
        select i.list_item_id
              ,i.list_item_name
              ,i.list_item_code   
          from list_type t
              ,list_item i 
         where t.list_code = 'PROCESS_STATE'
           and t.id = i.list_type_id)
select x.object_id deposit_id
      ,nvl(x.deal_number, d.deal_number) deal_number  
      ,case process_code
          when 'NEW_TRANCHE'             then 'розміщення траншу'
          when 'REPLENISH_TRANCHE'       then 'поповнення траншу'
          when 'EARLY_RETURN_TRANCHE'    then 'дострокове повернення траншу'
          when 'NEW_ON_DEMAND'           then 'відкриття вкладу на вимогу'
          when 'CLOSE_ON_DEMAND'         then 'закриття вкладу на вимогу'
          when 'TRANCHE_BLOCKING'        then 'блокування траншу'
          when 'TRANCHE_UNBLOCKING'      then 'розблокування траншу'
          when 'CHANGE_CALCULATION_TYPE' then 'зміна методу нарахування'
          when 'TRANCHE_PROLONGATION'    then 'пролонгація'
          when 'CLOSING_TRANCHE'         then 'закриття траншу'
          when 'REGISTRATION_ERROR'      then 'помилка'  
       end transaction_type
      ,case
          when process_code = 'TRANCHE_BLOCKING'
            then 'заблоковано' 
          when process_code = 'TRANCHE_UNBLOCKING'
            then 'розблоковано' 
          when process_code = 'TRANCHE_PROLONGATION'
            then 'пролонгація'
          when process_code = 'CLOSING_TRANCHE'
            then 'закрито' 
          when process_code = 'REGISTRATION_ERROR'
            then 'помилка'
          when x.process_state_id = 1
               -- возврат из авторизации
               -- т.е был ли процесс в статусе RUNNIG = 2 
               and exists(select null
                            from process_history h1
                           where h1.process_id = x.process_id
                             and h1.process_state_id = 2 
                             and h1.id < x.process_history_id) 
              then 
                 -- повторное редактирование после возврата с БО
                 case when exists(
                                select null
                                  from dual
                                 where (x.process_history_id, 1) in 
                                   (
                                    select h1.id, lag(h1.process_state_id) over(order by h1.id) state_id
                                      from process_history h1
                                     where h1.process_id = x.process_id
                                       and h1.id <= x.process_history_id)
                                   )      
                     then 'на редагуванні'
                     else 'відхилено БО / на редагуванні'
                 end  
          when x.process_state_id = 1
              then case when 
                           exists(select null
                                    from process_history h1
                                   where h1.process_id = x.process_id
                                     and h1.process_state_id = 1 
                                     and h1.id < x.process_history_id)  
                      then 'редагування'
                      else 'створено'
                  end    
          when x.process_state_id = 2 
             then  'на авторизації'
          when x.process_state_id = 3
          then
               -- проверяем на activity подтверждение бэк-офиса
               -- если DONE то недостаточно денег на счету
             case when    
                   exists(select null
                            from activity a
                                ,process_workflow pw
                                ,activity_history ah
                           where a.process_id = x.process_id
                             and a.activity_type_id = pw.id 
                             and pw.activity_code = 'BACK_OFFICE_CONFIRMATION'
                             and a.id = ah.activity_id  
                             and ah.activity_state_id = 5 -- DONE
                             and x.sys_time >= ah.sys_time
                             and 1 <> (
                                select nvl( min(case when h.comment_text = '#unexpected error#' then activity_state_id end) keep 
                                          (dense_rank first order by h.id), -1)
                                  from activity_history h
                                 where h.activity_id= a.id
                                   and h.id > ah.id
                                )   
                            )
                  then 'авторизовано з помилкою'
                  else 'помилка' 
             end                            
          when x.process_state_id = 5 
             then  'авторизовано'  
          else pst.list_item_name   
       end state_name
      ,x.sys_time       
      ,case
          when process_code = 'TRANCHE_BLOCKING'
            then x.comment_ 
          when process_code = 'TRANCHE_UNBLOCKING'
            then x.comment_
          when process_code = 'TRANCHE_PROLONGATION'
            then x.comment_ 
          when process_code = 'REGISTRATION_ERROR'
            then x.comment_
          when x.process_state_id = 1
               -- возврат из авторизации
               -- т.е был ли процесс в статусе RUNNIG = 2 
               and exists(select null
                            from process_history h1
                           where h1.process_id = x.process_id
                             and h1.process_state_id = 2 
                             and h1.id < x.process_history_id)
         -- значит у нас есть activity в статусе REMOVED = 4                 
          then 
                 -- повторное редактирование после возврата с БО
                 case when exists(
                                select null
                                  from dual
                                 where (x.process_history_id, 1) in 
                                   (
                                    select h1.id, lag(h1.process_state_id) over(order by h1.id) state_id
                                      from process_history h1
                                     where h1.process_id = x.process_id
                                       and h1.id <= x.process_history_id))      
                     then null
                     else  
                        (select max(ah.comment_text)
                          from activity a
                              ,activity_history ah
                              ,activity_dependency ad
                         where a.process_id = x.process_id
                           and a.id = ah.activity_id
                           and ah.sys_time >= x.sys_time
                           and a.id = ad.primary_activity_id
                           and x.process_state_id = 1    -- вернули в статус CREATED
                           -- берем первую activity учитывая dependency
                           and not exists(select  null 
                                            from activity_dependency ad2 
                                           where ad2.following_activity_id = a.id))
                 end  
          -- process в статусе DISCARDED      
          when x.process_state_id = 4
          then
                -- достаем причину удаления
               (select max(h.comment_text)
                       keep (dense_rank first order by h.id desc)  
                  from process_history h
                 where h.process_id = x.process_id
                   and h.process_state_id = x.process_state_id)
       end reason
      ,x.module_code
      ,x.process_code
      ,x.process_name
      ,x.process_id
      ,x.process_type_id
      ,x.process_history_id  
      ,x.process_state_id
      ,x.user_id
      ,u.fio
      ,ot.type_code deposit_type
      ,ot.type_name deposit_type_name
      ,o.object_type_id deposit_type_id
      ,x.action_date
from       
      (       
        select p.id process_id
              ,p.process_type_id
              ,p.object_id
              ,p.state_id
              ,ph.id process_history_id  
              ,ph.process_state_id
              ,ph.sys_time
              ,ph.user_id
              ,p.process_data
              ,ph.comment_text process_comment_text       
              ,pt.module_code, pt.process_code, pt.process_name
              ,coalesce(trn.comment_, dod.comment_, err.error_type||chr(10)||err.comment_) comment_ 
              ,nvl(trn.Deal_Number, dod.Deal_Number) Deal_Number 
              ,coalesce(trn.action_date, dod.action_date, prl.action_date, to_date(err.action_date, 'yyyy-mm-dd"T"hh24:mi:ss')) action_date
          from process p
              ,process_history ph
              ,process_type pt
              ,xmltable ('/SMBDepositTranche' passing xmltype(p.process_data) columns
                            Deal_Number        varchar2(100)  path 'DealNumber'
                           ,comment_           varchar2(1000) path 'Comment'
                           ,action_date        date           path 'ActionDate' 
                     )(+) trn
              ,xmltable ('/SMBDepositOnDemand' passing xmltype(p.process_data) columns
                            comment_           varchar2(1000) path 'Comment'
                           ,Deal_Number        varchar2(100)  path 'DealNumber'
                           ,action_date        date           path 'ActionDate'
                     )(+) dod            
              ,xmltable ('/SMBDepositProlongation' passing xmltype(p.process_data) columns
                            action_date        date           path 'ActionDate' 
                     )(+) prl
             ,xmltable ('/SMBDepositError' passing xmltype(p.process_data) columns
                            action_date        varchar2(50)   path 'ActionDate'
                           ,comment_           varchar2(4000) path 'data'
                           ,error_Type         varchar2(100)  path 'ErrorType'
                     )(+) err
        where 1 = 1
          and p.process_type_id = pt.id
          and p.id = ph.process_id  
          and pt.module_code = 'SMBD'
          -- берем только успешное блокирование / пролонгацию
          -- если при блокировке произошла ошибка откатывается весь процесс в предыдущий статус
          and (pt.process_code not in ('TRANCHE_BLOCKING', 'TRANCHE_UNBLOCKING', 'TRANCHE_PROLONGATION') or ph.process_state_id = 5) 
          ) x
    ,prc_state pst
    ,staff$base u
    ,smb_deposit dpt
    ,object o
    ,object_type ot
    ,deal d    
 where 1 = 1 
   and x.process_state_id = pst.list_item_id
   and u.id = x.user_id
   and x.object_id = dpt.id
   and x.object_id = o.id 
   and o.object_type_id = ot.id
   and ot.type_code in ('SMB_DEPOSIT_TRANCHE', 'SMB_DEPOSIT_ON_DEMAND')
   and dpt.id = d.id
;                    
                    
comment on table v_smb_process_detail is 'история движений по Траншам и ДпТ';
comment on column v_smb_process_detail.deposit_id              is 'идентификатор объекта';
comment on column v_smb_process_detail.deal_number             is 'номер депозита или номер пополнения транша';
comment on column v_smb_process_detail.transaction_type        is 'тип транзакции (создание, пополнение, блокировка....)';
comment on column v_smb_process_detail.state_name              is 'история состояний процеса';
comment on column v_smb_process_detail.sys_time                is 'врямя операции';
comment on column v_smb_process_detail.reason                  is 'комментарий, к действию ';
comment on column v_smb_process_detail.module_code             is 'модуль (SMBD)';
comment on column v_smb_process_detail.process_code            is 'код процесса';
comment on column v_smb_process_detail.process_name            is 'наименование процесса';
comment on column v_smb_process_detail.process_id              is 'идентификатор процесс';
comment on column v_smb_process_detail.process_type_id         is 'идентификатор типа процесс';
comment on column v_smb_process_detail.process_history_id      is 'идентификатор истории процесса';
comment on column v_smb_process_detail.process_state_id        is 'идентификатор истории процесса';
comment on column v_smb_process_detail.user_id                 is 'идентификатор пользователь' ;
comment on column v_smb_process_detail.fio                     is 'пользователь' ;
comment on column v_smb_process_detail.deposit_type            is 'тип депозита' ;
comment on column v_smb_process_detail.deposit_type_name       is 'наименование типа депозита' ;
comment on column v_smb_process_detail.deposit_type_id         is 'идентификатор типа депозита' ;
                    
PROMPT *** Create  grants  V_SMB_PROCESS_DETAIL ***
grant SELECT  on v_smb_process_detail  to BARSREADER_ROLE;
grant SELECT  on v_smb_process_detail  to BARS_ACCESS_DEFROLE;

PROMPT =============================================================================
PROMPT *** End *** == Scripts /Sql/BARS/View/V_SMB_PROCESS_DETAIL.sql == *** End ***
PROMPT =============================================================================