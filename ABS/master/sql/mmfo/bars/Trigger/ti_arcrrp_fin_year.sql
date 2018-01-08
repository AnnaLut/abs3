

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TI_ARCRRP_FIN_YEAR.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TI_ARCRRP_FIN_YEAR ***

  CREATE OR REPLACE TRIGGER BARS.TI_ARCRRP_FIN_YEAR 
   AFTER INSERT
   ON "BARS"."ARC_RRP"
   REFERENCING FOR EACH ROW
 WHEN (
new.kv=980 and new.fn_a like '$A%' and new.kf='300465'
      ) declare
  l_mfo_b     banks.mfo%type;
begin
      --
      -- триггер служит для блокировки платежей от филиалов по 3 модели
      -- кроме платежей на НБУ и Казначейство
      --
      select mfo into l_mfo_b from banks
      where mfo=:new.mfob and (
        mfo like '8%'                   -- на Казначейство
        or substr(sab,3,1)='H'          -- на Управления НБУ
        or mfo=gl.kf                    -- на ГРЦ
        or (mfop=gl.kf and kodn=6)      -- на Обл. Дирекциии Ощадбанка
        or mfop in                      -- на районные балансовые учреждения
          (select mfo from banks
           where mfop=gl.kf and kodn=6)
      );
     exception when no_data_found then
       raise_application_error(-20000, '\0978 - Заборонені платежі на всіх учасників, за виключенням НБУ та Казначейства', TRUE);

end;
/
ALTER TRIGGER BARS.TI_ARCRRP_FIN_YEAR DISABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TI_ARCRRP_FIN_YEAR.sql =========*** 
PROMPT ===================================================================================== 
