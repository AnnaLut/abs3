begin 
  execute immediate 'ALTER TABLE BARS.test_many_mbk DROP PRIMARY KEY CASCADE';
exception when others then 
  if sqlcode in (-942,-02441) then null; else raise; end if;
end;
/

begin 
  execute immediate 'DROP TABLE BARS.test_many_mbk CASCADE CONSTRAINTS';
exception when others then 
  if sqlcode in (-942,-02441) then null; else raise; end if;
end;
/

begin

  if getglobaloption('HAVETOBO') = 2 then   

     execute immediate 'begin bpa.alter_policy_info(''test_many_mbk'', ''WHOLE'' , null , null, null, null ); end;'; 
     execute immediate 'begin bpa.alter_policy_info(''test_many_mbk'', ''FILIAL'', null , null, null, null ); end;';

     EXECUTE IMMEDIATE 'create table BARS.test_many_mbk'||
      '(nd    number, 
        fdat  date, 
        s     number)';

  end if;

exception when others then
  -- ORA-00955: name is already used by an existing object
  if SQLCODE = -00955 then null;   else raise; end if; 
end;
/

begin
  if getglobaloption('HAVETOBO') = 2 then    
     execute immediate 'begin   bpa.alter_policies(''test_many_mbk''); end;'; 
   end if;
end;
/
commit;

begin
 execute immediate   'alter table test_many_mbk add (S1 NUMBER) ';
exception when others then
  -- ORA-01430: column being added already exists in table
  if SQLCODE = - 01430 then null;   else raise; end if; 
end;
/

begin
 execute immediate   'alter table test_many_mbk add (SK NUMBER) ';
exception when others then
  -- ORA-01430: column being added already exists in table
  if SQLCODE = - 01430 then null;   else raise; end if; 
end;
/

begin
 execute immediate   'alter table test_many_mbk add (SR NUMBER) ';
exception when others then
  -- ORA-01430: column being added already exists in table
  if SQLCODE = - 01430 then null;   else raise; end if; 
end;
/

COMMENT ON COLUMN BARS.TEST_MANY_MBK.S IS 'сумма тела в потоке';
COMMENT ON COLUMN BARS.TEST_MANY_MBK.S1 IS 'сумма процентов в потоке';
COMMENT ON COLUMN BARS.TEST_MANY_MBK.SK IS 'сумма (тела+проц)+К в потоке для расчета PV';
COMMENT ON COLUMN BARS.TEST_MANY_MBK.SR IS 'сумма расчетная потоке для расчета PV';

begin
   execute immediate 'CREATE INDEX BARS.IDX_MANY_MBK ON BARS.TEST_MANY_MBK (ND, FDAT)';
   exception when others then if (sqlcode = -00955 or sqlcode = -54) then null; else raise; end if;    
end;
/

exec bars_policy_adm.add_column_kf(p_table_name => 'TEST_MANY_MBK');
exec bars_policy_adm.alter_policy_info(p_table_name => 'TEST_MANY_MBK', p_policy_group => 'WHOLE', p_select_policy => null, p_insert_policy => 'E', p_update_policy => 'E', p_delete_policy => 'E');
exec bars_policy_adm.alter_policy_info(p_table_name => 'TEST_MANY_MBK', p_policy_group => 'FILIAL', p_select_policy => 'M', p_insert_policy => 'M', p_update_policy => 'M', p_delete_policy => 'M');
exec bars_policy_adm.alter_policies(p_table_name => 'TEST_MANY_MBK');

GRANT SELECT ON BARS.TEST_MANY_MBK TO BARS_ACCESS_DEFROLE;
GRANT SELECT ON BARS.TEST_MANY_MBK TO BARS_DM;
GRANT SELECT ON BARS.TEST_MANY_MBK TO START1;

