

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_TRUSTEE.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_TRUSTEE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_TRUSTEE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_TRUSTEE'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''DPT_TRUSTEE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_TRUSTEE ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_TRUSTEE 
   (	ID NUMBER(38,0), 
	DPT_ID NUMBER(38,0), 
	TYP_TR CHAR(1), 
	RNK_TR NUMBER(38,0), 
	RNK NUMBER(38,0), 
	ADD_NUM VARCHAR2(30), 
	ADD_DAT DATE, 
	FL_ACT NUMBER(1,0), 
	UNDO_ID NUMBER(38,0), 
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




PROMPT *** ALTER_POLICIES to DPT_TRUSTEE ***
 exec bpa.alter_policies('DPT_TRUSTEE');


COMMENT ON TABLE BARS.DPT_TRUSTEE IS 'Справочик 3-их лиц по вкладу';
COMMENT ON COLUMN BARS.DPT_TRUSTEE.ID IS 'Уникальный номер';
COMMENT ON COLUMN BARS.DPT_TRUSTEE.DPT_ID IS 'Номер вклада';
COMMENT ON COLUMN BARS.DPT_TRUSTEE.TYP_TR IS 'Тип доверенного лица - совкладчика';
COMMENT ON COLUMN BARS.DPT_TRUSTEE.RNK_TR IS 'РНК 3-го лица';
COMMENT ON COLUMN BARS.DPT_TRUSTEE.RNK IS 'РНК вкладчика';
COMMENT ON COLUMN BARS.DPT_TRUSTEE.ADD_NUM IS 'Номер доп.соглашения';
COMMENT ON COLUMN BARS.DPT_TRUSTEE.ADD_DAT IS 'Дата доп.соглашения';
COMMENT ON COLUMN BARS.DPT_TRUSTEE.FL_ACT IS 'Признак активности ДС';
COMMENT ON COLUMN BARS.DPT_TRUSTEE.UNDO_ID IS 'Код первичного ДС, которое отменяет данное';
COMMENT ON COLUMN BARS.DPT_TRUSTEE.KF IS '';
COMMENT ON COLUMN BARS.DPT_TRUSTEE.BRANCH IS '';




PROMPT *** Create  constraint PK_DPTTRUSTEE ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_TRUSTEE ADD CONSTRAINT PK_DPTTRUSTEE PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTTRUSTEE_RNK ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_TRUSTEE ADD CONSTRAINT CC_DPTTRUSTEE_RNK CHECK (rnk_tr != rnk) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_DPTTRUSTEE2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_TRUSTEE ADD CONSTRAINT UK_DPTTRUSTEE2 UNIQUE (DPT_ID, ADD_NUM)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTTRUSTEE_FLACT ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_TRUSTEE ADD CONSTRAINT CC_DPTTRUSTEE_FLACT CHECK (fl_act IN (0,1,-1) ) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK2_DPTTRUSTEE ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_TRUSTEE ADD CONSTRAINT UK2_DPTTRUSTEE UNIQUE (KF, ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTTRUSTEE_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_TRUSTEE MODIFY (ID CONSTRAINT CC_DPTTRUSTEE_ID_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTTRUSTEE_DPTID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_TRUSTEE MODIFY (DPT_ID CONSTRAINT CC_DPTTRUSTEE_DPTID_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTTRUSTEE_TYPTR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_TRUSTEE MODIFY (TYP_TR CONSTRAINT CC_DPTTRUSTEE_TYPTR_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTTRUSTEE_RNKTR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_TRUSTEE MODIFY (RNK_TR CONSTRAINT CC_DPTTRUSTEE_RNKTR_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTTRUSTEE_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_TRUSTEE MODIFY (RNK CONSTRAINT CC_DPTTRUSTEE_RNK_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTTRUSTEE_ADDNUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_TRUSTEE MODIFY (ADD_NUM CONSTRAINT CC_DPTTRUSTEE_ADDNUM_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTTRUSTEE_ADDDAT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_TRUSTEE MODIFY (ADD_DAT CONSTRAINT CC_DPTTRUSTEE_ADDDAT_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTTRUSTEE_FLACT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_TRUSTEE MODIFY (FL_ACT CONSTRAINT CC_DPTTRUSTEE_FLACT_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTTRUSTEE_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_TRUSTEE MODIFY (KF CONSTRAINT CC_DPTTRUSTEE_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTTRUSTEE_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_TRUSTEE MODIFY (BRANCH CONSTRAINT CC_DPTTRUSTEE_BRANCH_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPTTRUSTEE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPTTRUSTEE ON BARS.DPT_TRUSTEE (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_DPTTRUSTEE ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_DPTTRUSTEE ON BARS.DPT_TRUSTEE (DPT_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_DPTTRUSTEE2 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_DPTTRUSTEE2 ON BARS.DPT_TRUSTEE (DPT_ID, ADD_NUM) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK2_DPTTRUSTEE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK2_DPTTRUSTEE ON BARS.DPT_TRUSTEE (KF, ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_DPTTRUSTEE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_DPTTRUSTEE ON BARS.DPT_TRUSTEE (DPT_ID, TYP_TR, RNK_TR, DECODE(FL_ACT,1,DECODE(TO_CHAR(UNDO_ID),NULL,1,ID),ID)) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_TRUSTEE ***
grant SELECT                                                                 on DPT_TRUSTEE     to BARSREADER_ROLE;
grant SELECT                                                                 on DPT_TRUSTEE     to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_TRUSTEE     to BARS_ACCESS_DEFROLE;
grant ALTER,DEBUG,DELETE,FLASHBACK,INDEX,INSERT,ON COMMIT REFRESH,QUERY REWRITE,REFERENCES,SELECT,UPDATE on DPT_TRUSTEE     to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_TRUSTEE     to DPT_ROLE;
grant SELECT                                                                 on DPT_TRUSTEE     to KLBX;
grant SELECT                                                                 on DPT_TRUSTEE     to RPBN001;
grant SELECT                                                                 on DPT_TRUSTEE     to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_TRUSTEE     to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_TRUSTEE.sql =========*** End *** =
PROMPT ===================================================================================== 
