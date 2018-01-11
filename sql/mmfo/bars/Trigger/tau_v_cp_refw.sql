

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAU_V_CP_REFW.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAU_V_CP_REFW ***

  CREATE OR REPLACE TRIGGER BARS.TAU_V_CP_REFW INSTEAD OF INSERT OR UPDATE
  ON BARS.V_CP_REFW  FOR EACH ROW
BEGIN
  If inserting then
    if :new.ref is not null and :new.tag is not null then
      insert into cp_refw(ref, tag, value)
      values(:new.ref, :new.tag, :new.value);
    end if;
  End if;
  If updating then
    If :new.ref is not null and :new.tag is not null then
       if :new.ref <> :old.ref then
         raise_application_error(-20001, 'Змінювати можна тільки власне значення дод. параметру. (спроба зміни REF угоди ЦП)');
       end if;
       if :new.tag <> :old.tag then
         raise_application_error(-20001, 'Змінювати можна тільки власне значення дод. параметру. (спроба зміни TAG)');
       end if;
       MERGE into cp_refw c using(select * from dual) d
       on (c.ref = :new.ref and tag = :new.tag)
       WHEN MATCHED THEN
         update set value  = :new.value
        WHEN NOT MATCHED THEN
          insert (ref, tag, value)
          values(:new.ref, :new.tag, :new.value);

    End if;
  End if;
END;
/
ALTER TRIGGER BARS.TAU_V_CP_REFW ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAU_V_CP_REFW.sql =========*** End *
PROMPT ===================================================================================== 
