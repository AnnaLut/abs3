PROMPT *** ALTER_POLICY_INFO to STAFF$BASE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STAFF$BASE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''STAFF$BASE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table STAFF$BASE ***
begin 
  execute immediate '
  CREATE TABLE BARS.STAFF$BASE 
   (ID NUMBER(38,0), 
	FIO VARCHAR2(60), 
	LOGNAME VARCHAR2(30), 
	TYPE NUMBER(1,0), 
	TABN VARCHAR2(10), 
	BAX NUMBER(1,0), 
	TBAX DATE, 
	DISABLE NUMBER(1,0), 
	ADATE1 DATE, 
	ADATE2 DATE, 
	RDATE1 DATE, 
	RDATE2 DATE, 
	CLSID NUMBER(38,0) DEFAULT 0, 
	APPROVE NUMBER(1,0), 
	BRANCH VARCHAR2(30) DEFAULT null, 
	COUNTCONN NUMBER(10,0), 
	COUNTPASS NUMBER(10,0), 
	PROFILE VARCHAR2(30), 
	USEARC NUMBER(1,0) DEFAULT 0, 
	CSCHEMA VARCHAR2(30) DEFAULT ''BARS'', 
	WEB_PROFILE VARCHAR2(30) DEFAULT ''DEFAULT_PROFILE'', 
	POLICY_GROUP VARCHAR2(30) DEFAULT ''FILIAL'', 
	ACTIVE NUMBER(1,0) DEFAULT 1, 
	CREATED DATE, 
	EXPIRED DATE, 
	CHKSUM VARCHAR2(50), 
	USEGTW NUMBER(1,0) DEFAULT 0, 
	BLK CHAR(1), 
	TBLK DATE, 
	TEMPL_ID NUMBER(38,0) DEFAULT 1, 
	CAN_SELECT_BRANCH VARCHAR2(1), 
	CHGPWD CHAR(1), 
	TIP NUMBER(22,0), 
	CURRENT_BRANCH VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to STAFF$BASE ***
 exec bpa.alter_policies('STAFF$BASE');


COMMENT ON TABLE BARS.STAFF$BASE IS 'Справочник персонала банка';
COMMENT ON COLUMN BARS.STAFF$BASE.ID IS 'Код пользователя';
COMMENT ON COLUMN BARS.STAFF$BASE.FIO IS 'ФИО пользователя';
COMMENT ON COLUMN BARS.STAFF$BASE.LOGNAME IS 'Имя пользователя БД';
COMMENT ON COLUMN BARS.STAFF$BASE.TYPE IS 'Признак  отв.исп.';
COMMENT ON COLUMN BARS.STAFF$BASE.TABN IS 'Табельный №';
COMMENT ON COLUMN BARS.STAFF$BASE.BAX IS 'Признак прохождения проходной';
COMMENT ON COLUMN BARS.STAFF$BASE.TBAX IS 'Дата/время прохождения проходной';
COMMENT ON COLUMN BARS.STAFF$BASE.DISABLE IS 'Признак блокировки пользователя';
COMMENT ON COLUMN BARS.STAFF$BASE.ADATE1 IS 'Дата начала действия привилегии';
COMMENT ON COLUMN BARS.STAFF$BASE.ADATE2 IS 'Дата окончания действия привилегии';
COMMENT ON COLUMN BARS.STAFF$BASE.RDATE1 IS 'Дата начала бездействия привилегии';
COMMENT ON COLUMN BARS.STAFF$BASE.RDATE2 IS 'Дата окончания бездействия привилегии';
COMMENT ON COLUMN BARS.STAFF$BASE.CLSID IS 'Категория пользователя';
COMMENT ON COLUMN BARS.STAFF$BASE.APPROVE IS 'Признак подтверждения';
COMMENT ON COLUMN BARS.STAFF$BASE.BRANCH IS 'Код безбалансового отделения';
COMMENT ON COLUMN BARS.STAFF$BASE.COUNTCONN IS 'Количество соединений';
COMMENT ON COLUMN BARS.STAFF$BASE.COUNTPASS IS 'Количество попыток ввода пароля';
COMMENT ON COLUMN BARS.STAFF$BASE.PROFILE IS 'Профиль';
COMMENT ON COLUMN BARS.STAFF$BASE.USEARC IS 'Признак возможности работы пользователя с архивом: 0-не работать, 1-работать';
COMMENT ON COLUMN BARS.STAFF$BASE.CSCHEMA IS 'Текущая схема пользователя';
COMMENT ON COLUMN BARS.STAFF$BASE.WEB_PROFILE IS 'WEB-профиль пользователя';
COMMENT ON COLUMN BARS.STAFF$BASE.POLICY_GROUP IS '';
COMMENT ON COLUMN BARS.STAFF$BASE.ACTIVE IS '';
COMMENT ON COLUMN BARS.STAFF$BASE.CREATED IS '';
COMMENT ON COLUMN BARS.STAFF$BASE.EXPIRED IS '';
COMMENT ON COLUMN BARS.STAFF$BASE.CHKSUM IS '';
COMMENT ON COLUMN BARS.STAFF$BASE.USEGTW IS '';
COMMENT ON COLUMN BARS.STAFF$BASE.BLK IS '';
COMMENT ON COLUMN BARS.STAFF$BASE.TBLK IS '';
COMMENT ON COLUMN BARS.STAFF$BASE.TEMPL_ID IS '';
COMMENT ON COLUMN BARS.STAFF$BASE.CAN_SELECT_BRANCH IS '';
COMMENT ON COLUMN BARS.STAFF$BASE.CHGPWD IS '';
COMMENT ON COLUMN BARS.STAFF$BASE.TIP IS '';
COMMENT ON COLUMN BARS.STAFF$BASE.CURRENT_BRANCH IS 'Текущий бранч пользователя, выбранный с помощью bc.select_branch()';




PROMPT *** Create  constraint FK_STAFF_POLICYGROUPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF$BASE ADD CONSTRAINT FK_STAFF_POLICYGROUPS FOREIGN KEY (POLICY_GROUP)
	  REFERENCES BARS.POLICY_GROUPS (POLICY_GROUP) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_STAFF_WEB_PROFILE ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF$BASE ADD CONSTRAINT FK_STAFF_WEB_PROFILE FOREIGN KEY (WEB_PROFILE)
	  REFERENCES BARS.WEB_PROFILES (PROFILE_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_STAFF_STAFFCLS ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF$BASE ADD CONSTRAINT FK_STAFF_STAFFCLS FOREIGN KEY (CLSID)
	  REFERENCES BARS.STAFF_CLASS (CLSID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_STAFF_STAFFPROFILES ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF$BASE ADD CONSTRAINT FK_STAFF_STAFFPROFILES FOREIGN KEY (PROFILE)
	  REFERENCES BARS.STAFF_PROFILES (PROFILE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_STAFF_STAFFTIPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF$BASE ADD CONSTRAINT FK_STAFF_STAFFTIPS FOREIGN KEY (TIP)
	  REFERENCES BARS.STAFF_TIPS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_STAFF_STAFFTEMPL ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF$BASE ADD CONSTRAINT FK_STAFF_STAFFTEMPL FOREIGN KEY (TEMPL_ID)
	  REFERENCES BARS.STAFF_TEMPLATES (TEMPL_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_STAFF_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF$BASE ADD CONSTRAINT FK_STAFF_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STAFF_POLICYGROUP_BRANCH_CC ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF$BASE ADD CONSTRAINT CC_STAFF_POLICYGROUP_BRANCH_CC CHECK (branch=''/'' and policy_group=''WHOLE'' or length(branch)>1 and policy_group<>''WHOLE'') ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STAFF_USEARC ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF$BASE ADD CONSTRAINT CC_STAFF_USEARC CHECK (usearc in (0, 1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STAFF_BAX ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF$BASE ADD CONSTRAINT CC_STAFF_BAX CHECK (bax in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STAFF_APPROVE ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF$BASE ADD CONSTRAINT CC_STAFF_APPROVE CHECK (approve in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STAFF_RDATE1 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF$BASE ADD CONSTRAINT CC_STAFF_RDATE1 CHECK (rdate1 <= rdate2) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STAFF_ADATE1 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF$BASE ADD CONSTRAINT CC_STAFF_ADATE1 CHECK (adate1 <= adate2) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STAFF_DISABLE ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF$BASE ADD CONSTRAINT CC_STAFF_DISABLE CHECK (disable in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STAFF_TYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF$BASE ADD CONSTRAINT CC_STAFF_TYPE CHECK (type in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF$BASE ADD CONSTRAINT UK_STAFF UNIQUE (LOGNAME)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF$BASE ADD CONSTRAINT PK_STAFF PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STAFF_USEGTW_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF$BASE MODIFY (USEGTW CONSTRAINT CC_STAFF_USEGTW_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STAFF_CREATED_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF$BASE MODIFY (CREATED CONSTRAINT CC_STAFF_CREATED_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STAFF_ACTIVE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF$BASE MODIFY (ACTIVE CONSTRAINT CC_STAFF_ACTIVE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STAFF_POLICYGROUP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF$BASE MODIFY (POLICY_GROUP CONSTRAINT CC_STAFF_POLICYGROUP_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_STAFF_WEB_PROFILE ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF$BASE MODIFY (WEB_PROFILE CONSTRAINT NK_STAFF_WEB_PROFILE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STAFF_CSCHEMA_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF$BASE MODIFY (CSCHEMA CONSTRAINT CC_STAFF_CSCHEMA_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STAFF_USEARC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF$BASE MODIFY (USEARC CONSTRAINT CC_STAFF_USEARC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STAFF_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF$BASE MODIFY (BRANCH CONSTRAINT CC_STAFF_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STAFF_CLSID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF$BASE MODIFY (CLSID CONSTRAINT CC_STAFF_CLSID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STAFF_TYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF$BASE MODIFY (TYPE CONSTRAINT CC_STAFF_TYPE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STAFF_LOGNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF$BASE MODIFY (LOGNAME CONSTRAINT CC_STAFF_LOGNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STAFF_FIO_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF$BASE MODIFY (FIO CONSTRAINT CC_STAFF_FIO_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STAFF_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF$BASE MODIFY (ID CONSTRAINT CC_STAFF_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STAFF_TEMPLID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF$BASE MODIFY (TEMPL_ID CONSTRAINT CC_STAFF_TEMPLID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STAFF_CHGWPD ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF$BASE ADD CONSTRAINT CC_STAFF_CHGWPD CHECK (chgpwd in (''Y'', ''N'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STAFF_CANSELBRANCH_CC ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF$BASE ADD CONSTRAINT CC_STAFF_CANSELBRANCH_CC CHECK (can_select_branch=''Y'') ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STAFF_TABN_CC ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF$BASE ADD CONSTRAINT CC_STAFF_TABN_CC CHECK (length(tabn)=6) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STAFF_CSCHEMA ***
begin
	execute immediate 'alter table bars.staff$base drop constraint CC_STAFF_CSCHEMA';
exception
	when others then
		if sqlcode = -2443 then null; else raise; end if;
end;
/
begin
	execute immediate q'[alter table bars.staff$base add constraint CC_STAFF_CSCHEMA check (cschema in ('BARS', 'HIST','BARSAQ','FINMON','BARSUPL','BARS_DM', 'SBON', 'BARS_INTGR')) enable validate]';
exception
	when others then
		if sqlcode = -2264 then null; else raise; end if;
end;
/

PROMPT *** Create  index PK_STAFF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_STAFF ON BARS.STAFF$BASE (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_STAFF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_STAFF ON BARS.STAFF$BASE (LOGNAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_STAFF_WEB_PROFILE ***
begin   
 execute immediate '
  CREATE INDEX BARS.XPK_STAFF_WEB_PROFILE ON BARS.STAFF$BASE (WEB_PROFILE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_STAFF ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_STAFF ON BARS.STAFF$BASE (CREATED) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  STAFF$BASE ***
grant INSERT,SELECT,UPDATE                                                   on STAFF$BASE      to ABS_ADMIN;
grant FLASHBACK,REFERENCES,SELECT                                            on STAFF$BASE      to BARSAQ with grant option;
grant SELECT                                                                 on STAFF$BASE      to BARSUPL;
grant INSERT,SELECT,UPDATE                                                   on STAFF$BASE      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on STAFF$BASE      to BARS_SUP;
grant SELECT                                                                 on STAFF$BASE      to CUST001;
grant SELECT,UPDATE                                                          on STAFF$BASE      to START1;
grant INSERT,SELECT,UPDATE                                                   on STAFF$BASE      to WCS_SYNC_USER;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on STAFF$BASE      to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to STAFF$BASE ***

CREATE OR REPLACE PUBLIC SYNONYM STAFF$BASE FOR BARS.STAFF$BASE;
