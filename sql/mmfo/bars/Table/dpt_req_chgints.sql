

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_REQ_CHGINTS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_REQ_CHGINTS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_REQ_CHGINTS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_REQ_CHGINTS'', ''FILIAL'' , ''B'', ''B'', ''B'', ''B'');
               bpa.alter_policy_info(''DPT_REQ_CHGINTS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_REQ_CHGINTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_REQ_CHGINTS 
   (	REQ_ID NUMBER(38,0), 
	REQC_TYPE NUMBER(1,0), 
	REQC_BEGDATE DATE, 
	REQC_EXPDATE DATE, 
	REQC_OLDINT NUMBER(9,4), 
	REQC_NEWINT NUMBER(9,4), 
	REQC_NEWBR NUMBER(38,0), 
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




PROMPT *** ALTER_POLICIES to DPT_REQ_CHGINTS ***
 exec bpa.alter_policies('DPT_REQ_CHGINTS');


COMMENT ON TABLE BARS.DPT_REQ_CHGINTS IS 'Депозитные договора. Подтверждения запроса на удаление договора';
COMMENT ON COLUMN BARS.DPT_REQ_CHGINTS.REQ_ID IS 'Идентификатор запроса';
COMMENT ON COLUMN BARS.DPT_REQ_CHGINTS.REQC_TYPE IS 'Тип запроса (индивидуальная ставка/изм. существующей)';
COMMENT ON COLUMN BARS.DPT_REQ_CHGINTS.REQC_BEGDATE IS 'Дата начала действия ставки';
COMMENT ON COLUMN BARS.DPT_REQ_CHGINTS.REQC_EXPDATE IS 'Срок действия запроса';
COMMENT ON COLUMN BARS.DPT_REQ_CHGINTS.REQC_OLDINT IS 'Индив. Текущая процентная ставка';
COMMENT ON COLUMN BARS.DPT_REQ_CHGINTS.REQC_NEWINT IS 'Индив. Новая процентная ставка';
COMMENT ON COLUMN BARS.DPT_REQ_CHGINTS.REQC_NEWBR IS 'Изм. сущ. Новая базовая проц. ставка';
COMMENT ON COLUMN BARS.DPT_REQ_CHGINTS.KF IS '';
COMMENT ON COLUMN BARS.DPT_REQ_CHGINTS.BRANCH IS '';




PROMPT *** Create  constraint CC_DPTREQCHGINTS_REQCTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_REQ_CHGINTS ADD CONSTRAINT CC_DPTREQCHGINTS_REQCTYPE CHECK (reqc_type in (1, 2)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_DPTREQCHGINTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_REQ_CHGINTS ADD CONSTRAINT PK_DPTREQCHGINTS PRIMARY KEY (REQ_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTREQCHGINTS_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_REQ_CHGINTS MODIFY (BRANCH CONSTRAINT CC_DPTREQCHGINTS_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTREQCHGINTS_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_REQ_CHGINTS MODIFY (KF CONSTRAINT CC_DPTREQCHGINTS_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTREQCHGINTS_REQCTYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_REQ_CHGINTS MODIFY (REQC_TYPE CONSTRAINT CC_DPTREQCHGINTS_REQCTYPE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTREQCHGINTS_REQID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_REQ_CHGINTS MODIFY (REQ_ID CONSTRAINT CC_DPTREQCHGINTS_REQID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTREQCHGINTS_DPTREQS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_REQ_CHGINTS ADD CONSTRAINT FK_DPTREQCHGINTS_DPTREQS2 FOREIGN KEY (KF, REQ_ID)
	  REFERENCES BARS.DPT_REQUESTS (KF, REQ_ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTREQCHGINTS_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_REQ_CHGINTS ADD CONSTRAINT FK_DPTREQCHGINTS_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTREQCHGINTS_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_REQ_CHGINTS ADD CONSTRAINT FK_DPTREQCHGINTS_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTREQCHGINTS_TYPER ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_REQ_CHGINTS ADD CONSTRAINT CC_DPTREQCHGINTS_TYPER CHECK ((reqc_type = 1 and reqc_oldint is not null and reqc_newint is not null) or (reqc_type = 2 and reqc_newbr is not null and reqc_begdate is not null)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPTREQCHGINTS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPTREQCHGINTS ON BARS.DPT_REQ_CHGINTS (REQ_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_REQ_CHGINTS ***
grant SELECT                                                                 on DPT_REQ_CHGINTS to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_REQ_CHGINTS to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_REQ_CHGINTS.sql =========*** End *
PROMPT ===================================================================================== 
