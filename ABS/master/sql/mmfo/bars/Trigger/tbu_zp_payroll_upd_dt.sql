create or replace trigger tbu_zp_payroll_upd_dt
before update on ZP_PAYROLL for each row
declare
begin
:new.upd_date:=sysdate;
end;
/
