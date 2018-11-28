
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BILLS/view/v_bill_receiver_log.sql =========*** R
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FORCE VIEW BILLS.V_BILL_RECEIVER_LOG ("EXP_ID", "REC_DATE", "USER_REF", "ACTION", "PARAM_STR", "RESULT", "ID") AS 
  select key_id as exp_id,
       rec_date,
       user_ref,
       action,
       param_str,
       result,
       id
  from BILL_AUDIT t
  where log_level = 'INFO'
;
 show err;
 
comment on table V_BILL_RECEIVER_LOG is 'Протокол роботи з отримувачами';
comment on column V_BILL_RECEIVER_LOG.EXP_ID is 'Дія';
comment on column V_BILL_RECEIVER_LOG.REC_DATE is 'Дата та час операції';
comment on column V_BILL_RECEIVER_LOG.USER_REF is 'Користувач, який виконав операцію';
comment on column V_BILL_RECEIVER_LOG.PARAM_STR is 'Ключові параметри';
comment on column V_BILL_RECEIVER_LOG.RESULT is 'Результат операції';
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BILLS/view/v_bill_receiver_log.sql =========*** E
 PROMPT ===================================================================================== 
 