create or replace trigger TBIU_CCLIM_SUM
before insert or update
of SUMG, SUMO
on CC_LIM
for each row
declare
begin
  if ( nvl(:new.SUMO,0) < nvl(:new.SUMG,0) )
  then
   :new.SUMO := :new.SUMG;
  end if;
end TBIU_CCLIM_SUM;