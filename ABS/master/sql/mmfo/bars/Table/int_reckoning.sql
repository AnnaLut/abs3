

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/INT_RECKONING.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to INT_RECKONING ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''INT_RECKONING'', ''FILIAL'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table INT_RECKONING ***
begin 
  execute immediate '
  CREATE TABLE BARS.INT_RECKONING 
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




PROMPT *** ALTER_POLICIES to INT_RECKONING ***
 exec bpa.alter_policies('INT_RECKONING');


COMMENT ON TABLE BARS.INT_RECKONING IS '';
COMMENT ON COLUMN BARS.INT_RECKONING.ID IS '';
COMMENT ON COLUMN BARS.INT_RECKONING.RECKONING_ID IS '';
COMMENT ON COLUMN BARS.INT_RECKONING.DEAL_ID IS '';
COMMENT ON COLUMN BARS.INT_RECKONING.ACCOUNT_ID IS '';
COMMENT ON COLUMN BARS.INT_RECKONING.INTEREST_KIND IS '';
COMMENT ON COLUMN BARS.INT_RECKONING.DATE_FROM IS '';
COMMENT ON COLUMN BARS.INT_RECKONING.DATE_TO IS '';
COMMENT ON COLUMN BARS.INT_RECKONING.ACCOUNT_REST IS '';
COMMENT ON COLUMN BARS.INT_RECKONING.INTEREST_RATE IS '';
COMMENT ON COLUMN BARS.INT_RECKONING.INTEREST_AMOUNT IS '';
COMMENT ON COLUMN BARS.INT_RECKONING.INTEREST_TAIL IS '';
COMMENT ON COLUMN BARS.INT_RECKONING.PURPOSE IS '';
COMMENT ON COLUMN BARS.INT_RECKONING.STATE_ID IS '';
COMMENT ON COLUMN BARS.INT_RECKONING.MESSAGE IS '';
COMMENT ON COLUMN BARS.INT_RECKONING.OPER_REF IS '';




PROMPT *** Create  constraint SYS_C00118455 ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_RECKONING MODIFY (RECKONING_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118456 ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_RECKONING MODIFY (ACCOUNT_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_INT_RECKONING ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_RECKONING ADD CONSTRAINT PK_INT_RECKONING PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_INT_RECKONING_DEAL_ID ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_INT_RECKONING_DEAL_ID ON BARS.INT_RECKONING (DEAL_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_INT_RECKONING ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_INT_RECKONING ON BARS.INT_RECKONING (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_INT_RECKONING ***
begin   
 execute immediate '
  CREATE BITMAP INDEX BARS.I_INT_RECKONING ON BARS.INT_RECKONING (RECKONING_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  INT_RECKONING ***
grant SELECT                                                                 on INT_RECKONING   to BARSREADER_ROLE;
grant SELECT                                                                 on INT_RECKONING   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/INT_RECKONING.sql =========*** End ***
PROMPT ===================================================================================== 
