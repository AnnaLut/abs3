

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BL_PERSON_UPDATE.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BL_PERSON_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BL_PERSON_UPDATE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BL_PERSON_UPDATE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''BL_PERSON_UPDATE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BL_PERSON_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.BL_PERSON_UPDATE 
   (	PERSON_ID NUMBER, 
	INN VARCHAR2(10), 
	LNAME VARCHAR2(50), 
	FNAME VARCHAR2(50), 
	MNAME VARCHAR2(50), 
	BDATE DATE, 
	INN_DATE DATE, 
	INS_DATE DATE, 
	USER_ID NUMBER, 
	BASE_ID NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BL_PERSON_UPDATE ***
 exec bpa.alter_policies('BL_PERSON_UPDATE');


COMMENT ON TABLE BARS.BL_PERSON_UPDATE IS 'Изменения данных ФИЗЛИЦ';
COMMENT ON COLUMN BARS.BL_PERSON_UPDATE.PERSON_ID IS 'Уникальный идентификатор.';
COMMENT ON COLUMN BARS.BL_PERSON_UPDATE.INN IS 'Идентификационный налоговый номер.';
COMMENT ON COLUMN BARS.BL_PERSON_UPDATE.LNAME IS 'Фамилия';
COMMENT ON COLUMN BARS.BL_PERSON_UPDATE.FNAME IS 'Имя';
COMMENT ON COLUMN BARS.BL_PERSON_UPDATE.MNAME IS 'Отчество';
COMMENT ON COLUMN BARS.BL_PERSON_UPDATE.BDATE IS 'Дата рождения';
COMMENT ON COLUMN BARS.BL_PERSON_UPDATE.INN_DATE IS 'Дата выдачи идентификационного налогового номера';
COMMENT ON COLUMN BARS.BL_PERSON_UPDATE.INS_DATE IS 'Дата добавления записи';
COMMENT ON COLUMN BARS.BL_PERSON_UPDATE.USER_ID IS 'Код пользователя';
COMMENT ON COLUMN BARS.BL_PERSON_UPDATE.BASE_ID IS '';
COMMENT ON COLUMN BARS.BL_PERSON_UPDATE.KF IS '';




PROMPT *** Create  constraint NN_BL_PERSON_ID_UPD ***
begin   
 execute immediate '
  ALTER TABLE BARS.BL_PERSON_UPDATE MODIFY (PERSON_ID CONSTRAINT NN_BL_PERSON_ID_UPD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NN_BL_PERSON_USER_UPD ***
begin   
 execute immediate '
  ALTER TABLE BARS.BL_PERSON_UPDATE MODIFY (USER_ID CONSTRAINT NN_BL_PERSON_USER_UPD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index BL_PERSON_FIO_UPD ***
begin   
 execute immediate '
  CREATE INDEX BARS.BL_PERSON_FIO_UPD ON BARS.BL_PERSON_UPDATE (LNAME, FNAME, MNAME, BDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index BL_PERSON_INN_UPD ***
begin   
 execute immediate '
  CREATE INDEX BARS.BL_PERSON_INN_UPD ON BARS.BL_PERSON_UPDATE (INN) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BL_PERSON_UPDATE ***
grant SELECT                                                                 on BL_PERSON_UPDATE to BARSREADER_ROLE;
grant SELECT                                                                 on BL_PERSON_UPDATE to BARS_DM;
grant INSERT,SELECT                                                          on BL_PERSON_UPDATE to RBL;
grant SELECT                                                                 on BL_PERSON_UPDATE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BL_PERSON_UPDATE.sql =========*** End 
PROMPT ===================================================================================== 
