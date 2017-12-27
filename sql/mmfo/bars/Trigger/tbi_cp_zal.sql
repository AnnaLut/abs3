create or replace trigger TBI_CP_ZAL
  before insert ON BARS.CP_ZAL
  referencing  for each row
declare
begin

  if INSERTING then
    :new.id_cp_zal :=  bars_sqnc.get_nextval('S_CP_ZAL');
  end if;

end TBI_CP_ZAL;
/