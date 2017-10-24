

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_BL_BLOCK.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_BL_BLOCK ***

  CREATE OR REPLACE TRIGGER BARS.TBI_BL_BLOCK 
BEFORE INSERT
ON BARS.BL_BLOCK
REFERENCING NEW AS New OLD AS Old
FOR EACH ROW
DECLARE


BEGIN

  if inserting or updating then
     if :NEW.ID is null then
        SELECT S_BL_BLOCK_ID.NEXTVAL INTO :NEW.ID FROM dual;
     end if;
     :NEW.USER_ID := gl.aUID;
     if inserting or :NEW.BLK_DATE is null then
        :NEW.BLK_DATE := SYSDATE;
     end if;
  end if;

END TBI_BL_BLOCK;
/
ALTER TRIGGER BARS.TBI_BL_BLOCK ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_BL_BLOCK.sql =========*** End **
PROMPT ===================================================================================== 
