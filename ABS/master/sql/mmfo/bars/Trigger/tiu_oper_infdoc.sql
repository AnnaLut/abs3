

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_OPER_INFDOC.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_OPER_INFDOC ***

  CREATE OR REPLACE TRIGGER BARS.TIU_OPER_INFDOC 
before insert or update ON BARS.OPER
for each row
    WHEN (
new.dk is not null and new.mfoa is not null and new.mfob is not null and new.dk>1
      ) begin
  if :new.mfoa=:new.mfob and :new.mfob <> sys_context('bars_context','user_mfo') then
    bars_error.raise_nerror('SVC', 'INPDOC_LOCAL_INFDOC_DENY');
  end if;
end;



/
ALTER TRIGGER BARS.TIU_OPER_INFDOC ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_OPER_INFDOC.sql =========*** End
PROMPT ===================================================================================== 
