

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_BID_STATES.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_BID_STATES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_BID_STATES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_BID_STATES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_BID_STATES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_BID_STATES ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_BID_STATES 
   (	BID_ID NUMBER, 
	STATE_ID VARCHAR2(100), 
	CHECKOUTED NUMBER DEFAULT 0, 
	CHECKOUT_DAT DATE, 
	CHECKOUT_USER_ID NUMBER, 
	USER_COMMENT VARCHAR2(4000), 
	LAST_DATE DATE, 
	 CONSTRAINT FK_BIDSTATES_BID_BIDS_ID FOREIGN KEY (BID_ID)
	  REFERENCES BARS.WCS_BIDS (ID) ENABLE
   ) PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  PARTITION BY REFERENCE (FK_BIDSTATES_BID_BIDS_ID) 
 (PARTITION WCSBIDS_Y2011_Q1 SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION WCSBIDS_Y2011_Q2 SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION WCSBIDS_Y2011_Q3 SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION WCSBIDS_Y2011_Q4 SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION WCSBIDS_Y2012_Q1 SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION WCSBIDS_Y2012_Q2 SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION WCSBIDS_Y2012_Q3 SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION WCSBIDS_Y2012_Q4 SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION WCSBIDS_Y2013_Q1 SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION WCSBIDS_Y2013_Q2 SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION WCSBIDS_Y2013_Q3 SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION WCSBIDS_Y2013_Q4 SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION WCSBIDS_Y2015_Q1 SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION WCSBIDS_Y2015_Q2 SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION WCSBIDS_Y2015_Q3 SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION WCSBIDS_Y2015_Q4 SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION WCSBIDS_Y2016_Q1 SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION WCSBIDS_Y2016_Q2 SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION WCSBIDS_Y2016_Q3 SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION WCSBIDS_Y2016_Q4 SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_BID_STATES ***
 exec bpa.alter_policies('WCS_BID_STATES');


COMMENT ON TABLE BARS.WCS_BID_STATES IS '������� ��������� ������';
COMMENT ON COLUMN BARS.WCS_BID_STATES.BID_ID IS '������������� ������';
COMMENT ON COLUMN BARS.WCS_BID_STATES.STATE_ID IS '������������� ���������';
COMMENT ON COLUMN BARS.WCS_BID_STATES.CHECKOUTED IS '����������� �� ������ (0/1)';
COMMENT ON COLUMN BARS.WCS_BID_STATES.CHECKOUT_DAT IS '���� ���������� ������';
COMMENT ON COLUMN BARS.WCS_BID_STATES.CHECKOUT_USER_ID IS '������������ ��������������� ������';
COMMENT ON COLUMN BARS.WCS_BID_STATES.USER_COMMENT IS '����������� ������������';
COMMENT ON COLUMN BARS.WCS_BID_STATES.LAST_DATE IS '���� ���������� ��������� (������������ ��� ������� ���������)';




PROMPT *** Create  constraint CC_BIDSTATES_BIDID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_BID_STATES MODIFY (BID_ID CONSTRAINT CC_BIDSTATES_BIDID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_BIDSTATES_BID_BIDS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_BID_STATES ADD CONSTRAINT FK_BIDSTATES_BID_BIDS_ID FOREIGN KEY (BID_ID)
	  REFERENCES BARS.WCS_BIDS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_BIDSTATES ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_BID_STATES ADD CONSTRAINT PK_BIDSTATES PRIMARY KEY (BID_ID, STATE_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BIDSTATES_CHECKOUTED ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_BID_STATES ADD CONSTRAINT CC_BIDSTATES_CHECKOUTED CHECK (checkouted in (0, 1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BIDSTATES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BIDSTATES ON BARS.WCS_BID_STATES (BID_ID, STATE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XIE_BIDSTATES_LDATE ***
begin   
 execute immediate '
  CREATE INDEX BARS.XIE_BIDSTATES_LDATE ON BARS.WCS_BID_STATES (LAST_DATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_BID_STATES ***
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_BID_STATES  to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_BID_STATES  to START1;
grant SELECT                                                                 on WCS_BID_STATES  to WCS_SYNC_USER;



PROMPT *** Create SYNONYM  to WCS_BID_STATES ***

  CREATE OR REPLACE PUBLIC SYNONYM WCS_BID_STATES FOR BARS.WCS_BID_STATES;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_BID_STATES.sql =========*** End **
PROMPT ===================================================================================== 
