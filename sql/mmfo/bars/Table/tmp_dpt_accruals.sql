

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_DPT_ACCRUALS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_DPT_ACCRUALS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_DPT_ACCRUALS ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_DPT_ACCRUALS 
   (	DEPOSIT_ID NUMBER(38,0), 
	DAT_BEGIN DATE, 
	DAT_END DATE, 
	INTAMOUNT NUMBER, 
	TAX_S NUMBER, 
	TAX_SQ NUMBER, 
	TAX_S_MIL NUMBER, 
	TAX_SQ_MIL NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_DPT_ACCRUALS ***
 exec bpa.alter_policies('TMP_DPT_ACCRUALS');


COMMENT ON TABLE BARS.TMP_DPT_ACCRUALS IS '';
COMMENT ON COLUMN BARS.TMP_DPT_ACCRUALS.DEPOSIT_ID IS '';
COMMENT ON COLUMN BARS.TMP_DPT_ACCRUALS.DAT_BEGIN IS '';
COMMENT ON COLUMN BARS.TMP_DPT_ACCRUALS.DAT_END IS '';
COMMENT ON COLUMN BARS.TMP_DPT_ACCRUALS.INTAMOUNT IS '';
COMMENT ON COLUMN BARS.TMP_DPT_ACCRUALS.TAX_S IS '';
COMMENT ON COLUMN BARS.TMP_DPT_ACCRUALS.TAX_SQ IS '';
COMMENT ON COLUMN BARS.TMP_DPT_ACCRUALS.TAX_S_MIL IS '';
COMMENT ON COLUMN BARS.TMP_DPT_ACCRUALS.TAX_SQ_MIL IS '';




PROMPT *** Create  constraint SYS_C00137502 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_DPT_ACCRUALS MODIFY (DEPOSIT_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00137503 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_DPT_ACCRUALS MODIFY (DAT_BEGIN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00137504 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_DPT_ACCRUALS MODIFY (DAT_END NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_DPT_ACCRUALS ***
grant SELECT                                                                 on TMP_DPT_ACCRUALS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_DPT_ACCRUALS.sql =========*** End 
PROMPT ===================================================================================== 
