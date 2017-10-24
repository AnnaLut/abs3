

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_CPMANYUPD.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_CPMANYUPD ***

  CREATE OR REPLACE TRIGGER BARS.TBI_CPMANYUPD 
  BEFORE INSERT ON "BARS"."CP_MANY_UPD"
  REFERENCING FOR EACH ROW
begin

 select S_CPMANYupd.nextval into :new.U_ID from dual;
 :new.U_DAT := gl.bdate;

end tbi_CPMANYupd;
/
ALTER TRIGGER BARS.TBI_CPMANYUPD ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_CPMANYUPD.sql =========*** End *
PROMPT ===================================================================================== 
