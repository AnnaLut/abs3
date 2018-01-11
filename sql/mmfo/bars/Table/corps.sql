

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CORPS.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CORPS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CORPS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CORPS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CORPS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CORPS ***
begin 
  execute immediate '
  CREATE TABLE BARS.CORPS 
   (	RNK NUMBER(38,0), 
	NMKU VARCHAR2(250), 
	RUK VARCHAR2(70), 
	TELR VARCHAR2(20), 
	BUH VARCHAR2(70), 
	TELB VARCHAR2(20), 
	DOV VARCHAR2(35), 
	BDOV DATE, 
	EDOV DATE, 
	NLSNEW VARCHAR2(15), 
	MAINNLS VARCHAR2(15), 
	MAINMFO VARCHAR2(12), 
	MFONEW VARCHAR2(12), 
	TEL_FAX VARCHAR2(20), 
	E_MAIL VARCHAR2(100), 
	SEAL_ID NUMBER(38,0), 
	NMK VARCHAR2(182)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CORPS ***
 exec bpa.alter_policies('CORPS');


COMMENT ON TABLE BARS.CORPS IS 'Клиенты банка - юр.лица';
COMMENT ON COLUMN BARS.CORPS.RNK IS 'Рег №';
COMMENT ON COLUMN BARS.CORPS.NMKU IS 'Наименование по Уставу (полное)';
COMMENT ON COLUMN BARS.CORPS.RUK IS 'Руководитель-ФИО';
COMMENT ON COLUMN BARS.CORPS.TELR IS 'Телефон руководителя';
COMMENT ON COLUMN BARS.CORPS.BUH IS 'Главный бухгалтер';
COMMENT ON COLUMN BARS.CORPS.TELB IS 'Телефон гл.бухгалтера';
COMMENT ON COLUMN BARS.CORPS.DOV IS 'Доверен. лицо';
COMMENT ON COLUMN BARS.CORPS.BDOV IS 'Дата начала действия доверенности';
COMMENT ON COLUMN BARS.CORPS.EDOV IS 'Дата окончания действия доверенности';
COMMENT ON COLUMN BARS.CORPS.NLSNEW IS 'Счет новый';
COMMENT ON COLUMN BARS.CORPS.MAINNLS IS 'Гл.счет';
COMMENT ON COLUMN BARS.CORPS.MAINMFO IS 'МФО гл.счета';
COMMENT ON COLUMN BARS.CORPS.MFONEW IS 'МФО банка (новое)';
COMMENT ON COLUMN BARS.CORPS.TEL_FAX IS 'Факс';
COMMENT ON COLUMN BARS.CORPS.E_MAIL IS 'Адрес электронной почты';
COMMENT ON COLUMN BARS.CORPS.SEAL_ID IS 'Идентификатор графического представления печати юридического лица';
COMMENT ON COLUMN BARS.CORPS.NMK IS 'Наименование юр.лица';




PROMPT *** Create  constraint CC_CORPS_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CORPS MODIFY (RNK CONSTRAINT CC_CORPS_RNK_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_CORPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CORPS ADD CONSTRAINT PK_CORPS PRIMARY KEY (RNK)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CORPS_BDOV ***
begin   
 execute immediate '
  ALTER TABLE BARS.CORPS ADD CONSTRAINT CC_CORPS_BDOV CHECK (bdov = trunc(bdov)) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CORPS_EDOV ***
begin   
 execute immediate '
  ALTER TABLE BARS.CORPS ADD CONSTRAINT CC_CORPS_EDOV CHECK (edov = trunc(edov)) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CORPS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CORPS ON BARS.CORPS (RNK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index FK_CORPS_BANKS3 ***
begin   
 execute immediate '
  CREATE INDEX BARS.FK_CORPS_BANKS3 ON BARS.CORPS (MAINMFO) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index FK_CORPS_BANKS2 ***
begin   
 execute immediate '
  CREATE INDEX BARS.FK_CORPS_BANKS2 ON BARS.CORPS (MFONEW) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CORPS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CORPS           to ABS_ADMIN;
grant REFERENCES,SELECT                                                      on CORPS           to BARSAQ with grant option;
grant REFERENCES,SELECT                                                      on CORPS           to BARSAQ_ADM with grant option;
grant SELECT                                                                 on CORPS           to BARSDWH_ACCESS_USER;
grant SELECT                                                                 on CORPS           to BARSREADER_ROLE;
grant SELECT                                                                 on CORPS           to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on CORPS           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CORPS           to BARS_DM;
grant SELECT                                                                 on CORPS           to CC_DOC;
grant INSERT,SELECT,UPDATE                                                   on CORPS           to CUST001;
grant SELECT                                                                 on CORPS           to DPT;
grant ALTER,DEBUG,DELETE,FLASHBACK,INDEX,INSERT,ON COMMIT REFRESH,QUERY REWRITE,REFERENCES,SELECT,UPDATE on CORPS           to FINMON;
grant SELECT                                                                 on CORPS           to IBSADM_ROLE;
grant SELECT                                                                 on CORPS           to RCC_DEAL;
grant SELECT                                                                 on CORPS           to START1;
grant SELECT                                                                 on CORPS           to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CORPS           to WR_ALL_RIGHTS;
grant SELECT                                                                 on CORPS           to WR_CUSTLIST;
grant SELECT,UPDATE                                                          on CORPS           to WR_CUSTREG;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CORPS.sql =========*** End *** =======
PROMPT ===================================================================================== 
