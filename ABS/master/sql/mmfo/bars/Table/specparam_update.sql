

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SPECPARAM_UPDATE.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SPECPARAM_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SPECPARAM_UPDATE'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''SPECPARAM_UPDATE'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''SPECPARAM_UPDATE'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SPECPARAM_UPDATE ***
begin 
  execute immediate 'create table SPECPARAM_UPDATE 
( ACC  NUMBER(38), 
	R011 VARCHAR2(1), 
	R013 VARCHAR2(1), 
	S080 VARCHAR2(1), 
	S180 VARCHAR2(1), 
	S181 VARCHAR2(1), 
	S190 VARCHAR2(1), 
	S200 VARCHAR2(1), 
	S230 VARCHAR2(3), 
	S240 VARCHAR2(2), 
	D020 CHAR(2), 
	FDAT DATE, 
	USER_NAME VARCHAR2(30), 
	IDUPD NUMBER(38,0), 
	KF    VARCHAR2(6) DEFAULT NULL, 
	S260 VARCHAR2(2), 
	S270 VARCHAR2(2), 
	R014 VARCHAR2(1), 
	K072 VARCHAR2(1), 
	Z290 VARCHAR2(2), 
	S250 VARCHAR2(1), 
	S090 CHAR(1), 
	NKD VARCHAR2(40), 
	S031 VARCHAR2(2), 
	R114 VARCHAR2(1), 
	S280 VARCHAR2(2), 
	S290 VARCHAR2(2), 
	S370 VARCHAR2(1), 
	EFFECTDATE DATE, 
	R012 VARCHAR2(1), 
	S580 VARCHAR2(1), 
	ISTVAL NUMBER(1,0), 
	CHGACTION CHAR(1), 
	GLOBAL_BDATE DATE, 
	S130 VARCHAR2(2)
) tablespace BRSBIGD';
exception
  when others then
    if sqlcode=-955 then null; else raise; end if;
end; 
/

PROMPT *** ALTER_POLICIES to SPECPARAM_UPDATE ***
exec bpa.alter_policies('SPECPARAM_UPDATE');

COMMENT ON TABLE BARS.SPECPARAM_UPDATE IS 'История обновления спецпараметров счетов';
COMMENT ON COLUMN BARS.SPECPARAM_UPDATE.ACC IS 'Внутренний номер счета';
COMMENT ON COLUMN BARS.SPECPARAM_UPDATE.R011 IS '';
COMMENT ON COLUMN BARS.SPECPARAM_UPDATE.R013 IS '';
COMMENT ON COLUMN BARS.SPECPARAM_UPDATE.S080 IS '';
COMMENT ON COLUMN BARS.SPECPARAM_UPDATE.S180 IS '';
COMMENT ON COLUMN BARS.SPECPARAM_UPDATE.S181 IS '';
COMMENT ON COLUMN BARS.SPECPARAM_UPDATE.S190 IS '';
COMMENT ON COLUMN BARS.SPECPARAM_UPDATE.S200 IS '';
COMMENT ON COLUMN BARS.SPECPARAM_UPDATE.S230 IS 'Символ банка';
COMMENT ON COLUMN BARS.SPECPARAM_UPDATE.S240 IS '';
COMMENT ON COLUMN BARS.SPECPARAM_UPDATE.D020 IS '';
COMMENT ON COLUMN BARS.SPECPARAM_UPDATE.FDAT IS 'Дата';
COMMENT ON COLUMN BARS.SPECPARAM_UPDATE.USER_NAME IS 'Имя пользователя';
COMMENT ON COLUMN BARS.SPECPARAM_UPDATE.IDUPD IS 'Автор модификации';
COMMENT ON COLUMN BARS.SPECPARAM_UPDATE.KF IS '';
COMMENT ON COLUMN BARS.SPECPARAM_UPDATE.S260 IS '';
COMMENT ON COLUMN BARS.SPECPARAM_UPDATE.S270 IS '';
COMMENT ON COLUMN BARS.SPECPARAM_UPDATE.R014 IS '';
COMMENT ON COLUMN BARS.SPECPARAM_UPDATE.K072 IS '';
COMMENT ON COLUMN BARS.SPECPARAM_UPDATE.Z290 IS '';
COMMENT ON COLUMN BARS.SPECPARAM_UPDATE.S250 IS '';
COMMENT ON COLUMN BARS.SPECPARAM_UPDATE.S090 IS '';
COMMENT ON COLUMN BARS.SPECPARAM_UPDATE.NKD IS '';
COMMENT ON COLUMN BARS.SPECPARAM_UPDATE.S031 IS '';
COMMENT ON COLUMN BARS.SPECPARAM_UPDATE.R114 IS '';
COMMENT ON COLUMN BARS.SPECPARAM_UPDATE.S280 IS '';
COMMENT ON COLUMN BARS.SPECPARAM_UPDATE.S290 IS '';
COMMENT ON COLUMN BARS.SPECPARAM_UPDATE.S370 IS '';
COMMENT ON COLUMN BARS.SPECPARAM_UPDATE.EFFECTDATE IS 'банковская дата изменения';
COMMENT ON COLUMN BARS.SPECPARAM_UPDATE.R012 IS '';
COMMENT ON COLUMN BARS.SPECPARAM_UPDATE.S580 IS '';
COMMENT ON COLUMN BARS.SPECPARAM_UPDATE.ISTVAL IS 'Джерело вал.виручки';
COMMENT ON COLUMN BARS.SPECPARAM_UPDATE.CHGACTION IS 'Код оновлення (I/U/D)';
COMMENT ON COLUMN BARS.SPECPARAM_UPDATE.GLOBAL_BDATE IS 'Глобальна банк_вська дата';
COMMENT ON COLUMN BARS.SPECPARAM_UPDATE.S130 IS '';




PROMPT *** Create  constraint PK_SPECPARAMUPD ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPECPARAM_UPDATE ADD CONSTRAINT PK_SPECPARAMUPD PRIMARY KEY (IDUPD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SPECPARAMUPD_ACC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPECPARAM_UPDATE MODIFY (ACC CONSTRAINT CC_SPECPARAMUPD_ACC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SPECPARAMUPD_FDAT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPECPARAM_UPDATE MODIFY (FDAT CONSTRAINT CC_SPECPARAMUPD_FDAT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SPECPARAMUPD_USERNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPECPARAM_UPDATE MODIFY (USER_NAME CONSTRAINT CC_SPECPARAMUPD_USERNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SPECPARAMUPD_IDUPD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPECPARAM_UPDATE MODIFY (IDUPD CONSTRAINT CC_SPECPARAMUPD_IDUPD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009356 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPECPARAM_UPDATE MODIFY (GLOBAL_BDATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_SPECPARAMUPD_GLBDT_EFFDT ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_SPECPARAMUPD_GLBDT_EFFDT ON BARS.SPECPARAM_UPDATE (GLOBAL_BDATE, EFFECTDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XAI_SPECPARAMUPD_EFFDAT ***
begin   
 execute immediate '
  CREATE INDEX BARS.XAI_SPECPARAMUPD_EFFDAT ON BARS.SPECPARAM_UPDATE (EFFECTDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XIE_SPECPARAMUPD_ACC ***
begin   
 execute immediate '
  CREATE INDEX BARS.XIE_SPECPARAMUPD_ACC ON BARS.SPECPARAM_UPDATE (ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SPECPARAMUPD ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SPECPARAMUPD ON BARS.SPECPARAM_UPDATE (IDUPD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SPECPARAM_UPDATE ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SPECPARAM_UPDATE to ABS_ADMIN;
grant SELECT                                                                 on SPECPARAM_UPDATE to BARSREADER_ROLE;
grant SELECT                                                                 on SPECPARAM_UPDATE to BARSUPL;
grant ALTER,DEBUG,DELETE,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on SPECPARAM_UPDATE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SPECPARAM_UPDATE to BARS_DM;
grant ALTER,DEBUG,DELETE,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on SPECPARAM_UPDATE to RCC_DEAL;
grant SELECT                                                                 on SPECPARAM_UPDATE to START1;
grant SELECT                                                                 on SPECPARAM_UPDATE to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SPECPARAM_UPDATE to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SPECPARAM_UPDATE.sql =========*** End 
PROMPT ===================================================================================== 
