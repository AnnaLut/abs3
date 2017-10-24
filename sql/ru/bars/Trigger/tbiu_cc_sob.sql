

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBIU_CC_SOB.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBIU_CC_SOB ***

  CREATE OR REPLACE TRIGGER BARS.TBIU_CC_SOB before insert or update
  on cc_Sob for each row
DECLARE
  vSeq number;

begin

   if :NEW.FACT_DATE is not null then :NEW.OTM  :=6;    end if;
   if :NEW.OTM =6 and
      :NEW.FACT_DATE is null then
      :NEW.OTM:=(case when :OLD.OTM is null or :OLD.OTM=6 then 1 else :OLD.OTM end);
   end if;


   if inserting then
     select  s_cc_Sob.nextval into vSeq  from dual;
     :NEW.ID := vSeq;
     if :NEW.OTM  is null then   :NEW.OTM  :=1 ;       end if;
     if :NEW.FREQ is null then   :NEW.FREQ :=2 ;       end if;
     if :NEW.ISP  is null then   :NEW.ISP  :=USER_ID;  end if;
   end if;
end;
/
ALTER TRIGGER BARS.TBIU_CC_SOB ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBIU_CC_SOB.sql =========*** End ***
PROMPT ===================================================================================== 
