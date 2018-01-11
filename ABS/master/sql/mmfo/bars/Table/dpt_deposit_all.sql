

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_DEPOSIT_ALL.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_DEPOSIT_ALL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_DEPOSIT_ALL'', ''CENTER'' , ''E'', ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DPT_DEPOSIT_ALL'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''DPT_DEPOSIT_ALL'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_DEPOSIT_ALL ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_DEPOSIT_ALL 
   (	DEPOSIT_ID NUMBER(38,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_DEPOSIT_ALL ***
 exec bpa.alter_policies('DPT_DEPOSIT_ALL');


COMMENT ON TABLE BARS.DPT_DEPOSIT_ALL IS 'Депозитные договора (открытые и закрытые)';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_ALL.DEPOSIT_ID IS 'Код депозитного договора';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_ALL.KF IS '';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_ALL.BRANCH IS '';




PROMPT *** Create  constraint CC_DPTDPTALL_DEPOSITID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT_ALL MODIFY (DEPOSIT_ID CONSTRAINT CC_DPTDPTALL_DEPOSITID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTDPTALL_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT_ALL MODIFY (KF CONSTRAINT CC_DPTDPTALL_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTDPTALL_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT_ALL MODIFY (BRANCH CONSTRAINT CC_DPTDPTALL_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_DPTDPTALL ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT_ALL ADD CONSTRAINT PK_DPTDPTALL PRIMARY KEY (DEPOSIT_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_DPTDPTALL ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT_ALL ADD CONSTRAINT UK_DPTDPTALL UNIQUE (KF, DEPOSIT_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_DPTDPTALL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_DPTDPTALL ON BARS.DPT_DEPOSIT_ALL (KF, DEPOSIT_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPTDPTALL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPTDPTALL ON BARS.DPT_DEPOSIT_ALL (DEPOSIT_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_DEPOSIT_ALL ***
grant SELECT                                                                 on DPT_DEPOSIT_ALL to BARSREADER_ROLE;
grant SELECT                                                                 on DPT_DEPOSIT_ALL to BARS_DM;
grant SELECT                                                                 on DPT_DEPOSIT_ALL to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_DEPOSIT_ALL to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to DPT_DEPOSIT_ALL ***

  CREATE OR REPLACE PUBLIC SYNONYM DPT_DEPOSIT_ALL FOR BARS.DPT_DEPOSIT_ALL;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_DEPOSIT_ALL.sql =========*** End *
PROMPT ===================================================================================== 
