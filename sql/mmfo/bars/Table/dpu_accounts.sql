

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPU_ACCOUNTS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPU_ACCOUNTS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPU_ACCOUNTS'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DPU_ACCOUNTS'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''DPU_ACCOUNTS'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPU_ACCOUNTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPU_ACCOUNTS 
   (	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	DPUID NUMBER(38,0), 
	ACCID NUMBER(38,0), 
	 CONSTRAINT PK_DPUACCOUNTS PRIMARY KEY (KF, DPUID, ACCID) ENABLE
   ) ORGANIZATION INDEX COMPRESS 1 PCTFREE 0 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSMDLI 
 PCTTHRESHOLD 10';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPU_ACCOUNTS ***
 exec bpa.alter_policies('DPU_ACCOUNTS');


COMMENT ON TABLE BARS.DPU_ACCOUNTS IS 'Рахунки деп. договорів ЮО';
COMMENT ON COLUMN BARS.DPU_ACCOUNTS.KF IS 'Код фiлiалу (МФО)';
COMMENT ON COLUMN BARS.DPU_ACCOUNTS.DPUID IS 'Ідентифікатор договору';
COMMENT ON COLUMN BARS.DPU_ACCOUNTS.ACCID IS 'Ідентифікатор рахунку';




PROMPT *** Create  constraint SYS_C0034285 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_ACCOUNTS MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0034286 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_ACCOUNTS MODIFY (DPUID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0034287 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_ACCOUNTS MODIFY (ACCID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_DPUACCOUNTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_ACCOUNTS ADD CONSTRAINT PK_DPUACCOUNTS PRIMARY KEY (KF, DPUID, ACCID)
  USING INDEX PCTFREE 0 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS COMPRESS 1 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPUACCOUNTS_DPUDEAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_ACCOUNTS ADD CONSTRAINT FK_DPUACCOUNTS_DPUDEAL FOREIGN KEY (KF, DPUID)
	  REFERENCES BARS.DPU_DEAL (KF, DPU_ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPUACCOUNTS_ACCOUNTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_ACCOUNTS ADD CONSTRAINT FK_DPUACCOUNTS_ACCOUNTS FOREIGN KEY (KF, ACCID)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TEST_DPUACCOUNTS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TEST_DPUACCOUNTS ON BARS.DPU_ACCOUNTS (KF, DPUID, ACCID) 
  PCTFREE 0 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS COMPRESS 1 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPU_ACCOUNTS ***
grant SELECT                                                                 on DPU_ACCOUNTS    to BARSUPL;
grant SELECT                                                                 on DPU_ACCOUNTS    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPU_ACCOUNTS    to DPT;
grant SELECT                                                                 on DPU_ACCOUNTS    to DPT_ROLE;



PROMPT *** Create SYNONYM  to DPU_ACCOUNTS ***

  CREATE OR REPLACE PUBLIC SYNONYM DPU_ACCOUNTS FOR BARS.DPU_ACCOUNTS;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPU_ACCOUNTS.sql =========*** End *** 
PROMPT ===================================================================================== 
