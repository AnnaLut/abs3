

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BMS_MESSAGE.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BMS_MESSAGE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BMS_MESSAGE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BMS_MESSAGE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''BMS_MESSAGE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BMS_MESSAGE ***
begin 
  execute immediate '
  CREATE TABLE BARS.BMS_MESSAGE 
   (	ID NUMBER(10,0), 
	SENDER_ID NUMBER(10,0), 
	RECEIVER_ID VARCHAR2(32 CHAR), 
	RECEIVER_NAME VARCHAR2(300 CHAR), 
	MESSAGE_TYPE_ID NUMBER(5,0), 
	MESSAGE_TEXT VARCHAR2(4000), 
	SENDING_TIME DATE, 
	EFFECTIVE_TIME DATE, 
	EXPIRATION_TIME DATE, 
	PROCESSING_TIME DATE, 
	PROCESSING_COMMENT VARCHAR2(4000)
   ) PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSDYND 
  PARTITION BY RANGE (MESSAGE_TYPE_ID) INTERVAL (1) 
 (PARTITION INITIAL_PARTITION  VALUES LESS THAN (1) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSDYND ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BMS_MESSAGE ***
 exec bpa.alter_policies('BMS_MESSAGE');


COMMENT ON TABLE BARS.BMS_MESSAGE IS '';
COMMENT ON COLUMN BARS.BMS_MESSAGE.ID IS '';
COMMENT ON COLUMN BARS.BMS_MESSAGE.SENDER_ID IS '';
COMMENT ON COLUMN BARS.BMS_MESSAGE.RECEIVER_ID IS '';
COMMENT ON COLUMN BARS.BMS_MESSAGE.RECEIVER_NAME IS '';
COMMENT ON COLUMN BARS.BMS_MESSAGE.MESSAGE_TYPE_ID IS '';
COMMENT ON COLUMN BARS.BMS_MESSAGE.MESSAGE_TEXT IS '';
COMMENT ON COLUMN BARS.BMS_MESSAGE.SENDING_TIME IS '';
COMMENT ON COLUMN BARS.BMS_MESSAGE.EFFECTIVE_TIME IS '';
COMMENT ON COLUMN BARS.BMS_MESSAGE.EXPIRATION_TIME IS '';
COMMENT ON COLUMN BARS.BMS_MESSAGE.PROCESSING_TIME IS '';
COMMENT ON COLUMN BARS.BMS_MESSAGE.PROCESSING_COMMENT IS '';




PROMPT *** Create  constraint PK_BMS_MESSAGES ***
begin   
 execute immediate '
  ALTER TABLE BARS.BMS_MESSAGE ADD CONSTRAINT PK_BMS_MESSAGES PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C004239 ***
begin   
 execute immediate '
  ALTER TABLE BARS.BMS_MESSAGE MODIFY (SENDER_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C004240 ***
begin   
 execute immediate '
  ALTER TABLE BARS.BMS_MESSAGE MODIFY (RECEIVER_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C004241 ***
begin   
 execute immediate '
  ALTER TABLE BARS.BMS_MESSAGE MODIFY (MESSAGE_TYPE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C004242 ***
begin   
 execute immediate '
  ALTER TABLE BARS.BMS_MESSAGE MODIFY (MESSAGE_TEXT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C004243 ***
begin   
 execute immediate '
  ALTER TABLE BARS.BMS_MESSAGE MODIFY (SENDING_TIME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C004244 ***
begin   
 execute immediate '
  ALTER TABLE BARS.BMS_MESSAGE MODIFY (EFFECTIVE_TIME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BMS_MESSAGES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BMS_MESSAGES ON BARS.BMS_MESSAGE (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index BMS_MESSAGE_IDX ***
begin   
 execute immediate '
  CREATE INDEX BARS.BMS_MESSAGE_IDX ON BARS.BMS_MESSAGE (RECEIVER_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  TABLESPACE BRSDYNI  LOCAL
 (PARTITION INITIAL_PARTITION 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSDYNI ) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BMS_MESSAGE ***
grant SELECT                                                                 on BMS_MESSAGE     to BARSREADER_ROLE;
grant SELECT                                                                 on BMS_MESSAGE     to BARS_DM;
grant DELETE                                                                 on BMS_MESSAGE     to NOSCHENKOOO;
grant DELETE                                                                 on BMS_MESSAGE     to PODGORNAYALL06;
grant SELECT                                                                 on BMS_MESSAGE     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BMS_MESSAGE.sql =========*** End *** =
PROMPT ===================================================================================== 
