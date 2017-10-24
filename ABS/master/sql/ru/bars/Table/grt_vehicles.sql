

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/GRT_VEHICLES.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to GRT_VEHICLES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''GRT_VEHICLES'', ''FILIAL'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table GRT_VEHICLES ***
begin 
  execute immediate '
  CREATE TABLE BARS.GRT_VEHICLES 
   (	DEAL_ID NUMBER(38,0), 
	TYPE NUMBER(5,0), 
	MODEL VARCHAR2(48), 
	MILEAGE NUMBER(38,0), 
	VEH_REG_NUM VARCHAR2(12), 
	MADE_DATE DATE, 
	COLOR VARCHAR2(24), 
	VIN VARCHAR2(64), 
	ENGINE_NUM VARCHAR2(64), 
	REG_DOC_SER VARCHAR2(6), 
	REG_DOC_NUM VARCHAR2(12), 
	REG_DOC_DATE DATE, 
	REG_DOC_ORGAN VARCHAR2(96), 
	REG_OWNER_ADDR VARCHAR2(128), 
	REG_SPEC_MARKS VARCHAR2(128), 
	PARKING_ADDR VARCHAR2(64), 
	CRD_END_DATE DATE, 
	OWNSHIP_REG_NUM VARCHAR2(24), 
	OWNSHIP_REG_CHECKSUM VARCHAR2(128)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to GRT_VEHICLES ***
 exec bpa.alter_policies('GRT_VEHICLES');


COMMENT ON TABLE BARS.GRT_VEHICLES IS '���������� � ��������� ������������ ���������';
COMMENT ON COLUMN BARS.GRT_VEHICLES.DEAL_ID IS '������������� �������� ������';
COMMENT ON COLUMN BARS.GRT_VEHICLES.TYPE IS '��� ��';
COMMENT ON COLUMN BARS.GRT_VEHICLES.MODEL IS '�����, ������ ��';
COMMENT ON COLUMN BARS.GRT_VEHICLES.MILEAGE IS '������� ������ ��';
COMMENT ON COLUMN BARS.GRT_VEHICLES.VEH_REG_NUM IS '������������ � ��';
COMMENT ON COLUMN BARS.GRT_VEHICLES.MADE_DATE IS 'г� ������� ��';
COMMENT ON COLUMN BARS.GRT_VEHICLES.COLOR IS '���� ��';
COMMENT ON COLUMN BARS.GRT_VEHICLES.VIN IS '� ��� (������, ����, �������)';
COMMENT ON COLUMN BARS.GRT_VEHICLES.ENGINE_NUM IS '����� ���������';
COMMENT ON COLUMN BARS.GRT_VEHICLES.REG_DOC_SER IS '���� �������� ��� ���������';
COMMENT ON COLUMN BARS.GRT_VEHICLES.REG_DOC_NUM IS '����� ��������� ��� ���������';
COMMENT ON COLUMN BARS.GRT_VEHICLES.REG_DOC_DATE IS '���� ������ ��������� ��� ���������';
COMMENT ON COLUMN BARS.GRT_VEHICLES.REG_DOC_ORGAN IS '�����, ���� ����� �������� ��� ���������';
COMMENT ON COLUMN BARS.GRT_VEHICLES.REG_OWNER_ADDR IS '������ �������� ����� �������� ��� ��������� ��';
COMMENT ON COLUMN BARS.GRT_VEHICLES.REG_SPEC_MARKS IS '������� ����� � ������� ��� ��������� ��';
COMMENT ON COLUMN BARS.GRT_VEHICLES.PARKING_ADDR IS '̳��� ������� ������������� ������';
COMMENT ON COLUMN BARS.GRT_VEHICLES.CRD_END_DATE IS '����� 䳿 ���������� ��������';
COMMENT ON COLUMN BARS.GRT_VEHICLES.OWNSHIP_REG_NUM IS '��������������� ����� � ���. ������� ���� �������������';
COMMENT ON COLUMN BARS.GRT_VEHICLES.OWNSHIP_REG_CHECKSUM IS '����������� ����� � ���. ������� ���� �������������';




PROMPT *** Create  constraint FK_VEHICLES_DEALS ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_VEHICLES ADD CONSTRAINT FK_VEHICLES_DEALS FOREIGN KEY (DEAL_ID)
	  REFERENCES BARS.GRT_DEALS (DEAL_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_VEHICLES_VEHTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_VEHICLES ADD CONSTRAINT FK_VEHICLES_VEHTYPES FOREIGN KEY (TYPE)
	  REFERENCES BARS.GRT_VEHICLE_TYPES (TYPE_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_GRTVEHICLES ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_VEHICLES ADD CONSTRAINT PK_GRTVEHICLES PRIMARY KEY (DEAL_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GRTVEHICLES_VIN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_VEHICLES MODIFY (VIN CONSTRAINT CC_GRTVEHICLES_VIN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GRTVEHICLES_COLOR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_VEHICLES MODIFY (COLOR CONSTRAINT CC_GRTVEHICLES_COLOR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GRTVEHICLES_MADEDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_VEHICLES MODIFY (MADE_DATE CONSTRAINT CC_GRTVEHICLES_MADEDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GRTVEHICLES_REGNUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_VEHICLES MODIFY (VEH_REG_NUM CONSTRAINT CC_GRTVEHICLES_REGNUM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GRTVEHICLES_MODEL_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_VEHICLES MODIFY (MODEL CONSTRAINT CC_GRTVEHICLES_MODEL_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GRTVEHICLES_TYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_VEHICLES MODIFY (TYPE CONSTRAINT CC_GRTVEHICLES_TYPE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_GRTVEHICLES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_GRTVEHICLES ON BARS.GRT_VEHICLES (DEAL_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/GRT_VEHICLES.sql =========*** End *** 
PROMPT ===================================================================================== 
