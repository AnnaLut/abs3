

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/INS_DEALS.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to INS_DEALS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''INS_DEALS'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''INS_DEALS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table INS_DEALS ***
begin 
  execute immediate '
  CREATE TABLE BARS.INS_DEALS 
   (	ID NUMBER, 
	BRANCH VARCHAR2(30), 
	STAFF_ID NUMBER, 
	CRT_DATE DATE, 
	PARTNER_ID NUMBER, 
	TYPE_ID NUMBER, 
	STATUS_ID VARCHAR2(100) DEFAULT ''NEW'', 
	STATUS_DATE DATE DEFAULT sysdate, 
	STATUS_COMM VARCHAR2(512), 
	INS_RNK NUMBER, 
	SER VARCHAR2(100), 
	NUM VARCHAR2(100), 
	SDATE DATE, 
	EDATE DATE, 
	SUM NUMBER, 
	SUM_KV NUMBER DEFAULT 980, 
	INSU_TARIFF NUMBER, 
	INSU_SUM NUMBER, 
	OBJECT_TYPE VARCHAR2(100), 
	RNK NUMBER, 
	GRT_ID NUMBER, 
	ND NUMBER, 
	PAY_FREQ NUMBER(3,0), 
	RENEW_NEED NUMBER DEFAULT 0, 
	RENEW_NEWID NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to INS_DEALS ***
 exec bpa.alter_policies('INS_DEALS');


COMMENT ON TABLE BARS.INS_DEALS IS 'Страхові договори';
COMMENT ON COLUMN BARS.INS_DEALS.STAFF_ID IS 'Код менеджера';
COMMENT ON COLUMN BARS.INS_DEALS.CRT_DATE IS 'Дата створення';
COMMENT ON COLUMN BARS.INS_DEALS.PARTNER_ID IS 'Ідентифікатор СК';
COMMENT ON COLUMN BARS.INS_DEALS.TYPE_ID IS 'Ідентифікатор типу страхового договору';
COMMENT ON COLUMN BARS.INS_DEALS.STATUS_ID IS 'Ідентифікатор статусу договора';
COMMENT ON COLUMN BARS.INS_DEALS.STATUS_DATE IS 'Дата останньої зміни статусу';
COMMENT ON COLUMN BARS.INS_DEALS.STATUS_COMM IS 'Коментар до встановленого статусу';
COMMENT ON COLUMN BARS.INS_DEALS.KF IS '';
COMMENT ON COLUMN BARS.INS_DEALS.INS_RNK IS 'РНК страхувальника';
COMMENT ON COLUMN BARS.INS_DEALS.SER IS 'Серія';
COMMENT ON COLUMN BARS.INS_DEALS.NUM IS 'Номер';
COMMENT ON COLUMN BARS.INS_DEALS.SDATE IS 'Дата початку дії';
COMMENT ON COLUMN BARS.INS_DEALS.EDATE IS 'Дата кінця дії';
COMMENT ON COLUMN BARS.INS_DEALS.SUM IS 'Страхова сума';
COMMENT ON COLUMN BARS.INS_DEALS.SUM_KV IS 'Валюта страхової суми';
COMMENT ON COLUMN BARS.INS_DEALS.INSU_TARIFF IS 'Страховий тариф (%) (у випадку фіксованого тарифу)';
COMMENT ON COLUMN BARS.INS_DEALS.INSU_SUM IS 'Страхова премія (у випадку фіксованої премії)';
COMMENT ON COLUMN BARS.INS_DEALS.OBJECT_TYPE IS 'Тип обєкту страхування';
COMMENT ON COLUMN BARS.INS_DEALS.RNK IS 'РНК для договорів страховання контрагента';
COMMENT ON COLUMN BARS.INS_DEALS.GRT_ID IS 'Ідентивікатор договору застави для договорів страхування застави';
COMMENT ON COLUMN BARS.INS_DEALS.ID IS 'Ідентифікатор';
COMMENT ON COLUMN BARS.INS_DEALS.BRANCH IS 'Код відділення';
COMMENT ON COLUMN BARS.INS_DEALS.ND IS 'Номер першого кредитного договору прив`язки';
COMMENT ON COLUMN BARS.INS_DEALS.PAY_FREQ IS 'Періодичність сплати чергового платежу';
COMMENT ON COLUMN BARS.INS_DEALS.RENEW_NEED IS 'Чи необхідно перезаключати новий договір після його закінчення';
COMMENT ON COLUMN BARS.INS_DEALS.RENEW_NEWID IS 'Ідентифікатор нового договору страхування';




PROMPT *** Create  constraint SYS_C0033306 ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_DEALS MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INSDLS_BRCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_DEALS MODIFY (BRANCH CONSTRAINT CC_INSDLS_BRCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INSDLS_SID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_DEALS MODIFY (STAFF_ID CONSTRAINT CC_INSDLS_SID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INSDLS_CRTD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_DEALS MODIFY (CRT_DATE CONSTRAINT CC_INSDLS_CRTD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INSDLS_PID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_DEALS MODIFY (PARTNER_ID CONSTRAINT CC_INSDLS_PID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INSDLS_TID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_DEALS MODIFY (TYPE_ID CONSTRAINT CC_INSDLS_TID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INSDEALS_STATUSID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_DEALS MODIFY (STATUS_ID CONSTRAINT CC_INSDEALS_STATUSID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INSDEALS_STATUSDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_DEALS MODIFY (STATUS_DATE CONSTRAINT CC_INSDEALS_STATUSDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INSDLS_SER_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_DEALS MODIFY (INS_RNK CONSTRAINT CC_INSDLS_SER_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INSDLS_NUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_DEALS MODIFY (NUM CONSTRAINT CC_INSDLS_NUM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INSDLS_SDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_DEALS MODIFY (SDATE CONSTRAINT CC_INSDLS_SDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INSDLS_EDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_DEALS MODIFY (EDATE CONSTRAINT CC_INSDLS_EDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INSDLS_SUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_DEALS MODIFY (SUM CONSTRAINT CC_INSDLS_SUM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INSDLS_SUMKV_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_DEALS MODIFY (SUM_KV CONSTRAINT CC_INSDLS_SUMKV_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INSDLS_OBJTYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_DEALS MODIFY (OBJECT_TYPE CONSTRAINT CC_INSDLS_OBJTYPE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INSDLS_RNEED_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_DEALS MODIFY (RENEW_NEED CONSTRAINT CC_INSDLS_RNEED_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_INSDEALS ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_DEALS ADD CONSTRAINT PK_INSDEALS PRIMARY KEY (ID, KF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INSDEALS_TARIFF_OR_SUM ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_DEALS ADD CONSTRAINT CC_INSDEALS_TARIFF_OR_SUM CHECK (insu_tariff is not null or insu_sum is not null) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INSDEALS_RENEWNEED ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_DEALS ADD CONSTRAINT CC_INSDEALS_RENEWNEED CHECK (renew_need in (0, 1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_INSDEALS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_INSDEALS ON BARS.INS_DEALS (ID, KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  constraint FK_INSDEALS_BRANCH_BRANCH ***
begin   
  execute immediate '
    alter table INS_DEALS
      add constraint FK_INSDEALS_BRANCH_BRANCH foreign key (BRANCH)
      references BRANCH (BRANCH)
      novalidate
  ';
exception when others then
  if  sqlcode in (-2260,-2261,-2264,-2275,-1442) 
    then null; 
  else 
    raise; 
  end if;
end;
/


PROMPT *** Create  constraint FK_INSDEALS_GRTID_GRTDEALS ***
begin   
  execute immediate '
    alter table INS_DEALS
      add constraint FK_INSDEALS_GRTID_GRTDEALS foreign key (GRT_ID)
      references GRT_DEALS (DEAL_ID)
      novalidate
  ';
exception when others then
  if  sqlcode in (-2260,-2261,-2264,-2275,-1442) 
    then null; 
  else 
    raise; 
  end if;
end;
/
  

PROMPT *** Create  constraint FK_INSDEALS_ND_CCDEAL ***
begin   
  execute immediate '
    alter table INS_DEALS
      add constraint FK_INSDEALS_ND_CCDEAL foreign key (ND)
      references CC_DEAL (ND)
      deferrable
      novalidate
  ';
exception when others then
  if  sqlcode in (-2260,-2261,-2264,-2275,-1442) 
    then null; 
  else 
    raise; 
  end if;
end;
/
  

PROMPT *** Create  constraint FK_INSDEALS_NEWID_INSDEALS ***
begin   
  execute immediate '
    alter table INS_DEALS
      add constraint FK_INSDEALS_NEWID_INSDEALS foreign key (RENEW_NEWID, KF)
      references INS_DEALS (ID, KF)
      novalidate
  ';
exception when others then
  if  sqlcode in (-2260,-2261,-2264,-2275,-1442) 
    then null; 
  else 
    raise; 
  end if;
end;
/
  

PROMPT *** Create  constraint FK_INSDEALS_OT_OBJTYPES_ID ***
begin   
  execute immediate '
    alter table INS_DEALS
      add constraint FK_INSDEALS_OT_OBJTYPES_ID foreign key (OBJECT_TYPE)
      references INS_OBJECT_TYPES (ID)
      novalidate
  ';
exception when others then
  if  sqlcode in (-2260,-2261,-2264,-2275,-1442) 
    then null; 
  else 
    raise; 
  end if;
end;
/
  

PROMPT *** Create  constraint FK_INSDEALS_PARTNERTYPES ***
begin   
  execute immediate '
    alter table INS_DEALS
      add constraint FK_INSDEALS_PARTNERTYPES foreign key (PARTNER_ID, TYPE_ID, KF)
      references INS_PARTNER_TYPES (PARTNER_ID, TYPE_ID, KF)
      novalidate
  ';
exception when others then
  if  sqlcode in (-2260,-2261,-2264,-2275,-1442) 
    then null; 
  else 
    raise; 
  end if;
end;
/
  

PROMPT *** Create  constraint FK_INSDEALS_PF_FREQ ***
begin   
  execute immediate '
    alter table INS_DEALS
      add constraint FK_INSDEALS_PF_FREQ foreign key (PAY_FREQ)
      references FREQ (FREQ)
      novalidate
  ';
exception when others then
  if  sqlcode in (-2260,-2261,-2264,-2275,-1442) 
    then null; 
  else 
    raise; 
  end if;
end;
/
  

PROMPT *** Create  constraint FK_INSDEALS_RNK_CUSTOMER ***
begin   
  execute immediate '
    alter table INS_DEALS
      add constraint FK_INSDEALS_RNK_CUSTOMER foreign key (RNK)
      references CUSTOMER (RNK)
      novalidate
  ';
exception when others then
  if  sqlcode in (-2260,-2261,-2264,-2275,-1442) 
    then null; 
  else 
    raise; 
  end if;
end;
/
  

PROMPT *** Create  constraint FK_INSDEALS_SKV_TABVAL ***
begin   
  execute immediate '
    alter table INS_DEALS
      add constraint FK_INSDEALS_SKV_TABVAL foreign key (SUM_KV)
      references TABVAL$GLOBAL (KV)
      novalidate
  ';
exception when others then
  if  sqlcode in (-2260,-2261,-2264,-2275,-1442) 
    then null; 
  else 
    raise; 
  end if;
end;
/
  

PROMPT *** Create  constraint FK_INSDEALS_STFID_STAFF ***
begin   
  execute immediate '
    alter table INS_DEALS
      add constraint FK_INSDEALS_STFID_STAFF foreign key (STAFF_ID)
      references STAFF$BASE (ID)
      novalidate
  ';
exception when others then
  if  sqlcode in (-2260,-2261,-2264,-2275,-1442) 
    then null; 
  else 
    raise; 
  end if;
end;
/
  

PROMPT *** Create  constraint FK_INSDEALS_STSID_STATUSES ***
begin   
  execute immediate '
    alter table INS_DEALS
      add constraint FK_INSDEALS_STSID_STATUSES foreign key (STATUS_ID)
      references INS_DEAL_STATUSES (ID)
      novalidate
  ';
exception when others then
  if  sqlcode in (-2260,-2261,-2264,-2275,-1442) 
    then null; 
  else 
    raise; 
  end if;
end;
/
  
  
PROMPT *** Disable  constraint fk_insdeals_grtid_grtdeals ***
begin   
 execute immediate 'alter table ins_deals disable constraint fk_insdeals_grtid_grtdeals';
end;
/

PROMPT *** Create  grants  INS_DEALS ***
grant SELECT                                                                 on INS_DEALS       to BARSREADER_ROLE;
grant SELECT                                                                 on INS_DEALS       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on INS_DEALS       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/INS_DEALS.sql =========*** End *** ===
PROMPT ===================================================================================== 
