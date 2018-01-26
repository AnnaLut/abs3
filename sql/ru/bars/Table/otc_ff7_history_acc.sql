

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OTC_FF7_HISTORY_ACC.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OTC_FF7_HISTORY_ACC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OTC_FF7_HISTORY_ACC'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OTC_FF7_HISTORY_ACC'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OTC_FF7_HISTORY_ACC ***
begin 
  execute immediate '
  CREATE TABLE BARS.OTC_FF7_HISTORY_ACC 
   (	DATF DATE, 
	ACC NUMBER, 
	ACCC NUMBER(*,0), 
	NBS VARCHAR2(4), 
	SGN VARCHAR2(1), 
	NLS VARCHAR2(15), 
	KV NUMBER(*,0), 
	KV_DOG NUMBER(*,0), 
	NMS VARCHAR2(70), 
	DAOS DATE, 
	DAZS DATE, 
	OST NUMBER, 
	OSTQ NUMBER, 
	DOSQ NUMBER, 
	KOSQ NUMBER, 
	ND VARCHAR2(100), 
	NKD VARCHAR2(100), 
	SDATE DATE, 
	WDATE DATE, 
	SOS NUMBER(*,0), 
	RNK NUMBER, 
	STAFF NUMBER, 
	TOBO VARCHAR2(30), 
	S260 VARCHAR2(2), 
	K110 VARCHAR2(5), 
	K111 VARCHAR2(5), 
	S031 VARCHAR2(2), 
	S032 VARCHAR2(2), 
	CC VARCHAR2(2), 
	TIP CHAR(3), 
	OSTQ_KD NUMBER, 
	R_DOS NUMBER, 
	CC_ID VARCHAR2(100), 
	TPA NUMBER, 
	S080 VARCHAR2(1),
	R011 VARCHAR2(1),
	S245 VARCHAR2(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OTC_FF7_HISTORY_ACC ***
 exec bpa.alter_policies('OTC_FF7_HISTORY_ACC');


COMMENT ON TABLE BARS.OTC_FF7_HISTORY_ACC IS '';
COMMENT ON COLUMN BARS.OTC_FF7_HISTORY_ACC.OSTQ_KD IS 'Залишок по~договору';
COMMENT ON COLUMN BARS.OTC_FF7_HISTORY_ACC.R_DOS IS 'Сумма видачі~(з #03)';
COMMENT ON COLUMN BARS.OTC_FF7_HISTORY_ACC.CC_ID IS 'Номер~договору';
COMMENT ON COLUMN BARS.OTC_FF7_HISTORY_ACC.TPA IS '';
COMMENT ON COLUMN BARS.OTC_FF7_HISTORY_ACC.S080 IS '';
COMMENT ON COLUMN BARS.OTC_FF7_HISTORY_ACC.DATF IS 'Дата~формування~звіту';
COMMENT ON COLUMN BARS.OTC_FF7_HISTORY_ACC.ACC IS 'Ідентифікатор~рахунку';
COMMENT ON COLUMN BARS.OTC_FF7_HISTORY_ACC.ACCC IS 'Ідентифікатор~головного рахунку';
COMMENT ON COLUMN BARS.OTC_FF7_HISTORY_ACC.NBS IS 'Номер~балансового~рахунку';
COMMENT ON COLUMN BARS.OTC_FF7_HISTORY_ACC.SGN IS 'Знак залишку~(1 - актив,~2 - пасив)';
COMMENT ON COLUMN BARS.OTC_FF7_HISTORY_ACC.NLS IS 'Номер~рахунку';
COMMENT ON COLUMN BARS.OTC_FF7_HISTORY_ACC.KV IS 'Код~валюти~рахунку';
COMMENT ON COLUMN BARS.OTC_FF7_HISTORY_ACC.KV_DOG IS 'Код валюти~договора';
COMMENT ON COLUMN BARS.OTC_FF7_HISTORY_ACC.NMS IS 'Назва~рахунку';
COMMENT ON COLUMN BARS.OTC_FF7_HISTORY_ACC.DAOS IS 'Дата~відкриття~рахунку';
COMMENT ON COLUMN BARS.OTC_FF7_HISTORY_ACC.DAZS IS 'Дата~закриття~рахунку';
COMMENT ON COLUMN BARS.OTC_FF7_HISTORY_ACC.OST IS 'Залишок~на рахунку~(номінал)';
COMMENT ON COLUMN BARS.OTC_FF7_HISTORY_ACC.OSTQ IS 'Залишок~на рахунку~(еквівалент)';
COMMENT ON COLUMN BARS.OTC_FF7_HISTORY_ACC.DOSQ IS 'Дебетові~обороти~по рахунку';
COMMENT ON COLUMN BARS.OTC_FF7_HISTORY_ACC.KOSQ IS 'Кредитові~обороти~по рахунку';
COMMENT ON COLUMN BARS.OTC_FF7_HISTORY_ACC.ND IS 'Ідентифікатор~договора~(РЕФ КД)';
COMMENT ON COLUMN BARS.OTC_FF7_HISTORY_ACC.NKD IS 'Номер договора~(спец. парам.)';
COMMENT ON COLUMN BARS.OTC_FF7_HISTORY_ACC.SDATE IS 'Дата початку~дії договору';
COMMENT ON COLUMN BARS.OTC_FF7_HISTORY_ACC.WDATE IS 'Дата закінчення~дії договору';
COMMENT ON COLUMN BARS.OTC_FF7_HISTORY_ACC.SOS IS 'Стан обслуго~вування кредиту';
COMMENT ON COLUMN BARS.OTC_FF7_HISTORY_ACC.RNK IS 'РНК~клієнта';
COMMENT ON COLUMN BARS.OTC_FF7_HISTORY_ACC.STAFF IS 'Код~користувача';
COMMENT ON COLUMN BARS.OTC_FF7_HISTORY_ACC.TOBO IS 'Код безбал.~відділення';
COMMENT ON COLUMN BARS.OTC_FF7_HISTORY_ACC.S260 IS 'Параметр~S260';
COMMENT ON COLUMN BARS.OTC_FF7_HISTORY_ACC.K110 IS 'Вид екон.~діяльності~(К110)';
COMMENT ON COLUMN BARS.OTC_FF7_HISTORY_ACC.K111 IS 'Вид екон.~діяльності~(К111)';
COMMENT ON COLUMN BARS.OTC_FF7_HISTORY_ACC.S031 IS 'Вид~забезпечення~(S031)';
COMMENT ON COLUMN BARS.OTC_FF7_HISTORY_ACC.S032 IS 'Вид~забезпечення~(S032)';
COMMENT ON COLUMN BARS.OTC_FF7_HISTORY_ACC.CC IS 'Код СС';
COMMENT ON COLUMN BARS.OTC_FF7_HISTORY_ACC.TIP IS 'Тип рахунку';
COMMENT ON COLUMN BARS.OTC_FF7_HISTORY_ACC.R011 IS 'Параметр R011';
COMMENT ON COLUMN BARS.OTC_FF7_HISTORY_ACC.S245 IS 'Параметр S245';




PROMPT *** Create  constraint OTC_FF7_HISTORY_ACC_PK ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTC_FF7_HISTORY_ACC ADD CONSTRAINT OTC_FF7_HISTORY_ACC_PK PRIMARY KEY (DATF, ND, ACC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OTC_FF7_KV_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTC_FF7_HISTORY_ACC MODIFY (KV CONSTRAINT CC_OTC_FF7_KV_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OTC_FF7_NLS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTC_FF7_HISTORY_ACC MODIFY (NLS CONSTRAINT CC_OTC_FF7_NLS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OTC_FF7_ACC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTC_FF7_HISTORY_ACC MODIFY (ACC CONSTRAINT CC_OTC_FF7_ACC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OTC_FF7_DATF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTC_FF7_HISTORY_ACC MODIFY (DATF CONSTRAINT CC_OTC_FF7_DATF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index OTC_FF7_HISTORY_ACC_PK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.OTC_FF7_HISTORY_ACC_PK ON BARS.OTC_FF7_HISTORY_ACC (DATF, ND, ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OTC_FF7_HISTORY_ACC ***
grant DELETE,INSERT,SELECT,UPDATE                                            on OTC_FF7_HISTORY_ACC to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on OTC_FF7_HISTORY_ACC to RPBN002;



PROMPT *** Create SYNONYM  to OTC_FF7_HISTORY_ACC ***

  CREATE OR REPLACE PUBLIC SYNONYM OTC_FF7_HISTORY_ACC FOR BARS.OTC_FF7_HISTORY_ACC;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OTC_FF7_HISTORY_ACC.sql =========*** E
PROMPT ===================================================================================== 
