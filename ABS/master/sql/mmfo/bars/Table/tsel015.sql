

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TSEL015.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TSEL015 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TSEL015'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TSEL015'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TSEL015 ***
begin 
  execute immediate '
  CREATE TABLE BARS.TSEL015 
   (	NLSA VARCHAR2(15), 
	KVA NUMBER(3,0), 
	MFOB VARCHAR2(12), 
	NLSB VARCHAR2(14), 
	KVB NUMBER(3,0), 
	TT CHAR(3), 
	VOB NUMBER(38,0), 
	SUMA_SPS NUMBER, 
	KOEF NUMBER, 
	NMK VARCHAR2(38), 
	NMS VARCHAR2(38), 
	NMKB VARCHAR2(70), 
	NAZN VARCHAR2(160), 
	ACC NUMBER(38,0), 
	OKPOA VARCHAR2(14), 
	OKPOB VARCHAR2(14), 
	IDR NUMBER(38,0), 
	DIG NUMBER(10,0), 
	SPS NUMBER(38,0), 
	DK NUMBER(1,0), 
	SUMA NUMBER, 
	KOD NUMBER(1,0), 
	FORMULA VARCHAR2(255), 
	ID NUMBER(38,0), 
	MFOA VARCHAR2(6), 
	U_ID NUMBER(38,0), 
	US_ID NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TSEL015 ***
 exec bpa.alter_policies('TSEL015');


COMMENT ON TABLE BARS.TSEL015 IS 'Таблиця для даних перекриття';
COMMENT ON COLUMN BARS.TSEL015.NLSA IS 'Рахунок А';
COMMENT ON COLUMN BARS.TSEL015.KVA IS 'Валюта А';
COMMENT ON COLUMN BARS.TSEL015.MFOB IS 'МФО Б';
COMMENT ON COLUMN BARS.TSEL015.NLSB IS 'Рахунок Б';
COMMENT ON COLUMN BARS.TSEL015.KVB IS 'Валюта Б';
COMMENT ON COLUMN BARS.TSEL015.TT IS 'Код операції';
COMMENT ON COLUMN BARS.TSEL015.VOB IS 'Вид документа';
COMMENT ON COLUMN BARS.TSEL015.SUMA_SPS IS 'Сума';
COMMENT ON COLUMN BARS.TSEL015.KOEF IS 'Коефіцієнт';
COMMENT ON COLUMN BARS.TSEL015.NMK IS 'Платник';
COMMENT ON COLUMN BARS.TSEL015.NMS IS 'Назва рахунку';
COMMENT ON COLUMN BARS.TSEL015.NMKB IS 'Отримувач';
COMMENT ON COLUMN BARS.TSEL015.NAZN IS 'Призначення';
COMMENT ON COLUMN BARS.TSEL015.ACC IS '';
COMMENT ON COLUMN BARS.TSEL015.OKPOA IS 'ОКПО А';
COMMENT ON COLUMN BARS.TSEL015.OKPOB IS 'ОКПО Б';
COMMENT ON COLUMN BARS.TSEL015.IDR IS '';
COMMENT ON COLUMN BARS.TSEL015.DIG IS '';
COMMENT ON COLUMN BARS.TSEL015.SPS IS '';
COMMENT ON COLUMN BARS.TSEL015.DK IS 'Д/К';
COMMENT ON COLUMN BARS.TSEL015.SUMA IS 'Сума документу';
COMMENT ON COLUMN BARS.TSEL015.KOD IS 'KOD';
COMMENT ON COLUMN BARS.TSEL015.FORMULA IS 'Формула';
COMMENT ON COLUMN BARS.TSEL015.ID IS 'ID';
COMMENT ON COLUMN BARS.TSEL015.MFOA IS 'МФОА';
COMMENT ON COLUMN BARS.TSEL015.U_ID IS 'Порядковий номер';
COMMENT ON COLUMN BARS.TSEL015.US_ID IS 'ID Користувача';




PROMPT *** Create  constraint CC_TSEL015_NLSA ***
begin   
 execute immediate '
  ALTER TABLE BARS.TSEL015 MODIFY (NLSA CONSTRAINT CC_TSEL015_NLSA NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TSEL015_KVA ***
begin   
 execute immediate '
  ALTER TABLE BARS.TSEL015 MODIFY (KVA CONSTRAINT CC_TSEL015_KVA NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TSEL015_MFOB ***
begin   
 execute immediate '
  ALTER TABLE BARS.TSEL015 MODIFY (MFOB CONSTRAINT CC_TSEL015_MFOB NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TSEL015_NLSB ***
begin   
 execute immediate '
  ALTER TABLE BARS.TSEL015 MODIFY (KVB CONSTRAINT CC_TSEL015_NLSB NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TSEL015_TT ***
begin   
 execute immediate '
  ALTER TABLE BARS.TSEL015 MODIFY (TT CONSTRAINT CC_TSEL015_TT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TSEL015_VOB ***
begin   
 execute immediate '
  ALTER TABLE BARS.TSEL015 MODIFY (VOB CONSTRAINT CC_TSEL015_VOB NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TSEL015_NAZN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TSEL015 MODIFY (NAZN CONSTRAINT CC_TSEL015_NAZN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TSEL015_ACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.TSEL015 MODIFY (ACC CONSTRAINT CC_TSEL015_ACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TSEL015_IDR ***
begin   
 execute immediate '
  ALTER TABLE BARS.TSEL015 MODIFY (IDR CONSTRAINT CC_TSEL015_IDR NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TSEL015_DIG ***
begin   
 execute immediate '
  ALTER TABLE BARS.TSEL015 MODIFY (DIG CONSTRAINT CC_TSEL015_DIG NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TSEL015 ***
grant SELECT                                                                 on TSEL015         to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TSEL015         to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TSEL015         to START1;
grant SELECT                                                                 on TSEL015         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TSEL015.sql =========*** End *** =====
PROMPT ===================================================================================== 
