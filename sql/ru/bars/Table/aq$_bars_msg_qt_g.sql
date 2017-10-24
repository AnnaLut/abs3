

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/AQ$_BARS_MSG_QT_G.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to AQ$_BARS_MSG_QT_G ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table AQ$_BARS_MSG_QT_G ***
begin 
  execute immediate '
  CREATE TABLE BARS.AQ$_BARS_MSG_QT_G 
   (	MSGID RAW(16), 
	SUBSCRIBER# NUMBER, 
	NAME VARCHAR2(30), 
	ADDRESS# NUMBER, 
	SIGN SYS.AQ$_SIG_PROP , 
	DBS_SIGN SYS.AQ$_SIG_PROP , 
	 PRIMARY KEY (MSGID, SUBSCRIBER#, NAME, ADDRESS#) ENABLE
   ) USAGE QUEUE ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSDYND 
 PCTTHRESHOLD 50 INCLUDING SIGN OVERFLOW
 PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to AQ$_BARS_MSG_QT_G ***
 exec bpa.alter_policies('AQ$_BARS_MSG_QT_G');


COMMENT ON TABLE BARS.AQ$_BARS_MSG_QT_G IS '';
COMMENT ON COLUMN BARS.AQ$_BARS_MSG_QT_G.MSGID IS '';
COMMENT ON COLUMN BARS.AQ$_BARS_MSG_QT_G.SUBSCRIBER# IS '';
COMMENT ON COLUMN BARS.AQ$_BARS_MSG_QT_G.NAME IS '';
COMMENT ON COLUMN BARS.AQ$_BARS_MSG_QT_G.ADDRESS# IS '';
COMMENT ON COLUMN BARS.AQ$_BARS_MSG_QT_G.SIGN IS '';
COMMENT ON COLUMN BARS.AQ$_BARS_MSG_QT_G.DBS_SIGN IS '';




PROMPT *** Create  constraint SYS_IOT_TOP_2139477 ***
begin   
 execute immediate '
  ALTER TABLE BARS.AQ$_BARS_MSG_QT_G ADD PRIMARY KEY (MSGID, SUBSCRIBER#, NAME, ADDRESS#)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index SYS_IOT_TOP_2139477 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.SYS_IOT_TOP_2139477 ON BARS.AQ$_BARS_MSG_QT_G (MSGID, SUBSCRIBER#, NAME, ADDRESS#) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/AQ$_BARS_MSG_QT_G.sql =========*** End
PROMPT ===================================================================================== 
