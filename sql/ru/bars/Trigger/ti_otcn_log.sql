

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TI_OTCN_LOG.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TI_OTCN_LOG ***

  CREATE OR REPLACE TRIGGER BARS.TI_OTCN_LOG 
before insert on otcn_log for each row
begin
 select s_otcn_log.nextval into :new.id from dual;
end ti_implog;
/
ALTER TRIGGER BARS.TI_OTCN_LOG ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TI_OTCN_LOG.sql =========*** End ***
PROMPT ===================================================================================== 
