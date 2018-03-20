

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PERSON.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PERSON ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PERSON'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''PERSON'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PERSON ***
begin 
  execute immediate '
  CREATE TABLE BARS.PERSON 
   (	RNK NUMBER(38,0), 
	SEX CHAR(1), 
	PASSP NUMBER(*,0), 
	SER VARCHAR2(10), 
	NUMDOC VARCHAR2(20), 
	PDATE DATE DEFAULT TRUNC(SYSDATE), 
	ORGAN VARCHAR2(150), 
	BDAY DATE DEFAULT TRUNC(SYSDATE), 
	BPLACE VARCHAR2(70), 
	TELD VARCHAR2(20), 
	TELW VARCHAR2(20), 
	CELLPHONE VARCHAR2(20), 
	BDOV DATE, 
	EDOV DATE, 
	DATE_PHOTO DATE, 
	DOV VARCHAR2(35), 
	CELLPHONE_CONFIRMED NUMBER(1,0), 
	ACTUAL_DATE DATE, 
	EDDR_ID VARCHAR2(20)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PERSON ***
 exec bpa.alter_policies('PERSON');


COMMENT ON TABLE BARS.PERSON IS 'Клиенты-ФЛ';
COMMENT ON COLUMN BARS.PERSON.DATE_PHOTO IS 'Дата коли була вклеєна остання фотографія у паспорт';
COMMENT ON COLUMN BARS.PERSON.DOV IS '';
COMMENT ON COLUMN BARS.PERSON.CELLPHONE_CONFIRMED IS 'Признак чи підтверджено мобільний телефон';
COMMENT ON COLUMN BARS.PERSON.ACTUAL_DATE IS 'Дійсний до';
COMMENT ON COLUMN BARS.PERSON.EDDR_ID IS 'Унікальний номер запису в ЄДДР';
COMMENT ON COLUMN BARS.PERSON.RNK IS 'Идентификатор клиента';
COMMENT ON COLUMN BARS.PERSON.SEX IS 'Пол';
COMMENT ON COLUMN BARS.PERSON.PASSP IS 'Тип удостоверяющего документа';
COMMENT ON COLUMN BARS.PERSON.SER IS 'Серия док';
COMMENT ON COLUMN BARS.PERSON.NUMDOC IS '№ док';
COMMENT ON COLUMN BARS.PERSON.PDATE IS 'Даты выдачи док';
COMMENT ON COLUMN BARS.PERSON.ORGAN IS 'Организация, выдавшая удостоверяющий документ';
COMMENT ON COLUMN BARS.PERSON.BDAY IS 'Дата рождения';
COMMENT ON COLUMN BARS.PERSON.BPLACE IS 'Место рождения';
COMMENT ON COLUMN BARS.PERSON.TELD IS 'Домашний телефон';
COMMENT ON COLUMN BARS.PERSON.TELW IS 'Рабочий телефон';
COMMENT ON COLUMN BARS.PERSON.CELLPHONE IS 'Номер моб.телефону';
COMMENT ON COLUMN BARS.PERSON.BDOV IS 'Дата начала действия доверенности';
COMMENT ON COLUMN BARS.PERSON.EDOV IS 'Дата окончания действия доверенности';




PROMPT *** Create  constraint FK_PERSON_PASSP ***
begin   
 execute immediate '
  ALTER TABLE BARS.PERSON ADD CONSTRAINT FK_PERSON_PASSP FOREIGN KEY (PASSP)
	  REFERENCES BARS.PASSP (PASSP) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PERSON_CUSTOMER ***
begin   
 execute immediate '
  ALTER TABLE BARS.PERSON ADD CONSTRAINT FK_PERSON_CUSTOMER FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PERSON_SEX ***
begin   
 execute immediate '
  ALTER TABLE BARS.PERSON ADD CONSTRAINT FK_PERSON_SEX FOREIGN KEY (SEX)
	  REFERENCES BARS.SEX (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PERSON_PDATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.PERSON ADD CONSTRAINT CC_PERSON_PDATE CHECK (nvl(pdate,to_date(''01/01/3000'', ''dd/mm/yyyy'')) >= bday) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PERSON_BDOV ***
begin   
 execute immediate '
  ALTER TABLE BARS.PERSON ADD CONSTRAINT CC_PERSON_BDOV CHECK (bdov <= edov) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_PERSON ***
begin   
 execute immediate '
  ALTER TABLE BARS.PERSON ADD CONSTRAINT PK_PERSON PRIMARY KEY (RNK)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PERSON_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PERSON MODIFY (RNK CONSTRAINT CC_PERSON_RNK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_PERSON ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_PERSON ON BARS.PERSON (SER, NUMDOC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_PERSON_PSN ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_PERSON_PSN ON BARS.PERSON (PASSP, TRANSLATE(UPPER(SER),''ABCEHIKMOPTXY'',''АВСЕНІКМОРТХУ''), UPPER(NUMDOC)) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PERSON ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_PERSON ON BARS.PERSON (RNK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PERSON ***
grant DELETE,INSERT,SELECT,UPDATE                                            on PERSON          to ABS_ADMIN;
grant REFERENCES,SELECT                                                      on PERSON          to BARSAQ with grant option;
grant REFERENCES,SELECT                                                      on PERSON          to BARSAQ_ADM with grant option;
grant SELECT,SELECT                                                          on PERSON          to BARSDWH_ACCESS_USER;
grant SELECT                                                                 on PERSON          to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on PERSON          to BARS_ACCESS_DEFROLE;
grant ALTER,DEBUG,DELETE,FLASHBACK,INDEX,INSERT,ON COMMIT REFRESH,QUERY REWRITE,REFERENCES,SELECT,UPDATE on PERSON          to BARS_DM;
grant SELECT                                                                 on PERSON          to BARS_SUP;
grant SELECT                                                                 on PERSON          to CC_DOC;
grant INSERT,SELECT,UPDATE                                                   on PERSON          to CUST001;
grant SELECT                                                                 on PERSON          to DPT;
grant SELECT                                                                 on PERSON          to DPT_ROLE;
grant SELECT                                                                 on PERSON          to FINMON;
grant SELECT                                                                 on PERSON          to IBSADM_ROLE;
grant SELECT,SELECT                                                          on PERSON          to KLBX;
grant SELECT                                                                 on PERSON          to RPBN001;
grant SELECT                                                                 on PERSON          to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on PERSON          to WR_ALL_RIGHTS;
grant SELECT                                                                 on PERSON          to WR_CREDIT;
grant SELECT                                                                 on PERSON          to WR_CUSTREG;



PROMPT *** Create SYNONYM  to PERSON ***

  CREATE OR REPLACE SYNONYM BARSDWH_ACCESS_USER.PERSON FOR BARS.PERSON;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PERSON.sql =========*** End *** ======
PROMPT ===================================================================================== 
