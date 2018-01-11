

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_F00$GLOBAL.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_F00$GLOBAL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_F00$GLOBAL'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_F00$GLOBAL'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_F00$GLOBAL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_F00$GLOBAL ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_F00$GLOBAL 
   (	KODF CHAR(2), 
	AA CHAR(2), 
	A017 CHAR(1), 
	NN CHAR(2), 
	PERIOD CHAR(1), 
	PROCC VARCHAR2(5), 
	R CHAR(1), 
	SEMANTIC VARCHAR2(70), 
	RECID NUMBER(38,0), 
	KODF_EXT VARCHAR2(2), 
	F_PREF VARCHAR2(3), 
	PR_TOBO NUMBER(1,0), 
	TYPE_ZNAP VARCHAR2(1) DEFAULT ''C'', 
	PROCK NUMBER, 
	ID NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KL_F00$GLOBAL ***
 exec bpa.alter_policies('KL_F00$GLOBAL');


COMMENT ON TABLE BARS.KL_F00$GLOBAL IS 'Каталог отчетов для НБУ';
COMMENT ON COLUMN BARS.KL_F00$GLOBAL.ID IS '';
COMMENT ON COLUMN BARS.KL_F00$GLOBAL.KODF IS 'Код формы отчета';
COMMENT ON COLUMN BARS.KL_F00$GLOBAL.AA IS 'Номер схемы предоставления';
COMMENT ON COLUMN BARS.KL_F00$GLOBAL.A017 IS 'Код схемы предоставления';
COMMENT ON COLUMN BARS.KL_F00$GLOBAL.NN IS 'Код едениц отчетности';
COMMENT ON COLUMN BARS.KL_F00$GLOBAL.PERIOD IS 'Периодичность выдачи 
D - день 
M - месяц 
Y - год 
Q - квартал 
W - неделя 
5 - пятидневка';
COMMENT ON COLUMN BARS.KL_F00$GLOBAL.PROCC IS 'Код процедуры';
COMMENT ON COLUMN BARS.KL_F00$GLOBAL.R IS 'Резидентность  банка';
COMMENT ON COLUMN BARS.KL_F00$GLOBAL.SEMANTIC IS 'Наименование формы';
COMMENT ON COLUMN BARS.KL_F00$GLOBAL.RECID IS '';
COMMENT ON COLUMN BARS.KL_F00$GLOBAL.KODF_EXT IS 'Альтернативный код формы отчета';
COMMENT ON COLUMN BARS.KL_F00$GLOBAL.F_PREF IS 'Префикс для названия текстового файла';
COMMENT ON COLUMN BARS.KL_F00$GLOBAL.PR_TOBO IS '0=код области из каталога отчетов для НБУ, 1='KODOBL' из branch_params_values, 2=B040 из STAFF';
COMMENT ON COLUMN BARS.KL_F00$GLOBAL.TYPE_ZNAP IS 'Тип значения в поле ZNAP в таблице TMP_NBU';
COMMENT ON COLUMN BARS.KL_F00$GLOBAL.PROCK IS 'Код процедуры контроля';




PROMPT *** Create  constraint CC_KLF_PRTOBO ***
begin   
 execute immediate '
  ALTER TABLE BARS.KL_F00$GLOBAL ADD CONSTRAINT CC_KLF_PRTOBO CHECK (pr_tobo in (0,1,2,3,4,5,6,7,8)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KLF_PERIOD ***
begin   
 execute immediate '
  ALTER TABLE BARS.KL_F00$GLOBAL ADD CONSTRAINT CC_KLF_PERIOD CHECK (period in (''D'', ''M'', ''Y'', ''Q'', ''W'', ''5'', ''T'', ''P'', ''H'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_KLF ***
begin   
 execute immediate '
  ALTER TABLE BARS.KL_F00$GLOBAL ADD CONSTRAINT PK_KLF PRIMARY KEY (KODF, A017)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_KLF ***
begin   
 execute immediate '
  ALTER TABLE BARS.KL_F00$GLOBAL ADD CONSTRAINT UK_KLF UNIQUE (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KLF_KODF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KL_F00$GLOBAL MODIFY (KODF CONSTRAINT CC_KLF_KODF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KLF_AA_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KL_F00$GLOBAL MODIFY (AA CONSTRAINT CC_KLF_AA_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KLF_A017_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KL_F00$GLOBAL MODIFY (A017 CONSTRAINT CC_KLF_A017_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KLF_PROCC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KL_F00$GLOBAL MODIFY (PROCC CONSTRAINT CC_KLF_PROCC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KLF_SEMANTIC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KL_F00$GLOBAL MODIFY (SEMANTIC CONSTRAINT CC_KLF_SEMANTIC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_KLF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_KLF ON BARS.KL_F00$GLOBAL (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_KLF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_KLF ON BARS.KL_F00$GLOBAL (KODF, A017) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KL_F00$GLOBAL ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_F00$GLOBAL   to ABS_ADMIN;
grant SELECT                                                                 on KL_F00$GLOBAL   to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KL_F00$GLOBAL   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KL_F00$GLOBAL   to BARS_DM;
grant SELECT,UPDATE                                                          on KL_F00$GLOBAL   to RPBN002;
grant SELECT                                                                 on KL_F00$GLOBAL   to START1;
grant SELECT                                                                 on KL_F00$GLOBAL   to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KL_F00$GLOBAL   to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on KL_F00$GLOBAL   to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_F00$GLOBAL.sql =========*** End ***
PROMPT ===================================================================================== 
