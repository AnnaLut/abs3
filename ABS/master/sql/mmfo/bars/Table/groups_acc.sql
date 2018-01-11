

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/GROUPS_ACC.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to GROUPS_ACC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''GROUPS_ACC'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''GROUPS_ACC'', ''FILIAL'' , ''F'', ''F'', ''F'', ''F'');
               bpa.alter_policy_info(''GROUPS_ACC'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table GROUPS_ACC ***
begin 
  execute immediate '
  CREATE TABLE BARS.GROUPS_ACC 
   (	ID NUMBER(38,0), 
	NAME VARCHAR2(50), 
	SCOPE VARCHAR2(6) DEFAULT ''LOCAL''
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to GROUPS_ACC ***
 exec bpa.alter_policies('GROUPS_ACC');


COMMENT ON TABLE BARS.GROUPS_ACC IS 'Группы счетов';
COMMENT ON COLUMN BARS.GROUPS_ACC.ID IS 'Идентификатор группы счетов';
COMMENT ON COLUMN BARS.GROUPS_ACC.NAME IS 'Наименование';
COMMENT ON COLUMN BARS.GROUPS_ACC.SCOPE IS 'GLOBAL-глобальная группа, LOCAL-локальная(доступна только часть счетов своего бранча)';




PROMPT *** Create  constraint CC_GROUPSACC_SCOPE_CC ***
begin   
 execute immediate '
  ALTER TABLE BARS.GROUPS_ACC ADD CONSTRAINT CC_GROUPSACC_SCOPE_CC CHECK (scope in (''LOCAL'',''GLOBAL'',''PARENT'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_GROUPSACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.GROUPS_ACC ADD CONSTRAINT PK_GROUPSACC PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GROUPSACC_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GROUPS_ACC MODIFY (ID CONSTRAINT CC_GROUPSACC_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GROUPSACC_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GROUPS_ACC MODIFY (NAME CONSTRAINT CC_GROUPSACC_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GROUPSACC_SCOPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GROUPS_ACC MODIFY (SCOPE CONSTRAINT CC_GROUPSACC_SCOPE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_GROUPSACC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_GROUPSACC ON BARS.GROUPS_ACC (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  GROUPS_ACC ***
grant DELETE,INSERT,SELECT,UPDATE                                            on GROUPS_ACC      to ABS_ADMIN;
grant SELECT                                                                 on GROUPS_ACC      to BARSAQ;
grant SELECT                                                                 on GROUPS_ACC      to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on GROUPS_ACC      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on GROUPS_ACC      to BARS_DM;
grant SELECT                                                                 on GROUPS_ACC      to CUST001;
grant DELETE,INSERT,SELECT,UPDATE                                            on GROUPS_ACC      to DOSTUP;
grant SELECT                                                                 on GROUPS_ACC      to KLBX;
grant SELECT                                                                 on GROUPS_ACC      to START1;
grant SELECT                                                                 on GROUPS_ACC      to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on GROUPS_ACC      to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on GROUPS_ACC      to WR_REFREAD;
grant SELECT                                                                 on GROUPS_ACC      to WR_VIEWACC;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/GROUPS_ACC.sql =========*** End *** ==
PROMPT ===================================================================================== 
