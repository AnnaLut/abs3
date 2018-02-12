BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_VYDCP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CP_VYDCP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CP_VYDCP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

begin 
  execute immediate '
  CREATE TABLE BARS.CP_VYDCP
   (	ID VARCHAR2(8), 
	TITLE VARCHAR2(255)
   ) TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

begin   
 execute immediate 'create unique index U_CP_VYDCP on CP_VYDCP (id)
  tablespace BRSSMLI';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

begin   
 execute immediate 'alter table CP_VYDCP
  add constraint PK_CP_VYDCP primary key (ID)
USING INDEX U_CP_VYDCP';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




 exec bpa.alter_policies('CP_VYDCP');

COMMENT ON TABLE BARS.CP_VYDCP IS '7. Довідник «Класифікація фінансових інструментів»';

PROMPT *** Create  grants  cp_VYDCP ***
grant SELECT                                                          on cp_VYDCP       to BARS_ACCESS_DEFROLE;
grant SELECT                                                          on cp_VYDCP       to START1;
grant SELECT                                                          on cp_VYDCP       to CP_ROLE;
