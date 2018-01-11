

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NOTIFIERS.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NOTIFIERS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NOTIFIERS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''NOTIFIERS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''NOTIFIERS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NOTIFIERS ***
begin 
  execute immediate '
  CREATE TABLE BARS.NOTIFIERS 
   (	ID NUMBER(38,0), 
	NAME VARCHAR2(80), 
	COMM VARCHAR2(128)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NOTIFIERS ***
 exec bpa.alter_policies('NOTIFIERS');


COMMENT ON TABLE BARS.NOTIFIERS IS 'Справочник уведомителей: smtp, http etc';
COMMENT ON COLUMN BARS.NOTIFIERS.ID IS 'идентификатор уведомителя';
COMMENT ON COLUMN BARS.NOTIFIERS.NAME IS 'имя уведомителя';
COMMENT ON COLUMN BARS.NOTIFIERS.COMM IS 'комментарий';




PROMPT *** Create  constraint PK_NOTIFIERS ***
begin   
 execute immediate '
  ALTER TABLE BARS.NOTIFIERS ADD CONSTRAINT PK_NOTIFIERS PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NOTIFIERS_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NOTIFIERS MODIFY (ID CONSTRAINT CC_NOTIFIERS_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NOTIFIERS_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NOTIFIERS MODIFY (NAME CONSTRAINT CC_NOTIFIERS_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_NOTIFIERS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_NOTIFIERS ON BARS.NOTIFIERS (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NOTIFIERS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on NOTIFIERS       to ABS_ADMIN;
grant SELECT                                                                 on NOTIFIERS       to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on NOTIFIERS       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NOTIFIERS       to BARS_DM;
grant SELECT                                                                 on NOTIFIERS       to START1;
grant SELECT                                                                 on NOTIFIERS       to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on NOTIFIERS       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NOTIFIERS.sql =========*** End *** ===
PROMPT ===================================================================================== 
