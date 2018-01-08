

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/INS_FEE_PERIODS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to INS_FEE_PERIODS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''INS_FEE_PERIODS'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''INS_FEE_PERIODS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table INS_FEE_PERIODS ***
begin 
  execute immediate '
  CREATE TABLE BARS.INS_FEE_PERIODS 
   (	FEE_ID VARCHAR2(100), 
	PERIOD_ID NUMBER, 
	MIN_VALUE NUMBER, 
	PERC_VALUE NUMBER, 
	MAX_VALUE NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to INS_FEE_PERIODS ***
 exec bpa.alter_policies('INS_FEE_PERIODS');


COMMENT ON TABLE BARS.INS_FEE_PERIODS IS 'Комісії банку по договорах страхування у розрізі періодів';
COMMENT ON COLUMN BARS.INS_FEE_PERIODS.FEE_ID IS 'Ідентифікатор комісії';
COMMENT ON COLUMN BARS.INS_FEE_PERIODS.KF IS '';
COMMENT ON COLUMN BARS.INS_FEE_PERIODS.PERIOD_ID IS 'Період страхування (1, 2, 3, ...)';
COMMENT ON COLUMN BARS.INS_FEE_PERIODS.MIN_VALUE IS 'Мінімальна сума';
COMMENT ON COLUMN BARS.INS_FEE_PERIODS.PERC_VALUE IS 'Процент';
COMMENT ON COLUMN BARS.INS_FEE_PERIODS.MAX_VALUE IS 'Максимальна сума';




PROMPT *** Create  constraint CC_FEEPRDS_FID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_FEE_PERIODS MODIFY (FEE_ID CONSTRAINT CC_FEEPRDS_FID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FEEPRDS_PID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_FEE_PERIODS MODIFY (PERIOD_ID CONSTRAINT CC_FEEPRDS_PID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_FEEPRDS ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_FEE_PERIODS ADD CONSTRAINT PK_FEEPRDS PRIMARY KEY (FEE_ID, PERIOD_ID, KF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint СС_FEEPRDS_PRDID ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_FEE_PERIODS ADD CONSTRAINT СС_FEEPRDS_PRDID CHECK (period_id in (1, 2, 3, 4, 5, 6, 7, 8, 9, 10)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_FEEPRDS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_FEEPRDS ON BARS.INS_FEE_PERIODS (FEE_ID, PERIOD_ID, KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  INS_FEE_PERIODS ***
grant SELECT                                                                 on INS_FEE_PERIODS to BARSREADER_ROLE;
grant SELECT                                                                 on INS_FEE_PERIODS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/INS_FEE_PERIODS.sql =========*** End *
PROMPT ===================================================================================== 
