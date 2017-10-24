

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TV_CP_KODW.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TV_CP_KODW ***

  CREATE OR REPLACE TRIGGER BARS.TV_CP_KODW INSTEAD OF UPDATE
  ON V_CP_KODW REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
begin
  delete from CP_kodW where id=:old.id and tag=:old.tag;
  If :new.value is not null then
     insert into CP_kodW (id,tag, value) values (:old.id,:old.tag, :new.value);
  end if;
end TV_CP_kodW;


/
ALTER TRIGGER BARS.TV_CP_KODW ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TV_CP_KODW.sql =========*** End *** 
PROMPT ===================================================================================== 
