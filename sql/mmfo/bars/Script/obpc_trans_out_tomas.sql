/* ТОМАС : відправка до СМ операцій з карт. рахунками */

begin
insert into obpc_trans_out select '10' ,328,1,'PAYTOMAS',0 from dual ;
  exception when others then  
  if sqlcode = -00001 then null;   else raise; end if;   
end;
/
