

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_ZAYAVKA.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_ZAYAVKA ***

  CREATE OR REPLACE TRIGGER BARS.TU_ZAYAVKA 
after update ON BARS.ZAYAVKA
for each row
  WHEN (
new.viza<>old.viza and new.fnamekb is not null and new.identkb is not null
      ) declare
  l_idback  zay_back.id%type;
  l_reason  zay_back.reason%type;
begin

  if :new.viza = -1 then
     l_idback := :new.idback;
     select reason into l_reason from zay_back where id = l_idback;
  else
     l_idback := 0;
     l_reason := null;
  end if;

  insert into zay_baop (id, tipkb, kod, textback, identkb, fnamekb)
  values (bars_sqnc.get_nextval('s_zay_baop'), :new.tipkb, l_idback, l_reason, :new.identkb, :new.fnamekb);

end;

/
ALTER TRIGGER BARS.TU_ZAYAVKA ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_ZAYAVKA.sql =========*** End *** 
PROMPT ===================================================================================== 
