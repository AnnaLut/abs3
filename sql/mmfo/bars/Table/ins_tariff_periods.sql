

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/INS_TARIFF_PERIODS.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to INS_TARIFF_PERIODS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''INS_TARIFF_PERIODS'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
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
	AMORT NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
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


COMMENT ON TABLE BARS.INS_TARIFF_PERIODS IS 'Страхові тарифи у розрізі періодів';
COMMENT ON COLUMN BARS.INS_TARIFF_PERIODS.KF IS '';
COMMENT ON COLUMN BARS.INS_TARIFF_PERIODS.MAX_PERC IS 'Максимальний процент';
COMMENT ON COLUMN BARS.INS_TARIFF_PERIODS.AMORT IS 'Коефіцієнт амортизації';
COMMENT ON COLUMN BARS.INS_TARIFF_PERIODS.MIN_PERC IS 'Мінімальний процент';
COMMENT ON COLUMN BARS.INS_TARIFF_PERIODS.MAX_VALUE IS 'Максимальна сума';
COMMENT ON COLUMN BARS.INS_TARIFF_PERIODS.MIN_VALUE IS 'Мінімальна сума';
COMMENT ON COLUMN BARS.INS_TARIFF_PERIODS.TARIFF_ID IS 'Ідентифікатор тарифу';
COMMENT ON COLUMN BARS.INS_TARIFF_PERIODS.PERIOD_ID IS 'Період страхування (1, 2, 3, ...)';




PROMPT *** Create  constraint FK_TARIFFPRDS_TID_TARIFFS ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_TARIFF_PERIODS ADD CONSTRAINT FK_TARIFFPRDS_TID_TARIFFS FOREIGN KEY (TARIFF_ID, KF)
	  REFERENCES BARS.INS_TARIFFS (ID, KF) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_TARIFFPRDS ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_TARIFF_PERIODS ADD CONSTRAINT PK_TARIFFPRDS PRIMARY KEY (TARIFF_ID, PERIOD_ID, KF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
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




PROMPT *** Create  constraint CC_TARIFFPRDS_PID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_TARIFF_PERIODS MODIFY (PERIOD_ID CONSTRAINT CC_TARIFFPRDS_PID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint СС_INSTARIFFPRDS_PRDID ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_TARIFF_PERIODS ADD CONSTRAINT СС_INSTARIFFPRDS_PRDID CHECK (period_id in (1, 2, 3, 4, 5, 6, 7, 8, 9, 10)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TARIFFPRDS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TARIFFPRDS ON BARS.INS_TARIFF_PERIODS (TARIFF_ID, PERIOD_ID, KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/INS_TARIFF_PERIODS.sql =========*** En
PROMPT ===================================================================================== 
