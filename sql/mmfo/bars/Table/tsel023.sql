

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TSEL023.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TSEL023 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TSEL023'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TSEL023'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TSEL023 ***
begin 
  execute immediate '
  CREATE TABLE BARS.TSEL023 
   (	NLSA VARCHAR2(15), 
	KVA NUMBER(3,0), 
	MFOB VARCHAR2(12), 
	NLSB VARCHAR2(14), 
	KVB NUMBER(3,0), 
	TT CHAR(3), 
	VOB NUMBER(3,0), 
	ND VARCHAR2(10), 
	DATD DATE, 
	S NUMBER, 
	NAM_A VARCHAR2(70), 
	NAM_B VARCHAR2(38), 
	NAZN VARCHAR2(160), 
	OKPOA VARCHAR2(8), 
	OKPOB VARCHAR2(14), 
	GRP NUMBER(38,0), 
	REF NUMBER(38,0), 
	SOS NUMBER(1,0), 
	ID NUMBER(38,0), 
	DK NUMBER(1,0), 
	S2 NUMBER, 
	DREC VARCHAR2(60), 
	TABN VARCHAR2(10), 
	US_ID NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TSEL023 ***
 exec bpa.alter_policies('TSEL023');


COMMENT ON TABLE BARS.TSEL023 IS 'Таблиця для даних перекриття';
COMMENT ON COLUMN BARS.TSEL023.NLSA IS 'Рахунок А';
COMMENT ON COLUMN BARS.TSEL023.KVA IS 'Валюта А';
COMMENT ON COLUMN BARS.TSEL023.MFOB IS 'МФО Б';
COMMENT ON COLUMN BARS.TSEL023.NLSB IS 'Рахунок Б';
COMMENT ON COLUMN BARS.TSEL023.KVB IS 'Валюта Б';
COMMENT ON COLUMN BARS.TSEL023.TT IS 'Код операції';
COMMENT ON COLUMN BARS.TSEL023.VOB IS 'Вид операції';
COMMENT ON COLUMN BARS.TSEL023.ND IS 'ND';
COMMENT ON COLUMN BARS.TSEL023.DATD IS 'Дата документу';
COMMENT ON COLUMN BARS.TSEL023.S IS 'Сума документу';
COMMENT ON COLUMN BARS.TSEL023.NAM_A IS 'Платник';
COMMENT ON COLUMN BARS.TSEL023.NAM_B IS 'Отримувач';
COMMENT ON COLUMN BARS.TSEL023.NAZN IS 'Призначення';
COMMENT ON COLUMN BARS.TSEL023.OKPOA IS 'ОКПО А';
COMMENT ON COLUMN BARS.TSEL023.OKPOB IS 'ОКПО Б';
COMMENT ON COLUMN BARS.TSEL023.GRP IS 'Група перекриття';
COMMENT ON COLUMN BARS.TSEL023.REF IS 'Референс документу';
COMMENT ON COLUMN BARS.TSEL023.SOS IS 'Стан документу';
COMMENT ON COLUMN BARS.TSEL023.ID IS 'ID';
COMMENT ON COLUMN BARS.TSEL023.DK IS 'ДК';
COMMENT ON COLUMN BARS.TSEL023.S2 IS 'Сума документу';
COMMENT ON COLUMN BARS.TSEL023.DREC IS 'Додаткові реквізити';
COMMENT ON COLUMN BARS.TSEL023.TABN IS 'TABN';
COMMENT ON COLUMN BARS.TSEL023.US_ID IS '';




PROMPT *** Create  constraint CC_TSEL023_NAM_A ***
begin   
 execute immediate '
  ALTER TABLE BARS.TSEL023 MODIFY (NAM_A CONSTRAINT CC_TSEL023_NAM_A NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TSEL023_REF ***
begin   
 execute immediate '
  ALTER TABLE BARS.TSEL023 MODIFY (REF CONSTRAINT CC_TSEL023_REF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TSEL023_KVB ***
begin   
 execute immediate '
  ALTER TABLE BARS.TSEL023 MODIFY (KVB CONSTRAINT CC_TSEL023_KVB NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TSEL023_NLSA ***
begin   
 execute immediate '
  ALTER TABLE BARS.TSEL023 MODIFY (NLSA CONSTRAINT CC_TSEL023_NLSA NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TSEL023_KVA ***
begin   
 execute immediate '
  ALTER TABLE BARS.TSEL023 MODIFY (KVA CONSTRAINT CC_TSEL023_KVA NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TSEL023_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.TSEL023 MODIFY (ID CONSTRAINT CC_TSEL023_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TSEL023 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TSEL023         to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TSEL023         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TSEL023.sql =========*** End *** =====
PROMPT ===================================================================================== 
