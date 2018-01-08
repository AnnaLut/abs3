

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_EXTENSION_LOG.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_EXTENSION_LOG ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_EXTENSION_LOG'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_EXTENSION_LOG'', ''FILIAL'' , ''B'', ''B'', ''B'', ''B'');
               bpa.alter_policy_info(''DPT_EXTENSION_LOG'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_EXTENSION_LOG ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_EXTENSION_LOG 
   (	ID NUMBER(38,0), 
	DAT DATE, 
	DEPOSIT_ID NUMBER(38,0), 
	KOD NUMBER(1,0), 
	N_DUBL NUMBER(10,0), 
	DAT_BEGIN DATE, 
	DAT_END DATE, 
	RATE NUMBER(20,4), 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	IDUPD NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_EXTENSION_LOG ***
 exec bpa.alter_policies('DPT_EXTENSION_LOG');


COMMENT ON TABLE BARS.DPT_EXTENSION_LOG IS 'Журнал переоформлений вкладов';
COMMENT ON COLUMN BARS.DPT_EXTENSION_LOG.ID IS 'ID';
COMMENT ON COLUMN BARS.DPT_EXTENSION_LOG.DAT IS 'Дата';
COMMENT ON COLUMN BARS.DPT_EXTENSION_LOG.DEPOSIT_ID IS 'ID депозита';
COMMENT ON COLUMN BARS.DPT_EXTENSION_LOG.KOD IS 'Код';
COMMENT ON COLUMN BARS.DPT_EXTENSION_LOG.N_DUBL IS 'Порядковый номер изменения %%-ной ставки';
COMMENT ON COLUMN BARS.DPT_EXTENSION_LOG.DAT_BEGIN IS 'Дата начала';
COMMENT ON COLUMN BARS.DPT_EXTENSION_LOG.DAT_END IS 'Дата окончания';
COMMENT ON COLUMN BARS.DPT_EXTENSION_LOG.RATE IS 'Процентная ставка';
COMMENT ON COLUMN BARS.DPT_EXTENSION_LOG.BRANCH IS 'Код отделения';
COMMENT ON COLUMN BARS.DPT_EXTENSION_LOG.IDUPD IS '№ записи';




PROMPT *** Create  constraint FK_DPTEXTLOG_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_EXTENSION_LOG ADD CONSTRAINT FK_DPTEXTLOG_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTEXTLOG_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_EXTENSION_LOG ADD CONSTRAINT FK_DPTEXTLOG_STAFF FOREIGN KEY (ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTEXTLOG_KOD ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_EXTENSION_LOG ADD CONSTRAINT CC_DPTEXTLOG_KOD CHECK (kod = 0) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_DPTEXTLOG ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_EXTENSION_LOG ADD CONSTRAINT PK_DPTEXTLOG PRIMARY KEY (IDUPD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTEXTLOG_IDUPD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_EXTENSION_LOG MODIFY (IDUPD CONSTRAINT CC_DPTEXTLOG_IDUPD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTEXTLOG_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_EXTENSION_LOG MODIFY (BRANCH CONSTRAINT CC_DPTEXTLOG_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTEXTLOG_KOD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_EXTENSION_LOG MODIFY (KOD CONSTRAINT CC_DPTEXTLOG_KOD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTEXTLOG_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_EXTENSION_LOG MODIFY (ID CONSTRAINT CC_DPTEXTLOG_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTEXTLOG_DAT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_EXTENSION_LOG MODIFY (DAT CONSTRAINT CC_DPTEXTLOG_DAT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTEXTLOG_DEPOSITID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_EXTENSION_LOG MODIFY (DEPOSIT_ID CONSTRAINT CC_DPTEXTLOG_DEPOSITID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPTEXTLOG ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPTEXTLOG ON BARS.DPT_EXTENSION_LOG (IDUPD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_EXTENSION_LOG ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_EXTENSION_LOG to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_EXTENSION_LOG to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_EXTENSION_LOG to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_EXTENSION_LOG to DPT_ADMIN;
grant SELECT                                                                 on DPT_EXTENSION_LOG to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_EXTENSION_LOG to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_EXTENSION_LOG.sql =========*** End
PROMPT ===================================================================================== 
