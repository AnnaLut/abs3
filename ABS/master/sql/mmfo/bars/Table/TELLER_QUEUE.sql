PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TELLER_QUEUE.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TELLER_QUEUE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TELLER_QUEUE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TELLER_QUEUE ***
begin 
  execute immediate '
  CREATE TABLE BARS.TELLER_QUEUE 
   (	USER_ID VARCHAR2(20), 
	USER_NAME VARCHAR2(100), 
	HOST VARCHAR2(100), 
	REQ_NAME VARCHAR2(100), 
	START_DT DATE, 
	LAST_DT DATE, 
	REQ_RESP VARCHAR2(1000), 
	DEV_STATUS VARCHAR2(1000), 
	OPER_TYPE VARCHAR2(4), 
	OPER_REF NUMBER, 
	OPER_CODE VARCHAR2(3)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TELLER_QUEUE ***
 exec bpa.alter_policies('TELLER_QUEUE');


COMMENT ON TABLE BARS.TELLER_QUEUE IS '';
COMMENT ON COLUMN BARS.TELLER_QUEUE.USER_ID IS '';
COMMENT ON COLUMN BARS.TELLER_QUEUE.USER_NAME IS '';
COMMENT ON COLUMN BARS.TELLER_QUEUE.HOST IS '';
COMMENT ON COLUMN BARS.TELLER_QUEUE.REQ_NAME IS '';
COMMENT ON COLUMN BARS.TELLER_QUEUE.START_DT IS '';
COMMENT ON COLUMN BARS.TELLER_QUEUE.LAST_DT IS '';
COMMENT ON COLUMN BARS.TELLER_QUEUE.REQ_RESP IS '';
COMMENT ON COLUMN BARS.TELLER_QUEUE.DEV_STATUS IS '';
COMMENT ON COLUMN BARS.TELLER_QUEUE.OPER_TYPE IS '';
COMMENT ON COLUMN BARS.TELLER_QUEUE.OPER_REF IS '';
COMMENT ON COLUMN BARS.TELLER_QUEUE.OPER_CODE IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TELLER_QUEUE.sql =========*** End *** 
PROMPT ===================================================================================== 
