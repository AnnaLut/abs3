
PROMPT ===================================================================================== 
PROMPT *** Run *** ======== Scripts /Sql/BARS/Table/W4_ACC_UPDATE_ARC.sql =========*** Run *
PROMPT ===================================================================================== 

PROMPT *** ADD  W4_ACC_UPDATE_ARC into POLICY_TABLE ***
begin
  execute immediate  'begin bars.bpa.alter_policy_info( ''BARS'', ''W4_ACC_UPDATE_ARC'', ''CENTER'',  null,  ''E'',  ''E'', ''E'' ); end;';
  execute immediate  'begin bars.bpa.alter_policy_info( ''BARS'', ''W4_ACC_UPDATE_ARC'', ''WHOLE'',   null,  ''E'',  ''E'', ''E'' ); end;';
  execute immediate  'begin bars.bpa.alter_policy_info( ''BARS'', ''W4_ACC_UPDATE_ARC'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'' ); end;'; 
  commit;
end;
/

PROMPT *** Create  table W4_ACC_UPDATE_ARC ***
begin 
  execute immediate '
CREATE TABLE BARS.W4_ACC_UPDATE_ARC(
    IDUPD           NUMBER(38,0), 
    CHGACTION       CHAR(1 BYTE), 
    EFFECTDATE      DATE, 
    CHGDATE         DATE, 
    DONEBY          NUMBER, 
    ND              NUMBER(22,0), 
    ACC_PK          NUMBER(22,0), 
    ACC_OVR         NUMBER(22,0), 
    ACC_9129        NUMBER(22,0), 
    ACC_3570        NUMBER(22,0), 
    ACC_2208        NUMBER(22,0), 
    ACC_2627        NUMBER(22,0), 
    ACC_2207        NUMBER(22,0), 
    ACC_3579        NUMBER(22,0), 
    ACC_2209        NUMBER(22,0), 
    CARD_CODE       VARCHAR2(32 BYTE), 
    ACC_2625X       NUMBER(22,0), 
    ACC_2627X       NUMBER(22,0), 
    ACC_2625D       NUMBER(22,0), 
    ACC_2628        NUMBER(22,0), 
    ACC_2203        NUMBER(22,0), 
    FIN             NUMBER(*,0), 
    FIN23           NUMBER(*,0), 
    OBS23           NUMBER(*,0), 
    KAT23           NUMBER(*,0), 
    K23             NUMBER, 
    DAT_BEGIN       DATE, 
    DAT_END         DATE, 
    DAT_CLOSE       DATE, 
    PASS_DATE       DATE, 
    PASS_STATE      NUMBER(10,0), 
    KOL_SP          NUMBER, 
    S250            VARCHAR2(1 BYTE), 
    GRP             NUMBER(*,0), 
    GLOBAL_BDATE    DATE, 
    KF              VARCHAR2(6 BYTE))
TABLESPACE BRSBIGD
PARTITION BY LIST (KF)
  (PARTITION "P_W4ACCUPDARC_300465" VALUES (''300465'') TABLESPACE BRSBIGD,
   PARTITION "P_W4ACCUPDARC_324805" VALUES (''324805'') TABLESPACE BRSBIGD,
   PARTITION "P_W4ACCUPDARC_302076" VALUES (''302076'') TABLESPACE BRSBIGD,
   PARTITION "P_W4ACCUPDARC_303398" VALUES (''303398'') TABLESPACE BRSBIGD,
   PARTITION "P_W4ACCUPDARC_305482" VALUES (''305482'') TABLESPACE BRSBIGD,
   PARTITION "P_W4ACCUPDARC_335106" VALUES (''335106'') TABLESPACE BRSBIGD,
   PARTITION "P_W4ACCUPDARC_311647" VALUES (''311647'') TABLESPACE BRSBIGD,
   PARTITION "P_W4ACCUPDARC_312356" VALUES (''312356'') TABLESPACE BRSBIGD,
   PARTITION "P_W4ACCUPDARC_313957" VALUES (''313957'') TABLESPACE BRSBIGD,
   PARTITION "P_W4ACCUPDARC_336503" VALUES (''336503'') TABLESPACE BRSBIGD,
   PARTITION "P_W4ACCUPDARC_322669" VALUES (''322669'') TABLESPACE BRSBIGD,
   PARTITION "P_W4ACCUPDARC_323475" VALUES (''323475'') TABLESPACE BRSBIGD,
   PARTITION "P_W4ACCUPDARC_304665" VALUES (''304665'') TABLESPACE BRSBIGD,
   PARTITION "P_W4ACCUPDARC_325796" VALUES (''325796'') TABLESPACE BRSBIGD,
   PARTITION "P_W4ACCUPDARC_326461" VALUES (''326461'') TABLESPACE BRSBIGD,
   PARTITION "P_W4ACCUPDARC_328845" VALUES (''328845'') TABLESPACE BRSBIGD,
   PARTITION "P_W4ACCUPDARC_331467" VALUES (''331467'') TABLESPACE BRSBIGD,
   PARTITION "P_W4ACCUPDARC_333368" VALUES (''333368'') TABLESPACE BRSBIGD,
   PARTITION "P_W4ACCUPDARC_337568" VALUES (''337568'') TABLESPACE BRSBIGD,
   PARTITION "P_W4ACCUPDARC_338545" VALUES (''338545'') TABLESPACE BRSBIGD,
   PARTITION "P_W4ACCUPDARC_351823" VALUES (''351823'') TABLESPACE BRSBIGD,
   PARTITION "P_W4ACCUPDARC_352457" VALUES (''352457'') TABLESPACE BRSBIGD,
   PARTITION "P_W4ACCUPDARC_315784" VALUES (''315784'') TABLESPACE BRSBIGD,
   PARTITION "P_W4ACCUPDARC_354507" VALUES (''354507'') TABLESPACE BRSBIGD,
   PARTITION "P_W4ACCUPDARC_356334" VALUES (''356334'') TABLESPACE BRSBIGD,
   PARTITION "P_W4ACCUPDARC_353553" VALUES (''353553'') TABLESPACE BRSBIGD
  )';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end;
/

COMMENT ON TABLE  BARS.W4_ACC_UPDATE_ARC              IS 'Архівні дані з W4_ACC_UPDATE: Портфель карткових угод для ЦРВ';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE_ARC.IDUPD        IS 'Первичный ключ для таблицы обновления';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE_ARC.CHGACTION    IS 'Код обновления (I/U/D)';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE_ARC.EFFECTDATE   IS 'Банковская дата начала действия параметров';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE_ARC.CHGDATE      IS 'Системаная дата обновления';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE_ARC.DONEBY       IS 'Код пользователя. кто внес обновления(если в течении дня было несколько обновлений - остается только последнее)';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE_ARC.ND           IS 'Номер договору';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE_ARC.ACC_PK       IS 'Поточний картковий рахунок';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE_ARC.ACC_OVR      IS 'Кред. БПК';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE_ARC.ACC_9129     IS 'Невикористаний ліміт';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE_ARC.ACC_3570     IS 'Нараховані доходи (комісії)';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE_ARC.ACC_2208     IS 'Счет проц.доходов за пользование кредитом';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE_ARC.ACC_2627     IS 'Нараховані доходи за кредитами овердрафт';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE_ARC.ACC_2207     IS 'Прострочена заборгованість за кредитами ';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE_ARC.ACC_3579     IS 'Прострочені нараховані доходи (комісії)';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE_ARC.ACC_2209     IS 'Прострочені нараховані доходи за кредитами ';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE_ARC.CARD_CODE    IS 'Тип карты';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE_ARC.ACC_2627X    IS 'Нараховані доходи за несанкціонований овердрафт';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE_ARC.ACC_2625D    IS 'Вклад на вимогу Мобільний';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE_ARC.ACC_2628     IS 'Нараховані витрати за коштами на вимогу ';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE_ARC.DAT_BEGIN    IS 'Дата початку дії кредитного договору';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE_ARC.DAT_END      IS 'Дата закінчення дії кредитного договору';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE_ARC.DAT_CLOSE    IS 'Дата закриття договору W4_ACC';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE_ARC.PASS_DATE    IS 'Дата передачі справи';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE_ARC.PASS_STATE   IS 'Стан передачі справ до Бек-офісу: 1-передано, 2-перевірено, 3-повернуто на доопрацювання';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE_ARC.KOL_SP       IS 'К-во дней просрочки по договору';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE_ARC.S250         IS 'Портфельный метод (8)';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE_ARC.GRP          IS 'група активу портфельного методу';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE_ARC.GLOBAL_BDATE IS 'Глобальная банковская дата изменений';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE_ARC.KF           IS 'МФО региона';

PROMPT *** ALTER  POLICIES  W4_ACC_UPDATE_ARC***
begin
 execute immediate 'begin bars.bpa.alter_policies( ''BARS'', ''W4_ACC_UPDATE_ARC''); end;';
exception when others then null;
end;
/

PROMPT *** Create  constraint PK_W4ACCUPDARC ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_ACC_UPDATE_ARC ADD CONSTRAINT PK_W4ACCUPDARC PRIMARY KEY (IDUPD)
  USING INDEX COMPUTE STATISTICS TABLESPACE BRSBIGI ENABLE VALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** CREATE GRANT on BARS.W4_ACC_UPDATE_ARC  ...***
grant SELECT  on BARS.W4_ACC_UPDATE_ARC to BARSUPL;
grant SELECT  on BARS.W4_ACC_UPDATE_ARC to BARS_ACCESS_DEFROLE;
grant SELECT  on BARS.W4_ACC_UPDATE_ARC to START1;
grant SELECT  on BARS.W4_ACC_UPDATE_ARC to BARS_DM;
grant SELECT  on BARS.W4_ACC_UPDATE_ARC to UPLD;

PROMPT ===================================================================================== 
PROMPT *** End *** ======== Scripts /Sql/BARS/Table/W4_ACC_UPDATE_ARC.sql =========*** End *
PROMPT ===================================================================================== 


