

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SGN_USER_TRACE.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SGN_USER_TRACE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SGN_USER_TRACE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SGN_USER_TRACE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SGN_USER_TRACE ***
begin 
  execute immediate '
  CREATE TABLE BARS.SGN_USER_TRACE 
   (	CR_DATE TIMESTAMP (6) DEFAULT localtimestamp, 
	USER_ID NUMBER(38,0), 
	KEY_ID VARCHAR2(256), 
	BC_VERSION VARCHAR2(20), 
	USER_ADDRESS VARCHAR2(200), 
	BROWSER_INFO VARCHAR2(4000), 
	CHECK_STATUS NUMBER(3,0), 
	CHECK_ERROR VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SGN_USER_TRACE ***
 exec bpa.alter_policies('SGN_USER_TRACE');


COMMENT ON TABLE BARS.SGN_USER_TRACE IS '';
COMMENT ON COLUMN BARS.SGN_USER_TRACE.CR_DATE IS '';
COMMENT ON COLUMN BARS.SGN_USER_TRACE.USER_ID IS '';
COMMENT ON COLUMN BARS.SGN_USER_TRACE.KEY_ID IS '';
COMMENT ON COLUMN BARS.SGN_USER_TRACE.BC_VERSION IS '';
COMMENT ON COLUMN BARS.SGN_USER_TRACE.USER_ADDRESS IS '';
COMMENT ON COLUMN BARS.SGN_USER_TRACE.BROWSER_INFO IS '';
COMMENT ON COLUMN BARS.SGN_USER_TRACE.CHECK_STATUS IS '';
COMMENT ON COLUMN BARS.SGN_USER_TRACE.CHECK_ERROR IS '';




PROMPT *** Create  constraint SYS_C00118482 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SGN_USER_TRACE MODIFY (CR_DATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SGN_USER_TRACE.sql =========*** End **
PROMPT ===================================================================================== 
