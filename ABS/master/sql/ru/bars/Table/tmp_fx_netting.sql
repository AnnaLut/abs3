begin
execute immediate 
'create table tmp_fx_netting
as select c.*, 0 userid from CCK_AN_TMP_UPB c where 1=0';
exception when others then
if(sqlcode=-955) then null; else raise; end if;
end;
/

begin
execute immediate 
'ALTER TABLE BARS.TMP_FX_NETTING
 ADD (USERID  number )';
exception when others then
if(sqlcode=-1430) then null; else raise; end if; 
end;
/

begin
execute immediate 'ALTER TABLE TMP_FX_NETTING modify USERID DEFAULT sys_context(''bars_global'',''user_id'')';
end;
/