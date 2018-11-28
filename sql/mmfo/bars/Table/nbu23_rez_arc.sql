begin 
  execute immediate 'ALTER TABLE BARS.NBU23_REZ_ARC DROP PRIMARY KEY CASCADE';
exception when others then 
  if sqlcode in (-942,-02441) then null; else raise; end if;
end;
/


begin 
  execute immediate 'DROP TABLE BARS.NBU23_REZ_ARC CASCADE CONSTRAINTS';
exception when others then 
  if sqlcode in (-942,-02441) then null; else raise; end if;
end;
/

begin

   execute immediate 'begin bpa.alter_policy_info(''NBU23_REZ_ARC'', ''WHOLE'' , null , null, null, null ); end;'; 
   execute immediate 'begin bpa.alter_policy_info(''NBU23_REZ_ARC'', ''FILIAL'', null , null, null, null ); end;';

   EXECUTE IMMEDIATE 'create table nbu23_rez_ARC as select * from nbu23_rez where 1<>1';

exception when others then
  -- ORA-00955: name is already used by an existing object
  if SQLCODE = -00955 then null;   else raise; end if; 
end;
/

begin
  if getglobaloption('HAVETOBO') = 2 then    
     execute immediate 'begin   bpa.alter_policies(''NBU23_REZ_ARC''); end;'; 
   end if;
end;
/
commit;
begin
   execute immediate 'alter table NBU23_REZ_ARC add constraint PK_NBU23_REZ_ARC_ID primary key (ID, KV)';
   exception when others then if (sqlcode = -2260 or sqlcode = -54) then null; else raise; end if;
end;
/

begin
   execute immediate 'CREATE INDEX I3_NBU23REZARC ON NBU23_REZ_ARC (RNK, ND, KAT, KV, RZ, DDD)';
   exception when others then if (sqlcode = -00955 or sqlcode = -54) then null; else raise; end if;    
end;
/

begin
   execute immediate 'CREATE INDEX I4_NBU23REZARC ON BARS.NBU23_REZ_ARC (ACC, ND)';
   exception when others then if (sqlcode = -00955 or sqlcode = -54) then null; else raise; end if;    
end;
/

begin
   execute immediate 'CREATE INDEX I5_NBU23REZARC ON BARS.NBU23_REZ_ARC (FDAT, ND, ACC)';
   exception when others then if (sqlcode = -00955 or sqlcode = -54) then null; else raise; end if;    
end;
/

exec bars_policy_adm.add_column_kf(p_table_name => 'NBU23_REZ_ARC');
exec bars_policy_adm.alter_policy_info(p_table_name => 'NBU23_REZ_ARC', p_policy_group => 'WHOLE', p_select_policy => null, p_insert_policy => 'E', p_update_policy => 'E', p_delete_policy => 'E');
exec bars_policy_adm.alter_policy_info(p_table_name => 'NBU23_REZ_ARC', p_policy_group => 'FILIAL', p_select_policy => 'M', p_insert_policy => 'M', p_update_policy => 'M', p_delete_policy => 'M');
exec bars_policy_adm.alter_policies(p_table_name => 'NBU23_REZ_ARC');

-------------------------------------------------------------
GRANT SELECT ON BARS.NBU23_REZ_ARC TO RCC_DEAL;
GRANT SELECT ON BARS.NBU23_REZ_ARC TO START1;

COMMIT;



