

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PERSON.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PERSON ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PERSON'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''PERSON'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
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
   (KF varchar2(6) default sys_context(''bars_context'',''user_mfo'') not null,
    RNK NUMBER(38,0), 
	SEX CHAR(1), 
	PASSP NUMBER(*,0), 
	SER VARCHAR2(10), 
	NUMDOC VARCHAR2(20), 
	PDATE DATE DEFAULT TRUNC(SYSDATE), 
	ORGAN VARCHAR2(70), 
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
  TABLESPACE BRSBIGD
PARTITION BY LIST (KF)
( PARTITION P_300465 VALUES (''300465'')
, PARTITION P_302076 VALUES (''302076'')
, PARTITION P_303398 VALUES (''303398'')
, PARTITION P_304665 VALUES (''304665'')
, PARTITION P_305482 VALUES (''305482'')
, PARTITION P_311647 VALUES (''311647'')
, PARTITION P_312356 VALUES (''312356'')
, PARTITION P_313957 VALUES (''313957'')
, PARTITION P_315784 VALUES (''315784'')
, PARTITION P_322669 VALUES (''322669'')
, PARTITION P_323475 VALUES (''323475'')
, PARTITION P_324805 VALUES (''324805'')
, PARTITION P_325796 VALUES (''325796'')
, PARTITION P_326461 VALUES (''326461'')
, PARTITION P_328845 VALUES (''328845'')
, PARTITION P_331467 VALUES (''331467'')
, PARTITION P_333368 VALUES (''333368'')
, PARTITION P_335106 VALUES (''335106'')
, PARTITION P_336503 VALUES (''336503'')
, PARTITION P_337568 VALUES (''337568'')
, PARTITION P_338545 VALUES (''338545'')
, PARTITION P_351823 VALUES (''351823'')
, PARTITION P_352457 VALUES (''352457'')
, PARTITION P_353553 VALUES (''353553'')
, PARTITION P_354507 VALUES (''354507'')
, PARTITION P_356334 VALUES (''356334'')
)  ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PERSON ***
 exec bpa.alter_policies('PERSON');


COMMENT ON TABLE BARS.PERSON IS 'Клиенты-ФЛ';
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
COMMENT ON COLUMN BARS.PERSON.DATE_PHOTO IS 'Дата коли була вклеєна остання фотографія у паспорт';
COMMENT ON COLUMN BARS.PERSON.DOV IS '';
COMMENT ON COLUMN BARS.PERSON.CELLPHONE_CONFIRMED IS 'Признак чи підтверджено мобільний телефон';
COMMENT ON COLUMN BARS.PERSON.ACTUAL_DATE IS 'Дійсний до';
COMMENT ON COLUMN BARS.PERSON.EDDR_ID IS 'Унікальний номер запису в ЄДДР';




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




PROMPT *** Create  constraint CC_PERSON_BDOV ***
begin   
 execute immediate '
  ALTER TABLE BARS.PERSON ADD CONSTRAINT CC_PERSON_BDOV CHECK (bdov <= edov) ENABLE';
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




PROMPT *** Create  constraint CC_PERSON_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PERSON MODIFY (RNK CONSTRAINT CC_PERSON_RNK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
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

declare
  e_idx_exists           exception;
  pragma exception_init( e_idx_exists,      -00955 );
  e_col_already_idx      exception;
  pragma exception_init( e_col_already_idx, -01408 );
  e_dup_keys_found       exception;
  pragma exception_init( e_dup_keys_found,  -01452 );
begin
  execute immediate 'create unique index UK_PERSON_RNK on PERSON (KF,RNK) tablespace BRSBIGI local compress 1';
  dbms_output.put_line( 'Index created.' );
exception
  when e_idx_exists
  then dbms_output.put_line( 'Name is already used by an existing object.' );
  when e_col_already_idx
  then dbms_output.put_line( 'Such column list already indexed.' );
  when e_dup_keys_found
  then dbms_output.put_line( 'Cannot create unique index: duplicate keys found' );
end;
/


declare
  e_idx_exists           exception;
  pragma exception_init( e_idx_exists,      -00955 );
  e_col_already_idx      exception;
  pragma exception_init( e_col_already_idx, -01408 );
begin
  execute immediate q'[create index I_PERSON_PSN on PERSON (KF, PASSP, TRANSLATE(UPPER(SER),'ABCEHIKMOPTXY','АВСЕНІКМОРТХУ'), UPPER(NUMDOC))
  tablespace BRSBIGI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 128K
    next 128K
    minextents 1
    maxextents unlimited
  ) local compress 1]';
  dbms_output.put_line( 'Index created.' );
exception
  when e_idx_exists
  then dbms_output.put_line( 'Name is already used by an existing object.' );
  when e_col_already_idx 
  then dbms_output.put_line( 'Such column list already indexed.' );
end;
/

declare
  e_idx_exists           exception;
  pragma exception_init( e_idx_exists,      -00955 );
  e_col_already_idx      exception;
  pragma exception_init( e_col_already_idx, -01408 );
begin
  execute immediate q'[create index I1_PERSON on PERSON (KF, SER, NUMDOC)
  tablespace BRSBIGI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 128K
    next 128K
    minextents 1
    maxextents unlimited
  ) local compress 1]';
  dbms_output.put_line( 'Index created.' );
exception
  when e_idx_exists
  then dbms_output.put_line( 'Name is already used by an existing object.' );
  when e_col_already_idx 
  then dbms_output.put_line( 'Such column list already indexed.' );
end;
/



PROMPT *** Create  grants  PERSON ***
grant DELETE,INSERT,SELECT,UPDATE                                            on PERSON          to ABS_ADMIN;
grant REFERENCES,SELECT                                                      on PERSON          to BARSAQ with grant option;
grant REFERENCES,SELECT                                                      on PERSON          to BARSAQ_ADM with grant option;
grant SELECT                                                                 on PERSON          to BARSDWH_ACCESS_USER;
grant SELECT                                                                 on PERSON          to BARSREADER_ROLE;
grant SELECT                                                                 on PERSON          to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on PERSON          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PERSON          to BARS_DM;
grant SELECT                                                                 on PERSON          to CC_DOC;
grant INSERT,SELECT,UPDATE                                                   on PERSON          to CUST001;
grant SELECT                                                                 on PERSON          to DPT;
grant SELECT                                                                 on PERSON          to DPT_ROLE;
grant ALTER,DEBUG,DELETE,FLASHBACK,INDEX,INSERT,ON COMMIT REFRESH,QUERY REWRITE,REFERENCES,SELECT,UPDATE on PERSON          to FINMON;
grant SELECT                                                                 on PERSON          to IBSADM_ROLE;
grant SELECT,SELECT                                                          on PERSON          to KLBX;
grant SELECT                                                                 on PERSON          to RPBN001;
grant SELECT                                                                 on PERSON          to START1;
grant SELECT                                                                 on PERSON          to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on PERSON          to WR_ALL_RIGHTS;
grant SELECT                                                                 on PERSON          to WR_CREDIT;
grant SELECT                                                                 on PERSON          to WR_CUSTREG;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PERSON.sql =========*** End *** ======
PROMPT ===================================================================================== 
