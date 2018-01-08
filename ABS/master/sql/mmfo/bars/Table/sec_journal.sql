

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SEC_JOURNAL.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SEC_JOURNAL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SEC_JOURNAL'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SEC_JOURNAL'', ''FILIAL'' , ''F'', ''F'', ''F'', ''F'');
               bpa.alter_policy_info(''SEC_JOURNAL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SEC_JOURNAL ***
begin 
  execute immediate '
  CREATE TABLE BARS.SEC_JOURNAL 
   (	WHO_GRANT NUMBER(38,0), 
	RESOURCE_TYPE NUMBER(3,0), 
	SOURCE_TYPE NUMBER(3,0), 
	GR_DATE DATE, 
	ACTION NUMBER(3,0), 
	RESOURCE_ID VARCHAR2(38), 
	RESOURCE_KOD VARCHAR2(38), 
	RESOURCE_NAME VARCHAR2(270), 
	SOURCE_ID VARCHAR2(38), 
	SOURCE_KOD VARCHAR2(38), 
	SOURCE_NAME VARCHAR2(270), 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	REC_ID NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SEC_JOURNAL ***
 exec bpa.alter_policies('SEC_JOURNAL');


COMMENT ON TABLE BARS.SEC_JOURNAL IS 'Журнал действий безопасности';
COMMENT ON COLUMN BARS.SEC_JOURNAL.WHO_GRANT IS 'Кто выдавал/заберал ресурс';
COMMENT ON COLUMN BARS.SEC_JOURNAL.RESOURCE_TYPE IS 'Код типа ресурса';
COMMENT ON COLUMN BARS.SEC_JOURNAL.SOURCE_TYPE IS 'Тип приемника ресурса  1 - АРМ  20 пользователь';
COMMENT ON COLUMN BARS.SEC_JOURNAL.GR_DATE IS 'Дата выдачи/подтверждения';
COMMENT ON COLUMN BARS.SEC_JOURNAL.ACTION IS 'Идентификатор действия';
COMMENT ON COLUMN BARS.SEC_JOURNAL.RESOURCE_ID IS 'Номер ресурса (композитивный)';
COMMENT ON COLUMN BARS.SEC_JOURNAL.RESOURCE_KOD IS 'Код ресурса (композитивный)';
COMMENT ON COLUMN BARS.SEC_JOURNAL.RESOURCE_NAME IS 'Имя ресурса (композитивный)';
COMMENT ON COLUMN BARS.SEC_JOURNAL.SOURCE_ID IS 'Номер приемника ресурса (композитивный)';
COMMENT ON COLUMN BARS.SEC_JOURNAL.SOURCE_KOD IS 'Код приемникаресурса (композитивный)';
COMMENT ON COLUMN BARS.SEC_JOURNAL.SOURCE_NAME IS 'Имя приемника ресурса (композитивный)';
COMMENT ON COLUMN BARS.SEC_JOURNAL.BRANCH IS 'Код подразделения';
COMMENT ON COLUMN BARS.SEC_JOURNAL.REC_ID IS 'Идентификатор записи';




PROMPT *** Create  constraint PK_SECJOURNAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_JOURNAL ADD CONSTRAINT PK_SECJOURNAL PRIMARY KEY (REC_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SECJOURNAL_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_JOURNAL ADD CONSTRAINT FK_SECJOURNAL_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SECJOURNAL_RECID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_JOURNAL MODIFY (REC_ID CONSTRAINT CC_SECJOURNAL_RECID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SECJOURNAL_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_JOURNAL MODIFY (BRANCH CONSTRAINT CC_SECJOURNAL_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SECJOURNAL_ACTION_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_JOURNAL MODIFY (ACTION CONSTRAINT CC_SECJOURNAL_ACTION_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SECJOURNAL_GRDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_JOURNAL MODIFY (GR_DATE CONSTRAINT CC_SECJOURNAL_GRDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SECJOURNAL_SOURCETYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_JOURNAL MODIFY (SOURCE_TYPE CONSTRAINT CC_SECJOURNAL_SOURCETYPE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SECJOURNAL_RESOURCETYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_JOURNAL MODIFY (RESOURCE_TYPE CONSTRAINT CC_SECJOURNAL_RESOURCETYPE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SECJOURNAL_SECRESOURCES ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_JOURNAL ADD CONSTRAINT FK_SECJOURNAL_SECRESOURCES FOREIGN KEY (RESOURCE_TYPE)
	  REFERENCES BARS.SEC_RESOURCES (RES_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SECJOURNAL_SECRESOURCES2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_JOURNAL ADD CONSTRAINT FK_SECJOURNAL_SECRESOURCES2 FOREIGN KEY (SOURCE_TYPE)
	  REFERENCES BARS.SEC_RESOURCES (RES_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SECJOURNAL_SECACTION ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_JOURNAL ADD CONSTRAINT FK_SECJOURNAL_SECACTION FOREIGN KEY (ACTION)
	  REFERENCES BARS.SEC_ACTION (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SECJOURNAL_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_JOURNAL ADD CONSTRAINT FK_SECJOURNAL_STAFF FOREIGN KEY (WHO_GRANT)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SECJOURNAL_WHOGRANT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_JOURNAL MODIFY (WHO_GRANT CONSTRAINT CC_SECJOURNAL_WHOGRANT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SECJOURNAL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SECJOURNAL ON BARS.SEC_JOURNAL (REC_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SEC_JOURNAL ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SEC_JOURNAL     to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on SEC_JOURNAL     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SEC_JOURNAL     to BARS_DM;
grant SELECT                                                                 on SEC_JOURNAL     to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SEC_JOURNAL     to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SEC_JOURNAL.sql =========*** End *** =
PROMPT ===================================================================================== 
