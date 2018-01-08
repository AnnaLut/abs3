
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/t_priocom_exchange.sql =========*** Run
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.T_PRIOCOM_EXCHANGE as object
(
  selector varchar2(30),
  message  varchar2(1024)
)
/

 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/t_priocom_exchange.sql =========*** End
 PROMPT ===================================================================================== 
 