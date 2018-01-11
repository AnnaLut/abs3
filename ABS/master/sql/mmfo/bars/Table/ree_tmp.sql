

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/REE_TMP.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to REE_TMP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''REE_TMP'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''REE_TMP'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''REE_TMP'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table REE_TMP ***
begin 
  execute immediate '
  CREATE TABLE BARS.REE_TMP 
   (	MFO VARCHAR2(12), 
	ID_A VARCHAR2(14), 
	RT CHAR(1), 
	OT CHAR(1), 
	ODAT DATE DEFAULT TRUNC(SYSDATE), 
	NLS VARCHAR2(15), 
	PRZ CHAR(1), 
	KV NUMBER(38,0), 
	C_AG CHAR(1), 
	NMK VARCHAR2(38), 
	NMKW VARCHAR2(38), 
	C_REG NUMBER(38,0), 
	C_DST NUMBER(38,0), 
	ID_O VARCHAR2(6), 
	SIGN RAW(128), 
	FN_I VARCHAR2(12), 
	DAT_I DATE, 
	REC_I NUMBER(38,0), 
	FN_O VARCHAR2(30), 
	DAT_O DATE, 
	REC_O NUMBER(38,0), 
	ERRK NUMBER(38,0), 
	REC NUMBER(38,0), 
	OTM NUMBER(38,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to REE_TMP ***
 exec bpa.alter_policies('REE_TMP');


COMMENT ON TABLE BARS.REE_TMP IS 'Счета для отправки в ДПА (@F)';
COMMENT ON COLUMN BARS.REE_TMP.KF IS '';
COMMENT ON COLUMN BARS.REE_TMP.ODAT IS 'Дата операции';
COMMENT ON COLUMN BARS.REE_TMP.NLS IS 'Счет';
COMMENT ON COLUMN BARS.REE_TMP.PRZ IS 'Не исп.';
COMMENT ON COLUMN BARS.REE_TMP.KV IS 'Валюта';
COMMENT ON COLUMN BARS.REE_TMP.C_AG IS 'Резидентность';
COMMENT ON COLUMN BARS.REE_TMP.NMK IS 'Наименование клиента';
COMMENT ON COLUMN BARS.REE_TMP.NMKW IS 'Наименование клиента краткое';
COMMENT ON COLUMN BARS.REE_TMP.C_REG IS 'Код ДПА';
COMMENT ON COLUMN BARS.REE_TMP.C_DST IS 'Код органа регистрации';
COMMENT ON COLUMN BARS.REE_TMP.ID_O IS 'Не исп.';
COMMENT ON COLUMN BARS.REE_TMP.SIGN IS 'Не исп.';
COMMENT ON COLUMN BARS.REE_TMP.FN_I IS 'Не исп.';
COMMENT ON COLUMN BARS.REE_TMP.DAT_I IS 'Не исп.';
COMMENT ON COLUMN BARS.REE_TMP.REC_I IS 'Не исп.';
COMMENT ON COLUMN BARS.REE_TMP.FN_O IS 'Имя файла @F';
COMMENT ON COLUMN BARS.REE_TMP.DAT_O IS 'Дата файла @F';
COMMENT ON COLUMN BARS.REE_TMP.REC_O IS 'Номер строки в файле @F';
COMMENT ON COLUMN BARS.REE_TMP.ERRK IS 'Код ошибки';
COMMENT ON COLUMN BARS.REE_TMP.REC IS 'Не исп.';
COMMENT ON COLUMN BARS.REE_TMP.OTM IS 'Статус обработки';
COMMENT ON COLUMN BARS.REE_TMP.MFO IS 'МФО';
COMMENT ON COLUMN BARS.REE_TMP.ID_A IS 'ОКПО';
COMMENT ON COLUMN BARS.REE_TMP.RT IS 'Тип госреестра';
COMMENT ON COLUMN BARS.REE_TMP.OT IS 'Тип операции';




PROMPT *** Create  constraint CC_REETMP_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.REE_TMP MODIFY (KF CONSTRAINT CC_REETMP_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_REETMP ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_REETMP ON BARS.REE_TMP (NLS, KV) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  REE_TMP ***
grant SELECT                                                                 on REE_TMP         to BARSREADER_ROLE;
grant DELETE,SELECT,UPDATE                                                   on REE_TMP         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on REE_TMP         to BARS_DM;
grant UPDATE                                                                 on REE_TMP         to RPBN001;
grant DELETE,SELECT,UPDATE                                                   on REE_TMP         to RPBN002;
grant SELECT                                                                 on REE_TMP         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on REE_TMP         to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to REE_TMP ***

  CREATE OR REPLACE PUBLIC SYNONYM REE_TMP FOR BARS.REE_TMP;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/REE_TMP.sql =========*** End *** =====
PROMPT ===================================================================================== 
