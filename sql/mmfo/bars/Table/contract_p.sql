

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CONTRACT_P.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CONTRACT_P ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CONTRACT_P'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CONTRACT_P'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CONTRACT_P'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CONTRACT_P ***
begin 
  execute immediate '
  CREATE TABLE BARS.CONTRACT_P 
   (	IDP NUMBER, 
	REF NUMBER, 
	PID NUMBER, 
	ID NUMBER, 
	FDAT DATE, 
	KV NUMBER, 
	S NUMBER, 
	KURS NUMBER(30,8), 
	KOMISS NUMBER, 
	ACC NUMBER, 
	RNK NUMBER, 
	IMPEXP NUMBER, 
	DETAILS VARCHAR2(160), 
	ID_PARENT NUMBER, 
	DAT91 DATE, 
	DAT DATE, 
	PR_F36 NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CONTRACT_P ***
 exec bpa.alter_policies('CONTRACT_P');


COMMENT ON TABLE BARS.CONTRACT_P IS 'Платежи по Эксп-Имп.контрактам';
COMMENT ON COLUMN BARS.CONTRACT_P.IDP IS 'Идентификатор платежа';
COMMENT ON COLUMN BARS.CONTRACT_P.REF IS 'Референс документа';
COMMENT ON COLUMN BARS.CONTRACT_P.PID IS 'Код контракта';
COMMENT ON COLUMN BARS.CONTRACT_P.ID IS 'Код субконтракта';
COMMENT ON COLUMN BARS.CONTRACT_P.FDAT IS 'Дата платежа (не обязат. OPER.VDAT!!!)';
COMMENT ON COLUMN BARS.CONTRACT_P.KV IS 'Валюта платежа';
COMMENT ON COLUMN BARS.CONTRACT_P.S IS 'Сумма платежа  (не обязат. OPER.S!!!)';
COMMENT ON COLUMN BARS.CONTRACT_P.KURS IS 'Курс платежа';
COMMENT ON COLUMN BARS.CONTRACT_P.KOMISS IS 'Сумма комиссии (для экспорта)';
COMMENT ON COLUMN BARS.CONTRACT_P.ACC IS 'Внутр.№ клиента';
COMMENT ON COLUMN BARS.CONTRACT_P.RNK IS 'Рег.№ клиента';
COMMENT ON COLUMN BARS.CONTRACT_P.IMPEXP IS 'Тип контракта (0 - экспорт, 1 - импорт)';
COMMENT ON COLUMN BARS.CONTRACT_P.DETAILS IS 'Подробности платежа';
COMMENT ON COLUMN BARS.CONTRACT_P.ID_PARENT IS 'Код родит.платежа';
COMMENT ON COLUMN BARS.CONTRACT_P.DAT91 IS '';
COMMENT ON COLUMN BARS.CONTRACT_P.DAT IS 'Дата ввода платежа';
COMMENT ON COLUMN BARS.CONTRACT_P.PR_F36 IS '';




PROMPT *** Create  constraint PK_CONTRACTP ***
begin   
 execute immediate '
  ALTER TABLE BARS.CONTRACT_P ADD CONSTRAINT PK_CONTRACTP PRIMARY KEY (IDP)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_CONTRACT_P_IDP ***
begin   
 execute immediate '
  ALTER TABLE BARS.CONTRACT_P MODIFY (IDP CONSTRAINT NK_CONTRACT_P_IDP NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CONTRACTP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CONTRACTP ON BARS.CONTRACT_P (IDP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CONTRACT_P ***
grant SELECT                                                                 on CONTRACT_P      to BARSREADER_ROLE;
grant SELECT                                                                 on CONTRACT_P      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CONTRACT_P      to BARS_DM;
grant SELECT                                                                 on CONTRACT_P      to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CONTRACT_P      to WR_ALL_RIGHTS;
grant SELECT                                                                 on CONTRACT_P      to ZAY;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CONTRACT_P.sql =========*** End *** ==
PROMPT ===================================================================================== 
