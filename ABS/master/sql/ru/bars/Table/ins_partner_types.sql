

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/INS_PARTNER_TYPES.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to INS_PARTNER_TYPES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''INS_PARTNER_TYPES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''INS_PARTNER_TYPES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table INS_PARTNER_TYPES ***
begin 
  execute immediate '
  CREATE TABLE BARS.INS_PARTNER_TYPES 
   (	PARTNER_ID NUMBER, 
	TYPE_ID NUMBER, 
	TARIFF_ID VARCHAR2(100), 
	FEE_ID VARCHAR2(100), 
	LIMIT_ID VARCHAR2(100), 
	ACTIVE NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to INS_PARTNER_TYPES ***
 exec bpa.alter_policies('INS_PARTNER_TYPES');


COMMENT ON TABLE BARS.INS_PARTNER_TYPES IS '������ ���� ��������� ��������, �� ��������� �������';
COMMENT ON COLUMN BARS.INS_PARTNER_TYPES.PARTNER_ID IS '������������� ��';
COMMENT ON COLUMN BARS.INS_PARTNER_TYPES.TYPE_ID IS '������������� ���� ���������� ��������';
COMMENT ON COLUMN BARS.INS_PARTNER_TYPES.TARIFF_ID IS '��. ������ �� ������� �� ���';
COMMENT ON COLUMN BARS.INS_PARTNER_TYPES.FEE_ID IS '��. ���� �� ������� �� ���';
COMMENT ON COLUMN BARS.INS_PARTNER_TYPES.LIMIT_ID IS '��. ���� �� ��� ���� ��';
COMMENT ON COLUMN BARS.INS_PARTNER_TYPES.ACTIVE IS '���� ��������� ������� �� ������ ���� ���������� ��������';




PROMPT *** Create  constraint FK_INSPARTNERTPS_LID_LIMITS ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNER_TYPES ADD CONSTRAINT FK_INSPARTNERTPS_LID_LIMITS FOREIGN KEY (LIMIT_ID)
	  REFERENCES BARS.INS_LIMITS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_INSPARTNERTPS_FID_FEES ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNER_TYPES ADD CONSTRAINT FK_INSPARTNERTPS_FID_FEES FOREIGN KEY (FEE_ID)
	  REFERENCES BARS.INS_FEES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_INSPARTNERTPS_TID_TARIFFS ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNER_TYPES ADD CONSTRAINT FK_INSPARTNERTPS_TID_TARIFFS FOREIGN KEY (TARIFF_ID)
	  REFERENCES BARS.INS_TARIFFS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_INSPARTNERTPS_TID_TYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNER_TYPES ADD CONSTRAINT FK_INSPARTNERTPS_TID_TYPES FOREIGN KEY (TYPE_ID)
	  REFERENCES BARS.INS_TYPES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_INSPARTNERTPS_PID_PARTNERS ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNER_TYPES ADD CONSTRAINT FK_INSPARTNERTPS_PID_PARTNERS FOREIGN KEY (PARTNER_ID)
	  REFERENCES BARS.INS_PARTNERS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_INSPARTNERTPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNER_TYPES ADD CONSTRAINT PK_INSPARTNERTPS PRIMARY KEY (PARTNER_ID, TYPE_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INSPRTTPS_ACT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNER_TYPES MODIFY (ACTIVE CONSTRAINT CC_INSPRTTPS_ACT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INSPRTTPS_TID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNER_TYPES MODIFY (TYPE_ID CONSTRAINT CC_INSPRTTPS_TID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INSPRTTPS_PID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNER_TYPES MODIFY (PARTNER_ID CONSTRAINT CC_INSPRTTPS_PID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INSPARTNERTYPES_ACTIVE ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNER_TYPES ADD CONSTRAINT CC_INSPARTNERTYPES_ACTIVE CHECK (active in (0, 1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_INSPARTNERTPS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_INSPARTNERTPS ON BARS.INS_PARTNER_TYPES (PARTNER_ID, TYPE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/INS_PARTNER_TYPES.sql =========*** End
PROMPT ===================================================================================== 
