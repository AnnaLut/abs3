

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIUD_V_BL_LOST_PASS.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIUD_V_BL_LOST_PASS ***

  CREATE OR REPLACE TRIGGER BARS.TIUD_V_BL_LOST_PASS 
INSTEAD OF INSERT OR UPDATE OR DELETE  ON BARS.V_BL_LOST_PASS FOR EACH ROW
declare
pass_ser_ BL_LOST_PASS.pass_ser%type;
pass_num_ BL_LOST_PASS.pass_num%type;
base_ bl_lost_pass.base_id%type;
c number;
BEGIN

if inserting or updating then
 PASS_SER_:=bl.validation_pass_ser(:NEW.PASS_SER);
 PASS_NUM_:=bl.validation_pass_num(:NEW.PASS_NUM);

 BASE_:=:NEW.BASE_ID;
 if :NEW.BASE_ID is null then
    BASE_:=0;

 end if;


  begin
    Insert into BL_LOST_PASS
       (PASS_SER, PASS_NUM, LNAME, FNAME, MNAME,
        BDATE, BASE, INFO_SOURCE, PASS_DATE, PASS_OFFICE,BASE_ID)
     Values
       (PASS_SER_, PASS_NUM_, upper(trim(:NEW.LNAME)), upper(trim(:NEW.FNAME)), upper(trim(:NEW.MNAME)),
       :NEW.BDATE, upper(trim(:NEW.BASE)),upper(trim(:NEW.INFO_SOURCE)), :NEW.PASS_DATE,upper(trim(:NEW.PASS_OFFICE)),BASE_);
 EXCEPTION
     WHEN others THEN
   if sqlcode=-1 then
    update BL_LOST_PASS
        set
            LNAME=upper(trim(:NEW.LNAME)),
            FNAME=upper(trim(:NEW.FNAME)),
            MNAME=upper(trim(:NEW.MNAME)),
            BDATE=upper(trim(:NEW.BDATE)),
            BASE= :NEW.BASE ,
            INFO_SOURCE=upper(trim(:NEW.INFO_SOURCE)),
            PASS_DATE=  :NEW.PASS_DATE,
            PASS_OFFICE=upper(trim(:NEW.PASS_OFFICE))
        where PASS_SER=PASS_SER_ and PASS_NUM=PASS_NUM_ and BASE_ID=BASE_
        and ( nvl(LNAME,'0')!=nvl(upper(trim(:NEW.LNAME)),'0') or
              nvl(FNAME,'0')!=nvl(upper(trim(:NEW.FNAME)),'0') or
              nvl(MNAME,'0')!=nvl(upper(trim(:NEW.MNAME)),'0') or
              nvl(BDATE,gl.bd)!=nvl(:NEW.BDATE,gl.bd) or
              nvl(BASE,'0')!=nvl(upper(trim(:NEW.BASE)),'0') or
              nvl(INFO_SOURCE,'0')!=nvl(upper(trim(:NEW.INFO_SOURCE)),'0') or
              nvl(PASS_DATE,gl.bd)!=nvl(upper(trim(:NEW.PASS_DATE)),gl.bd) or
              nvl(BASE,'0')!=nvl(upper(trim(:NEW.BASE)),'0') or
              nvl(PASS_OFFICE,'0')!=nvl(upper(trim(:NEW.PASS_OFFICE)),'0')
             );
    else
    raise;
    end if;

  end;

end if;

if deleting then

 PASS_SER_:=bl.validation_pass_ser(:OLD.PASS_SER);
 PASS_NUM_:=bl.validation_pass_num(:OLD.PASS_NUM);

 BASE_:=:OLD.BASE_ID;
 if :OLD.BASE_ID is null  then
    BASE_:=0;
 end if;

 delete from BL_LOST_PASS  where pass_ser=pass_ser_ and pass_num=pass_num_ and base_id=base_;
end if;
-- EXCEPTION
--     WHEN others THEN
--     RAISE_APPLICATION_ERROR (-20001,SQLERRM );

END;



/
ALTER TRIGGER BARS.TIUD_V_BL_LOST_PASS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIUD_V_BL_LOST_PASS.sql =========***
PROMPT ===================================================================================== 
