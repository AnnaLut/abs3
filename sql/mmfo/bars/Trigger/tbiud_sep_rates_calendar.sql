

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBIUD_SEP_RATES_CALENDAR.sql =======
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBIUD_SEP_RATES_CALENDAR ***

  CREATE OR REPLACE TRIGGER BARS.TBIUD_SEP_RATES_CALENDAR 
  BEFORE INSERT OR DELETE OR UPDATE OF START_DATE, FINISH_DATE ON "BARS"."SEP_RATES_CALENDAR"
  REFERENCING FOR EACH ROW
  declare
  err       exception;
  pragma    exception_init(err, -1);
begin
    if (inserting or updating) and :new.start_date>=:new.finish_date then
        raise_application_error(-20000, 'Дата начала периода должна быть строго меньше даты окончания периода');
    end if;
    if inserting then
        if :new.id is null then
            select s_sep_rates_calendar.nextval into :new.id from dual;
        end if;
        insert into sep_rates_fdat(fdat) select fdat from fdat where fdat between :new.start_date and :new.finish_date;
    elsif deleting then
        delete from sep_rates_fdat where fdat between :old.start_date and :old.finish_date;
    elsif updating then
        if :new.closed='Y' and (:old.start_date<>:new.start_date or :old.finish_date<>:new.finish_date) then
            raise_application_error(-20000, 'Период № '||:old.id||' уже закрыт и модификации не подлежит');
        end if;
        delete from sep_rates_totals where id=:old.id;
        delete from sep_rates_fdat where fdat between :old.start_date and :old.finish_date;
        insert into sep_rates_fdat(fdat) select fdat from fdat where fdat between :new.start_date and :new.finish_date;
    end if;
exception when err then
    if SQLERRM like 'ORA-00001: unique constraint (BARS.PK_SEPRATESFDAT) violated%' then
        raise_application_error(-20000, 'Текущий период перекрывается с прошлыми периодами', TRUE);
    end if;
end;



/
ALTER TRIGGER BARS.TBIUD_SEP_RATES_CALENDAR ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBIUD_SEP_RATES_CALENDAR.sql =======
PROMPT ===================================================================================== 
