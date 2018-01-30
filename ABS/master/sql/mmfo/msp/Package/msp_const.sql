create or replace package msp_const is

  -- msp_requests.act_type
  req_PAYMENT_DATA     constant number := 1;
  req_DATA_STATE       constant number := 3;
  req_VALIDATION_STATE constant number := 4;
  req_PAYMENT_STATE    constant number := 5;

  -- msp_requests.state
  st_req_NEW_REQUEST             constant number := -1; -- Новий запит
  st_req_PARSED                  constant number :=  0; -- Розпарсений успішно
  st_req_ERROR_ECP_REQUEST       constant number :=  1; -- Помилка ЕЦП для конверту
  st_req_ERROR_DECRYPT_ENVELOPE  constant number :=  2; -- Помилка розшифрування даних конверту
  st_req_ERROR_XML_ENVELOPE      constant number :=  3; -- Помилка в структурі xml
  st_req_ERROR_UNPACK_ENVELOPE   constant number :=  4; -- Помилка при розархівуванні файлу
  st_req_ERROR_UNIQUE_ENVELOPE   constant number :=  5; -- Помилка унікальності конверту

  -- msp_envelopes.state
  st_env_ENVLIST_PROCESSING      constant number := -2; -- Конверт в процесі розшифрування
  st_env_ENVLIST_RECEIVED        constant number := -1; -- Новий конверт
  st_env_PARSED                  constant number :=  0; -- Конверт розібраний
  st_env_ERROR_ECP_ENVELOPE      constant number :=  1; -- Помилка ЕЦП для файлу
  st_env_ERROR_DECRYPT_ENVELOPE  constant number :=  2; -- Помилка розшифрування даних конверту
  st_env_ERROR_XML_ENVELOPE      constant number :=  3; -- Помилка в структурі xml
  st_env_ERROR_UNPACK_ENVELOPE   constant number :=  4; -- Помилка при розархівуванні файлу
  st_env_MATCH1_PROCESSING       constant number :=  9; -- Квитанція 1 в процесі формування
  st_env_MATCH2_PROCESSING       constant number :=  10; -- Квитанція 2 в процесі формування
  st_env_MATCH1_CREATED          constant number :=  11; -- Квитанція 1 зформована
  st_env_MATCH1_SIGN_WAIT        constant number :=  12; -- Конверт квитанції 1 готовий до підписання
  st_env_MATCH1_CREATE_ERROR     constant number :=  13; -- Помилка формування квитанції 1
  st_env_MATCH1_SEND             constant number :=  14; -- Квитанція 1 відправлена
  st_env_MATCH1_ENV_CREATE_ERROR constant number :=  15; -- Помилка формування конверту квитанції 1
  st_env_MATCH2_CREATED          constant number :=  16; -- Квитанція 2 зформована
  st_env_MATCH2_SIGN_WAIT        constant number :=  17; -- Конверт квитанції 2 готовий до підписання
  st_env_MATCH2_CREATE_ERROR     constant number :=  18; -- Помилка формування квитанції 2
  st_env_MATCH2_SEND             constant number :=  19; -- Квитанція 2 відправлена
  st_env_MATCH2_ENV_CREATE_ERROR constant number :=  20; -- Помилка формування конверту квитанції 2

end msp_const;
/
