

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_ARCRRP_DCP.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_ARCRRP_DCP ***

  CREATE OR REPLACE TRIGGER BARS.TIU_ARCRRP_DCP 
  AFTER INSERT OR UPDATE ON "BARS"."ARC_RRP"
  REFERENCING FOR EACH ROW
DECLARE
Ret_ number;
Mfo_ varchar2(12);
BEGIN
   IF :NEW.MFOA<>:NEW.MFOB AND instr(:NEW.D_REC,'#d')>0 THEN
      Mfo_ := gl.aMFO;
      BEGIN
         SELECT count(*) INTO Ret_
         FROM dual
         WHERE :NEW.MFOA in (select mfo from banks where kodn=6 and mfop=Mfo_)
           AND :NEW.MFOB=Mfo_
           AND :NEW.SOS=5
            OR :NEW.MFOA in (select mfo from banks where kodn=6 and mfop=Mfo_)
           AND :NEW.MFOB in (select mfo from banks where kodn=6 and mfop=Mfo_)
           AND :NEW.FN_B is not null and :NEW.DAT_B is not null
           AND (:NEW.FN_B, :NEW.DAT_B) in (select fn, dat from zag_b where otm=7) ;
         if Ret_ > 0 then
            INSERT INTO DCP_B(rec) VALUES(:NEW.REC);
         end if;
      EXCEPTION WHEN OTHERS THEN null;
      END;
   END IF;
END;


/
ALTER TRIGGER BARS.TIU_ARCRRP_DCP ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_ARCRRP_DCP.sql =========*** End 
PROMPT ===================================================================================== 
