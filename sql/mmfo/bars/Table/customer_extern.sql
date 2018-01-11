

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CUSTOMER_EXTERN.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CUSTOMER_EXTERN ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CUSTOMER_EXTERN'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CUSTOMER_EXTERN'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CUSTOMER_EXTERN'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CUSTOMER_EXTERN ***
begin 
  execute immediate '
  CREATE TABLE BARS.CUSTOMER_EXTERN 
   (	ID NUMBER(22,0), 
	NAME VARCHAR2(70), 
	DOC_TYPE NUMBER(22,0), 
	DOC_SERIAL VARCHAR2(30), 
	DOC_NUMBER VARCHAR2(22), 
	DOC_DATE DATE, 
	DOC_ISSUER VARCHAR2(70), 
	BIRTHDAY DATE, 
	BIRTHPLACE VARCHAR2(70), 
	SEX CHAR(1) DEFAULT ''0'', 
	ADR VARCHAR2(100), 
	TEL VARCHAR2(100), 
	EMAIL VARCHAR2(100), 
	CUSTTYPE NUMBER(1,0), 
	OKPO VARCHAR2(14), 
	COUNTRY NUMBER(3,0), 
	REGION VARCHAR2(2), 
	FS CHAR(2), 
	VED CHAR(5), 
	SED CHAR(4), 
	ISE CHAR(5), 
	NOTES VARCHAR2(80), 
	RNK NUMBER, 
	DETRNK DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CUSTOMER_EXTERN ***
 exec bpa.alter_policies('CUSTOMER_EXTERN');


COMMENT ON TABLE BARS.CUSTOMER_EXTERN IS 'Не клиенты банка';
COMMENT ON COLUMN BARS.CUSTOMER_EXTERN.ID IS 'Id';
COMMENT ON COLUMN BARS.CUSTOMER_EXTERN.NAME IS 'Наименование/ФИО';
COMMENT ON COLUMN BARS.CUSTOMER_EXTERN.DOC_TYPE IS 'Тип документа';
COMMENT ON COLUMN BARS.CUSTOMER_EXTERN.DOC_SERIAL IS 'Серия документв';
COMMENT ON COLUMN BARS.CUSTOMER_EXTERN.DOC_NUMBER IS 'Номер документа';
COMMENT ON COLUMN BARS.CUSTOMER_EXTERN.DOC_DATE IS 'Дата выдачи документа';
COMMENT ON COLUMN BARS.CUSTOMER_EXTERN.DOC_ISSUER IS 'Место выдачи документа';
COMMENT ON COLUMN BARS.CUSTOMER_EXTERN.BIRTHDAY IS 'Дата рождения';
COMMENT ON COLUMN BARS.CUSTOMER_EXTERN.BIRTHPLACE IS 'Место рождения';
COMMENT ON COLUMN BARS.CUSTOMER_EXTERN.SEX IS '';
COMMENT ON COLUMN BARS.CUSTOMER_EXTERN.ADR IS 'Адрес';
COMMENT ON COLUMN BARS.CUSTOMER_EXTERN.TEL IS 'Телефон';
COMMENT ON COLUMN BARS.CUSTOMER_EXTERN.EMAIL IS 'E_mail';
COMMENT ON COLUMN BARS.CUSTOMER_EXTERN.CUSTTYPE IS 'Признак (1-ЮЛ, 2-ФЛ)';
COMMENT ON COLUMN BARS.CUSTOMER_EXTERN.OKPO IS 'ОКПО';
COMMENT ON COLUMN BARS.CUSTOMER_EXTERN.COUNTRY IS 'Код страны';
COMMENT ON COLUMN BARS.CUSTOMER_EXTERN.REGION IS 'Код региона';
COMMENT ON COLUMN BARS.CUSTOMER_EXTERN.FS IS 'Форма собственности (K081)';
COMMENT ON COLUMN BARS.CUSTOMER_EXTERN.VED IS 'Вид эк. деят-ти (K110)';
COMMENT ON COLUMN BARS.CUSTOMER_EXTERN.SED IS 'Орг.-правовая форма (K051)';
COMMENT ON COLUMN BARS.CUSTOMER_EXTERN.ISE IS 'Инст. сектор экономики (K070)';
COMMENT ON COLUMN BARS.CUSTOMER_EXTERN.NOTES IS 'Комментарий';
COMMENT ON COLUMN BARS.CUSTOMER_EXTERN.RNK IS 'РНК клієнта, що створився пізніше';
COMMENT ON COLUMN BARS.CUSTOMER_EXTERN.DETRNK IS 'Дата визначення РНК';




PROMPT *** Create  constraint PK_CUSTOMEREXTERN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_EXTERN ADD CONSTRAINT PK_CUSTOMEREXTERN PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMEREXTERN_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_EXTERN MODIFY (ID CONSTRAINT CC_CUSTOMEREXTERN_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMEREXTERN_SEX_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_EXTERN MODIFY (SEX CONSTRAINT CC_CUSTOMEREXTERN_SEX_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CUSTOMEREXTERN ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CUSTOMEREXTERN ON BARS.CUSTOMER_EXTERN (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CUSTOMER_EXTERN ***
grant SELECT                                                                 on CUSTOMER_EXTERN to BARSREADER_ROLE;
grant SELECT                                                                 on CUSTOMER_EXTERN to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on CUSTOMER_EXTERN to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CUSTOMER_EXTERN to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CUSTOMER_EXTERN to CUST001;
grant SELECT                                                                 on CUSTOMER_EXTERN to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CUSTOMER_EXTERN to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to CUSTOMER_EXTERN ***

  CREATE OR REPLACE PUBLIC SYNONYM CUSTOMER_EXTERN FOR BARS.CUSTOMER_EXTERN;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CUSTOMER_EXTERN.sql =========*** End *
PROMPT ===================================================================================== 
