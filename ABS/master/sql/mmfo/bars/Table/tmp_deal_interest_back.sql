

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_DEAL_INTEREST_BACK.sql =========**
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_DEAL_INTEREST_BACK ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_DEAL_INTEREST_BACK ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_DEAL_INTEREST_BACK 
   (	ID NUMBER(38,0), 
	RECKONING_ID VARCHAR2(32 CHAR), 
	DEAL_ID NUMBER(38,0), 
	ACCOUNT_ID NUMBER(38,0), 
	INTEREST_KIND NUMBER(38,0), 
	DATE_FROM DATE, 
	DATE_TO DATE, 
	ACCOUNT_REST NUMBER(38,0), 
	INTEREST_RATE NUMBER(38,12), 
	INTEREST_AMOUNT NUMBER(38,0), 
	INTEREST_TAIL NUMBER(38,38), 
	PURPOSE VARCHAR2(4000), 
	STATE_ID NUMBER(5,0), 
	MESSAGE VARCHAR2(4000), 
	OPER_REF NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_DEAL_INTEREST_BACK ***
 exec bpa.alter_policies('TMP_DEAL_INTEREST_BACK');


COMMENT ON TABLE BARS.TMP_DEAL_INTEREST_BACK IS '';
COMMENT ON COLUMN BARS.TMP_DEAL_INTEREST_BACK.ID IS '';
COMMENT ON COLUMN BARS.TMP_DEAL_INTEREST_BACK.RECKONING_ID IS '';
COMMENT ON COLUMN BARS.TMP_DEAL_INTEREST_BACK.DEAL_ID IS '';
COMMENT ON COLUMN BARS.TMP_DEAL_INTEREST_BACK.ACCOUNT_ID IS '';
COMMENT ON COLUMN BARS.TMP_DEAL_INTEREST_BACK.INTEREST_KIND IS '';
COMMENT ON COLUMN BARS.TMP_DEAL_INTEREST_BACK.DATE_FROM IS '';
COMMENT ON COLUMN BARS.TMP_DEAL_INTEREST_BACK.DATE_TO IS '';
COMMENT ON COLUMN BARS.TMP_DEAL_INTEREST_BACK.ACCOUNT_REST IS '';
COMMENT ON COLUMN BARS.TMP_DEAL_INTEREST_BACK.INTEREST_RATE IS '';
COMMENT ON COLUMN BARS.TMP_DEAL_INTEREST_BACK.INTEREST_AMOUNT IS '';
COMMENT ON COLUMN BARS.TMP_DEAL_INTEREST_BACK.INTEREST_TAIL IS '';
COMMENT ON COLUMN BARS.TMP_DEAL_INTEREST_BACK.PURPOSE IS '';
COMMENT ON COLUMN BARS.TMP_DEAL_INTEREST_BACK.STATE_ID IS '';
COMMENT ON COLUMN BARS.TMP_DEAL_INTEREST_BACK.MESSAGE IS '';
COMMENT ON COLUMN BARS.TMP_DEAL_INTEREST_BACK.OPER_REF IS '';




PROMPT *** Create  constraint SYS_C00132691 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_DEAL_INTEREST_BACK MODIFY (RECKONING_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00132692 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_DEAL_INTEREST_BACK MODIFY (ACCOUNT_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_DEAL_INTEREST_BACK ***
grant SELECT                                                                 on TMP_DEAL_INTEREST_BACK to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_DEAL_INTEREST_BACK.sql =========**
PROMPT ===================================================================================== 
