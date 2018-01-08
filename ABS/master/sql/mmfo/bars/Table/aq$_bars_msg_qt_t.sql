

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/AQ$_BARS_MSG_QT_T.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to AQ$_BARS_MSG_QT_T ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table AQ$_BARS_MSG_QT_T ***
begin 
  execute immediate '
  CREATE TABLE BARS.AQ$_BARS_MSG_QT_T 
   (	NEXT_DATE TIMESTAMP (6), 
	TXN_ID VARCHAR2(30), 
	MSGID RAW(16), 
	ACTION NUMBER, 
	 PRIMARY KEY (NEXT_DATE, TXN_ID, MSGID) ENABLE
   ) USAGE QUEUE ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSDYND 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to AQ$_BARS_MSG_QT_T ***
 exec bpa.alter_policies('AQ$_BARS_MSG_QT_T');


COMMENT ON TABLE BARS.AQ$_BARS_MSG_QT_T IS '';
COMMENT ON COLUMN BARS.AQ$_BARS_MSG_QT_T.NEXT_DATE IS '';
COMMENT ON COLUMN BARS.AQ$_BARS_MSG_QT_T.TXN_ID IS '';
COMMENT ON COLUMN BARS.AQ$_BARS_MSG_QT_T.MSGID IS '';
COMMENT ON COLUMN BARS.AQ$_BARS_MSG_QT_T.ACTION IS '';




PROMPT *** Create  constraint SYS_IOT_TOP_80058 ***
begin   
 execute immediate '
  ALTER TABLE BARS.AQ$_BARS_MSG_QT_T ADD PRIMARY KEY (NEXT_DATE, TXN_ID, MSGID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index SYS_IOT_TOP_80058 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.SYS_IOT_TOP_80058 ON BARS.AQ$_BARS_MSG_QT_T (NEXT_DATE, TXN_ID, MSGID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  AQ$_BARS_MSG_QT_T ***
grant SELECT                                                                 on AQ$_BARS_MSG_QT_T to BARSREADER_ROLE;
grant SELECT                                                                 on AQ$_BARS_MSG_QT_T to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/AQ$_BARS_MSG_QT_T.sql =========*** End
PROMPT ===================================================================================== 
