

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/AQ$_BARS_MAIL_QT_S.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to AQ$_BARS_MAIL_QT_S ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table AQ$_BARS_MAIL_QT_S ***
begin 
  execute immediate '
  CREATE TABLE BARS.AQ$_BARS_MAIL_QT_S 
   (	SUBSCRIBER_ID NUMBER, 
	QUEUE_NAME VARCHAR2(30), 
	NAME VARCHAR2(30), 
	ADDRESS VARCHAR2(1024), 
	PROTOCOL NUMBER, 
	SUBSCRIBER_TYPE NUMBER, 
	RULE_NAME VARCHAR2(30), 
	TRANS_NAME VARCHAR2(65), 
	RULESET_NAME VARCHAR2(65), 
	NEGATIVE_RULESET_NAME VARCHAR2(65), 
	CREATION_TIME TIMESTAMP (6) WITH TIME ZONE, 
	MODIFICATION_TIME TIMESTAMP (6) WITH TIME ZONE, 
	DELETION_TIME TIMESTAMP (6) WITH TIME ZONE, 
	SCN_AT_REMOVE NUMBER, 
	SCN_AT_ADD NUMBER
   ) USAGE QUEUE PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to AQ$_BARS_MAIL_QT_S ***
 exec bpa.alter_policies('AQ$_BARS_MAIL_QT_S');


COMMENT ON TABLE BARS.AQ$_BARS_MAIL_QT_S IS '';
COMMENT ON COLUMN BARS.AQ$_BARS_MAIL_QT_S.NAME IS '';
COMMENT ON COLUMN BARS.AQ$_BARS_MAIL_QT_S.ADDRESS IS '';
COMMENT ON COLUMN BARS.AQ$_BARS_MAIL_QT_S.PROTOCOL IS '';
COMMENT ON COLUMN BARS.AQ$_BARS_MAIL_QT_S.SUBSCRIBER_TYPE IS '';
COMMENT ON COLUMN BARS.AQ$_BARS_MAIL_QT_S.RULE_NAME IS '';
COMMENT ON COLUMN BARS.AQ$_BARS_MAIL_QT_S.TRANS_NAME IS '';
COMMENT ON COLUMN BARS.AQ$_BARS_MAIL_QT_S.RULESET_NAME IS '';
COMMENT ON COLUMN BARS.AQ$_BARS_MAIL_QT_S.NEGATIVE_RULESET_NAME IS '';
COMMENT ON COLUMN BARS.AQ$_BARS_MAIL_QT_S.CREATION_TIME IS '';
COMMENT ON COLUMN BARS.AQ$_BARS_MAIL_QT_S.MODIFICATION_TIME IS '';
COMMENT ON COLUMN BARS.AQ$_BARS_MAIL_QT_S.DELETION_TIME IS '';
COMMENT ON COLUMN BARS.AQ$_BARS_MAIL_QT_S.SCN_AT_REMOVE IS '';
COMMENT ON COLUMN BARS.AQ$_BARS_MAIL_QT_S.SCN_AT_ADD IS '';
COMMENT ON COLUMN BARS.AQ$_BARS_MAIL_QT_S.SUBSCRIBER_ID IS '';
COMMENT ON COLUMN BARS.AQ$_BARS_MAIL_QT_S.QUEUE_NAME IS '';




PROMPT *** Create  constraint SYS_C0011606 ***
begin   
 execute immediate '
  ALTER TABLE BARS.AQ$_BARS_MAIL_QT_S ADD PRIMARY KEY (SUBSCRIBER_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010241 ***
begin   
 execute immediate '
  ALTER TABLE BARS.AQ$_BARS_MAIL_QT_S MODIFY (SUBSCRIBER_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010242 ***
begin   
 execute immediate '
  ALTER TABLE BARS.AQ$_BARS_MAIL_QT_S MODIFY (QUEUE_NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index SYS_C0011606 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.SYS_C0011606 ON BARS.AQ$_BARS_MAIL_QT_S (SUBSCRIBER_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  AQ$_BARS_MAIL_QT_S ***
grant DELETE,INSERT,SELECT,UPDATE                                            on AQ$_BARS_MAIL_QT_S to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on AQ$_BARS_MAIL_QT_S to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on AQ$_BARS_MAIL_QT_S to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/AQ$_BARS_MAIL_QT_S.sql =========*** En
PROMPT ===================================================================================== 
