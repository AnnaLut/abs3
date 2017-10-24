

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SMS_QUERY_DATA.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SMS_QUERY_DATA ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SMS_QUERY_DATA'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SMS_QUERY_DATA'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SMS_QUERY_DATA ***
begin 
  execute immediate '
  CREATE TABLE BARS.SMS_QUERY_DATA 
   (	SMS_ID VARCHAR2(36), 
	MSG_ID NUMBER(*,0), 
	NEXT_QUERY_TIME DATE, 
	QUERY_COUNTER NUMBER(*,0) DEFAULT 0, 
	QUERY_TIME DATE, 
	QUERY_CODE VARCHAR2(2), 
	SMS_STATE VARCHAR2(30) DEFAULT ''UNKNOWN'', 
	LAST_ERROR VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SMS_QUERY_DATA ***
 exec bpa.alter_policies('SMS_QUERY_DATA');


COMMENT ON TABLE BARS.SMS_QUERY_DATA IS '��� �� ����� SMS';
COMMENT ON COLUMN BARS.SMS_QUERY_DATA.SMS_ID IS 'ID SMS';
COMMENT ON COLUMN BARS.SMS_QUERY_DATA.MSG_ID IS 'ID �����������';
COMMENT ON COLUMN BARS.SMS_QUERY_DATA.NEXT_QUERY_TIME IS '��� ���������� ������';
COMMENT ON COLUMN BARS.SMS_QUERY_DATA.QUERY_COUNTER IS '';
COMMENT ON COLUMN BARS.SMS_QUERY_DATA.QUERY_TIME IS '��� ������';
COMMENT ON COLUMN BARS.SMS_QUERY_DATA.QUERY_CODE IS '��������� ������';
COMMENT ON COLUMN BARS.SMS_QUERY_DATA.SMS_STATE IS '������ �������� SMS';
COMMENT ON COLUMN BARS.SMS_QUERY_DATA.LAST_ERROR IS '���� �������� �������';




PROMPT *** Create  constraint FK_MSGSUBMIT_SMSQUERY ***
begin   
 execute immediate '
  ALTER TABLE BARS.SMS_QUERY_DATA ADD CONSTRAINT FK_MSGSUBMIT_SMSQUERY FOREIGN KEY (MSG_ID)
	  REFERENCES BARS.MSG_SUBMIT_DATA (MSG_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SMSQUERY ***
begin   
 execute immediate '
  ALTER TABLE BARS.SMS_QUERY_DATA ADD CONSTRAINT PK_SMSQUERY PRIMARY KEY (SMS_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SMSQUERY_STATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SMS_QUERY_DATA MODIFY (SMS_STATE CONSTRAINT CC_SMSQUERY_STATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SMSQUERY_QCOUNTER_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SMS_QUERY_DATA MODIFY (QUERY_COUNTER CONSTRAINT CC_SMSQUERY_QCOUNTER_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SMSQUERY_MSGID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SMS_QUERY_DATA MODIFY (MSG_ID CONSTRAINT CC_SMSQUERY_MSGID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SMSQUERY_SMSID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SMS_QUERY_DATA MODIFY (SMS_ID CONSTRAINT CC_SMSQUERY_SMSID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SMSQUERY ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SMSQUERY ON BARS.SMS_QUERY_DATA (SMS_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_SMSQUERY_STATE ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_SMSQUERY_STATE ON BARS.SMS_QUERY_DATA (SMS_STATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_SMSQUERY_NEXTQUERYTIME ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_SMSQUERY_NEXTQUERYTIME ON BARS.SMS_QUERY_DATA (NEXT_QUERY_TIME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SMS_QUERY_DATA.sql =========*** End **
PROMPT ===================================================================================== 
