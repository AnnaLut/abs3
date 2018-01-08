

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BARSROLES.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BARSROLES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BARSROLES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BARSROLES'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''BARSROLES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BARSROLES ***
begin 
  execute immediate '
  CREATE TABLE BARS.BARSROLES 
   (	ROLEID NUMBER(5,0), 
	ROLETYPE VARCHAR2(1), 
	ROLENAME VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BARSROLES ***
 exec bpa.alter_policies('BARSROLES');


COMMENT ON TABLE BARS.BARSROLES IS 'Роли Oracle используемые в администрировании пользователей';
COMMENT ON COLUMN BARS.BARSROLES.ROLEID IS 'ID роли (№ п/п))';
COMMENT ON COLUMN BARS.BARSROLES.ROLETYPE IS 'Тип роли';
COMMENT ON COLUMN BARS.BARSROLES.ROLENAME IS 'Название роли';




PROMPT *** Create  constraint SYS_C009335 ***
begin   
 execute immediate '
  ALTER TABLE BARS.BARSROLES MODIFY (ROLEID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009336 ***
begin   
 execute immediate '
  ALTER TABLE BARS.BARSROLES MODIFY (ROLETYPE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009337 ***
begin   
 execute immediate '
  ALTER TABLE BARS.BARSROLES MODIFY (ROLENAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_BARSROLES ***
begin   
 execute immediate '
  ALTER TABLE BARS.BARSROLES ADD CONSTRAINT PK_BARSROLES PRIMARY KEY (ROLEID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BARSROLES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BARSROLES ON BARS.BARSROLES (ROLEID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BARSROLES ***
grant DELETE,INSERT,SELECT,UPDATE                                            on BARSROLES       to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on BARSROLES       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BARSROLES       to BARS_DM;
grant SELECT                                                                 on BARSROLES       to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BARSROLES       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BARSROLES.sql =========*** End *** ===
PROMPT ===================================================================================== 
