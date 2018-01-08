

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ACC_TARIF_ARC.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ACC_TARIF_ARC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ACC_TARIF_ARC'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''ACC_TARIF_ARC'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''ACC_TARIF_ARC'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ACC_TARIF_ARC ***
begin 
  execute immediate '
  CREATE TABLE BARS.ACC_TARIF_ARC 
   (	ACC NUMBER(38,0), 
	KOD NUMBER(38,0), 
	TAR NUMBER(24,0), 
	PR NUMBER(20,4), 
	SMIN NUMBER(24,0), 
	SMAX NUMBER(24,0), 
	FDAT DATE, 
	USER_ID NUMBER(38,0), 
	VID CHAR(1), 
	BDATE DATE, 
	EDATE DATE, 
	IDUPD NUMBER(38,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	OST_AVG NUMBER(24,0), 
	NDOK_RKO NUMBER, 
	KV_SMIN NUMBER(3,0), 
	KV_SMAX NUMBER(3,0), 
	GLOBAL_BDATE DATE, 
	EFFECTDATE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ACC_TARIF_ARC ***
 exec bpa.alter_policies('ACC_TARIF_ARC');


COMMENT ON TABLE BARS.ACC_TARIF_ARC IS 'Тарифы и комиссии по счетам. История изменений';
COMMENT ON COLUMN BARS.ACC_TARIF_ARC.ACC IS 'Идентификатор счета';
COMMENT ON COLUMN BARS.ACC_TARIF_ARC.KOD IS 'Идентификатор тарифа';
COMMENT ON COLUMN BARS.ACC_TARIF_ARC.TAR IS 'Сумма за 1 документ';
COMMENT ON COLUMN BARS.ACC_TARIF_ARC.PR IS '% от суммы документа';
COMMENT ON COLUMN BARS.ACC_TARIF_ARC.SMIN IS 'минимальная сумма тарифа';
COMMENT ON COLUMN BARS.ACC_TARIF_ARC.SMAX IS 'максимальная сумма тарифа';
COMMENT ON COLUMN BARS.ACC_TARIF_ARC.FDAT IS 'дата модификации';
COMMENT ON COLUMN BARS.ACC_TARIF_ARC.USER_ID IS 'автор модификации';
COMMENT ON COLUMN BARS.ACC_TARIF_ARC.VID IS 'вид изм I - новый, U-измен';
COMMENT ON COLUMN BARS.ACC_TARIF_ARC.BDATE IS 'Дата начала действия тарифа';
COMMENT ON COLUMN BARS.ACC_TARIF_ARC.EDATE IS 'Дата окончания действия тарифа';
COMMENT ON COLUMN BARS.ACC_TARIF_ARC.IDUPD IS 'Идентификатор записи';
COMMENT ON COLUMN BARS.ACC_TARIF_ARC.KF IS 'Код филиала';
COMMENT ON COLUMN BARS.ACC_TARIF_ARC.OST_AVG IS 'Среднекалендарный остаток за прошлый месяц';
COMMENT ON COLUMN BARS.ACC_TARIF_ARC.NDOK_RKO IS 'Количество документов за прошлый месяц';
COMMENT ON COLUMN BARS.ACC_TARIF_ARC.KV_SMIN IS 'Валюта минимальной граничной суммы';
COMMENT ON COLUMN BARS.ACC_TARIF_ARC.KV_SMAX IS 'Валюта максиимальной граничной суммы';
COMMENT ON COLUMN BARS.ACC_TARIF_ARC.GLOBAL_BDATE IS 'Глобальна банківська дата зміни';
COMMENT ON COLUMN BARS.ACC_TARIF_ARC.EFFECTDATE IS 'Локальна банківська дата зміни';




PROMPT *** Create  constraint CC_ACCTARIFARC_IDUPD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_TARIF_ARC ADD CONSTRAINT CC_ACCTARIFARC_IDUPD_NN CHECK (IDUPD IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCTARIFARC_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_TARIF_ARC MODIFY (KF CONSTRAINT CC_ACCTARIFARC_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCTARIFARC_VID ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_TARIF_ARC ADD CONSTRAINT CC_ACCTARIFARC_VID CHECK (vid in (''I'', ''U'', ''D'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCTARIFARC_BDATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_TARIF_ARC ADD CONSTRAINT CC_ACCTARIFARC_BDATE CHECK (bdate = trunc(bdate)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCTARIFARC_EDATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_TARIF_ARC ADD CONSTRAINT CC_ACCTARIFARC_EDATE CHECK (edate = trunc(edate)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCTARIFARC_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_TARIF_ARC ADD CONSTRAINT FK_ACCTARIFARC_STAFF FOREIGN KEY (USER_ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCTARIFARC_BANKS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_TARIF_ARC ADD CONSTRAINT FK_ACCTARIFARC_BANKS FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCTARIFARC_ACCOUNTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_TARIF_ARC ADD CONSTRAINT FK_ACCTARIFARC_ACCOUNTS FOREIGN KEY (ACC)
	  REFERENCES BARS.ACCOUNTS (ACC) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCTARIFARC_GLOBALBD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_TARIF_ARC MODIFY (GLOBAL_BDATE CONSTRAINT CC_ACCTARIFARC_GLOBALBD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCTARIFARC_EFFECTDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_TARIF_ARC MODIFY (EFFECTDATE CONSTRAINT CC_ACCTARIFARC_EFFECTDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCTARIFARC_ACC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_TARIF_ARC MODIFY (ACC CONSTRAINT CC_ACCTARIFARC_ACC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCTARIFARC_KOD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_TARIF_ARC MODIFY (KOD CONSTRAINT CC_ACCTARIFARC_KOD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCTARIFARC_TAR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_TARIF_ARC MODIFY (TAR CONSTRAINT CC_ACCTARIFARC_TAR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCTARIFARC_PR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_TARIF_ARC MODIFY (PR CONSTRAINT CC_ACCTARIFARC_PR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCTARIFARC_FDAT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_TARIF_ARC MODIFY (FDAT CONSTRAINT CC_ACCTARIFARC_FDAT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCTARIFARC_USERID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_TARIF_ARC MODIFY (USER_ID CONSTRAINT CC_ACCTARIFARC_USERID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCTARIFARC_VID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_TARIF_ARC MODIFY (VID CONSTRAINT CC_ACCTARIFARC_VID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_ACCTARIFARC ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_TARIF_ARC ADD CONSTRAINT PK_ACCTARIFARC PRIMARY KEY (IDUPD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ACCTARIFARC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ACCTARIFARC ON BARS.ACC_TARIF_ARC (IDUPD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_ACCTARIFARC_GLBDT_EFFDT ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_ACCTARIFARC_GLBDT_EFFDT ON BARS.ACC_TARIF_ARC (GLOBAL_BDATE, EFFECTDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_ACCTARIFARC_ACC_KOD ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_ACCTARIFARC_ACC_KOD ON BARS.ACC_TARIF_ARC (KF, ACC, KOD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ACC_TARIF_ARC ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ACC_TARIF_ARC   to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ACC_TARIF_ARC   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ACC_TARIF_ARC   to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACC_TARIF_ARC   to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ACC_TARIF_ARC   to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on ACC_TARIF_ARC   to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ACC_TARIF_ARC.sql =========*** End ***
PROMPT ===================================================================================== 
