

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_CC_SOB.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_CC_SOB ***

  CREATE OR REPLACE TRIGGER BARS.TBI_CC_SOB 
  BEFORE INSERT ON "BARS"."CC_SOB"
  REFERENCING FOR EACH ROW
  DECLARE
  vSeq number;
begin
     select  s_cc_Sob.nextval into vSeq  from dual;
     :NEW.ID := vSeq;
     if :NEW.OTM  is null then   :NEW.OTM  :=1 ;       end if;
     if :NEW.FREQ is null then   :NEW.FREQ :=2 ;       end if;
     if :NEW.ISP  is null then   :NEW.ISP  :=USER_ID;  end if;
end;



/
ALTER TRIGGER BARS.TBI_CC_SOB ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_CC_SOB.sql =========*** End *** 
PROMPT ===================================================================================== 
