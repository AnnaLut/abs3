

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BMS_MESSAGE_TYPE.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BMS_MESSAGE_TYPE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BMS_MESSAGE_TYPE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BMS_MESSAGE_TYPE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''BMS_MESSAGE_TYPE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BMS_MESSAGE_TYPE ***
begin 
  execute immediate '
  CREATE TABLE BARS.BMS_MESSAGE_TYPE 
   (	ID NUMBER(5,0), 
	MESSAGE_TYPE_CODE VARCHAR2(30 CHAR), 
	MESSAGE_TYPE_NAME VARCHAR2(300 CHAR), 
	VALIDITY_PERIOD NUMBER(4,2), 
	RECEIVER_ID_TYPE VARCHAR2(30 CHAR), 
	IS_PERSISTED CHAR(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BMS_MESSAGE_TYPE ***
 exec bpa.alter_policies('BMS_MESSAGE_TYPE');


COMMENT ON TABLE BARS.BMS_MESSAGE_TYPE IS '';
COMMENT ON COLUMN BARS.BMS_MESSAGE_TYPE.ID IS '';
COMMENT ON COLUMN BARS.BMS_MESSAGE_TYPE.MESSAGE_TYPE_CODE IS '';
COMMENT ON COLUMN BARS.BMS_MESSAGE_TYPE.MESSAGE_TYPE_NAME IS '';
COMMENT ON COLUMN BARS.BMS_MESSAGE_TYPE.VALIDITY_PERIOD IS '';
COMMENT ON COLUMN BARS.BMS_MESSAGE_TYPE.RECEIVER_ID_TYPE IS '';
COMMENT ON COLUMN BARS.BMS_MESSAGE_TYPE.IS_PERSISTED IS '';




PROMPT *** Create  constraint PK_BMS_MESSAGE_TYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.BMS_MESSAGE_TYPE ADD CONSTRAINT PK_BMS_MESSAGE_TYPE PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_BMS_MESSAGE_TYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.BMS_MESSAGE_TYPE ADD CONSTRAINT UK_BMS_MESSAGE_TYPE UNIQUE (MESSAGE_TYPE_CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C004795 ***
begin   
 execute immediate '
  ALTER TABLE BARS.BMS_MESSAGE_TYPE MODIFY (MESSAGE_TYPE_CODE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C004796 ***
begin   
 execute immediate '
  ALTER TABLE BARS.BMS_MESSAGE_TYPE MODIFY (MESSAGE_TYPE_NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C004797 ***
begin   
 execute immediate '
  ALTER TABLE BARS.BMS_MESSAGE_TYPE MODIFY (VALIDITY_PERIOD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C004798 ***
begin   
 execute immediate '
  ALTER TABLE BARS.BMS_MESSAGE_TYPE MODIFY (RECEIVER_ID_TYPE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C004799 ***
begin   
 execute immediate '
  ALTER TABLE BARS.BMS_MESSAGE_TYPE MODIFY (IS_PERSISTED NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BMS_MESSAGE_TYPE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BMS_MESSAGE_TYPE ON BARS.BMS_MESSAGE_TYPE (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_BMS_MESSAGE_TYPE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_BMS_MESSAGE_TYPE ON BARS.BMS_MESSAGE_TYPE (MESSAGE_TYPE_CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BMS_MESSAGE_TYPE ***
grant SELECT                                                                 on BMS_MESSAGE_TYPE to BARSREADER_ROLE;
grant SELECT                                                                 on BMS_MESSAGE_TYPE to BARS_DM;
grant SELECT                                                                 on BMS_MESSAGE_TYPE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BMS_MESSAGE_TYPE.sql =========*** End 
PROMPT ===================================================================================== 
