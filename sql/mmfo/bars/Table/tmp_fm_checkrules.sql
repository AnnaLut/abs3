

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_FM_CHECKRULES.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_FM_CHECKRULES ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_FM_CHECKRULES ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_FM_CHECKRULES 
   (	ID NUMBER(22,0), 
	REF NUMBER(22,0), 
	RULES VARCHAR2(254)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_FM_CHECKRULES ***
 exec bpa.alter_policies('TMP_FM_CHECKRULES');


COMMENT ON TABLE BARS.TMP_FM_CHECKRULES IS '';
COMMENT ON COLUMN BARS.TMP_FM_CHECKRULES.ID IS '';
COMMENT ON COLUMN BARS.TMP_FM_CHECKRULES.REF IS '';
COMMENT ON COLUMN BARS.TMP_FM_CHECKRULES.RULES IS '';




PROMPT *** Create  constraint PK_TMPFMCHECKRULES ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_FM_CHECKRULES ADD CONSTRAINT PK_TMPFMCHECKRULES PRIMARY KEY (ID, REF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPFMCHECKRULES_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_FM_CHECKRULES MODIFY (ID CONSTRAINT CC_TMPFMCHECKRULES_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPFMCHECKRULES_REF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_FM_CHECKRULES MODIFY (REF CONSTRAINT CC_TMPFMCHECKRULES_REF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPFMCHECKRULES_RULES_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_FM_CHECKRULES MODIFY (RULES CONSTRAINT CC_TMPFMCHECKRULES_RULES_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TMPFMCHECKRULES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TMPFMCHECKRULES ON BARS.TMP_FM_CHECKRULES (ID, REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_FM_CHECKRULES ***
grant SELECT                                                                 on TMP_FM_CHECKRULES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_FM_CHECKRULES to BARS_DM;
grant SELECT                                                                 on TMP_FM_CHECKRULES to FINMON01;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_FM_CHECKRULES.sql =========*** End
PROMPT ===================================================================================== 
