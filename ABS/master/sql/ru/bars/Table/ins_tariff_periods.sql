

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/INS_TARIFF_PERIODS.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to INS_TARIFF_PERIODS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''INS_TARIFF_PERIODS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''INS_TARIFF_PERIODS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table INS_TARIFF_PERIODS ***
begin 
  execute immediate '
  CREATE TABLE BARS.INS_TARIFF_PERIODS 
   (	TARIFF_ID VARCHAR2(100), 
	PERIOD_ID NUMBER, 
	MIN_VALUE NUMBER, 
	MIN_PERC NUMBER, 
	MAX_VALUE NUMBER, 
	MAX_PERC NUMBER, 
	AMORT NUMBER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to INS_TARIFF_PERIODS ***
 exec bpa.alter_policies('INS_TARIFF_PERIODS');


COMMENT ON TABLE BARS.INS_TARIFF_PERIODS IS '������� ������ � ����� ������';
COMMENT ON COLUMN BARS.INS_TARIFF_PERIODS.TARIFF_ID IS '������������� ������';
COMMENT ON COLUMN BARS.INS_TARIFF_PERIODS.PERIOD_ID IS '����� ����������� (1, 2, 3, ...)';
COMMENT ON COLUMN BARS.INS_TARIFF_PERIODS.MIN_VALUE IS '̳������� ����';
COMMENT ON COLUMN BARS.INS_TARIFF_PERIODS.MIN_PERC IS '̳�������� �������';
COMMENT ON COLUMN BARS.INS_TARIFF_PERIODS.MAX_VALUE IS '����������� ����';
COMMENT ON COLUMN BARS.INS_TARIFF_PERIODS.MAX_PERC IS '������������ �������';
COMMENT ON COLUMN BARS.INS_TARIFF_PERIODS.AMORT IS '���������� �����������';




PROMPT *** Create  constraint FK_TARIFFPRDS_TID_TARIFFS ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_TARIFF_PERIODS ADD CONSTRAINT FK_TARIFFPRDS_TID_TARIFFS FOREIGN KEY (TARIFF_ID)
	  REFERENCES BARS.INS_TARIFFS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint ��_INSTARIFFPRDS_PRDID ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_TARIFF_PERIODS ADD CONSTRAINT ��_INSTARIFFPRDS_PRDID CHECK (period_id in (1, 2, 3, 4, 5, 6, 7, 8, 9, 10)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_TARIFFPRDS ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_TARIFF_PERIODS ADD CONSTRAINT PK_TARIFFPRDS PRIMARY KEY (TARIFF_ID, PERIOD_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TARIFFPRDS_PID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_TARIFF_PERIODS MODIFY (PERIOD_ID CONSTRAINT CC_TARIFFPRDS_PID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TARIFFPRDS_TID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_TARIFF_PERIODS MODIFY (TARIFF_ID CONSTRAINT CC_TARIFFPRDS_TID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TARIFFPRDS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TARIFFPRDS ON BARS.INS_TARIFF_PERIODS (TARIFF_ID, PERIOD_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/INS_TARIFF_PERIODS.sql =========*** En
PROMPT ===================================================================================== 
