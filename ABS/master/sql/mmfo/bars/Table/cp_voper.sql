BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_VOPER'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CP_VOPER'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CP_VOPER'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

begin 
  execute immediate '
  CREATE TABLE BARS.CP_VOPER
   (	ID VARCHAR2(2), 
	TITLE VARCHAR2(255)
   ) TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

begin   
 execute immediate 'create unique index U_CP_VOPER on CP_VOPER (id)
  tablespace BRSSMLI';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

begin   
 execute immediate 'alter table CP_VOPER
  add constraint PK_CP_VOPER primary key (ID)
USING INDEX U_CP_VOPER';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




 exec bpa.alter_policies('CP_VOPER');

COMMENT ON TABLE BARS.CP_VOPER IS 'Вид операції(ЦП)';

PROMPT *** Create  grants  cp_VOPER ***
grant SELECT                                                          on cp_VOPER       to BARS_ACCESS_DEFROLE;
grant SELECT                                                          on cp_VOPER       to START1;
grant SELECT                                                          on cp_VOPER       to CP_ROLE;

