

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_ZAYSEGMACC.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_ZAYSEGMACC ***

  CREATE OR REPLACE TRIGGER BARS.TIU_ZAYSEGMACC 
before insert or update on zay_segm_acc
for each row
declare
  l_nbs  accounts.acc%type;
begin
  select nbs into l_nbs from accounts where acc = :new.acc;
  if l_nbs <> '6114' then
    BARS_ERROR.raise_error('CAC', 6, to_char(l_nbs));
  end if;
end;


/
ALTER TRIGGER BARS.TIU_ZAYSEGMACC ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_ZAYSEGMACC.sql =========*** End 
PROMPT ===================================================================================== 
