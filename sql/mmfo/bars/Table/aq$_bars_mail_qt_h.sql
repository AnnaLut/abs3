

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/AQ$_BARS_MAIL_QT_H.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to AQ$_BARS_MAIL_QT_H ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table AQ$_BARS_MAIL_QT_H ***
begin 
  execute immediate '
  CREATE TABLE BARS.AQ$_BARS_MAIL_QT_H 
   (	MSGID RAW(16), 
	SUBSCRIBER# NUMBER, 
	NAME VARCHAR2(30), 
	ADDRESS# NUMBER, 
	DEQUEUE_TIME TIMESTAMP (6), 
	TRANSACTION_ID VARCHAR2(30), 
	DEQUEUE_USER VARCHAR2(30), 
	PROPAGATED_MSGID RAW(16), 
	RETRY_COUNT NUMBER, 
	HINT ROWID, 
	SPARE RAW(16), 
	 PRIMARY KEY (MSGID, SUBSCRIBER#, NAME, ADDRESS#) ENABLE
   ) USAGE QUEUE ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSDYND 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to AQ$_BARS_MAIL_QT_H ***
 exec bpa.alter_policies('AQ$_BARS_MAIL_QT_H');


COMMENT ON TABLE BARS.AQ$_BARS_MAIL_QT_H IS '';
COMMENT ON COLUMN BARS.AQ$_BARS_MAIL_QT_H.MSGID IS '';
COMMENT ON COLUMN BARS.AQ$_BARS_MAIL_QT_H.SUBSCRIBER# IS '';
COMMENT ON COLUMN BARS.AQ$_BARS_MAIL_QT_H.NAME IS '';
COMMENT ON COLUMN BARS.AQ$_BARS_MAIL_QT_H.ADDRESS# IS '';
COMMENT ON COLUMN BARS.AQ$_BARS_MAIL_QT_H.DEQUEUE_TIME IS '';
COMMENT ON COLUMN BARS.AQ$_BARS_MAIL_QT_H.TRANSACTION_ID IS '';
COMMENT ON COLUMN BARS.AQ$_BARS_MAIL_QT_H.DEQUEUE_USER IS '';
COMMENT ON COLUMN BARS.AQ$_BARS_MAIL_QT_H.PROPAGATED_MSGID IS '';
COMMENT ON COLUMN BARS.AQ$_BARS_MAIL_QT_H.RETRY_COUNT IS '';
COMMENT ON COLUMN BARS.AQ$_BARS_MAIL_QT_H.HINT IS '';
COMMENT ON COLUMN BARS.AQ$_BARS_MAIL_QT_H.SPARE IS '';




PROMPT *** Create  constraint SYS_IOT_TOP_79987 ***
begin   
 execute immediate '
  ALTER TABLE BARS.AQ$_BARS_MAIL_QT_H ADD PRIMARY KEY (MSGID, SUBSCRIBER#, NAME, ADDRESS#)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index SYS_IOT_TOP_79987 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.SYS_IOT_TOP_79987 ON BARS.AQ$_BARS_MAIL_QT_H (MSGID, SUBSCRIBER#, NAME, ADDRESS#) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  AQ$_BARS_MAIL_QT_H ***
grant SELECT                                                                 on AQ$_BARS_MAIL_QT_H to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on AQ$_BARS_MAIL_QT_H to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on AQ$_BARS_MAIL_QT_H to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on AQ$_BARS_MAIL_QT_H to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/AQ$_BARS_MAIL_QT_H.sql =========*** En
PROMPT ===================================================================================== 
