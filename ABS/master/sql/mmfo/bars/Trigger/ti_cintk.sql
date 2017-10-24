

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TI_CINTK.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TI_CINTK ***

  CREATE OR REPLACE TRIGGER BARS.TI_CINTK 
  BEFORE INSERT ON "BARS"."CIN_TK"
  REFERENCING FOR EACH ROW
  begin
  If Nvl(:new.id, 0 ) = 0 then
     select s_CIN_TK.nextval into :NEW.ID from dual;
  end if;
 -----------------
end ti_CINTK;



/
ALTER TRIGGER BARS.TI_CINTK ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TI_CINTK.sql =========*** End *** ==
PROMPT ===================================================================================== 
