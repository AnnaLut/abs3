

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TGR_V_CC_SOB_W.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TGR_V_CC_SOB_W ***

  CREATE OR REPLACE TRIGGER BARS.TGR_V_CC_SOB_W 
INSTEAD OF UPDATE  OR DELETE OR INSERT
ON BARS.V_CC_SOB_W REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE

new_dat date;
BEGIN

 -- Разрешаем удалять событие только если существует такое же событие с таким же типов в тот же день
 if deleting and :OLD.PSYS>0 and :OLD.ID is not null and :OLD.FDAT is not null then
    delete from cc_sob where id=:OLD.ID and
       exists (select 1 from cc_sob where nd=:OLD.ND and  psys=:OLD.PSYS
                                          and fdat=to_date(:OLD.FDAT,'dd/mm/yyyy')
                                          and  id!=:OLD.ID
              );
 end if;


 If nvl(:new.otm,0) <=0 then
     raise_application_error(
            -20203,
            '\9359 - Стан події не заповнено, вкажіть стан події ',
            TRUE);
 end if;



 if inserting then

  if :NEW.PSYS>0 then
    insert into cc_sob (nd,fdat,txt,freq,psys,otm)
    select :NEW.ND, to_date(:NEW.FDAT,'dd/mm/yyyy') ,:NEW.TXT,:NEW.FREQ,:NEW.PSYS , :NEW.OTM  from dual
    where not exists (select 1 from cc_sob where nd=:NEW.ND and  psys=:NEW.PSYS and fdat=to_date(:NEW.FDAT,'dd/mm/yyyy') );
  else
     insert into cc_sob (nd,fdat,txt,freq,psys,otm)
     values (:NEW.ND, to_date(:NEW.FDAT,'dd/mm/yyyy') ,:NEW.TXT,:NEW.FREQ,:NEW.PSYS, :NEW.OTM);
  end if;

 end if;

if  updating  then

  update cc_sob set otm=(case when :OLD.fact_date is not null and :NEW.fact_date is not null then 6 else :NEW.OTM end), freq=:NEW.FREQ, txt=:NEW.TXT, fact_date=to_date(:NEW.fact_date,'dd/mm/yyyy') ,
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
       insert into cc_sob (nd,fdat,txt,freq,psys,otm)
   values (:OLD.ND, new_dat,:NEW.TXT,:OLD.FREQ,:OLD.PSYS,1);
   exception when dup_val_on_index then
    null;
   end;
   end if;

 end if;

end TGR_V_CC_SOB_W;


/
ALTER TRIGGER BARS.TGR_V_CC_SOB_W ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TGR_V_CC_SOB_W.sql =========*** End 
PROMPT ===================================================================================== 
