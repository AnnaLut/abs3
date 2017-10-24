

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/GRT_MORTGAGE_LAND.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to GRT_MORTGAGE_LAND ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''GRT_MORTGAGE_LAND'', ''FILIAL'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table GRT_MORTGAGE_LAND ***
begin 
  execute immediate '
  CREATE TABLE BARS.GRT_MORTGAGE_LAND 
   (	DEAL_ID NUMBER(38,0), 
	AREA NUMBER(38,0), 
	LAND_PURPOSE VARCHAR2(128), 
	BUILD_NUM VARCHAR2(64), 
	BUILD_LIT VARCHAR2(10), 
	OWNSHIP_DOC_SER VARCHAR2(12), 
	OWNSHIP_DOC_NUM VARCHAR2(20), 
	OWNSHIP_DOC_DATE DATE, 
	OWNSHIP_DOC_REASON VARCHAR2(128), 
	OWNSHIP_REGBOOK_NUM VARCHAR2(24), 
	EXTRACT_REG_DATE DATE, 
	EXTRACT_REG_ORGAN VARCHAR2(128), 
	EXTRACT_REG_NUM VARCHAR2(12), 
	EXTRACT_REG_SUM NUMBER(38,0), 
	LESSEE_NUM NUMBER(38,0), 
	LESSEE_NAME VARCHAR2(128), 
	LESSEE_DOG_ENDDATE DATE, 
	LESSEE_DOG_NUM VARCHAR2(12), 
	LESSEE_DOG_DATE DATE, 
	BANS_REG_NUM VARCHAR2(12), 
	BANS_REG_DATE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to GRT_MORTGAGE_LAND ***
 exec bpa.alter_policies('GRT_MORTGAGE_LAND');


COMMENT ON TABLE BARS.GRT_MORTGAGE_LAND IS '�������';
COMMENT ON COLUMN BARS.GRT_MORTGAGE_LAND.DEAL_ID IS '������������� �������� ������';
COMMENT ON COLUMN BARS.GRT_MORTGAGE_LAND.AREA IS '������� ���������� �������';
COMMENT ON COLUMN BARS.GRT_MORTGAGE_LAND.LAND_PURPOSE IS '������� ���������� ���������� �������';
COMMENT ON COLUMN BARS.GRT_MORTGAGE_LAND.BUILD_NUM IS '����� ����';
COMMENT ON COLUMN BARS.GRT_MORTGAGE_LAND.BUILD_LIT IS '������ ����';
COMMENT ON COLUMN BARS.GRT_MORTGAGE_LAND.OWNSHIP_DOC_SER IS '���� ���������� ���� �� ����� �������� �� �������� ������';
COMMENT ON COLUMN BARS.GRT_MORTGAGE_LAND.OWNSHIP_DOC_NUM IS '����� ���������� ���� �� ����� �������� �� �������� ������';
COMMENT ON COLUMN BARS.GRT_MORTGAGE_LAND.OWNSHIP_DOC_DATE IS '���� ������ ���������� ���� �� ����� �������� �� �������� ������';
COMMENT ON COLUMN BARS.GRT_MORTGAGE_LAND.OWNSHIP_DOC_REASON IS 'ϳ������ ������ ���������� ���� �� ����� �������� �� �������� ������';
COMMENT ON COLUMN BARS.GRT_MORTGAGE_LAND.OWNSHIP_REGBOOK_NUM IS '����� � ���� ������ ��������� ��������� ���� �� ����� �������� �� �����';
COMMENT ON COLUMN BARS.GRT_MORTGAGE_LAND.EXTRACT_REG_DATE IS '���� ������ � ������ ���� �������� �� �������� �����';
COMMENT ON COLUMN BARS.GRT_MORTGAGE_LAND.EXTRACT_REG_ORGAN IS '����� ������, �� ����� ����� � ������ ���� �������� �� �������� �����';
COMMENT ON COLUMN BARS.GRT_MORTGAGE_LAND.EXTRACT_REG_NUM IS '����� ������ � ������ ���� �������� �� �������� �����';
COMMENT ON COLUMN BARS.GRT_MORTGAGE_LAND.EXTRACT_REG_SUM IS '������� ����� ������ � ������ ���� �������� �� �������� �����';
COMMENT ON COLUMN BARS.GRT_MORTGAGE_LAND.LESSEE_NUM IS '� �.� ��������';
COMMENT ON COLUMN BARS.GRT_MORTGAGE_LAND.LESSEE_NAME IS '����� ��������';
COMMENT ON COLUMN BARS.GRT_MORTGAGE_LAND.LESSEE_DOG_ENDDATE IS '����� �������� ������';
COMMENT ON COLUMN BARS.GRT_MORTGAGE_LAND.LESSEE_DOG_NUM IS '����� �������� ������';
COMMENT ON COLUMN BARS.GRT_MORTGAGE_LAND.LESSEE_DOG_DATE IS '���� �������� ������';
COMMENT ON COLUMN BARS.GRT_MORTGAGE_LAND.BANS_REG_NUM IS '����� ������ � ������� ������ ������� ��������� �ᒺ��� ���������� �����';
COMMENT ON COLUMN BARS.GRT_MORTGAGE_LAND.BANS_REG_DATE IS '���� ������ � ������� ������ ������� ��������� �ᒺ��� ���������� �����';




PROMPT *** Create  constraint FK_MORTGAGELAND_DEALS ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_MORTGAGE_LAND ADD CONSTRAINT FK_MORTGAGELAND_DEALS FOREIGN KEY (DEAL_ID)
	  REFERENCES BARS.GRT_DEALS (DEAL_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_GRTMORTLAND ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_MORTGAGE_LAND ADD CONSTRAINT PK_GRTMORTLAND PRIMARY KEY (DEAL_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GRTMORTLAND_LANDPURP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_MORTGAGE_LAND MODIFY (LAND_PURPOSE CONSTRAINT CC_GRTMORTLAND_LANDPURP_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GRTMORTLAND_AREA_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_MORTGAGE_LAND MODIFY (AREA CONSTRAINT CC_GRTMORTLAND_AREA_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_GRTMORTLAND ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_GRTMORTLAND ON BARS.GRT_MORTGAGE_LAND (DEAL_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/GRT_MORTGAGE_LAND.sql =========*** End
PROMPT ===================================================================================== 
