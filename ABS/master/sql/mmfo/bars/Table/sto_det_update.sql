

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/STO_DET_UPDATE.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to STO_DET_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STO_DET_UPDATE'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''STO_DET_UPDATE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''STO_DET_UPDATE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table STO_DET_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.STO_DET_UPDATE 
   (	IDS NUMBER(*,0), 
	VOB NUMBER(*,0), 
	DK NUMBER(*,0), 
	TT CHAR(3), 
	NLSA VARCHAR2(15), 
	KVA NUMBER(*,0), 
	NLSB VARCHAR2(15), 
	KVB NUMBER(*,0), 
	MFOB VARCHAR2(12), 
	POLU VARCHAR2(38), 
	NAZN VARCHAR2(160), 
	FSUM VARCHAR2(100), 
	OKPO VARCHAR2(10), 
	DAT1 DATE, 
	DAT2 DATE, 
	FREQ NUMBER, 
	DAT0 DATE, 
	WEND NUMBER(*,0), 
	STMP DATE, 
	IDD NUMBER(*,0), 
	ORD NUMBER(38,0), 
	KF VARCHAR2(6), 
	DR VARCHAR2(9), 
	BRANCH VARCHAR2(30), 
	ACTION NUMBER(1,0), 
	IDUPD NUMBER, 
	WHEN TIMESTAMP (6), 
	USERID NUMBER, 
	USERID_MADE NUMBER, 
	BRANCH_MADE VARCHAR2(30), 
	DATETIMESTAMP TIMESTAMP (6), 
	BRANCH_CARD VARCHAR2(30), 
	STATUS_ID NUMBER(*,0), 
	DISCLAIM_ID NUMBER(*,0), 
	STATUS_DATE DATE, 
	STATUS_UID NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to STO_DET_UPDATE ***
 exec bpa.alter_policies('STO_DET_UPDATE');


COMMENT ON TABLE BARS.STO_DET_UPDATE IS '';
COMMENT ON COLUMN BARS.STO_DET_UPDATE.IDS IS 'Код схеми';
COMMENT ON COLUMN BARS.STO_DET_UPDATE.VOB IS 'Вид документа';
COMMENT ON COLUMN BARS.STO_DET_UPDATE.DK IS 'Ознака Д/К';
COMMENT ON COLUMN BARS.STO_DET_UPDATE.TT IS 'Код операцiї';
COMMENT ON COLUMN BARS.STO_DET_UPDATE.NLSA IS 'Рахунок вiдправника';
COMMENT ON COLUMN BARS.STO_DET_UPDATE.KVA IS 'Валюта вiдправника';
COMMENT ON COLUMN BARS.STO_DET_UPDATE.NLSB IS 'Рахуноак отримувача';
COMMENT ON COLUMN BARS.STO_DET_UPDATE.KVB IS 'Валюта отримувача';
COMMENT ON COLUMN BARS.STO_DET_UPDATE.MFOB IS 'Банк отримувача';
COMMENT ON COLUMN BARS.STO_DET_UPDATE.POLU IS 'Назва отримувача';
COMMENT ON COLUMN BARS.STO_DET_UPDATE.NAZN IS 'Призначення платежу';
COMMENT ON COLUMN BARS.STO_DET_UPDATE.FSUM IS 'Формула суми';
COMMENT ON COLUMN BARS.STO_DET_UPDATE.OKPO IS 'ОКПО отримувача';
COMMENT ON COLUMN BARS.STO_DET_UPDATE.DAT1 IS 'Дата "С" ';
COMMENT ON COLUMN BARS.STO_DET_UPDATE.DAT2 IS 'Дата "По" ';
COMMENT ON COLUMN BARS.STO_DET_UPDATE.FREQ IS 'Периодичность';
COMMENT ON COLUMN BARS.STO_DET_UPDATE.DAT0 IS 'Дата пред.платежа';
COMMENT ON COLUMN BARS.STO_DET_UPDATE.WEND IS 'Вых.день(-1 или +1)';
COMMENT ON COLUMN BARS.STO_DET_UPDATE.STMP IS '';
COMMENT ON COLUMN BARS.STO_DET_UPDATE.IDD IS '';
COMMENT ON COLUMN BARS.STO_DET_UPDATE.ORD IS 'Порядок виконання';
COMMENT ON COLUMN BARS.STO_DET_UPDATE.KF IS '';
COMMENT ON COLUMN BARS.STO_DET_UPDATE.DR IS '';
COMMENT ON COLUMN BARS.STO_DET_UPDATE.BRANCH IS 'Бранч для бюджета';
COMMENT ON COLUMN BARS.STO_DET_UPDATE.ACTION IS '';
COMMENT ON COLUMN BARS.STO_DET_UPDATE.IDUPD IS '';
COMMENT ON COLUMN BARS.STO_DET_UPDATE.WHEN IS '';
COMMENT ON COLUMN BARS.STO_DET_UPDATE.USERID IS 'Номер користувача, що створив рег.плат';
COMMENT ON COLUMN BARS.STO_DET_UPDATE.USERID_MADE IS '';
COMMENT ON COLUMN BARS.STO_DET_UPDATE.BRANCH_MADE IS 'Відділення, де створено рег.плат';
COMMENT ON COLUMN BARS.STO_DET_UPDATE.DATETIMESTAMP IS 'Дата та час створення';
COMMENT ON COLUMN BARS.STO_DET_UPDATE.BRANCH_CARD IS 'Відділення карткового рахунку';
COMMENT ON COLUMN BARS.STO_DET_UPDATE.STATUS_ID IS 'Статус рег.плат';
COMMENT ON COLUMN BARS.STO_DET_UPDATE.DISCLAIM_ID IS 'Ідентифікатор відмови (0 - пітдверджено)';
COMMENT ON COLUMN BARS.STO_DET_UPDATE.STATUS_DATE IS 'Дата та час обробки в бек-офісі';
COMMENT ON COLUMN BARS.STO_DET_UPDATE.STATUS_UID IS 'Користувач, що обробив запит в бек-офісі';




PROMPT *** Create  constraint SYS_C006200 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_DET_UPDATE MODIFY (IDS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006201 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_DET_UPDATE MODIFY (MFOB NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006202 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_DET_UPDATE MODIFY (POLU NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006203 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_DET_UPDATE MODIFY (NAZN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006204 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_DET_UPDATE MODIFY (OKPO NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006205 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_DET_UPDATE MODIFY (DAT1 NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006206 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_DET_UPDATE MODIFY (DAT2 NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006207 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_DET_UPDATE MODIFY (FREQ NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006208 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_DET_UPDATE MODIFY (WEND NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006209 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_DET_UPDATE MODIFY (IDD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  STO_DET_UPDATE ***
grant SELECT                                                                 on STO_DET_UPDATE  to BARSREADER_ROLE;
grant SELECT                                                                 on STO_DET_UPDATE  to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on STO_DET_UPDATE  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on STO_DET_UPDATE  to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on STO_DET_UPDATE  to STO;
grant SELECT                                                                 on STO_DET_UPDATE  to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on STO_DET_UPDATE  to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/STO_DET_UPDATE.sql =========*** End **
PROMPT ===================================================================================== 
