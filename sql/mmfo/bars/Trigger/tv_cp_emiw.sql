

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TV_CP_EMIW.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TV_CP_EMIW ***

  CREATE OR REPLACE TRIGGER BARS.TV_CP_EMIW INSTEAD OF UPDATE
  ON V_CP_EMIW REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
begin
  delete from CP_EMIW where rnk=:old.rnk and tag=:old.tag;
  If :new.value is not null then
     insert into CP_EMIW (rnk,tag, value) values (:old.rnk,:old.tag, :new.value);
  end if;
end TV_CP_EMIW;


/
ALTER TRIGGER BARS.TV_CP_EMIW ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TV_CP_EMIW.sql =========*** End *** 
PROMPT ===================================================================================== 
