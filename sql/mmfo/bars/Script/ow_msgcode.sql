/* ТОМАС : відправка до СМ операцій з карт. рахунками */

begin
insert into ow_msgcode  select 'PAYTOMAS' ,1,'P5BACA' from dual ;
  exception when others then  
  if sqlcode = -00001 then null;   else raise; end if;   
end;
/
