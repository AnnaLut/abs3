

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TI_SEC_AUDIT.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TI_SEC_AUDIT ***

  CREATE OR REPLACE TRIGGER BARS.TI_SEC_AUDIT 
  AFTER INSERT ON "BARS"."SEC_AUDIT"
  REFERENCING FOR EACH ROW
  declare

ret_    number;
alarm_  number;

begin

    alarm_ := 0;

    begin
        select decode(sec_alarm, 'Y', 1, 0) into alarm_
          from sec_rectype
         where sec_rectype = :new.rec_type;
    exception
        when NO_DATA_FOUND then
        alarm_ := 0;
    end;

    if (alarm_ <> 0) then
        bars_alerter_push_msg(ret_,
           'SEC_WATCHER',
	   0,
	   :new.rec_message,
	   :new.rec_type,
	   to_char(:new.rec_date,'dd/MM/yyyy hh:mi:ss')||'@'||to_char(:new.rec_bdate,'dd/MM/yyyy'),
	   to_char(:new.rec_uid)||'@'||:new.machine);
    end if;

exception
    when OTHERS then return;
end ti_sec_audit;



/
ALTER TRIGGER BARS.TI_SEC_AUDIT ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TI_SEC_AUDIT.sql =========*** End **
PROMPT ===================================================================================== 
