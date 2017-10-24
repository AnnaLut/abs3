
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/kl_params.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.KL_PARAMS 
is
  /*
  A typical usage of these boolean constants is

         $if KL_PARAMS.SBER $then
           --
         $else
           --
         $end
  */

  VERSION      constant pls_integer := 1;
  SBER         constant boolean     := TRUE;  -- OSC   - Для ОщадБанка
  TREASURY     constant boolean     := FALSE; -- KAZ   - Для казначейства (без связ.клиентов, счетов юр.лиц в др.банках)
  NADRA        constant boolean     := FALSE; -- NADRA - Для банка Надра
  SIGN         constant boolean     := TRUE;  -- SIGN  - С функцией обновления подписи/печати
  FINMON       constant boolean     := TRUE;  -- FM    - С функцией проверки наименования клиента на принадлежность к списку террористов
  RI           constant boolean     := TRUE;  -- RI    - С функцией обработки согласно реестра инсайдеров (CUSTOMER_RI)
  CLV          constant boolean     := TRUE;  -- CLV   - С визированием обновлений

end KL_PARAMS;
/

 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/kl_params.sql =========*** End *** =
 PROMPT ===================================================================================== 
 