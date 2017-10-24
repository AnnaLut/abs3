

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/AQ$_BARS_MAIL_QT_I.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to AQ$_BARS_MAIL_QT_I ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table AQ$_BARS_MAIL_QT_I ***
begin 
  execute immediate '
  CREATE TABLE BARS.AQ$_BARS_MAIL_QT_I 
   (	SUBSCRIBER# NUMBER, 
	NAME VARCHAR2(30), 
	QUEUE# NUMBER, 
	MSG_ENQ_TIME TIMESTAMP (6), 
	MSG_STEP_NO NUMBER, 
	MSG_CHAIN_NO NUMBER, 
	MSG_LOCAL_ORDER_NO NUMBER, 
	MSGID RAW(16), 
	HINT ROWID, 
	SPARE RAW(16), 
	 PRIMARY KEY (SUBSCRIBER#, NAME, QUEUE#, MSG_ENQ_TIME, MSG_STEP_NO, MSG_CHAIN_NO, MSG_LOCAL_ORDER_NO, MSGID) ENABLE
   ) USAGE QUEUE ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSDYND 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to AQ$_BARS_MAIL_QT_I ***
 exec bpa.alter_policies('AQ$_BARS_MAIL_QT_I');


COMMENT ON TABLE BARS.AQ$_BARS_MAIL_QT_I IS '';
COMMENT ON COLUMN BARS.AQ$_BARS_MAIL_QT_I.SUBSCRIBER# IS '';
COMMENT ON COLUMN BARS.AQ$_BARS_MAIL_QT_I.NAME IS '';
COMMENT ON COLUMN BARS.AQ$_BARS_MAIL_QT_I.QUEUE# IS '';
COMMENT ON COLUMN BARS.AQ$_BARS_MAIL_QT_I.MSG_ENQ_TIME IS '';
COMMENT ON COLUMN BARS.AQ$_BARS_MAIL_QT_I.MSG_STEP_NO IS '';
COMMENT ON COLUMN BARS.AQ$_BARS_MAIL_QT_I.MSG_CHAIN_NO IS '';
COMMENT ON COLUMN BARS.AQ$_BARS_MAIL_QT_I.MSG_LOCAL_ORDER_NO IS '';
COMMENT ON COLUMN BARS.AQ$_BARS_MAIL_QT_I.MSGID IS '';
COMMENT ON COLUMN BARS.AQ$_BARS_MAIL_QT_I.HINT IS '';
COMMENT ON COLUMN BARS.AQ$_BARS_MAIL_QT_I.SPARE IS '';




PROMPT *** Create  constraint SYS_IOT_TOP_80069 ***
begin   
 execute immediate '
  ALTER TABLE BARS.AQ$_BARS_MAIL_QT_I ADD PRIMARY KEY (SUBSCRIBER#, NAME, QUEUE#, MSG_ENQ_TIME, MSG_STEP_NO, MSG_CHAIN_NO, MSG_LOCAL_ORDER_NO, MSGID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index SYS_IOT_TOP_80069 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.SYS_IOT_TOP_80069 ON BARS.AQ$_BARS_MAIL_QT_I (SUBSCRIBER#, NAME, QUEUE#, MSG_ENQ_TIME, MSG_STEP_NO, MSG_CHAIN_NO, MSG_LOCAL_ORDER_NO, MSGID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  AQ$_BARS_MAIL_QT_I ***
grant DELETE,INSERT,SELECT,UPDATE                                            on AQ$_BARS_MAIL_QT_I to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on AQ$_BARS_MAIL_QT_I to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on AQ$_BARS_MAIL_QT_I to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/AQ$_BARS_MAIL_QT_I.sql =========*** En
PROMPT ===================================================================================== 
