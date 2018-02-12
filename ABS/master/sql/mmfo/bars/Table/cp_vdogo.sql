BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_VDOGO'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CP_VDOGO'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CP_VDOGO'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

begin 
  execute immediate '
  CREATE TABLE BARS.CP_VDOGO
   (	ID VARCHAR2(4), 
	TITLE VARCHAR2(255)
   ) TABLESPACE BRSSMLD';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

begin   
 execute immediate 'create unique index U_CP_VDOGO on CP_VDOGO (id)
  tablespace BRSSMLI';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

begin   
 execute immediate 'alter table CP_VDOGO
  add constraint PK_CP_VDOGO primary key (ID)
USING INDEX U_CP_VDOGO';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




 exec bpa.alter_policies('CP_VDOGO');

COMMENT ON TABLE BARS.CP_VDOGO IS '15. Довідник «Види договорів у діяльності з торгівлі цінними паперами»';

grant SELECT                                                          on cp_VDOGO       to BARS_ACCESS_DEFROLE;
grant SELECT                                                          on cp_VDOGO       to START1;
grant SELECT                                                          on cp_VDOGO       to CP_ROLE;
