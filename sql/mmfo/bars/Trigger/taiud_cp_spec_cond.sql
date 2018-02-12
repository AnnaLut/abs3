  CREATE OR REPLACE TRIGGER BARS.taiud_cp_spec_cond
before insert or update or delete on cp_spec_cond for each row
declare
-- l_id number;
begin
  if deleting then
    raise_application_error(  -20001, 'Фізичне видалення з довіднику заборонено');
  elsif updating then
    if :old.del_date is not null and :new.del_date is not null then
      raise_application_error(  -20001, 'Зміна запису заборонено так як помічено як видалений');
    end if;
  elsif inserting then
    if :new.id is null then
     select nvl(max(id),0) + 1 into :new.id from cp_spec_cond;
    end if;
  end if;
end;



/
ALTER TRIGGER BARS.taiud_cp_spec_cond ENABLE;
