

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SEC_AUDIT.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SEC_AUDIT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SEC_AUDIT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SEC_AUDIT'', ''FILIAL'' , ''B'', ''B'', ''E'', ''E'');
               bpa.alter_policy_info(''SEC_AUDIT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SEC_AUDIT ***
begin 
  execute immediate '
  CREATE TABLE BARS.SEC_AUDIT 
   (	REC_ID NUMBER(38,0), 
	REC_UID NUMBER(38,0) DEFAULT null, 
	REC_UNAME VARCHAR2(30) DEFAULT sys_context(''userenv'', ''session_user''), 
	REC_UPROXY VARCHAR2(30) DEFAULT sys_context(''userenv'', ''proxy_user''), 
	REC_DATE DATE DEFAULT sysdate, 
	REC_BDATE DATE, 
	REC_TYPE VARCHAR2(10) DEFAULT ''INFO'', 
	REC_MODULE VARCHAR2(30), 
	REC_MESSAGE VARCHAR2(4000), 
	MACHINE VARCHAR2(255) DEFAULT sys_context(''userenv'', ''terminal''), 
	REC_OBJECT VARCHAR2(100), 
	REC_USERID NUMBER(38,0) DEFAULT sys_context(''userenv'', ''session_userid''), 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	REC_STACK VARCHAR2(2000), 
	CLIENT_IDENTIFIER VARCHAR2(64) DEFAULT sys_context(''userenv'',''client_identifier'')
   ) PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS  LOGGING 
  TABLESPACE BRSAUDITD 
  PARTITION BY RANGE (REC_DATE) INTERVAL (NUMTODSINTERVAL(1,''DAY'')) 
 (PARTITION SYS_P51969  VALUES LESS THAN (TO_DATE('' 2015-10-11 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN'')) SEGMENT CREATION IMMEDIATE 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSAUDITD )  ENABLE ROW MOVEMENT ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SEC_AUDIT ***
 exec bpa.alter_policies('SEC_AUDIT');


COMMENT ON TABLE BARS.SEC_AUDIT IS '';
COMMENT ON COLUMN BARS.SEC_AUDIT.REC_ID IS '';
COMMENT ON COLUMN BARS.SEC_AUDIT.REC_UID IS '';
COMMENT ON COLUMN BARS.SEC_AUDIT.REC_UNAME IS '';
COMMENT ON COLUMN BARS.SEC_AUDIT.REC_UPROXY IS '';
COMMENT ON COLUMN BARS.SEC_AUDIT.REC_DATE IS '';
COMMENT ON COLUMN BARS.SEC_AUDIT.REC_BDATE IS '';
COMMENT ON COLUMN BARS.SEC_AUDIT.REC_TYPE IS '';
COMMENT ON COLUMN BARS.SEC_AUDIT.REC_MODULE IS '';
COMMENT ON COLUMN BARS.SEC_AUDIT.REC_MESSAGE IS '';
COMMENT ON COLUMN BARS.SEC_AUDIT.MACHINE IS '';
COMMENT ON COLUMN BARS.SEC_AUDIT.REC_OBJECT IS '';
COMMENT ON COLUMN BARS.SEC_AUDIT.REC_USERID IS '';
COMMENT ON COLUMN BARS.SEC_AUDIT.BRANCH IS '';
COMMENT ON COLUMN BARS.SEC_AUDIT.REC_STACK IS '';
COMMENT ON COLUMN BARS.SEC_AUDIT.CLIENT_IDENTIFIER IS '���������� �������������(��-� ������)';




PROMPT *** Create  constraint CC_SECAUDIT_RECID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_AUDIT MODIFY (REC_ID CONSTRAINT CC_SECAUDIT_RECID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SECAUDIT_RECDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_AUDIT MODIFY (REC_DATE CONSTRAINT CC_SECAUDIT_RECDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SEC_AUDIT ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SEC_AUDIT       to ABS_ADMIN;
grant SELECT                                                                 on SEC_AUDIT       to BARSREADER_ROLE;
grant SELECT                                                                 on SEC_AUDIT       to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on SEC_AUDIT       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SEC_AUDIT       to START1;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on SEC_AUDIT       to TEST2;
grant SELECT                                                                 on SEC_AUDIT       to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SEC_AUDIT       to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to SEC_AUDIT ***

  CREATE OR REPLACE SYNONYM BARS.SEC_AUDIT_MAIN FOR BARS.SEC_AUDIT;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SEC_AUDIT.sql =========*** End *** ===
PROMPT ===================================================================================== 
