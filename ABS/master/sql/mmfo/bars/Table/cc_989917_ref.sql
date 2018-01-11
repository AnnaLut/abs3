

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CC_989917_REF.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CC_989917_REF ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CC_989917_REF'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CC_989917_REF'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''CC_989917_REF'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CC_989917_REF ***
begin 
  execute immediate '
  CREATE TABLE BARS.CC_989917_REF 
   (	REF1 NUMBER(38,0), 
	REF2 NUMBER(38,0), 
	ACC NUMBER(38,0), 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CC_989917_REF ***
 exec bpa.alter_policies('CC_989917_REF');


COMMENT ON TABLE BARS.CC_989917_REF IS 'Картотека 989917 для кредитних справ';
COMMENT ON COLUMN BARS.CC_989917_REF.REF1 IS 'Референс начального документа';
COMMENT ON COLUMN BARS.CC_989917_REF.REF2 IS 'Референс перекредитованного документа';
COMMENT ON COLUMN BARS.CC_989917_REF.ACC IS 'Идентификатор счета картотеки';
COMMENT ON COLUMN BARS.CC_989917_REF.BRANCH IS 'BRANCH відділення REF1';
COMMENT ON COLUMN BARS.CC_989917_REF.KF IS '';




PROMPT *** Create  constraint PK_CC989917REF ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_989917_REF ADD CONSTRAINT PK_CC989917REF PRIMARY KEY (REF1)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008428 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_989917_REF MODIFY (ACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008427 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_989917_REF MODIFY (REF1 NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CC989917REF_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_989917_REF MODIFY (BRANCH CONSTRAINT CC_CC989917REF_BRANCH NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CC989917REF_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_989917_REF MODIFY (KF CONSTRAINT CC_CC989917REF_KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CC989917REF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CC989917REF ON BARS.CC_989917_REF (REF1) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_CC989917REF ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_CC989917REF ON BARS.CC_989917_REF (ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CC_989917_REF ***
grant SELECT                                                                 on CC_989917_REF   to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CC_989917_REF   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_989917_REF   to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CC_989917_REF   to RCC_DEAL;
grant SELECT                                                                 on CC_989917_REF   to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CC_989917_REF   to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CC_989917_REF.sql =========*** End ***
PROMPT ===================================================================================== 
