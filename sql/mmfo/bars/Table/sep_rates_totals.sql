

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SEP_RATES_TOTALS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SEP_RATES_TOTALS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SEP_RATES_TOTALS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SEP_RATES_TOTALS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SEP_RATES_TOTALS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SEP_RATES_TOTALS ***
begin 
  execute immediate '
  CREATE TABLE BARS.SEP_RATES_TOTALS 
   (	ID NUMBER(*,0), 
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
	SUM_TOTAL NUMBER, 
	REF NUMBER, 
	REF2 NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SEP_RATES_TOTALS ***
 exec bpa.alter_policies('SEP_RATES_TOTALS');


COMMENT ON TABLE BARS.SEP_RATES_TOTALS IS '';
COMMENT ON COLUMN BARS.SEP_RATES_TOTALS.ID IS '';
COMMENT ON COLUMN BARS.SEP_RATES_TOTALS.MFO IS '';
COMMENT ON COLUMN BARS.SEP_RATES_TOTALS.CNT_1 IS '';
COMMENT ON COLUMN BARS.SEP_RATES_TOTALS.CNT_2 IS '';
COMMENT ON COLUMN BARS.SEP_RATES_TOTALS.CNT_3 IS '';
COMMENT ON COLUMN BARS.SEP_RATES_TOTALS.CNT_4 IS '';
COMMENT ON COLUMN BARS.SEP_RATES_TOTALS.CNT_5 IS '';
COMMENT ON COLUMN BARS.SEP_RATES_TOTALS.CNT_6 IS '';
COMMENT ON COLUMN BARS.SEP_RATES_TOTALS.CNT_7 IS '';
COMMENT ON COLUMN BARS.SEP_RATES_TOTALS.CNT_8 IS '';
COMMENT ON COLUMN BARS.SEP_RATES_TOTALS.SUM_1 IS '';
COMMENT ON COLUMN BARS.SEP_RATES_TOTALS.SUM_2 IS '';
COMMENT ON COLUMN BARS.SEP_RATES_TOTALS.SUM_3 IS '';
COMMENT ON COLUMN BARS.SEP_RATES_TOTALS.SUM_4 IS '';
COMMENT ON COLUMN BARS.SEP_RATES_TOTALS.SUM_5 IS '';
COMMENT ON COLUMN BARS.SEP_RATES_TOTALS.SUM_6 IS '';
COMMENT ON COLUMN BARS.SEP_RATES_TOTALS.SUM_7 IS '';
COMMENT ON COLUMN BARS.SEP_RATES_TOTALS.SUM_8 IS '';
COMMENT ON COLUMN BARS.SEP_RATES_TOTALS.SUM_TOTAL IS '';
COMMENT ON COLUMN BARS.SEP_RATES_TOTALS.REF IS '';
COMMENT ON COLUMN BARS.SEP_RATES_TOTALS.REF2 IS '';




PROMPT *** Create  constraint PK_SEPRATESTOTALS ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEP_RATES_TOTALS ADD CONSTRAINT PK_SEPRATESTOTALS PRIMARY KEY (ID, MFO)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SEPRATESTOTALS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEP_RATES_TOTALS ADD CONSTRAINT FK_SEPRATESTOTALS_ID FOREIGN KEY (ID)
	  REFERENCES BARS.SEP_RATES_CALENDAR (ID) DISABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SEPRATESTOTALS_SUMTT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEP_RATES_TOTALS MODIFY (SUM_TOTAL CONSTRAINT CC_SEPRATESTOTALS_SUMTT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SEPRATESTOTALS_SUM8_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEP_RATES_TOTALS MODIFY (SUM_8 CONSTRAINT CC_SEPRATESTOTALS_SUM8_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SEPRATESTOTALS_SUM7_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEP_RATES_TOTALS MODIFY (SUM_7 CONSTRAINT CC_SEPRATESTOTALS_SUM7_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SEPRATESTOTALS_SUM6_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEP_RATES_TOTALS MODIFY (SUM_6 CONSTRAINT CC_SEPRATESTOTALS_SUM6_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SEPRATESTOTALS_SUM5_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEP_RATES_TOTALS MODIFY (SUM_5 CONSTRAINT CC_SEPRATESTOTALS_SUM5_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SEPRATESTOTALS_SUM4_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEP_RATES_TOTALS MODIFY (SUM_4 CONSTRAINT CC_SEPRATESTOTALS_SUM4_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SEPRATESTOTALS_SUM3_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEP_RATES_TOTALS MODIFY (SUM_3 CONSTRAINT CC_SEPRATESTOTALS_SUM3_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SEPRATESTOTALS_SUM2_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEP_RATES_TOTALS MODIFY (SUM_2 CONSTRAINT CC_SEPRATESTOTALS_SUM2_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SEPRATESTOTALS_SUM1_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEP_RATES_TOTALS MODIFY (SUM_1 CONSTRAINT CC_SEPRATESTOTALS_SUM1_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SEPRATESTOTALS_CNT8_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEP_RATES_TOTALS MODIFY (CNT_8 CONSTRAINT CC_SEPRATESTOTALS_CNT8_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SEPRATESTOTALS_CNT7_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEP_RATES_TOTALS MODIFY (CNT_7 CONSTRAINT CC_SEPRATESTOTALS_CNT7_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SEPRATESTOTALS_CNT6_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEP_RATES_TOTALS MODIFY (CNT_6 CONSTRAINT CC_SEPRATESTOTALS_CNT6_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SEPRATESTOTALS_CNT5_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEP_RATES_TOTALS MODIFY (CNT_5 CONSTRAINT CC_SEPRATESTOTALS_CNT5_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SEPRATESTOTALS_CNT4_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEP_RATES_TOTALS MODIFY (CNT_4 CONSTRAINT CC_SEPRATESTOTALS_CNT4_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SEPRATESTOTALS_CNT3_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEP_RATES_TOTALS MODIFY (CNT_3 CONSTRAINT CC_SEPRATESTOTALS_CNT3_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SEPRATESTOTALS_CNT2_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEP_RATES_TOTALS MODIFY (CNT_2 CONSTRAINT CC_SEPRATESTOTALS_CNT2_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SEPRATESTOTALS_CNT1_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEP_RATES_TOTALS MODIFY (CNT_1 CONSTRAINT CC_SEPRATESTOTALS_CNT1_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SEPRATESTOTALS_MFO_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEP_RATES_TOTALS MODIFY (MFO CONSTRAINT CC_SEPRATESTOTALS_MFO_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SEPRATESTOTALS_IDÑ_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEP_RATES_TOTALS MODIFY (ID CONSTRAINT CC_SEPRATESTOTALS_IDÑ_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SEPRATESTOTALS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SEPRATESTOTALS ON BARS.SEP_RATES_TOTALS (ID, MFO) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SEP_RATES_TOTALS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SEP_RATES_TOTALS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SEP_RATES_TOTALS to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on SEP_RATES_TOTALS to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SEP_RATES_TOTALS.sql =========*** End 
PROMPT ===================================================================================== 
