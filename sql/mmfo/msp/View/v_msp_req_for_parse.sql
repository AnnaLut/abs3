PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/msp/view/v_msp_req_for_parse.sql =========*** Run *** =
PROMPT ===================================================================================== 

create or replace view v_msp_req_for_parse as
select ID,REQ_xml,STATE, act_type, create_date
    from msp_requests mr
   where mr.state = -1
     and mr.act_type = 1;
/

comment on table v_msp_req_for_parse is 'Нові запити від ІВЦ (payment_data)';
comment on column v_msp_req_for_parse.id is 'id запиту';
comment on column v_msp_req_for_parse.req_xml is 'XML запиту';
comment on column v_msp_req_for_parse.state is 'Стан запиту (msp_request_state)';
comment on column v_msp_req_for_parse.act_type is '1 - msp_const.req_PAYMENT_DATA - ІВЦ прислав файл (конверт), 2 - не використовується, 3 - msp_const.req_DATA_STATE - запит на стан прийнятого файлу, 4 - msp_const.req_VALIDATION_STATE - запит на результат валідації реєстру (квитанція 1), 5 - msp_const.req_PAYMENT_STATE - запит на квитанцію 2 (факт оплати реєстрів в конверті)';
comment on column v_msp_req_for_parse.create_date is 'Дата створення запиту';
   
grant select on v_msp_req_for_parse to bars_access_defrole;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/msp/view/v_msp_req_for_parse.sql =========*** End *** =
PROMPT ===================================================================================== 
