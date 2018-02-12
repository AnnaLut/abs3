CREATE OR REPLACE TRIGGER TAU_V_CP_KODW INSTEAD OF INSERT OR UPDATE
  ON BARS.V_CP_KODW  FOR EACH ROW
BEGIN
  If inserting then
    if :new.id is not null and :new.tag is not null then
      insert into cp_kodw(id, tag, value)
      values(:new.id, :new.tag, :new.value);
    end if;
  End if;
  If updating then
    If :new.id is not null and :new.tag is not null then
       if :new.id <> :old.id then
         raise_application_error(-20001, 'Змінювати можна тільки власне значення дод. параметру. (спроба зміни ID ЦП)');
       end if;
       if :new.tag <> :old.tag then
         raise_application_error(-20001, 'Змінювати можна тільки власне значення дод. параметру. (спроба зміни TAG)');
       end if;
       MERGE into cp_kodw c using(select * from dual) d
       on (c.id = :new.id and tag = :new.tag)
       WHEN MATCHED THEN 
         update set value  = :new.value
        WHEN NOT MATCHED THEN 
          insert (id, tag, value)
          values(:new.id, :new.tag, :new.value);
         
/*       update cp_kodw
          set value  = :new.value
        where id  = :new.id
          and tag = :new.tag;*/
    End if;
  End if;
END;
/
ALTER TRIGGER BARS.TAU_V_CP_KODW ENABLE;
