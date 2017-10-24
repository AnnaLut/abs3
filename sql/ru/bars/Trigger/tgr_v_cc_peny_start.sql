

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TGR_V_CC_PENY_START.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TGR_V_CC_PENY_START ***

  CREATE OR REPLACE TRIGGER BARS.TGR_V_CC_PENY_START 
INSTEAD OF UPDATE OR INSERT OR DELETE
ON BARS.V_CC_PENY_START REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
 nd_ int;
 BR_ int:=0;
 gl_bd date:=gl.bd;
 l_IR varchar2(24);
--gl_bd date:=gl.bd;
BEGIN
 if  inserting or updating  then
   l_IR:=:NEW.IR;
   if upper(:NEW.ir)=upper('������ ������') then
      BR_:=1;
      l_IR:=null;
   end if;
   begin
     select min(nd) into nd_ from nd_acc n where acc=:new.acc;
     insert into cc_peny_start (acc,ostc,branch,nd,ir)
                        values (:NEW.acc,cck_app.to_number2(:NEW.OSTC)*100
                               ,:new.branch, nd_,l_IR);
   exception when DUP_VAL_ON_INDEX then
    update cc_peny_start set ostc=:NEW.ostc*100, IR=cck_app.TO_number2 (l_IR) where acc=:new.acc;
   end;
      begin
      select max(bdat) into gl_bd from int_ratn where id=2 and acc=:NEW.acc;
      exception when no_data_found then
       gl_bd:=gl.bd;
      end;
   if nvl(:OLD.IR,'000')!=nvl(:NEW.IR,'000') then

     if BR_=1 then
         delete from nd_txt where nd=nd_ and tag='SN8_R';
     else
         begin
          INSERT INTO ND_TXT (nd,tag,txt )VALUES (nd_,'SN8_R',l_IR);
         exception when dup_val_on_index then
          update nd_txt set txt=l_IR where nd=nd_ and tag='SN8_R';
         end;
     end if;
   end if;

 end if;

end TGR_v_cc_peny_start;
/
ALTER TRIGGER BARS.TGR_V_CC_PENY_START ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TGR_V_CC_PENY_START.sql =========***
PROMPT ===================================================================================== 
