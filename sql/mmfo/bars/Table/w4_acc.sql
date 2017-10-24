

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/W4_ACC.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to W4_ACC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''W4_ACC'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''W4_ACC'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''W4_ACC'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table W4_ACC ***
begin 
  execute immediate '
  CREATE TABLE BARS.W4_ACC 
   (	ND NUMBER(22,0), 
	ACC_PK NUMBER(22,0), 
	ACC_OVR NUMBER(22,0), 
	ACC_9129 NUMBER(22,0), 
	ACC_3570 NUMBER(22,0), 
	ACC_2208 NUMBER(22,0), 
	ACC_2627 NUMBER(22,0), 
	ACC_2207 NUMBER(22,0), 
	ACC_3579 NUMBER(22,0), 
	ACC_2209 NUMBER(22,0), 
	CARD_CODE VARCHAR2(32), 
	ACC_2625X NUMBER(22,0), 
	ACC_2627X NUMBER(22,0), 
	ACC_2625D NUMBER(22,0), 
	ACC_2628 NUMBER(22,0), 
	ACC_2203 NUMBER(22,0), 
	FIN NUMBER(*,0), 
	FIN23 NUMBER(*,0), 
	OBS23 NUMBER(*,0), 
	KAT23 NUMBER(*,0), 
	K23 NUMBER, 
	DAT_BEGIN DATE, 
	DAT_END DATE, 
	DAT_CLOSE DATE, 
	PASS_DATE DATE, 
	PASS_STATE NUMBER(10,0), 
	KOL_SP NUMBER, 
	S250 VARCHAR2(1), 
	GRP NUMBER(*,0), 
	NOT_USE_REZ23 DATE, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to W4_ACC ***
 exec bpa.alter_policies('W4_ACC');


COMMENT ON TABLE BARS.W4_ACC IS 'OW. Портфель карткових угод для ЦРВ';
COMMENT ON COLUMN BARS.W4_ACC.KF IS '';
COMMENT ON COLUMN BARS.W4_ACC.ND IS 'Номер договору';
COMMENT ON COLUMN BARS.W4_ACC.ACC_PK IS 'Поточний картковий рахунок';
COMMENT ON COLUMN BARS.W4_ACC.ACC_OVR IS 'Кред. БПК';
COMMENT ON COLUMN BARS.W4_ACC.ACC_9129 IS 'Невикористаний ліміт';
COMMENT ON COLUMN BARS.W4_ACC.ACC_3570 IS 'Нараховані доходи (комісії)';
COMMENT ON COLUMN BARS.W4_ACC.ACC_2208 IS 'Счет проц.доходов за пользование кредитом';
COMMENT ON COLUMN BARS.W4_ACC.ACC_2627 IS 'Нараховані доходи за кредитами овердрафт';
COMMENT ON COLUMN BARS.W4_ACC.ACC_2207 IS 'Прострочена заборгованість за кредитами ';
COMMENT ON COLUMN BARS.W4_ACC.ACC_3579 IS 'Прострочені нараховані доходи (комісії)';
COMMENT ON COLUMN BARS.W4_ACC.ACC_2209 IS 'Прострочені нараховані доходи за кредитами ';
COMMENT ON COLUMN BARS.W4_ACC.CARD_CODE IS 'Тип карты';
COMMENT ON COLUMN BARS.W4_ACC.ACC_2625X IS '';
COMMENT ON COLUMN BARS.W4_ACC.ACC_2627X IS 'Нараховані доходи за несанкціонований овердрафт';
COMMENT ON COLUMN BARS.W4_ACC.ACC_2625D IS 'Вклад на вимогу Мобільний';
COMMENT ON COLUMN BARS.W4_ACC.ACC_2628 IS 'Нараховані витрати за коштами на вимогу ';
COMMENT ON COLUMN BARS.W4_ACC.ACC_2203 IS '';
COMMENT ON COLUMN BARS.W4_ACC.FIN IS '';
COMMENT ON COLUMN BARS.W4_ACC.FIN23 IS 'ФiнКлас по НБУ-23';
COMMENT ON COLUMN BARS.W4_ACC.OBS23 IS 'Обсл.долга по НБУ-23';
COMMENT ON COLUMN BARS.W4_ACC.KAT23 IS 'Категорiя якостi за кредитом по НБУ-23';
COMMENT ON COLUMN BARS.W4_ACC.K23 IS 'Коеф.Показник ризику по НБУ-23';
COMMENT ON COLUMN BARS.W4_ACC.DAT_BEGIN IS 'Дата початку кредитного договору';
COMMENT ON COLUMN BARS.W4_ACC.DAT_END IS 'Дата закінчення строку дії кредитного договору';
COMMENT ON COLUMN BARS.W4_ACC.DAT_CLOSE IS 'Дата закриття договору bpk_ACC';
COMMENT ON COLUMN BARS.W4_ACC.PASS_DATE IS 'Дата передачі справи';
COMMENT ON COLUMN BARS.W4_ACC.PASS_STATE IS 'Стан передачі справ до Бек-офісу: 1-передано, 2-перевірено, 3-повернуто на доопрацювання';
COMMENT ON COLUMN BARS.W4_ACC.KOL_SP IS 'К-во дней просрочки по договору';
COMMENT ON COLUMN BARS.W4_ACC.S250 IS 'Портфельный метод (8)';
COMMENT ON COLUMN BARS.W4_ACC.GRP IS 'група активу портфельного методу';
COMMENT ON COLUMN BARS.W4_ACC.NOT_USE_REZ23 IS 'Карточка не используется в расчете резерва по 23 постанове';




PROMPT *** Create  constraint UK6_W4ACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_ACC ADD CONSTRAINT UK6_W4ACC UNIQUE (ACC_2207)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK7_W4ACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_ACC ADD CONSTRAINT UK7_W4ACC UNIQUE (ACC_3579)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_W4ACC_CARDCODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_ACC MODIFY (CARD_CODE CONSTRAINT CC_W4ACC_CARDCODE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_W4ACC_ACCPK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_ACC MODIFY (ACC_PK CONSTRAINT CC_W4ACC_ACCPK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_W4ACC_ND_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_ACC MODIFY (ND CONSTRAINT CC_W4ACC_ND_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_W4ACC_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_ACC ADD CONSTRAINT FK_W4ACC_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_W4ACC_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_ACC MODIFY (KF CONSTRAINT CC_W4ACC_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK8_W4ACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_ACC ADD CONSTRAINT UK8_W4ACC UNIQUE (ACC_2209)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_W4ACC_DATEND_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_ACC ADD CONSTRAINT CC_W4ACC_DATEND_NN CHECK (dat_end is not null) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_W4ACC_DATBEGIN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_ACC ADD CONSTRAINT CC_W4ACC_DATBEGIN_NN CHECK (dat_begin is not null) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK9_W4ACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_ACC ADD CONSTRAINT UK9_W4ACC UNIQUE (ACC_2625X)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK10_W4ACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_ACC ADD CONSTRAINT UK10_W4ACC UNIQUE (ACC_2627X)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK11_W4ACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_ACC ADD CONSTRAINT UK11_W4ACC UNIQUE (ACC_2625D)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK12_W4ACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_ACC ADD CONSTRAINT UK12_W4ACC UNIQUE (ACC_2203)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_W4ACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_ACC ADD CONSTRAINT PK_W4ACC PRIMARY KEY (ND)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_W4ACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_ACC ADD CONSTRAINT UK_W4ACC UNIQUE (ACC_PK)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK1_W4ACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_ACC ADD CONSTRAINT UK1_W4ACC UNIQUE (ACC_OVR)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK2_W4ACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_ACC ADD CONSTRAINT UK2_W4ACC UNIQUE (ACC_9129)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK3_W4ACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_ACC ADD CONSTRAINT UK3_W4ACC UNIQUE (ACC_3570)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK4_W4ACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_ACC ADD CONSTRAINT UK4_W4ACC UNIQUE (ACC_2208)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK5_W4ACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_ACC ADD CONSTRAINT UK5_W4ACC UNIQUE (ACC_2627)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_W4ACC_STANFIN23 ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_ACC ADD CONSTRAINT FK_W4ACC_STANFIN23 FOREIGN KEY (FIN23)
	  REFERENCES BARS.STAN_FIN23 (FIN) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_W4ACC_STANOBS23 ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_ACC ADD CONSTRAINT FK_W4ACC_STANOBS23 FOREIGN KEY (OBS23)
	  REFERENCES BARS.STAN_OBS23 (OBS) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_W4ACC_STANKAT23 ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_ACC ADD CONSTRAINT FK_W4ACC_STANKAT23 FOREIGN KEY (KAT23)
	  REFERENCES BARS.STAN_KAT23 (KAT) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_W4ACC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_W4ACC ON BARS.W4_ACC (ND) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_W4ACC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_W4ACC ON BARS.W4_ACC (ACC_PK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK1_W4ACC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK1_W4ACC ON BARS.W4_ACC (ACC_OVR) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK2_W4ACC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK2_W4ACC ON BARS.W4_ACC (ACC_9129) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK3_W4ACC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK3_W4ACC ON BARS.W4_ACC (ACC_3570) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK4_W4ACC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK4_W4ACC ON BARS.W4_ACC (ACC_2208) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK5_W4ACC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK5_W4ACC ON BARS.W4_ACC (ACC_2627) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK6_W4ACC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK6_W4ACC ON BARS.W4_ACC (ACC_2207) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK7_W4ACC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK7_W4ACC ON BARS.W4_ACC (ACC_3579) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK8_W4ACC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK8_W4ACC ON BARS.W4_ACC (ACC_2209) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK9_W4ACC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK9_W4ACC ON BARS.W4_ACC (ACC_2625X) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK10_W4ACC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK10_W4ACC ON BARS.W4_ACC (ACC_2627X) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK11_W4ACC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK11_W4ACC ON BARS.W4_ACC (ACC_2625D) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK12_W4ACC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK12_W4ACC ON BARS.W4_ACC (ACC_2203) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  W4_ACC ***
grant SELECT                                                                 on W4_ACC          to BARSUPL;
grant INSERT,SELECT,UPDATE                                                   on W4_ACC          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on W4_ACC          to BARS_DM;
grant INSERT,SELECT,UPDATE                                                   on W4_ACC          to OW;
grant SELECT                                                                 on W4_ACC          to START1;
grant SELECT                                                                 on W4_ACC          to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/W4_ACC.sql =========*** End *** ======
PROMPT ===================================================================================== 
