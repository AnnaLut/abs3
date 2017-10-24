

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_DEB_REG_MAN.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_DEB_REG_MAN ***

  CREATE OR REPLACE TRIGGER BARS.TIU_DEB_REG_MAN 
before insert or update on deb_reg_man for each row
begin
  if :new.eventdate is null then
    :new.eventdate := bankdate;
  end if;
end;
/
ALTER TRIGGER BARS.TIU_DEB_REG_MAN ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_DEB_REG_MAN.sql =========*** End
PROMPT ===================================================================================== 
