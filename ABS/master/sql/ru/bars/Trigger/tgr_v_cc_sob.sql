

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TGR_V_CC_SOB.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TGR_V_CC_SOB ***

  CREATE OR REPLACE TRIGGER BARS.TGR_V_CC_SOB 
INSTEAD OF UPDATE  OR DELETE OR INSERT
ON BARS.V_CC_SOB REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE

new_dat date;
BEGIN

 ---  19/04/2013 Возвращаем deleting
 ---  03/07/2012 По просьбе Ощада Чтобы не могли химичить убираем deleting

 if deleting then
    delete from cc_sob where id=:OLD.ID;
 end if;

if inserting then
    insert into cc_sob (nd,fdat,txt,freq,psys)
   values (:NEW.ND, to_date(:NEW.FDAT,'dd/mm/yyyy') ,:NEW.TXT,:NEW.FREQ,:NEW.PSYS);
 end if;

 if  updating  then

  update cc_sob set otm=:NEW.OTM, freq=:NEW.FREQ, txt=:NEW.TXT, fact_date=to_date(:NEW.fact_date,'dd/mm/yyyy') ,
  isp=:NEW.ISP
  where id=:OLD.ID and nd=:OLD.ND;
  if :NEW.OTM!=:OLD.OTM and :NEW.OTM=6 then
     if :OLD.FREQ=1 then new_dat:=CorrectDate2(980,to_date(:OLD.FDAT,'dd/mm/yyyy')+1,0);
     elsif :OLD.FREQ=3 then new_dat:=CorrectDate2(980,to_date(:OLD.FDAT,'dd/mm/yyyy')+7,0);
     elsif :OLD.FREQ=5 then new_dat:=add_months(to_date(:OLD.FDAT,'dd/mm/yyyy'),1);
     elsif :OLD.FREQ=7 then new_dat:=add_months(to_date(:OLD.FDAT,'dd/mm/yyyy'),3);
     elsif :OLD.FREQ=7 then new_dat:=add_months(to_date(:OLD.FDAT,'dd/mm/yyyy'),3);
     elsif :OLD.FREQ=180 then new_dat:=add_months(to_date(:OLD.FDAT,'dd/mm/yyyy'),6);
     elsif :OLD.FREQ=360 then new_dat:=add_months(to_date(:OLD.FDAT,'dd/mm/yyyy'),12);
     else
        new_dat:=to_date(:OLD.FDAT,'dd/mm/yyyy');
     end if;

    begin
       insert into cc_sob (nd,fdat,txt,freq,psys)
   values (:OLD.ND, new_dat,:NEW.TXT,:OLD.FREQ,:OLD.PSYS);
   exception when dup_val_on_index then
    null;
   end;
   end if;

 end if;

end TGR_V_CC_SOB;
/
ALTER TRIGGER BARS.TGR_V_CC_SOB ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TGR_V_CC_SOB.sql =========*** End **
PROMPT ===================================================================================== 
