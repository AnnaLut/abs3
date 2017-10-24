

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_DEB_REG_TMP.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_DEB_REG_TMP ***

  CREATE OR REPLACE TRIGGER BARS.TIU_DEB_REG_TMP 
before insert or update on deb_reg_tmp for each row
begin
  if :new.eventdate is null then
    :new.eventdate := bankdate;
  end if;
end;
/
ALTER TRIGGER BARS.TIU_DEB_REG_TMP ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_DEB_REG_TMP.sql =========*** End
PROMPT ===================================================================================== 
