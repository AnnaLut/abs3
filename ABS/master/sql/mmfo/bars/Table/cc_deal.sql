

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CC_DEAL.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CC_DEAL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CC_DEAL'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CC_DEAL'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''CC_DEAL'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CC_DEAL ***
begin 
  execute immediate '
  CREATE TABLE BARS.CC_DEAL 
   (	ND NUMBER(30,0), 
	SOS NUMBER(*,0), 
	CC_ID VARCHAR2(50), 
	SDATE DATE DEFAULT SYSDATE, 
	WDATE DATE DEFAULT SYSDATE, 
	RNK NUMBER(*,0), 
	VIDD NUMBER(*,0), 
	LIMIT NUMBER(24,4), 
	KPROLOG NUMBER(*,0), 
	USER_ID NUMBER(*,0), 
	OBS NUMBER(*,0), 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	IR NUMBER, 
	PROD VARCHAR2(100), 
	SDOG NUMBER(24,2), 
	SKARB_ID VARCHAR2(50), 
	FIN NUMBER(*,0), 
	NDI NUMBER(*,0), 
	FIN23 NUMBER(*,0), 
	OBS23 NUMBER(*,0), 
	KAT23 NUMBER(*,0), 
	K23 NUMBER, 
	KOL_SP NUMBER, 
	S250 VARCHAR2(1), 
	GRP NUMBER(*,0), 
	FIN_351 NUMBER, 
	PD NUMBER, 
	NDG NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CC_DEAL ***
 exec bpa.alter_policies('CC_DEAL');


COMMENT ON TABLE BARS.CC_DEAL IS 'Договора';
COMMENT ON COLUMN BARS.CC_DEAL.FIN_351 IS 'Фін.стан згідно 351 пост.';
COMMENT ON COLUMN BARS.CC_DEAL.PD IS 'PD';
COMMENT ON COLUMN BARS.CC_DEAL.NDG IS 'Реф генерального КД ';
COMMENT ON COLUMN BARS.CC_DEAL.ND IS 'Номер договора (референц)';
COMMENT ON COLUMN BARS.CC_DEAL.SOS IS 'СОСТОЯНИЕ договора';
COMMENT ON COLUMN BARS.CC_DEAL.CC_ID IS 'Идентификатор договора';
COMMENT ON COLUMN BARS.CC_DEAL.SDATE IS 'Дата заключения договора';
COMMENT ON COLUMN BARS.CC_DEAL.WDATE IS 'Дата завершения';
COMMENT ON COLUMN BARS.CC_DEAL.RNK IS 'Номер клиента';
COMMENT ON COLUMN BARS.CC_DEAL.VIDD IS 'Вид договора';
COMMENT ON COLUMN BARS.CC_DEAL.LIMIT IS 'Лимит договора';
COMMENT ON COLUMN BARS.CC_DEAL.KPROLOG IS '';
COMMENT ON COLUMN BARS.CC_DEAL.USER_ID IS 'Исполнитель';
COMMENT ON COLUMN BARS.CC_DEAL.OBS IS '';
COMMENT ON COLUMN BARS.CC_DEAL.BRANCH IS 'Бранч(ТОБО)-эмитент КД';
COMMENT ON COLUMN BARS.CC_DEAL.KF IS '';
COMMENT ON COLUMN BARS.CC_DEAL.IR IS 'Ст.бр для VIDD=26 или Эт.ЭС для 1,2,3,11,12,13';
COMMENT ON COLUMN BARS.CC_DEAL.PROD IS 'Код продукта';
COMMENT ON COLUMN BARS.CC_DEAL.SDOG IS 'Начальная сумма 100.55 - в цел с коп';
COMMENT ON COLUMN BARS.CC_DEAL.SKARB_ID IS '';
COMMENT ON COLUMN BARS.CC_DEAL.FIN IS 'Клас позичальника (фин.стан)';
COMMENT ON COLUMN BARS.CC_DEAL.NDI IS 'Код первоначального реф договора (связанные договора)';
COMMENT ON COLUMN BARS.CC_DEAL.FIN23 IS 'ФiнКлас по НБУ-23';
COMMENT ON COLUMN BARS.CC_DEAL.OBS23 IS 'Обсл.долга по НБУ-23';
COMMENT ON COLUMN BARS.CC_DEAL.KAT23 IS 'Категорiя якостi за кредитом по НБУ-23';
COMMENT ON COLUMN BARS.CC_DEAL.K23 IS 'Коеф.Показник ризику по НБУ-23';
COMMENT ON COLUMN BARS.CC_DEAL.KOL_SP IS 'К-во дней просрочки по договору';
COMMENT ON COLUMN BARS.CC_DEAL.S250 IS 'Портфельный метод (8)';
COMMENT ON COLUMN BARS.CC_DEAL.GRP IS 'група активу портфельного методу';




PROMPT *** Create  constraint CC_CCDEAL_VIDD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_DEAL MODIFY (VIDD CONSTRAINT CC_CCDEAL_VIDD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_CC_DEAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_DEAL ADD CONSTRAINT XPK_CC_DEAL PRIMARY KEY (ND)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_CCDEAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_DEAL ADD CONSTRAINT UK_CCDEAL UNIQUE (KF, ND)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_CC_DEAL_ND_RNK ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_DEAL ADD CONSTRAINT UK_CC_DEAL_ND_RNK UNIQUE (ND, RNK, KF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_CC_DEAL_ND ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_DEAL MODIFY (ND CONSTRAINT NK_CC_DEAL_ND NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CCDEAL_SOS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_DEAL MODIFY (SOS CONSTRAINT CC_CCDEAL_SOS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CCDEAL_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_DEAL MODIFY (RNK CONSTRAINT CC_CCDEAL_RNK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CCDEAL_STAFF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_DEAL MODIFY (USER_ID CONSTRAINT CC_CCDEAL_STAFF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CC_DEAL_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_DEAL MODIFY (BRANCH CONSTRAINT CC_CC_DEAL_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

declare
  e_idx_exists           exception;
  pragma exception_init( e_idx_exists,      -00955 );
  e_col_already_idx      exception;
  pragma exception_init( e_col_already_idx, -01408 );
begin
  execute immediate 'create index IDX_CCDEAL_SDATE on CC_DEAL (SDATE) tablespace BRSMDLI';
  dbms_output.put_line( 'Index created.' );
exception
  when e_idx_exists 
  then dbms_output.put_line( 'Name is already used by an existing object.' );
  when e_col_already_idx 
  then dbms_output.put_line( 'Such column list already indexed.' );
end;
/



PROMPT *** Create  constraint CC_CCDEAL_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_DEAL MODIFY (KF CONSTRAINT CC_CCDEAL_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_CCDEAL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_CCDEAL ON BARS.CC_DEAL (KF, ND) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_CC_DEAL_ND_RNK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_CC_DEAL_ND_RNK ON BARS.CC_DEAL (ND, RNK, KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XIE_CC_DEAL_SKARB_ID ***
begin   
 execute immediate '
  CREATE INDEX BARS.XIE_CC_DEAL_SKARB_ID ON BARS.CC_DEAL (SKARB_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CC_DEAL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CC_DEAL ON BARS.CC_DEAL (ND) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_CCDEAL_RNK ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_CCDEAL_RNK ON BARS.CC_DEAL (RNK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CC_DEAL ***
grant SELECT                                                                 on CC_DEAL         to BARSDWH_ACCESS_USER;
grant SELECT                                                                 on CC_DEAL         to BARSREADER_ROLE;
grant SELECT                                                                 on CC_DEAL         to BARSUPL;
grant ALTER,DELETE,FLASHBACK,INSERT,SELECT,UPDATE                            on CC_DEAL         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_DEAL         to BARS_DM;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on CC_DEAL         to FOREX;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on CC_DEAL         to RCC_DEAL;
grant SELECT                                                                 on CC_DEAL         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CC_DEAL         to WR_ALL_RIGHTS;
grant SELECT                                                                 on CC_DEAL         to WR_CREDIT;
grant FLASHBACK,SELECT                                                       on CC_DEAL         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CC_DEAL.sql =========*** End *** =====
PROMPT ===================================================================================== 
