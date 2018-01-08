

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_TECHACCOUNTS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_TECHACCOUNTS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_TECHACCOUNTS'', ''CENTER'' , ''E'', ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DPT_TECHACCOUNTS'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''DPT_TECHACCOUNTS'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_TECHACCOUNTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_TECHACCOUNTS 
   (	DPT_ID NUMBER(38,0), 
	TECH_ACC NUMBER(38,0), 
	RNK NUMBER(38,0), 
	DPT_ACC NUMBER(38,0), 
	DPT_DATBEGIN DATE, 
	DPT_DATEND DATE, 
	TECH_DATEND DATE, 
	DPT_IDUPD NUMBER(38,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_TECHACCOUNTS ***
 exec bpa.alter_policies('DPT_TECHACCOUNTS');


COMMENT ON TABLE BARS.DPT_TECHACCOUNTS IS 'Технические счета по закрытым вкладам';
COMMENT ON COLUMN BARS.DPT_TECHACCOUNTS.DPT_ID IS '№ вклада';
COMMENT ON COLUMN BARS.DPT_TECHACCOUNTS.TECH_ACC IS 'Внутр.номер техн.счета';
COMMENT ON COLUMN BARS.DPT_TECHACCOUNTS.RNK IS 'Рег.№ вкладчика';
COMMENT ON COLUMN BARS.DPT_TECHACCOUNTS.DPT_ACC IS 'Внутр.номер деп.счета';
COMMENT ON COLUMN BARS.DPT_TECHACCOUNTS.DPT_DATBEGIN IS 'Дата начала вклада';
COMMENT ON COLUMN BARS.DPT_TECHACCOUNTS.DPT_DATEND IS 'Дата окончания вклада';
COMMENT ON COLUMN BARS.DPT_TECHACCOUNTS.TECH_DATEND IS 'План.дата закрытия техн.счета';
COMMENT ON COLUMN BARS.DPT_TECHACCOUNTS.DPT_IDUPD IS 'Код записи в архиве вкладов';
COMMENT ON COLUMN BARS.DPT_TECHACCOUNTS.KF IS '';
COMMENT ON COLUMN BARS.DPT_TECHACCOUNTS.BRANCH IS '';




PROMPT *** Create  constraint PK_DPTTECHACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_TECHACCOUNTS ADD CONSTRAINT PK_DPTTECHACC PRIMARY KEY (TECH_ACC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPT_TECHACC_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_TECHACCOUNTS MODIFY (BRANCH CONSTRAINT CC_DPT_TECHACC_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPT_TECHACC_ACCOUNTS3 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_TECHACCOUNTS ADD CONSTRAINT FK_DPT_TECHACC_ACCOUNTS3 FOREIGN KEY (KF, TECH_ACC)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPT_TECHACC_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_TECHACCOUNTS ADD CONSTRAINT FK_DPT_TECHACC_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTTECHACC_CUSTOMER ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_TECHACCOUNTS ADD CONSTRAINT FK_DPTTECHACC_CUSTOMER FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPT_TECHACC_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_TECHACCOUNTS ADD CONSTRAINT FK_DPT_TECHACC_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPT_TECHACC_DPTDEPOSITCLOS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_TECHACCOUNTS ADD CONSTRAINT FK_DPT_TECHACC_DPTDEPOSITCLOS2 FOREIGN KEY (KF, DPT_IDUPD)
	  REFERENCES BARS.DPT_DEPOSIT_CLOS (KF, IDUPD) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPT_TECHACC_DPTDPTALL2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_TECHACCOUNTS ADD CONSTRAINT FK_DPT_TECHACC_DPTDPTALL2 FOREIGN KEY (KF, DPT_ID)
	  REFERENCES BARS.DPT_DEPOSIT_ALL (KF, DEPOSIT_ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTTECHACC_DPTID ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_TECHACCOUNTS MODIFY (DPT_ID CONSTRAINT CC_DPTTECHACC_DPTID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTTECHACC_TECHACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_TECHACCOUNTS MODIFY (TECH_ACC CONSTRAINT CC_DPTTECHACC_TECHACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTTECHACC_RNK ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_TECHACCOUNTS MODIFY (RNK CONSTRAINT CC_DPTTECHACC_RNK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTTECHACC_DPTACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_TECHACCOUNTS MODIFY (DPT_ACC CONSTRAINT CC_DPTTECHACC_DPTACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTTECHACC_DPTDATBEGIN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_TECHACCOUNTS MODIFY (DPT_DATBEGIN CONSTRAINT CC_DPTTECHACC_DPTDATBEGIN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTTECHACC_DPTDATEND ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_TECHACCOUNTS MODIFY (DPT_DATEND CONSTRAINT CC_DPTTECHACC_DPTDATEND NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTTECHACC_DPTIDUPD ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_TECHACCOUNTS MODIFY (DPT_IDUPD CONSTRAINT CC_DPTTECHACC_DPTIDUPD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPT_TECHACC_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_TECHACCOUNTS MODIFY (KF CONSTRAINT CC_DPT_TECHACC_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPT_TECHACC_ACCOUNTS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_TECHACCOUNTS ADD CONSTRAINT FK_DPT_TECHACC_ACCOUNTS2 FOREIGN KEY (KF, DPT_ACC)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPTTECHACC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPTTECHACC ON BARS.DPT_TECHACCOUNTS (TECH_ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_DPTTECHACC_KFACC ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_DPTTECHACC_KFACC ON BARS.DPT_TECHACCOUNTS (KF, TECH_ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_DPTTECHACC_KFIDUPD ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_DPTTECHACC_KFIDUPD ON BARS.DPT_TECHACCOUNTS (KF, DPT_IDUPD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_TECHACCOUNTS ***
grant SELECT                                                                 on DPT_TECHACCOUNTS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_TECHACCOUNTS to BARS_DM;
grant SELECT                                                                 on DPT_TECHACCOUNTS to DPT_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_TECHACCOUNTS to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_TECHACCOUNTS.sql =========*** End 
PROMPT ===================================================================================== 
