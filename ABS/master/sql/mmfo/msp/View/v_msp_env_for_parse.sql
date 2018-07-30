PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/msp/view/v_msp_env_for_parse.sql =========*** Run *** =
PROMPT ===================================================================================== 

create or replace view v_msp_env_for_parse as
select "ID","ID_MSP_ENV","CODE","SENDER","RECIPIENT","PARTNUMBER","PARTTOTAL","ECP","DATA","DATA_DECODE","STATE","COMM","CREATE_DATE"
    from msp_envelopes
   where state = -1;
/

comment on table msp.v_msp_env_for_parse is 'Список нових конвертів від ІОЦ (для парсингу TOSS)';
comment on column msp.v_msp_env_for_parse.id is '№ реєстру = id msp.msp_requests act_type =1';
comment on column msp.v_msp_env_for_parse.id_msp_env is 'Внутрішній код пакета в ІОЦ';
comment on column msp.v_msp_env_for_parse.code is 'Код запиту від ІОЦ';
comment on column msp.v_msp_env_for_parse.sender is 'Відправник пакету';
comment on column msp.v_msp_env_for_parse.recipient is 'Отримувач пакету';
comment on column msp.v_msp_env_for_parse.partnumber is 'Порядковий номер частини конверту';
comment on column msp.v_msp_env_for_parse.parttotal is 'Загальна к-ть частин конверту';
comment on column msp.v_msp_env_for_parse.ecp is 'ЕЦП, який був накладений в ІОЦ';
comment on column msp.v_msp_env_for_parse.data is 'Зашифрований конверт';
comment on column msp.v_msp_env_for_parse.data_decode is 'Розшифрований конверт (base64)';
comment on column msp.v_msp_env_for_parse.state is 'Стан конверту';
comment on column msp.v_msp_env_for_parse.comm is 'Коментар обробки конверту';
comment on column msp.v_msp_env_for_parse.create_date is 'Дата створення конверту';


grant select on v_msp_env_for_parse to bars_access_defrole;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/msp/view/v_msp_env_for_parse.sql =========*** End *** =
PROMPT ===================================================================================== 
