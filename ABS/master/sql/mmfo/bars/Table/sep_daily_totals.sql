

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SEP_DAILY_TOTALS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SEP_DAILY_TOTALS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SEP_DAILY_TOTALS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SEP_DAILY_TOTALS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SEP_DAILY_TOTALS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SEP_DAILY_TOTALS ***
begin 
  execute immediate '
  CREATE TABLE BARS.SEP_DAILY_TOTALS 
   (	FDAT DATE, 
	MFO VARCHAR2(6), 
	CNT_1 NUMBER, 
	CNT_2 NUMBER, 
	CNT_3 NUMBER, 
	CNT_4 NUMBER, 
	CNT_5 NUMBER, 
	CNT_6 NUMBER, 
	CNT_7 NUMBER, 
	CNT_8 NUMBER, 
	SUM_1 NUMBER, 
	SUM_2 NUMBER, 
	SUM_3 NUMBER, 
	SUM_4 NUMBER, 
	SUM_5 NUMBER, 
	SUM_6 NUMBER, 
	SUM_7 NUMBER, 
	SUM_8 NUMBER, 
	SUM_TOTAL NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SEP_DAILY_TOTALS ***
 exec bpa.alter_policies('SEP_DAILY_TOTALS');


COMMENT ON TABLE BARS.SEP_DAILY_TOTALS IS '';
COMMENT ON COLUMN BARS.SEP_DAILY_TOTALS.FDAT IS '';
COMMENT ON COLUMN BARS.SEP_DAILY_TOTALS.MFO IS '';
COMMENT ON COLUMN BARS.SEP_DAILY_TOTALS.CNT_1 IS '';
COMMENT ON COLUMN BARS.SEP_DAILY_TOTALS.CNT_2 IS '';
COMMENT ON COLUMN BARS.SEP_DAILY_TOTALS.CNT_3 IS '';
COMMENT ON COLUMN BARS.SEP_DAILY_TOTALS.CNT_4 IS '';
COMMENT ON COLUMN BARS.SEP_DAILY_TOTALS.CNT_5 IS '';
COMMENT ON COLUMN BARS.SEP_DAILY_TOTALS.CNT_6 IS '';
COMMENT ON COLUMN BARS.SEP_DAILY_TOTALS.CNT_7 IS '';
COMMENT ON COLUMN BARS.SEP_DAILY_TOTALS.CNT_8 IS '';
COMMENT ON COLUMN BARS.SEP_DAILY_TOTALS.SUM_1 IS '';
COMMENT ON COLUMN BARS.SEP_DAILY_TOTALS.SUM_2 IS '';
COMMENT ON COLUMN BARS.SEP_DAILY_TOTALS.SUM_3 IS '';
COMMENT ON COLUMN BARS.SEP_DAILY_TOTALS.SUM_4 IS '';
COMMENT ON COLUMN BARS.SEP_DAILY_TOTALS.SUM_5 IS '';
COMMENT ON COLUMN BARS.SEP_DAILY_TOTALS.SUM_6 IS '';
COMMENT ON COLUMN BARS.SEP_DAILY_TOTALS.SUM_7 IS '';
COMMENT ON COLUMN BARS.SEP_DAILY_TOTALS.SUM_8 IS '';
COMMENT ON COLUMN BARS.SEP_DAILY_TOTALS.SUM_TOTAL IS '';




PROMPT *** Create  constraint PK_SEPDAILYTOTALS ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEP_DAILY_TOTALS ADD CONSTRAINT PK_SEPDAILYTOTALS PRIMARY KEY (FDAT, MFO)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SEPDAILYTOTALS_FDAT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEP_DAILY_TOTALS MODIFY (FDAT CONSTRAINT CC_SEPDAILYTOTALS_FDAT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SEPDAILYTOTALS_SUMTT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEP_DAILY_TOTALS MODIFY (SUM_TOTAL CONSTRAINT CC_SEPDAILYTOTALS_SUMTT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SEPDAILYTOTALS_SUM8_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEP_DAILY_TOTALS MODIFY (SUM_8 CONSTRAINT CC_SEPDAILYTOTALS_SUM8_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SEPDAILYTOTALS_SUM7_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEP_DAILY_TOTALS MODIFY (SUM_7 CONSTRAINT CC_SEPDAILYTOTALS_SUM7_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SEPDAILYTOTALS_SUM6_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEP_DAILY_TOTALS MODIFY (SUM_6 CONSTRAINT CC_SEPDAILYTOTALS_SUM6_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SEPDAILYTOTALS_SUM5_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEP_DAILY_TOTALS MODIFY (SUM_5 CONSTRAINT CC_SEPDAILYTOTALS_SUM5_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SEPDAILYTOTALS_SUM4_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEP_DAILY_TOTALS MODIFY (SUM_4 CONSTRAINT CC_SEPDAILYTOTALS_SUM4_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SEPDAILYTOTALS_SUM3_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEP_DAILY_TOTALS MODIFY (SUM_3 CONSTRAINT CC_SEPDAILYTOTALS_SUM3_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SEPDAILYTOTALS_SUM2_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEP_DAILY_TOTALS MODIFY (SUM_2 CONSTRAINT CC_SEPDAILYTOTALS_SUM2_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SEPDAILYTOTALS_SUM1_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEP_DAILY_TOTALS MODIFY (SUM_1 CONSTRAINT CC_SEPDAILYTOTALS_SUM1_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SEPDAILYTOTALS_CNT8_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEP_DAILY_TOTALS MODIFY (CNT_8 CONSTRAINT CC_SEPDAILYTOTALS_CNT8_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SEPDAILYTOTALS_CNT7_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEP_DAILY_TOTALS MODIFY (CNT_7 CONSTRAINT CC_SEPDAILYTOTALS_CNT7_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SEPDAILYTOTALS_CNT6_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEP_DAILY_TOTALS MODIFY (CNT_6 CONSTRAINT CC_SEPDAILYTOTALS_CNT6_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SEPDAILYTOTALS_CNT5_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEP_DAILY_TOTALS MODIFY (CNT_5 CONSTRAINT CC_SEPDAILYTOTALS_CNT5_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SEPDAILYTOTALS_CNT4_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEP_DAILY_TOTALS MODIFY (CNT_4 CONSTRAINT CC_SEPDAILYTOTALS_CNT4_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SEPDAILYTOTALS_CNT3_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEP_DAILY_TOTALS MODIFY (CNT_3 CONSTRAINT CC_SEPDAILYTOTALS_CNT3_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SEPDAILYTOTALS_CNT2_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEP_DAILY_TOTALS MODIFY (CNT_2 CONSTRAINT CC_SEPDAILYTOTALS_CNT2_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SEPDAILYTOTALS_CNT1_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEP_DAILY_TOTALS MODIFY (CNT_1 CONSTRAINT CC_SEPDAILYTOTALS_CNT1_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SEPDAILYTOTALS_MFO_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEP_DAILY_TOTALS MODIFY (MFO CONSTRAINT CC_SEPDAILYTOTALS_MFO_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SEPDAILYTOTALS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SEPDAILYTOTALS ON BARS.SEP_DAILY_TOTALS (FDAT, MFO) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SEP_DAILY_TOTALS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SEP_DAILY_TOTALS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SEP_DAILY_TOTALS to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on SEP_DAILY_TOTALS to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SEP_DAILY_TOTALS.sql =========*** End 
PROMPT ===================================================================================== 
