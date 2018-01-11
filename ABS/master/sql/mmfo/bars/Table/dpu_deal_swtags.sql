

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPU_DEAL_SWTAGS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPU_DEAL_SWTAGS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPU_DEAL_SWTAGS'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DPU_DEAL_SWTAGS'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''DPU_DEAL_SWTAGS'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPU_DEAL_SWTAGS ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPU_DEAL_SWTAGS 
   (	DPU_ID NUMBER(38,0), 
	TAG56_NAME VARCHAR2(100), 
	TAG56_ADR VARCHAR2(50), 
	TAG56_CODE VARCHAR2(11), 
	TAG57_NAME VARCHAR2(100), 
	TAG57_ADR VARCHAR2(50), 
	TAG57_CODE VARCHAR2(11), 
	TAG57_ACC VARCHAR2(20), 
	TAG59_NAME VARCHAR2(100), 
	TAG59_ADR VARCHAR2(50), 
	TAG59_ACC VARCHAR2(20), 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPU_DEAL_SWTAGS ***
 exec bpa.alter_policies('DPU_DEAL_SWTAGS');


COMMENT ON TABLE BARS.DPU_DEAL_SWTAGS IS 'Платежные реквизиты для переводов вал.депозитов ЮЛ по системе SWIFT';
COMMENT ON COLUMN BARS.DPU_DEAL_SWTAGS.DPU_ID IS '';
COMMENT ON COLUMN BARS.DPU_DEAL_SWTAGS.TAG56_NAME IS 'Название банка-посредника';
COMMENT ON COLUMN BARS.DPU_DEAL_SWTAGS.TAG56_ADR IS 'Адрес банка-посредника';
COMMENT ON COLUMN BARS.DPU_DEAL_SWTAGS.TAG56_CODE IS 'SWIFT-код банка-посредника';
COMMENT ON COLUMN BARS.DPU_DEAL_SWTAGS.TAG57_NAME IS 'Название банка-бенефициара';
COMMENT ON COLUMN BARS.DPU_DEAL_SWTAGS.TAG57_ADR IS 'Адрес банка-бенефициара';
COMMENT ON COLUMN BARS.DPU_DEAL_SWTAGS.TAG57_CODE IS 'SWIFT-код банка-бенефициара';
COMMENT ON COLUMN BARS.DPU_DEAL_SWTAGS.TAG57_ACC IS 'Счет банка-бенефициара в банке-посреднике';
COMMENT ON COLUMN BARS.DPU_DEAL_SWTAGS.TAG59_NAME IS 'Название бенефициара';
COMMENT ON COLUMN BARS.DPU_DEAL_SWTAGS.TAG59_ADR IS 'Адрес бенефициара';
COMMENT ON COLUMN BARS.DPU_DEAL_SWTAGS.TAG59_ACC IS 'Счет бенефициара';
COMMENT ON COLUMN BARS.DPU_DEAL_SWTAGS.BRANCH IS '';
COMMENT ON COLUMN BARS.DPU_DEAL_SWTAGS.KF IS '';




PROMPT *** Create  constraint CC_DPUDEALSWTAGS_DPUID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEAL_SWTAGS MODIFY (DPU_ID CONSTRAINT CC_DPUDEALSWTAGS_DPUID_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUDEALSWTAGS_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEAL_SWTAGS MODIFY (BRANCH CONSTRAINT CC_DPUDEALSWTAGS_BRANCH_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUDEALSWTAGS_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEAL_SWTAGS MODIFY (KF CONSTRAINT CC_DPUDEALSWTAGS_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_DPUDEALSWTAGS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEAL_SWTAGS ADD CONSTRAINT PK_DPUDEALSWTAGS PRIMARY KEY (DPU_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPUDEALSWTAGS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPUDEALSWTAGS ON BARS.DPU_DEAL_SWTAGS (DPU_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPU_DEAL_SWTAGS ***
grant SELECT                                                                 on DPU_DEAL_SWTAGS to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPU_DEAL_SWTAGS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPU_DEAL_SWTAGS to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPU_DEAL_SWTAGS to DPT_ROLE;
grant SELECT                                                                 on DPU_DEAL_SWTAGS to UPLD;



PROMPT *** Create SYNONYM  to DPU_DEAL_SWTAGS ***

  CREATE OR REPLACE PUBLIC SYNONYM DPU_DEAL_SWTAGS FOR BARS.DPU_DEAL_SWTAGS;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPU_DEAL_SWTAGS.sql =========*** End *
PROMPT ===================================================================================== 
