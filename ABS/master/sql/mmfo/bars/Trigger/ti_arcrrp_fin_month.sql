

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TI_ARCRRP_FIN_MONTH.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TI_ARCRRP_FIN_MONTH ***

  CREATE OR REPLACE TRIGGER BARS.TI_ARCRRP_FIN_MONTH 
  AFTER INSERT ON "BARS"."ARC_RRP"
  REFERENCING FOR EACH ROW
    WHEN (
new.kv=980 and new.fn_a like '$A%'
      ) declare
  l_mfo_b     banks.mfo%type;
begin
  --
  -- триггер служит для блокировки платежей от филиалов по 3 модели
  -- на все банки, кроме филиалов ВПС
  --
  select mfo into l_mfo_b from banks
  where mfo=:new.mfob and
    (    mfo=gl.kf                    -- на ГРЦ
      or (mfop=gl.kf and kodn=6)      -- на Обл. Дирекциии Ощадбанка
      or mfop in                      -- на районные балансовые учреждения
         (select mfo from banks
         where mfop=gl.kf and kodn=6)
    );
exception when no_data_found then
  raise_application_error(-20000, '\0977 - Блокування початкових від учасника забороняє цей платіж', TRUE);
end;


/
ALTER TRIGGER BARS.TI_ARCRRP_FIN_MONTH DISABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TI_ARCRRP_FIN_MONTH.sql =========***
PROMPT ===================================================================================== 
