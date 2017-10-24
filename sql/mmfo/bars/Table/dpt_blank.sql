

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_BLANK.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_BLANK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_BLANK'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DPT_BLANK'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''DPT_BLANK'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_BLANK ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_BLANK 
   (	ID VARCHAR2(30), 
	PRINT_DATE DATE, 
	DEPOSIT_ID NUMBER(38,0), 
	DOC_SCHEME_ID VARCHAR2(35), 
	ID_FAULTY VARCHAR2(30), 
	STATUS NUMBER(1,0) DEFAULT 1, 
	STAFF_ID NUMBER(38,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_BLANK ***
 exec bpa.alter_policies('DPT_BLANK');


COMMENT ON TABLE BARS.DPT_BLANK IS 'Таблица использования бланков депозитных договоров (ПРАВЭКС)';
COMMENT ON COLUMN BARS.DPT_BLANK.ID IS 'Номер бланка договора (ПК)';
COMMENT ON COLUMN BARS.DPT_BLANK.PRINT_DATE IS 'Дата печати текста договора';
COMMENT ON COLUMN BARS.DPT_BLANK.DEPOSIT_ID IS 'Идентификатор депозитного договора';
COMMENT ON COLUMN BARS.DPT_BLANK.DOC_SCHEME_ID IS 'Идентификатор шаблона депозитного договора';
COMMENT ON COLUMN BARS.DPT_BLANK.ID_FAULTY IS 'Номер испорченного бланка договора, вместо которого печатается текущий договор';
COMMENT ON COLUMN BARS.DPT_BLANK.STATUS IS 'Статус бланка (1-использован, 2-испорчен)';
COMMENT ON COLUMN BARS.DPT_BLANK.STAFF_ID IS 'Идентификатор пользователя, распечатавшего текст договора';
COMMENT ON COLUMN BARS.DPT_BLANK.KF IS '';
COMMENT ON COLUMN BARS.DPT_BLANK.BRANCH IS '';




PROMPT *** Create  constraint CC_DPTBLANK_STATUS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BLANK ADD CONSTRAINT CC_DPTBLANK_STATUS CHECK (STATUS IN (1,2)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_DPTBLANK ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BLANK ADD CONSTRAINT PK_DPTBLANK PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTBLANK_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BLANK MODIFY (BRANCH CONSTRAINT CC_DPTBLANK_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTBLANK_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BLANK MODIFY (KF CONSTRAINT CC_DPTBLANK_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTBLANK_STAFFID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BLANK MODIFY (STAFF_ID CONSTRAINT CC_DPTBLANK_STAFFID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTBLANK_STATUS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BLANK MODIFY (STATUS CONSTRAINT CC_DPTBLANK_STATUS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTBLANK_DOCSCHEMEID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BLANK MODIFY (DOC_SCHEME_ID CONSTRAINT CC_DPTBLANK_DOCSCHEMEID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTBLANK_DEPOSITID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BLANK MODIFY (DEPOSIT_ID CONSTRAINT CC_DPTBLANK_DEPOSITID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTBLANK_PRINTDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BLANK MODIFY (PRINT_DATE CONSTRAINT CC_DPTBLANK_PRINTDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_DPTBLANK ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BLANK ADD CONSTRAINT UK_DPTBLANK UNIQUE (KF, ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTBLANK_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BLANK ADD CONSTRAINT FK_DPTBLANK_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTBLANK_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BLANK ADD CONSTRAINT FK_DPTBLANK_STAFF FOREIGN KEY (STAFF_ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTBLANK_DOCSCHEME ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BLANK ADD CONSTRAINT FK_DPTBLANK_DOCSCHEME FOREIGN KEY (DOC_SCHEME_ID)
	  REFERENCES BARS.DOC_SCHEME (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTBLANK_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BLANK ADD CONSTRAINT FK_DPTBLANK_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTBLANK_DPTDPTALL2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BLANK ADD CONSTRAINT FK_DPTBLANK_DPTDPTALL2 FOREIGN KEY (KF, DEPOSIT_ID)
	  REFERENCES BARS.DPT_DEPOSIT_ALL (KF, DEPOSIT_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTBLANK_DPTBLANK2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BLANK ADD CONSTRAINT FK_DPTBLANK_DPTBLANK2 FOREIGN KEY (KF, ID_FAULTY)
	  REFERENCES BARS.DPT_BLANK (KF, ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTBLANK_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BLANK MODIFY (ID CONSTRAINT CC_DPTBLANK_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_DPTBLANK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_DPTBLANK ON BARS.DPT_BLANK (KF, ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I2_DPTBLANK ***
begin   
 execute immediate '
  CREATE INDEX BARS.I2_DPTBLANK ON BARS.DPT_BLANK (PRINT_DATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I3_DPTBLANK ***
begin   
 execute immediate '
  CREATE INDEX BARS.I3_DPTBLANK ON BARS.DPT_BLANK (DEPOSIT_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPTBLANK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPTBLANK ON BARS.DPT_BLANK (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_BLANK ***
grant INSERT,SELECT,UPDATE                                                   on DPT_BLANK       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_BLANK       to BARS_DM;
grant INSERT,SELECT,UPDATE                                                   on DPT_BLANK       to DPT_ROLE;
grant INSERT,SELECT,UPDATE                                                   on DPT_BLANK       to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_BLANK       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_BLANK.sql =========*** End *** ===
PROMPT ===================================================================================== 
