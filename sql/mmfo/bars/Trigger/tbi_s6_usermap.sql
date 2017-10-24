

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_S6_USERMAP.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_S6_USERMAP ***

  CREATE OR REPLACE TRIGGER BARS.TBI_S6_USERMAP 
BEFORE INSERT on s6_usermap FOR EACH ROW
begin
  :new.kf := nvl(:new.kf,f_ourmfo_g);
  :new.USERSUFFIX := to_char(:new.isps6);
END tbi_s6_usermap;



/
ALTER TRIGGER BARS.TBI_S6_USERMAP ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_S6_USERMAP.sql =========*** End 
PROMPT ===================================================================================== 
