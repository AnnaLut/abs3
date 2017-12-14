CREATE OR REPLACE VIEW VW_escr_pay_log_body AS
select id_log ,-- не виводити  
deal_id,--реф кд
err_code,--код помилки не показувати
et.description err_desc, --помилка
comments -- детально
from escr_pay_log_body lb,escr_errors_types et
where lb.err_code=et.id;
grant
  select on VW_escr_pay_log_body to BARS_ACCESS_DEFROLE;
