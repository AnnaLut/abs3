

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/LINES_K.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to LINES_K ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''LINES_K'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''LINES_K'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''LINES_K'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table LINES_K ***
begin 
  execute immediate '
  CREATE TABLE BARS.LINES_K 
   (	FN VARCHAR2(30), 
	DAT DATE, 
	N NUMBER, 
	MFO VARCHAR2(40), 
	OKPO VARCHAR2(14), 
	OTYPE NUMBER(1,0), 
	ODATE DATE, 
	NLS VARCHAR2(40), 
	KV NUMBER(3,0), 
	RESID NUMBER(1,0), 
	NMKK VARCHAR2(70), 
	COUNTRY NUMBER(3,0), 
	C_REG NUMBER(2,0), 
	C_DST NUMBER(2,0), 
	ID_O VARCHAR2(6), 
	SIGN RAW(64), 
	ERR VARCHAR2(4), 
	FN_R VARCHAR2(30), 
	DATE_R DATE, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to LINES_K ***
 exec bpa.alter_policies('LINES_K');


COMMENT ON TABLE BARS.LINES_K IS 'Детальные строки файла @K';
COMMENT ON COLUMN BARS.LINES_K.FN IS 'Имя файла @K';
COMMENT ON COLUMN BARS.LINES_K.DAT IS 'Дата формирования файла';
COMMENT ON COLUMN BARS.LINES_K.N IS '№ строки в файле';
COMMENT ON COLUMN BARS.LINES_K.MFO IS 'МФО банка, в кот. ведется счет';
COMMENT ON COLUMN BARS.LINES_K.OKPO IS 'ОКПО банка-владельца счета (наше ОКПО)';
COMMENT ON COLUMN BARS.LINES_K.OTYPE IS 'Тип операции (1-откр./3-закпр.)';
COMMENT ON COLUMN BARS.LINES_K.ODATE IS 'Дата операции';
COMMENT ON COLUMN BARS.LINES_K.NLS IS '№ счета';
COMMENT ON COLUMN BARS.LINES_K.KV IS 'Валюта счета';
COMMENT ON COLUMN BARS.LINES_K.RESID IS 'Резидентность банка, в кот. ведется счет';
COMMENT ON COLUMN BARS.LINES_K.NMKK IS 'Наименование банка-корреспондента';
COMMENT ON COLUMN BARS.LINES_K.COUNTRY IS 'Код страны банка-нерезидента';
COMMENT ON COLUMN BARS.LINES_K.C_REG IS 'Номер ДПА, в кот. зарег. банк-владелец счета (наш)';
COMMENT ON COLUMN BARS.LINES_K.C_DST IS '';
COMMENT ON COLUMN BARS.LINES_K.ID_O IS 'Код операциониста';
COMMENT ON COLUMN BARS.LINES_K.SIGN IS 'Подпись';
COMMENT ON COLUMN BARS.LINES_K.ERR IS 'Код ошибки';
COMMENT ON COLUMN BARS.LINES_K.FN_R IS 'Имя файла-квитанции @IF';
COMMENT ON COLUMN BARS.LINES_K.DATE_R IS 'Дата файла-квитанции @IF';
COMMENT ON COLUMN BARS.LINES_K.KF IS '';




PROMPT *** Create  constraint XPK_LINES_K ***
begin   
 execute immediate '
  ALTER TABLE BARS.LINES_K ADD CONSTRAINT XPK_LINES_K PRIMARY KEY (FN, DAT, N)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_LINES_ZAG_K ***
begin   
 execute immediate '
  ALTER TABLE BARS.LINES_K ADD CONSTRAINT R_LINES_ZAG_K FOREIGN KEY (FN, DAT)
	  REFERENCES BARS.ZAG_F (FN, DAT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_LINESK_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.LINES_K ADD CONSTRAINT FK_LINESK_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_LINES_K_FN ***
begin   
 execute immediate '
  ALTER TABLE BARS.LINES_K MODIFY (FN CONSTRAINT NK_LINES_K_FN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_LINES_K_DAT ***
begin   
 execute immediate '
  ALTER TABLE BARS.LINES_K MODIFY (DAT CONSTRAINT NK_LINES_K_DAT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_LINES_K_N ***
begin   
 execute immediate '
  ALTER TABLE BARS.LINES_K MODIFY (N CONSTRAINT NK_LINES_K_N NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_LINESK_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.LINES_K MODIFY (KF CONSTRAINT CC_LINESK_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_LINES_K ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_LINES_K ON BARS.LINES_K (FN, DAT, N) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  LINES_K ***
grant DELETE,INSERT,SELECT,UPDATE                                            on LINES_K         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on LINES_K         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on LINES_K         to RPBN002;



PROMPT *** Create SYNONYM  to LINES_K ***

  CREATE OR REPLACE PUBLIC SYNONYM LINES_K FOR BARS.LINES_K;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/LINES_K.sql =========*** End *** =====
PROMPT ===================================================================================== 
