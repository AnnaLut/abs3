

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TGR_V_CC_START_PARAMS.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TGR_V_CC_START_PARAMS ***

  CREATE OR REPLACE TRIGGER BARS.TGR_V_CC_START_PARAMS 
INSTEAD OF UPDATE OR INSERT OR DELETE
ON BARS.V_CC_START_PARAMS REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
 nd_ int;
BEGIN
 if  updating  then
    update cc_deal set sdate=nvl(:NEW.SDATE,sdate), wdate=nvl(:NEW.WDATE,sdate)  where nd=:OLD.ND and :NEW.SDATE<:NEW.WDATE;
    update cc_add set bdate=:NEW.SDATE,wdate=:NEW.SDATE where nd=:OLD.ND and :NEW.SDATE<:NEW.WDATE;
 end if;

end TGR_v_cc_start_params;




/
ALTER TRIGGER BARS.TGR_V_CC_START_PARAMS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TGR_V_CC_START_PARAMS.sql =========*
PROMPT ===================================================================================== 
