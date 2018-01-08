

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_ZAYSEGMACC.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_ZAYSEGMACC ***


  CREATE OR REPLACE TRIGGER BARS.tiu_zaysegmacc
before insert or update ON BARS.ZAY_SEGM_ACC
for each row
declare
  l_nbs  accounts.acc%type;
begin
  select nbs into l_nbs from accounts where acc = :new.acc;
  if l_nbs <> case when newnbs.g_state= 1 then '6514' else'6114' end then
    BARS_ERROR.raise_error('CAC', 6, to_char(l_nbs));
  end if;
end;



/

ALTER TRIGGER BARS.TIU_ZAYSEGMACC ENABLE;
/

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_ZAYSEGMACC.sql =========*** End 
PROMPT ===================================================================================== 
