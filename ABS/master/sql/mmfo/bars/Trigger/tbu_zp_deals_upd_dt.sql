create or replace trigger tbu_zp_deals_upd_dt
before update on zp_deals for each row
declare
begin
:new.upd_date:=sysdate;
end;
/
