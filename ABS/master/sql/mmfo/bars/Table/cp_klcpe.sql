BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_KLCPE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CP_KLCPE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CP_KLCPE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

begin 
  execute immediate '
  CREATE TABLE BARS.CP_KLCPE
   (	ID NUMBER(2), 
	TITLE VARCHAR2(100)
   ) TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

begin   
 execute immediate 'create unique index U_CP_KLCPE on CP_KLCPE (id)
  tablespace BRSSMLI';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

begin   
 execute immediate 'alter table CP_KLCPE
  add constraint PK_CP_KLCPE primary key (ID)
USING INDEX U_CP_KLCPE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




 exec bpa.alter_policies('CP_KLCPE');

COMMENT ON TABLE BARS.CP_KLCPE IS 'Класифікація ЦП по типу емітента';

PROMPT *** Create  grants  cp_KLCPE ***
grant SELECT                                                          on cp_KLCPE       to BARS_ACCESS_DEFROLE;
grant SELECT                                                          on cp_KLCPE       to START1;
grant SELECT                                                          on cp_KLCPE       to CP_ROLE;

