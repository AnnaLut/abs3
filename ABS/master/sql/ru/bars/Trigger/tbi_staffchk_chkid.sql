

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_STAFFCHK_CHKID.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_STAFFCHK_CHKID ***

  CREATE OR REPLACE TRIGGER BARS.TBI_STAFFCHK_CHKID 
before insert or update on staff_chk for each row
declare
  l_id number;
begin
  l_id := getglobaloption('BPK_CHK');
  if :new.chkid = l_id then
      -- Запрещено выдавать пользователям %s группу визирования!
      bars_error.raise_nerror('BPK', 'BPK_CHK', l_id);
  end if;
end;
/
ALTER TRIGGER BARS.TBI_STAFFCHK_CHKID ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_STAFFCHK_CHKID.sql =========*** 
PROMPT ===================================================================================== 
