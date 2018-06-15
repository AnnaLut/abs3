create or replace trigger TBIU_CCLIM_SUM
before insert or update
of SUMG, SUMO
on CC_LIM
for each row
declare
begin
  :new.SUMO := nvl(:new.SUMO,0);
  :new.SUMG := nvl(:new.SUMG,0);
  if ( :new.SUMO < :new.SUMG )
  then
   :new.SUMO := :new.SUMG;
  end if;
end TBIU_CCLIM_SUM;
/

show errors;
