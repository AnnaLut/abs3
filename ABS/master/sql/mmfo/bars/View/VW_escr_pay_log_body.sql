

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/VW_ESCR_PAY_LOG_BODY.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  view VW_ESCR_PAY_LOG_BODY ***

  CREATE OR REPLACE FORCE VIEW BARS.VW_ESCR_PAY_LOG_BODY ("ID_LOG", "DEAL_ID", "ERR_CODE", "ERR_DESC", "COMMENTS") AS 
  select id_log ,-- не виводити
deal_id,--реф кд
err_code,--код помилки не показувати
et.description err_desc, --помилка
comments -- детально
from escr_pay_log_body lb,escr_errors_types et
where lb.err_code=et.id;

PROMPT *** Create  grants  VW_ESCR_PAY_LOG_BODY ***
grant SELECT                                                                 on VW_ESCR_PAY_LOG_BODY to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/VW_ESCR_PAY_LOG_BODY.sql =========*** E
PROMPT ===================================================================================== 
