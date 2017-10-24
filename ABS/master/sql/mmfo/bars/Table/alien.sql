

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ALIEN.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ALIEN ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ALIEN'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ALIEN'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ALIEN'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ALIEN ***
begin 
  execute immediate '
  CREATE TABLE BARS.ALIEN 
   (	MFO VARCHAR2(12), 
	NLS VARCHAR2(15), 
	NLSALT VARCHAR2(15), 
	KV NUMBER(3,0), 
	OKPO VARCHAR2(14), 
	NAME CHAR(70), 
	CRISK NUMBER(1,0), 
	NOTESEC RAW(128), 
	ID NUMBER(38,0), 
	REC_ID NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ALIEN ***
 exec bpa.alter_policies('ALIEN');


COMMENT ON TABLE BARS.ALIEN IS 'Справочник контрагентов (клиентов других банков)';
COMMENT ON COLUMN BARS.ALIEN.MFO IS 'МФО банка';
COMMENT ON COLUMN BARS.ALIEN.NLS IS 'Счет';
COMMENT ON COLUMN BARS.ALIEN.NLSALT IS 'Альтернативный счёт';
COMMENT ON COLUMN BARS.ALIEN.KV IS 'Код валюты';
COMMENT ON COLUMN BARS.ALIEN.OKPO IS 'Код ОКПО';
COMMENT ON COLUMN BARS.ALIEN.NAME IS 'Наименование клиента';
COMMENT ON COLUMN BARS.ALIEN.CRISK IS 'Категория риска';
COMMENT ON COLUMN BARS.ALIEN.NOTESEC IS 'Примечание службы безопасности';
COMMENT ON COLUMN BARS.ALIEN.ID IS 'Идентификатор пользователя';
COMMENT ON COLUMN BARS.ALIEN.REC_ID IS 'Идентификатор записи';




PROMPT *** Create  constraint PK_ALIEN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ALIEN ADD CONSTRAINT PK_ALIEN PRIMARY KEY (REC_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ALIEN_TABVAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.ALIEN ADD CONSTRAINT FK_ALIEN_TABVAL FOREIGN KEY (KV)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ALIEN_STANFIN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ALIEN ADD CONSTRAINT FK_ALIEN_STANFIN FOREIGN KEY (CRISK)
	  REFERENCES BARS.STAN_FIN (FIN) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ALIEN_BANKS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ALIEN ADD CONSTRAINT FK_ALIEN_BANKS FOREIGN KEY (MFO)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ALIEN_RECID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ALIEN MODIFY (REC_ID CONSTRAINT CC_ALIEN_RECID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ALIEN_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.ALIEN ADD CONSTRAINT FK_ALIEN_STAFF FOREIGN KEY (ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ALIEN ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ALIEN ON BARS.ALIEN (REC_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I2_ALIEN ***
begin   
 execute immediate '
  CREATE INDEX BARS.I2_ALIEN ON BARS.ALIEN (MFO, NLS, KV) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_ALIEN ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_ALIEN ON BARS.ALIEN (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ALIEN ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ALIEN           to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on ALIEN           to ALIEN;
grant SELECT                                                                 on ALIEN           to BARSAQ with grant option;
grant SELECT                                                                 on ALIEN           to BARSAQ_ADM with grant option;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ALIEN           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ALIEN           to BARS_DM;
grant DELETE,INSERT,UPDATE                                                   on ALIEN           to FOREX;
grant DELETE,INSERT,UPDATE                                                   on ALIEN           to PYOD001;
grant SELECT                                                                 on ALIEN           to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ALIEN           to WR_ALL_RIGHTS;
grant INSERT,SELECT,UPDATE                                                   on ALIEN           to WR_DOC_INPUT;
grant FLASHBACK,SELECT                                                       on ALIEN           to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ALIEN.sql =========*** End *** =======
PROMPT ===================================================================================== 
