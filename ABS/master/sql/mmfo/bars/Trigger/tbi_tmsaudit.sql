CREATE OR REPLACE TRIGGER TBI_TMSAUDIT
  BEFORE INSERT ON BARS.TMS_AUDIT
  REFERENCING FOR EACH ROW
begin
    if (:new.rec_id is null) then
        select s_tmsaudit.nextval into :new.rec_id from dual;
    end if;

    if (:new.rec_bdate is null) then
        :new.rec_bdate := bankdate;
    end if;
end;
/
