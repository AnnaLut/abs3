begin
execute immediate 
'create table tmp_irr_user
as select c.*, 0 userid from tmp_irr c where 1=0';
exception when others then
if(sqlcode=-955) then null; else raise; end if;
end;
/

begin
execute immediate 
'ALTER TABLE BARS.tmp_irr_user
 ADD (USERID  number )';
exception when others then
if(sqlcode=-1430) then null; else raise; end if; 
end;
/

begin
execute immediate 'ALTER TABLE tmp_irr_user modify USERID DEFAULT sys_context(''bars_global'',''user_id'')';
end;
/