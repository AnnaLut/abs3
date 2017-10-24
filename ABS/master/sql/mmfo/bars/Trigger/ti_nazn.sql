

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TI_NAZN.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TI_NAZN ***

  CREATE OR REPLACE TRIGGER BARS.TI_NAZN 
  BEFORE INSERT ON "BARS"."ARC_RRP"
  REFERENCING FOR EACH ROW
    WHEN (
NEW.MFOB='300465' AND NEW.NLSB='26503301839'
      ) DECLARE
-- Проверка назначения платежа для СберБанкА
  l_mfo    banks.mfo%type;
BEGIN
    begin
      select mfo into l_mfo from (
        select mfo from banks where kodn=6 and blk=0
        union all
        select mfo from banks where blk=0 and mfop in (select mfo from banks where kodn=6 and blk=0)
      ) where mfo=:new.mfoa;
      if substr(:NEW.nazn,1,3) <> '$%$' then
        :NEW.blk:=8614;
      end if;
    exception when no_data_found then null;
    end;
END;


/
ALTER TRIGGER BARS.TI_NAZN ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TI_NAZN.sql =========*** End *** ===
PROMPT ===================================================================================== 
