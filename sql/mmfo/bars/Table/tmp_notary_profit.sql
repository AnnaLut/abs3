

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_NOTARY_PROFIT.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_NOTARY_PROFIT ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_NOTARY_PROFIT ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_NOTARY_PROFIT 
   (	ID NUMBER(*,0), 
	NOTARY_ID NUMBER(10,0), 
	ACCR_ID NUMBER(10,0), 
	BRANCH VARCHAR2(30), 
	NBSOB22 VARCHAR2(6), 
	REF_OPER NUMBER, 
	DAT_OPER DATE, 
	PROFIT NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_NOTARY_PROFIT ***
 exec bpa.alter_policies('TMP_NOTARY_PROFIT');


COMMENT ON TABLE BARS.TMP_NOTARY_PROFIT IS '';
COMMENT ON COLUMN BARS.TMP_NOTARY_PROFIT.ID IS '';
COMMENT ON COLUMN BARS.TMP_NOTARY_PROFIT.NOTARY_ID IS '';
COMMENT ON COLUMN BARS.TMP_NOTARY_PROFIT.ACCR_ID IS '';
COMMENT ON COLUMN BARS.TMP_NOTARY_PROFIT.BRANCH IS '';
COMMENT ON COLUMN BARS.TMP_NOTARY_PROFIT.NBSOB22 IS '';
COMMENT ON COLUMN BARS.TMP_NOTARY_PROFIT.REF_OPER IS '';
COMMENT ON COLUMN BARS.TMP_NOTARY_PROFIT.DAT_OPER IS '';
COMMENT ON COLUMN BARS.TMP_NOTARY_PROFIT.PROFIT IS '';




PROMPT *** Create  constraint SYS_C00119241 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_NOTARY_PROFIT MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119242 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_NOTARY_PROFIT MODIFY (NOTARY_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119243 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_NOTARY_PROFIT MODIFY (BRANCH NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119244 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_NOTARY_PROFIT MODIFY (NBSOB22 NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119245 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_NOTARY_PROFIT MODIFY (REF_OPER NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119246 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_NOTARY_PROFIT MODIFY (DAT_OPER NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119247 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_NOTARY_PROFIT MODIFY (PROFIT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_NOTARY_PROFIT ***
grant SELECT                                                                 on TMP_NOTARY_PROFIT to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_NOTARY_PROFIT to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_NOTARY_PROFIT.sql =========*** End
PROMPT ===================================================================================== 
