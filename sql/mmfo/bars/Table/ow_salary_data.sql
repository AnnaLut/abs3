

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OW_SALARY_DATA.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OW_SALARY_DATA ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OW_SALARY_DATA'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''OW_SALARY_DATA'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''OW_SALARY_DATA'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OW_SALARY_DATA ***
begin 
  execute immediate '
  CREATE TABLE BARS.OW_SALARY_DATA 
   (	ID NUMBER(22,0), 
	IDN NUMBER(22,0), 
	OKPO VARCHAR2(14), 
	FIRST_NAME VARCHAR2(70), 
	LAST_NAME VARCHAR2(70), 
	MIDDLE_NAME VARCHAR2(70), 
	TYPE_DOC NUMBER(22,0), 
	PASPSERIES VARCHAR2(16), 
	PASPNUM VARCHAR2(16), 
	PASPISSUER VARCHAR2(128), 
	PASPDATE DATE, 
	BDAY DATE, 
	COUNTRY VARCHAR2(3), 
	RESIDENT VARCHAR2(1), 
	GENDER VARCHAR2(1), 
	PHONE_HOME VARCHAR2(13), 
	PHONE_MOB VARCHAR2(13), 
	EMAIL VARCHAR2(30), 
	ENG_FIRST_NAME VARCHAR2(30), 
	ENG_LAST_NAME VARCHAR2(30), 
	MNAME VARCHAR2(20), 
	ADDR1_CITYNAME VARCHAR2(100), 
	ADDR1_PCODE VARCHAR2(10), 
	ADDR1_DOMAIN VARCHAR2(48), 
	ADDR1_REGION VARCHAR2(48), 
	ADDR1_STREET VARCHAR2(100), 
	ADDR2_CITYNAME VARCHAR2(100), 
	ADDR2_PCODE VARCHAR2(10), 
	ADDR2_DOMAIN VARCHAR2(48), 
	ADDR2_REGION VARCHAR2(48), 
	ADDR2_STREET VARCHAR2(100), 
	WORK VARCHAR2(254), 
	OFFICE VARCHAR2(32), 
	DATE_W DATE, 
	OKPO_W VARCHAR2(14), 
	PERS_CAT VARCHAR2(2), 
	AVER_SUM NUMBER(12,0), 
	TABN VARCHAR2(32), 
	STR_ERR VARCHAR2(254), 
	RNK NUMBER(22,0), 
	ND NUMBER(22,0), 
	FLAG_OPEN NUMBER(1,0), 
	ACC_INSTANT NUMBER(22,0), 
	ADDR1_STREETTYPE NUMBER(10,0), 
	ADDR1_STREETNAME VARCHAR2(100), 
	ADDR1_BUD VARCHAR2(50), 
	ADDR2_STREETTYPE NUMBER(10,0), 
	ADDR2_STREETNAME VARCHAR2(100), 
	ADDR2_BUD VARCHAR2(50), 
	KK_SECRET_WORD VARCHAR2(32), 
	KK_REGTYPE NUMBER(1,0), 
	KK_CITYAREAID NUMBER(10,0), 
	KK_STREETTYPEID NUMBER(10,0), 
	KK_STREETNAME VARCHAR2(64), 
	KK_APARTMENT VARCHAR2(32), 
	KK_POSTCODE VARCHAR2(5), 
	KK_PHOTO_DATA BLOB, 
	MAX_TERM NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	PASP_END_DATE DATE, 
	PASP_EDDRID_ID VARCHAR2(14)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD 
 LOB (KK_PHOTO_DATA) STORE AS BASICFILE (
  TABLESPACE BRSSMLD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/
begin
  execute immediate '
alter table OW_SALARY_DATA add (
  addr1_city_type     NUMBER(22),  
  addr2_city_type     NUMBER(22)
  )
';
exception when others then       
  if sqlcode=-01430 then null; else raise; end if; 

end ;
/
begin
  execute immediate ' alter table ow_salary_data drop column addr1_flat'; 
exception when others then       
  if sqlcode=-00904 then null; else raise; end if;   
end;
/
begin
  execute immediate ' alter table ow_salary_data drop column addr2_flat'; 
exception when others then       
  if sqlcode=-00904 then null; else raise; end if; 
end;
/

begin
  execute immediate '
alter table OW_SALARY_DATA add (
  addr1_flat          VARCHAR2(100 CHAR),
  addr2_flat          VARCHAR2(100 CHAR)
  )
';
exception when others then       
  if sqlcode=-01430 then null; else raise; end if; 
end ;
/




PROMPT *** ALTER_POLICIES to OW_SALARY_DATA ***
 exec bpa.alter_policies('OW_SALARY_DATA');


COMMENT ON TABLE BARS.OW_SALARY_DATA IS 'OpenWay. Імпортовані файли зарплатних проектів';
COMMENT ON COLUMN BARS.OW_SALARY_DATA.KF IS '';
COMMENT ON COLUMN BARS.OW_SALARY_DATA.PASP_END_DATE IS 'Дійсний до/термін дії';
COMMENT ON COLUMN BARS.OW_SALARY_DATA.PASP_EDDRID_ID IS 'Унікальний номер запису в ЄДДР';
COMMENT ON COLUMN BARS.OW_SALARY_DATA.ID IS 'Ід.';
COMMENT ON COLUMN BARS.OW_SALARY_DATA.IDN IS '';
COMMENT ON COLUMN BARS.OW_SALARY_DATA.OKPO IS '';
COMMENT ON COLUMN BARS.OW_SALARY_DATA.FIRST_NAME IS '';
COMMENT ON COLUMN BARS.OW_SALARY_DATA.LAST_NAME IS '';
COMMENT ON COLUMN BARS.OW_SALARY_DATA.MIDDLE_NAME IS '';
COMMENT ON COLUMN BARS.OW_SALARY_DATA.TYPE_DOC IS '';
COMMENT ON COLUMN BARS.OW_SALARY_DATA.PASPSERIES IS '';
COMMENT ON COLUMN BARS.OW_SALARY_DATA.PASPNUM IS '';
COMMENT ON COLUMN BARS.OW_SALARY_DATA.PASPISSUER IS '';
COMMENT ON COLUMN BARS.OW_SALARY_DATA.PASPDATE IS '';
COMMENT ON COLUMN BARS.OW_SALARY_DATA.BDAY IS '';
COMMENT ON COLUMN BARS.OW_SALARY_DATA.COUNTRY IS '';
COMMENT ON COLUMN BARS.OW_SALARY_DATA.RESIDENT IS '';
COMMENT ON COLUMN BARS.OW_SALARY_DATA.GENDER IS '';
COMMENT ON COLUMN BARS.OW_SALARY_DATA.PHONE_HOME IS '';
COMMENT ON COLUMN BARS.OW_SALARY_DATA.PHONE_MOB IS '';
COMMENT ON COLUMN BARS.OW_SALARY_DATA.EMAIL IS '';
COMMENT ON COLUMN BARS.OW_SALARY_DATA.ENG_FIRST_NAME IS '';
COMMENT ON COLUMN BARS.OW_SALARY_DATA.ENG_LAST_NAME IS '';
COMMENT ON COLUMN BARS.OW_SALARY_DATA.MNAME IS '';
COMMENT ON COLUMN BARS.OW_SALARY_DATA.ADDR1_CITYNAME IS 'Місто (прописки/реєстрації)';
COMMENT ON COLUMN BARS.OW_SALARY_DATA.ADDR1_PCODE IS 'Індекс (прописки/реєстрації)';
COMMENT ON COLUMN BARS.OW_SALARY_DATA.ADDR1_DOMAIN IS 'Область (прописки/реєстрації)';
COMMENT ON COLUMN BARS.OW_SALARY_DATA.ADDR1_REGION IS 'Район (прописки/реєстрації)';
COMMENT ON COLUMN BARS.OW_SALARY_DATA.ADDR1_STREET IS 'Вулиця, будинок, квартира (прописки/реєстрації)';
COMMENT ON COLUMN BARS.OW_SALARY_DATA.ADDR2_CITYNAME IS 'Місто (проживання)';
COMMENT ON COLUMN BARS.OW_SALARY_DATA.ADDR2_PCODE IS 'Індекс (проживання)';
COMMENT ON COLUMN BARS.OW_SALARY_DATA.ADDR2_DOMAIN IS 'Область (проживання)';
COMMENT ON COLUMN BARS.OW_SALARY_DATA.ADDR2_REGION IS 'Район (проживання)';
COMMENT ON COLUMN BARS.OW_SALARY_DATA.ADDR2_STREET IS 'Вулиця, будинок, квартира (проживання)';
COMMENT ON COLUMN BARS.OW_SALARY_DATA.WORK IS '';
COMMENT ON COLUMN BARS.OW_SALARY_DATA.OFFICE IS '';
COMMENT ON COLUMN BARS.OW_SALARY_DATA.DATE_W IS '';
COMMENT ON COLUMN BARS.OW_SALARY_DATA.OKPO_W IS '';
COMMENT ON COLUMN BARS.OW_SALARY_DATA.PERS_CAT IS '';
COMMENT ON COLUMN BARS.OW_SALARY_DATA.AVER_SUM IS '';
COMMENT ON COLUMN BARS.OW_SALARY_DATA.TABN IS '';
COMMENT ON COLUMN BARS.OW_SALARY_DATA.STR_ERR IS '';
COMMENT ON COLUMN BARS.OW_SALARY_DATA.RNK IS '';
COMMENT ON COLUMN BARS.OW_SALARY_DATA.ND IS '';
COMMENT ON COLUMN BARS.OW_SALARY_DATA.FLAG_OPEN IS 'Флаг открытия: 0-не открывать счет, 1-открывать счет, 2-спросить';
COMMENT ON COLUMN BARS.OW_SALARY_DATA.ACC_INSTANT IS 'ACC рахунку Instant';
COMMENT ON COLUMN BARS.OW_SALARY_DATA.ADDR1_STREETTYPE IS 'Адреса прописки: тип вулиці';
COMMENT ON COLUMN BARS.OW_SALARY_DATA.ADDR1_STREETNAME IS 'Адреса прописки: назва вулиці';
COMMENT ON COLUMN BARS.OW_SALARY_DATA.ADDR1_BUD IS 'Адреса прописки: будинок, квартира';
COMMENT ON COLUMN BARS.OW_SALARY_DATA.ADDR2_STREETTYPE IS 'Адреса проживання: тип вулиці';
COMMENT ON COLUMN BARS.OW_SALARY_DATA.ADDR2_STREETNAME IS 'Адреса проживання: назва вулиці';
COMMENT ON COLUMN BARS.OW_SALARY_DATA.ADDR2_BUD IS 'Адреса проживання: будинок, квартира';
COMMENT ON COLUMN BARS.OW_SALARY_DATA.KK_SECRET_WORD IS 'Таємне слово для КК';
COMMENT ON COLUMN BARS.OW_SALARY_DATA.KK_REGTYPE IS 'Тип реєстрації громадянина';
COMMENT ON COLUMN BARS.OW_SALARY_DATA.KK_CITYAREAID IS 'Код району міста';
COMMENT ON COLUMN BARS.OW_SALARY_DATA.KK_STREETTYPEID IS 'Код типу вулиці';
COMMENT ON COLUMN BARS.OW_SALARY_DATA.KK_STREETNAME IS 'Вулиця';
COMMENT ON COLUMN BARS.OW_SALARY_DATA.KK_APARTMENT IS 'Номер будинку (та квартири)';
COMMENT ON COLUMN BARS.OW_SALARY_DATA.KK_POSTCODE IS 'Поштовий індекс';
COMMENT ON COLUMN BARS.OW_SALARY_DATA.KK_PHOTO_DATA IS 'Фото клієнта для КК';
COMMENT ON COLUMN BARS.OW_SALARY_DATA.MAX_TERM IS 'Срок действия карты в месяцах';
COMMENT ON COLUMN BARS.OW_SALARY_DATA.addr1_flat IS 'Квартира (прописки)';
COMMENT ON COLUMN BARS.OW_SALARY_DATA.addr2_flat IS 'Квартира (проживання)';
COMMENT ON COLUMN BARS.OW_SALARY_DATA.addr1_city_type IS 'Тип населенного пункту (прописки)';

                        


PROMPT *** Create  constraint CC_OWSALARYDATA_FLAGOPEN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_SALARY_DATA ADD CONSTRAINT CC_OWSALARYDATA_FLAGOPEN CHECK (flag_open in (0,1,2,3,4)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_OWSALARYDATA ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_SALARY_DATA ADD CONSTRAINT PK_OWSALARYDATA PRIMARY KEY (ID, IDN)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWSALARYDATA_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_SALARY_DATA MODIFY (KF CONSTRAINT CC_OWSALARYDATA_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OWSALARYDATA ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OWSALARYDATA ON BARS.OW_SALARY_DATA (ID, IDN) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OW_SALARY_DATA ***
grant SELECT                                                                 on OW_SALARY_DATA  to BARSREADER_ROLE;
grant INSERT,SELECT,UPDATE                                                   on OW_SALARY_DATA  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OW_SALARY_DATA  to BARS_DM;
grant INSERT,SELECT,UPDATE                                                   on OW_SALARY_DATA  to OW;
grant SELECT                                                                 on OW_SALARY_DATA  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OW_SALARY_DATA.sql =========*** End **
PROMPT ===================================================================================== 
