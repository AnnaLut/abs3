begin

  if getglobaloption('HAVETOBO') = 2 then   

     execute immediate 'begin bpa.alter_policy_info(''REZ_DEB'', ''WHOLE'' , null , null, null, null ); end;'; 
     execute immediate 'begin bpa.alter_policy_info(''REZ_DEB'', ''FILIAL'', null , null, null, null ); end;';

     EXECUTE IMMEDIATE 'create table BARS.REZ_DEB'||
      '(nbs     varchar2(4),
        deb     integer,
        pr      integer,
        pr2     INTEGER,  
        txt     varchar2(200)
        )';

  end if;

exception when others then
  -- ORA-00955: name is already used by an existing object
  if SQLCODE = -00955 then null;   else raise; end if; 
end;
/

begin
  if getglobaloption('HAVETOBO') = 2 then    
     execute immediate 'begin   bpa.alter_policies(''REZ_DEB''); end;'; 
   end if;
end;
/
commit;
-------------------------------------------------------------
COMMENT ON TABLE  BARS.REZ_DEB         IS 'Кредитний ризик 351';
COMMENT ON COLUMN BARS.REZ_DEB.nbs     IS 'Бал.рах.';
COMMENT ON COLUMN BARS.REZ_DEB.deb     IS 'Тип дебіторки';

begin
 execute immediate   'alter table REZ_DEB add (tipa  INTEGER) ';
exception when others then
  -- ORA-01430: column being added already exists in table
  if SQLCODE = - 01430 then null;   else raise; end if; 
end;
/
COMMENT ON COLUMN REZ_DEB.tipa  IS 'Тип активу (по REZ_TIPA)';

begin
 execute immediate   'alter table REZ_DEB add (tipa_FV INTEGER) ';
exception when others then
  -- ORA-01430: column being added already exists in table
  if SQLCODE = - 01430 then null;   else raise; end if; 
end;
/
COMMENT ON COLUMN REZ_DEB.tipa_FV  IS 'Тип активу для прийому від FV';

begin
 execute immediate   'alter table REZ_DEB add (D_CLOSE DATE) ';
exception when others then
  -- ORA-01430: column being added already exists in table
  if SQLCODE = - 01430 then null;   else raise; end if; 
end;
/
COMMENT ON COLUMN REZ_DEB.D_CLOSE  IS 'Дата закриття бал.рахунку';

begin
 execute immediate   'alter table REZ_DEB add (Grupa integer) ';
exception when others then
  -- ORA-01430: column being added already exists in table
  if SQLCODE = - 01430 then null;   else raise; end if; 
end;
/
COMMENT ON COLUMN REZ_DEB.D_CLOSE  IS 'Группування рахунків для різних цілей';

begin
  EXECUTE IMMEDIATE 
 'ALTER TABLE REZ_DEB ADD (CONSTRAINT PK_REZ_DEB PRIMARY KEY (NBS))';
exception when others then
  -- ORA-02260: table can have only one primary key
  if SQLCODE = -02260 then null;   else raise; end if; 
end;
/

begin
   execute immediate 'CREATE INDEX I1_REZ_DEB ON REZ_DEB (nbs,deb)';
   exception when others then if (sqlcode = -00955 or sqlcode = -54) then null; else raise; end if;    
end;
/

exec bars_policy_adm.alter_policy_info(p_table_name => 'REZ_DEB', p_policy_group => 'WHOLE', p_select_policy => null, p_insert_policy => null, p_update_policy => null, p_delete_policy => null); 
exec bars_policy_adm.alter_policy_info(p_table_name => 'REZ_DEB', p_policy_group => 'FILIAL', p_select_policy => null, p_insert_policy => 'E', p_update_policy => 'E', p_delete_policy => 'E');   
exec bars_policy_adm.alter_policies(p_table_name => 'REZ_DEB');

GRANT SELECT ON BARS.REZ_DEB TO RCC_DEAL;
GRANT SELECT ON BARS.REZ_DEB TO START1;
GRANT SELECT ON BARS.REZ_DEB TO BARS_ACCESS_DEFROLE;

COMMIT;
