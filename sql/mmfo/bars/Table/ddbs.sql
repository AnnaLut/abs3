

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DDBS.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DDBS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DDBS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DDBS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DDBS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DDBS ***
begin 
  execute immediate '
  CREATE TABLE BARS.DDBS 
   (	DDB_ID NUMBER(38,0), 
	DDB_NAME VARCHAR2(128), 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 1 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DDBS ***
 exec bpa.alter_policies('DDBS');


COMMENT ON TABLE BARS.DDBS IS 'Список распределенных БД';
COMMENT ON COLUMN BARS.DDBS.DDB_ID IS 'Идентификатор распределенной БД';
COMMENT ON COLUMN BARS.DDBS.DDB_NAME IS 'Полное имя БД (global_name)';
COMMENT ON COLUMN BARS.DDBS.BRANCH IS 'Код безбалансового подразделения';




PROMPT *** Create  constraint FK_DDBS_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.DDBS ADD CONSTRAINT FK_DDBS_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DDBS_DDBID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DDBS MODIFY (DDB_ID CONSTRAINT CC_DDBS_DDBID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DDBS_DDBNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DDBS MODIFY (DDB_NAME CONSTRAINT CC_DDBS_DDBNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_DDBS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DDBS ADD CONSTRAINT PK_DDBS PRIMARY KEY (DDB_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DDBS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DDBS ON BARS.DDBS (DDB_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DDBS ***
grant SELECT                                                                 on DDBS            to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DDBS            to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DDBS.sql =========*** End *** ========
PROMPT ===================================================================================== 
