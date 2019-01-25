PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TELLER_INFORM_LOG.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TELLER_INFORM_LOG ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TELLER_INFORM_LOG'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TELLER_INFORM_LOG ***
begin 
  execute immediate '
  CREATE TABLE BARS.TELLER_INFORM_LOG 
   (	TYPE_INFO VARCHAR2(10), 
	USERID NUMBER, 
	USERNAME VARCHAR2(20), 
	RECEIVER VARCHAR2(50), 
	MSG_BODY CLOB, 
	DT_SEND DATE, 
	DT_CONFIRM DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND 
 LOB (MSG_BODY) STORE AS BASICFILE (
  TABLESPACE BRSDYND ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TELLER_INFORM_LOG ***
 exec bpa.alter_policies('TELLER_INFORM_LOG');


COMMENT ON TABLE BARS.TELLER_INFORM_LOG IS '';
COMMENT ON COLUMN BARS.TELLER_INFORM_LOG.TYPE_INFO IS '';
COMMENT ON COLUMN BARS.TELLER_INFORM_LOG.USERID IS '';
COMMENT ON COLUMN BARS.TELLER_INFORM_LOG.USERNAME IS '';
COMMENT ON COLUMN BARS.TELLER_INFORM_LOG.RECEIVER IS '';
COMMENT ON COLUMN BARS.TELLER_INFORM_LOG.MSG_BODY IS '';
COMMENT ON COLUMN BARS.TELLER_INFORM_LOG.DT_SEND IS '';
COMMENT ON COLUMN BARS.TELLER_INFORM_LOG.DT_CONFIRM IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TELLER_INFORM_LOG.sql =========*** End
PROMPT ===================================================================================== 
