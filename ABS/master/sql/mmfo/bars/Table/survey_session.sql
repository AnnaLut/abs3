

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SURVEY_SESSION.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SURVEY_SESSION ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SURVEY_SESSION'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''SURVEY_SESSION'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''SURVEY_SESSION'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SURVEY_SESSION ***
begin 
  execute immediate '
  CREATE TABLE BARS.SURVEY_SESSION 
   (	SESSION_ID NUMBER(38,0), 
	RNK NUMBER(38,0), 
	SURVEY_ID NUMBER(38,0), 
	USER_ID NUMBER(38,0), 
	SESSION_DATE DATE DEFAULT sysdate, 
	FL_DECLINE NUMBER(1,0) DEFAULT 1, 
	COMPLETED NUMBER(1,0) DEFAULT 0, 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SURVEY_SESSION ***
 exec bpa.alter_policies('SURVEY_SESSION');


COMMENT ON TABLE BARS.SURVEY_SESSION IS 'Сессии анкетирования клиентов';
COMMENT ON COLUMN BARS.SURVEY_SESSION.SESSION_ID IS 'Номер сессии';
COMMENT ON COLUMN BARS.SURVEY_SESSION.RNK IS 'Рег.№ клиента';
COMMENT ON COLUMN BARS.SURVEY_SESSION.SURVEY_ID IS 'Идентификатор анкеты';
COMMENT ON COLUMN BARS.SURVEY_SESSION.USER_ID IS 'Пользователь';
COMMENT ON COLUMN BARS.SURVEY_SESSION.SESSION_DATE IS 'Дата анкетирования';
COMMENT ON COLUMN BARS.SURVEY_SESSION.FL_DECLINE IS 'Отказ от анкетирования';
COMMENT ON COLUMN BARS.SURVEY_SESSION.COMPLETED IS 'Признак окончания заполнения анкеты';
COMMENT ON COLUMN BARS.SURVEY_SESSION.BRANCH IS '';
COMMENT ON COLUMN BARS.SURVEY_SESSION.KF IS '';




PROMPT *** Create  constraint CC_SURVEYSESSION_COMPLETED ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY_SESSION ADD CONSTRAINT CC_SURVEYSESSION_COMPLETED CHECK (completed IN (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SURVEYSESSION ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY_SESSION ADD CONSTRAINT PK_SURVEYSESSION PRIMARY KEY (SESSION_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SURVEYSESSION_FLDECLINE ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY_SESSION ADD CONSTRAINT CC_SURVEYSESSION_FLDECLINE CHECK (fl_decline IN (0, 1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_SURVEYSESSION ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY_SESSION ADD CONSTRAINT UK_SURVEYSESSION UNIQUE (KF, SESSION_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SURVEYSESSION_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY_SESSION MODIFY (KF CONSTRAINT CC_SURVEYSESSION_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SURVEYSESSION_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY_SESSION MODIFY (RNK CONSTRAINT CC_SURVEYSESSION_RNK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SURVEYSESSION_SURVEYID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY_SESSION MODIFY (SURVEY_ID CONSTRAINT CC_SURVEYSESSION_SURVEYID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SURVEYSESSION_USERID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY_SESSION MODIFY (USER_ID CONSTRAINT CC_SURVEYSESSION_USERID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SURVEYSESSION_FLDECLINE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY_SESSION MODIFY (FL_DECLINE CONSTRAINT CC_SURVEYSESSION_FLDECLINE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SURVEYSESSION_COMPLETED_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY_SESSION MODIFY (COMPLETED CONSTRAINT CC_SURVEYSESSION_COMPLETED_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SURVEYSESSION_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY_SESSION MODIFY (BRANCH CONSTRAINT CC_SURVEYSESSION_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SURVEYSESSION ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SURVEYSESSION ON BARS.SURVEY_SESSION (SESSION_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_SURVEYSESSION ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_SURVEYSESSION ON BARS.SURVEY_SESSION (KF, SESSION_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SURVEY_SESSION ***
grant SELECT                                                                 on SURVEY_SESSION  to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SURVEY_SESSION  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SURVEY_SESSION  to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on SURVEY_SESSION  to DPT_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SURVEY_SESSION  to RCC_DEAL;
grant SELECT                                                                 on SURVEY_SESSION  to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SURVEY_SESSION  to WR_ALL_RIGHTS;
grant DELETE,SELECT                                                          on SURVEY_SESSION  to WR_CREDIT;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SURVEY_SESSION.sql =========*** End **
PROMPT ===================================================================================== 
