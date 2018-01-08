

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SEC_ATTR_JOURNAL.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SEC_ATTR_JOURNAL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SEC_ATTR_JOURNAL'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SEC_ATTR_JOURNAL'', ''FILIAL'' , ''F'', ''F'', ''F'', ''F'');
               bpa.alter_policy_info(''SEC_ATTR_JOURNAL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SEC_ATTR_JOURNAL ***
begin 
  execute immediate '
  CREATE TABLE BARS.SEC_ATTR_JOURNAL 
   (	REC_ID NUMBER(38,0), 
	WHO_GRANT NUMBER(38,0), 
	DATE_GRANT DATE DEFAULT sysdate, 
	ACTION NUMBER(3,0), 
	ATTR_ID NUMBER(38,0), 
	ATTR_VALUE VARCHAR2(254), 
	USER_ID NUMBER(38,0), 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SEC_ATTR_JOURNAL ***
 exec bpa.alter_policies('SEC_ATTR_JOURNAL');


COMMENT ON TABLE BARS.SEC_ATTR_JOURNAL IS 'Журнал безпеки: атрибути користувача';
COMMENT ON COLUMN BARS.SEC_ATTR_JOURNAL.REC_ID IS '_д.';
COMMENT ON COLUMN BARS.SEC_ATTR_JOURNAL.WHO_GRANT IS 'Хто зм_нив';
COMMENT ON COLUMN BARS.SEC_ATTR_JOURNAL.DATE_GRANT IS 'Дата зм_ни';
COMMENT ON COLUMN BARS.SEC_ATTR_JOURNAL.ACTION IS 'Д_я';
COMMENT ON COLUMN BARS.SEC_ATTR_JOURNAL.ATTR_ID IS 'Код атрибуту';
COMMENT ON COLUMN BARS.SEC_ATTR_JOURNAL.ATTR_VALUE IS 'Значення атрибуту';
COMMENT ON COLUMN BARS.SEC_ATTR_JOURNAL.USER_ID IS '_д. користувача';
COMMENT ON COLUMN BARS.SEC_ATTR_JOURNAL.BRANCH IS '';




PROMPT *** Create  constraint PK_SECATTRJOURNAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_ATTR_JOURNAL ADD CONSTRAINT PK_SECATTRJOURNAL PRIMARY KEY (REC_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SECATTRJOURNAL_STAFF2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_ATTR_JOURNAL ADD CONSTRAINT FK_SECATTRJOURNAL_STAFF2 FOREIGN KEY (USER_ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SECATTRJOURNAL_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_ATTR_JOURNAL MODIFY (BRANCH CONSTRAINT CC_SECATTRJOURNAL_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SECATTRJOURNAL_ACTION_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_ATTR_JOURNAL MODIFY (ACTION CONSTRAINT CC_SECATTRJOURNAL_ACTION_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SECATTRJOURNAL_DATEGRANT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_ATTR_JOURNAL MODIFY (DATE_GRANT CONSTRAINT CC_SECATTRJOURNAL_DATEGRANT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SECATTRJOURNAL_WHOGRANT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_ATTR_JOURNAL MODIFY (WHO_GRANT CONSTRAINT CC_SECATTRJOURNAL_WHOGRANT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SECATTRJOURNAL_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_ATTR_JOURNAL ADD CONSTRAINT FK_SECATTRJOURNAL_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SECATTRJOURNAL_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_ATTR_JOURNAL ADD CONSTRAINT FK_SECATTRJOURNAL_STAFF FOREIGN KEY (WHO_GRANT)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SECATTRJOURNAL_SECATTR ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_ATTR_JOURNAL ADD CONSTRAINT FK_SECATTRJOURNAL_SECATTR FOREIGN KEY (ATTR_ID)
	  REFERENCES BARS.SEC_ATTRIBUTES (ATTR_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SECATTRJOURNAL_RECID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_ATTR_JOURNAL MODIFY (REC_ID CONSTRAINT CC_SECATTRJOURNAL_RECID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SECATTRJOURNAL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SECATTRJOURNAL ON BARS.SEC_ATTR_JOURNAL (REC_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SEC_ATTR_JOURNAL ***
grant INSERT,SELECT                                                          on SEC_ATTR_JOURNAL to ABS_ADMIN;
grant INSERT,SELECT                                                          on SEC_ATTR_JOURNAL to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SEC_ATTR_JOURNAL to BARS_DM;



PROMPT *** Create SYNONYM  to SEC_ATTR_JOURNAL ***

  CREATE OR REPLACE PUBLIC SYNONYM SEC_ATTR_JOURNAL FOR BARS.SEC_ATTR_JOURNAL;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SEC_ATTR_JOURNAL.sql =========*** End 
PROMPT ===================================================================================== 
