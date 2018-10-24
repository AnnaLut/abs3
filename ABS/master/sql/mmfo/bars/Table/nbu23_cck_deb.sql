begin 
  execute immediate 'ALTER TABLE BARS.NBU23_CCK_DEB DROP PRIMARY KEY CASCADE';
exception when others then 
  if sqlcode in (-942,-02441) then null; else raise; end if;
end;
/


begin 
  execute immediate 'DROP TABLE BARS.NBU23_CCK_DEB CASCADE CONSTRAINTS';
exception when others then 
  if sqlcode in (-942,-02441) then null; else raise; end if;
end;
/

begin

  if getglobaloption('HAVETOBO') = 2 then   

     execute immediate 'begin bpa.alter_policy_info(''NBU23_CCK_DEB'', ''WHOLE'' , null , null, null, null ); end;'; 
     execute immediate 'begin bpa.alter_policy_info(''NBU23_CCK_DEB'', ''FILIAL'', null , null, null, null ); end;';

     EXECUTE IMMEDIATE 'create table NBU23_CCK_DEB as select * from rez_cr where 1<>1';

  end if;

exception when others then
  -- ORA-00955: name is already used by an existing object
  if SQLCODE = -00955 then null;   else raise; end if; 
end;
/

begin
  if getglobaloption('HAVETOBO') = 2 then    
     execute immediate 'begin   bpa.alter_policies(''NBU23_CCK_DEB''); end;'; 
   end if;
end;
/
commit;
PROMPT *** Create  index I2_NBU23_CCK_DEB ***
begin   
 execute immediate '
  CREATE INDEX BARS.I2_NBU23_CCK_DEB ON BARS.NBU23_CCK_DEB (RNK) 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

begin
   execute immediate 'CREATE INDEX I1_NBU23_CCK_DEB ON NBU23_CCK_DEB (OKPO)';
   exception when others then if (sqlcode = -00955 or sqlcode = -54) then null; else raise; end if;    
end;
/

-------------------------------------------------------------
GRANT SELECT ON BARS.NBU23_CCK_DEB TO RCC_DEAL;
GRANT SELECT ON BARS.NBU23_CCK_DEB TO START1;

COMMIT;

