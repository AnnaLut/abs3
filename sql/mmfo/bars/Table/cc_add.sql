

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CC_ADD.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CC_ADD ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CC_ADD'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CC_ADD'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''CC_ADD'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CC_ADD ***
begin 
  execute immediate '
  CREATE TABLE BARS.CC_ADD 
   (	ND NUMBER(30,0), 
	ADDS NUMBER(*,0), 
	AIM NUMBER(*,0), 
	S NUMBER(24,4), 
	KV NUMBER(*,0), 
	BDATE DATE DEFAULT SYSDATE, 
	WDATE DATE DEFAULT SYSDATE, 
	ACCS NUMBER(38,0), 
	ACCP NUMBER(38,0), 
	SOUR NUMBER(*,0), 
	ACCKRED VARCHAR2(34), 
	MFOKRED VARCHAR2(12), 
	FREQ NUMBER(*,0), 
	PDATE DATE, 
	REFV NUMBER(*,0), 
	REFP NUMBER(*,0), 
	ACCPERC VARCHAR2(34), 
	MFOPERC VARCHAR2(12), 
	SWI_BIC CHAR(11), 
	SWI_ACC VARCHAR2(34), 
	SWI_REF NUMBER(38,0), 
	SWO_BIC CHAR(11), 
	SWO_ACC VARCHAR2(34), 
	SWO_REF NUMBER(38,0), 
	INT_AMOUNT NUMBER(24,4), 
	ALT_PARTYB VARCHAR2(250), 
	INTERM_B VARCHAR2(250), 
	INT_PARTYA VARCHAR2(250), 
	INT_PARTYB VARCHAR2(250), 
	INT_INTERMA VARCHAR2(250), 
	INT_INTERMB VARCHAR2(250), 
	SSUDA NUMBER(12,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	OKPOKRED VARCHAR2(14), 
	NAMKRED VARCHAR2(38), 
	NAZNKRED VARCHAR2(160), 
	NLS_1819 VARCHAR2(14), 
	FIELD_58D VARCHAR2(250)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CC_ADD ***
 exec bpa.alter_policies('CC_ADD');


COMMENT ON TABLE BARS.CC_ADD IS 'Доп.соглашения';
COMMENT ON COLUMN BARS.CC_ADD.ND IS 'Номер договора (референц)';
COMMENT ON COLUMN BARS.CC_ADD.ADDS IS 'N доп. соглащения';
COMMENT ON COLUMN BARS.CC_ADD.AIM IS 'Целевое назначение договора';
COMMENT ON COLUMN BARS.CC_ADD.S IS 'Сумма договора';
COMMENT ON COLUMN BARS.CC_ADD.KV IS 'Код вал';
COMMENT ON COLUMN BARS.CC_ADD.BDATE IS 'Дата начала действия';
COMMENT ON COLUMN BARS.CC_ADD.WDATE IS 'Дата выдачи';
COMMENT ON COLUMN BARS.CC_ADD.ACCS IS 'ACC ссудного счета';
COMMENT ON COLUMN BARS.CC_ADD.ACCP IS 'Внутренний номер счета начисленных процентов';
COMMENT ON COLUMN BARS.CC_ADD.SOUR IS 'Источник кредитования';
COMMENT ON COLUMN BARS.CC_ADD.ACCKRED IS 'Счет для перечисления';
COMMENT ON COLUMN BARS.CC_ADD.MFOKRED IS 'МФО для перечисления';
COMMENT ON COLUMN BARS.CC_ADD.FREQ IS 'Периодичность всяких событий ';
COMMENT ON COLUMN BARS.CC_ADD.PDATE IS '';
COMMENT ON COLUMN BARS.CC_ADD.REFV IS 'Внутренний номер документа (от "сотворения мира")';
COMMENT ON COLUMN BARS.CC_ADD.REFP IS 'Внутренний номер документа (от "сотворения мира")';
COMMENT ON COLUMN BARS.CC_ADD.ACCPERC IS '';
COMMENT ON COLUMN BARS.CC_ADD.MFOPERC IS '';
COMMENT ON COLUMN BARS.CC_ADD.SWI_BIC IS '';
COMMENT ON COLUMN BARS.CC_ADD.SWI_ACC IS '';
COMMENT ON COLUMN BARS.CC_ADD.SWI_REF IS '';
COMMENT ON COLUMN BARS.CC_ADD.SWO_BIC IS '';
COMMENT ON COLUMN BARS.CC_ADD.SWO_ACC IS '';
COMMENT ON COLUMN BARS.CC_ADD.SWO_REF IS '';
COMMENT ON COLUMN BARS.CC_ADD.INT_AMOUNT IS 'Сумма предварительно рассчитанных процентов';
COMMENT ON COLUMN BARS.CC_ADD.ALT_PARTYB IS 'Альтернативное заполнение исходящей трассы';
COMMENT ON COLUMN BARS.CC_ADD.INTERM_B IS 'Реквизиты посредника по стороне Б';
COMMENT ON COLUMN BARS.CC_ADD.INT_PARTYA IS 'Трасса входящего платежа для процентов';
COMMENT ON COLUMN BARS.CC_ADD.INT_PARTYB IS 'Трасса исходящего платежа для процентов';
COMMENT ON COLUMN BARS.CC_ADD.INT_INTERMA IS 'Реквизиты посредника входящего платежа для процентов';
COMMENT ON COLUMN BARS.CC_ADD.INT_INTERMB IS 'Реквизиты посредника исходящего платежа для процентов';
COMMENT ON COLUMN BARS.CC_ADD.SSUDA IS '';
COMMENT ON COLUMN BARS.CC_ADD.KF IS '';
COMMENT ON COLUMN BARS.CC_ADD.OKPOKRED IS ' Код ЄДРПОУ получателя';
COMMENT ON COLUMN BARS.CC_ADD.NAMKRED IS 'Наименование получателя';
COMMENT ON COLUMN BARS.CC_ADD.NAZNKRED IS 'Назначение платежа';
COMMENT ON COLUMN BARS.CC_ADD.NLS_1819 IS 'Транзит 1819 для кредитных ресурсов';
COMMENT ON COLUMN BARS.CC_ADD.FIELD_58D IS 'Поле 58D для рублей';




PROMPT *** Create  constraint PK_CCADD ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_ADD ADD CONSTRAINT PK_CCADD PRIMARY KEY (ND, ADDS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CCADD_ACCOUNTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_ADD ADD CONSTRAINT FK_CCADD_ACCOUNTS FOREIGN KEY (KF, ACCS)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CCADD_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_ADD MODIFY (KF CONSTRAINT CC_CCADD_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_CC_ADD_ADDS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_ADD MODIFY (ADDS CONSTRAINT NK_CC_ADD_ADDS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_CC_ADD_ND ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_ADD MODIFY (ND CONSTRAINT NK_CC_ADD_ND NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CCADD_SWJOURNAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_ADD ADD CONSTRAINT FK_CCADD_SWJOURNAL FOREIGN KEY (SWI_REF)
	  REFERENCES BARS.SW_JOURNAL (SWREF) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CCADD_SWJOURNAL2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_ADD ADD CONSTRAINT FK_CCADD_SWJOURNAL2 FOREIGN KEY (SWO_REF)
	  REFERENCES BARS.SW_JOURNAL (SWREF) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_CCSOURCE_CCADD ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_ADD ADD CONSTRAINT R_CCSOURCE_CCADD FOREIGN KEY (SOUR)
	  REFERENCES BARS.CC_SOURCE (SOUR) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_TABVAL_CCADD ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_ADD ADD CONSTRAINT R_TABVAL_CCADD FOREIGN KEY (KV)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XFK_FREQ ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_ADD ADD CONSTRAINT XFK_FREQ FOREIGN KEY (FREQ)
	  REFERENCES BARS.FREQ (FREQ) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_CCAIM_CCADD ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_ADD ADD CONSTRAINT R_CCAIM_CCADD FOREIGN KEY (AIM)
	  REFERENCES BARS.CC_AIM (AIM) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CCADD_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_ADD ADD CONSTRAINT FK_CCADD_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CCADD_SWBANKS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_ADD ADD CONSTRAINT FK_CCADD_SWBANKS2 FOREIGN KEY (SWO_BIC)
	  REFERENCES BARS.SW_BANKS (BIC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CCADD_SWBANKS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_ADD ADD CONSTRAINT FK_CCADD_SWBANKS FOREIGN KEY (SWI_BIC)
	  REFERENCES BARS.SW_BANKS (BIC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_CCDEAL_CCADD ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_ADD ADD CONSTRAINT R_CCDEAL_CCADD FOREIGN KEY (ND)
	  REFERENCES BARS.CC_DEAL (ND) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CCADD ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CCADD ON BARS.CC_ADD (ND, ADDS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  index IDX_CCADD_KFACC ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_CCADD_KFACC ON BARS.CC_ADD (KF, ACCS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/


begin
 execute immediate   'alter table CC_add add (N_NBU varchar2(50)) ';
exception when others then
  -- ORA-01430: column being added already exists in table
  if SQLCODE = - 01430 then null;   else raise; end if; 
end;
/
COMMENT ON COLUMN cc_add.n_NBU IS 'Номер свідоцтва НБУ';

begin
 execute immediate   'alter table CC_add add (D_NBU date) ';
exception when others then
  -- ORA-01430: column being added already exists in table
  if SQLCODE = - 01430 then null;   else raise; end if; 
end;
/
COMMENT ON COLUMN cc_add.D_NBU IS 'Дата реєстрації в НБУ';


PROMPT *** Create  grants  CC_ADD ***
grant SELECT                                                                 on CC_ADD          to BARSDWH_ACCESS_USER;
grant SELECT                                                                 on CC_ADD          to BARSUPL;
grant ALTER,DELETE,FLASHBACK,INSERT,SELECT,UPDATE                            on CC_ADD          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_ADD          to BARS_DM;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on CC_ADD          to FOREX;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on CC_ADD          to RCC_DEAL;
grant SELECT                                                                 on CC_ADD          to RPBN001;
grant SELECT                                                                 on CC_ADD          to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CC_ADD          to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on CC_ADD          to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CC_ADD.sql =========*** End *** ======
PROMPT ===================================================================================== 
