

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TV_CP_REFW.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TV_CP_REFW ***

  CREATE OR REPLACE TRIGGER BARS.TV_CP_REFW INSTEAD OF UPDATE
  ON V_CP_refW REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
begin
  delete from CP_refW where ref=:old.ref and tag=:old.tag;
  If :new.value is not null then
     insert into CP_refW (ref,tag, value) values (:old.ref,:old.tag, :new.value);
  end if;
end TV_CP_refW;


/
ALTER TRIGGER BARS.TV_CP_REFW ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TV_CP_REFW.sql =========*** End *** 
PROMPT ===================================================================================== 
