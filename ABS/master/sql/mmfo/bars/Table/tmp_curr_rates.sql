

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_CURR_RATES.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_CURR_RATES ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_CURR_RATES ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_CURR_RATES 
   (	KV NUMBER(3,0), 
	VDATE DATE, 
	BSUM NUMBER(9,4), 
	RATE_O NUMBER(9,4), 
	RATE_B NUMBER(9,4), 
	RATE_S NUMBER(9,4), 
	RATE_SPOT NUMBER(9,4), 
	RATE_FORWARD NUMBER(9,4), 
	LIM_POS NUMBER(24,0), 
	BRANCH VARCHAR2(30), 
	OTM VARCHAR2(1), 
	OFFICIAL VARCHAR2(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_CURR_RATES ***
 exec bpa.alter_policies('TMP_CURR_RATES');


COMMENT ON TABLE BARS.TMP_CURR_RATES IS '';
COMMENT ON COLUMN BARS.TMP_CURR_RATES.KV IS '';
COMMENT ON COLUMN BARS.TMP_CURR_RATES.VDATE IS '';
COMMENT ON COLUMN BARS.TMP_CURR_RATES.BSUM IS '';
COMMENT ON COLUMN BARS.TMP_CURR_RATES.RATE_O IS '';
COMMENT ON COLUMN BARS.TMP_CURR_RATES.RATE_B IS '';
COMMENT ON COLUMN BARS.TMP_CURR_RATES.RATE_S IS '';
COMMENT ON COLUMN BARS.TMP_CURR_RATES.RATE_SPOT IS '';
COMMENT ON COLUMN BARS.TMP_CURR_RATES.RATE_FORWARD IS '';
COMMENT ON COLUMN BARS.TMP_CURR_RATES.LIM_POS IS '';
COMMENT ON COLUMN BARS.TMP_CURR_RATES.BRANCH IS '';
COMMENT ON COLUMN BARS.TMP_CURR_RATES.OTM IS '';
COMMENT ON COLUMN BARS.TMP_CURR_RATES.OFFICIAL IS '';




PROMPT *** Create  constraint SYS_C006368 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_CURR_RATES MODIFY (KV NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006369 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_CURR_RATES MODIFY (VDATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006370 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_CURR_RATES MODIFY (BSUM NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006371 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_CURR_RATES MODIFY (RATE_O NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006372 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_CURR_RATES MODIFY (BRANCH NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006373 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_CURR_RATES MODIFY (OTM NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_CURR_RATES ***
grant SELECT                                                                 on TMP_CURR_RATES  to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_CURR_RATES  to BARS_DM;
grant SELECT                                                                 on TMP_CURR_RATES  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_CURR_RATES.sql =========*** End **
PROMPT ===================================================================================== 
