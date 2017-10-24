

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ZAG_PF.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ZAG_PF ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ZAG_PF'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''ZAG_PF'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''ZAG_PF'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ZAG_PF ***
begin 
  execute immediate '
  CREATE TABLE BARS.ZAG_PF 
   (	FN CHAR(12), 
	DAT DATE, 
	N NUMBER, 
	SDE NUMBER(24,0), 
	SKR NUMBER(24,0), 
	DATK DATE, 
	SIGN_KEY CHAR(6), 
	SIGN RAW(128), 
	OTM NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ZAG_PF ***
 exec bpa.alter_policies('ZAG_PF');


COMMENT ON TABLE BARS.ZAG_PF IS 'Заголовки файлов PF';
COMMENT ON COLUMN BARS.ZAG_PF.FN IS 'Имя файла PF';
COMMENT ON COLUMN BARS.ZAG_PF.DAT IS 'Дата/время создания файла PF';
COMMENT ON COLUMN BARS.ZAG_PF.N IS 'Число информационных строк в файле';
COMMENT ON COLUMN BARS.ZAG_PF.SDE IS 'Сумма дебета';
COMMENT ON COLUMN BARS.ZAG_PF.SKR IS 'Сумма кредита';
COMMENT ON COLUMN BARS.ZAG_PF.DATK IS 'Дата квитовки';
COMMENT ON COLUMN BARS.ZAG_PF.SIGN_KEY IS 'ID ключа подписи';
COMMENT ON COLUMN BARS.ZAG_PF.SIGN IS 'подпись на файл PF';
COMMENT ON COLUMN BARS.ZAG_PF.OTM IS 'Отметка состояния файла(сформ. сквитован...)';
COMMENT ON COLUMN BARS.ZAG_PF.KF IS '';




PROMPT *** Create  constraint PK_ZAGPF ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAG_PF ADD CONSTRAINT PK_ZAGPF PRIMARY KEY (KF, FN, DAT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ZAGPF_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAG_PF ADD CONSTRAINT FK_ZAGPF_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007974 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAG_PF MODIFY (FN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007975 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAG_PF MODIFY (DAT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007976 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAG_PF MODIFY (SDE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007977 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAG_PF MODIFY (SKR NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZAGPF_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAG_PF MODIFY (KF CONSTRAINT CC_ZAGPF_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_ZAG_PF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_ZAG_PF ON BARS.ZAG_PF (FN, DAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ZAGPF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ZAGPF ON BARS.ZAG_PF (KF, FN, DAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ZAG_PF ***
grant INSERT,SELECT,UPDATE                                                   on ZAG_PF          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ZAG_PF          to BARS_DM;
grant INSERT,SELECT,UPDATE                                                   on ZAG_PF          to DEB_REG;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ZAG_PF.sql =========*** End *** ======
PROMPT ===================================================================================== 
