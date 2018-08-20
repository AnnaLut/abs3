

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/Table/PFU_EPP_LINE_GUARDIAN.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  table PFU_EPP_LINE_GUARDIAN ***
begin 
  execute immediate '
  CREATE TABLE PFU.PFU_EPP_LINE_GUARDIAN 
 (ID                      NUMBER(10,0), 
  BATCH_REQUEST_ID        NUMBER(10,0), 
  PERSON_RECORD_NUMBER    VARCHAR2(4000), 
  LAST_NAME               VARCHAR2(4000), 
  FIRST_NAME              VARCHAR2(4000), 
  MIDDLE_NAME             VARCHAR2(4000), 
  GENDER                  VARCHAR2(4000), 
  DATE_OF_BIRTH           VARCHAR2(4000), 
  PHONE_NUMBERS           VARCHAR2(4000), 
  EMBOSSING_NAME          VARCHAR2(4000), 
  TAX_REGISTRATION_NUMBER VARCHAR2(4000), 
  DOCUMENT_TYPE           VARCHAR2(4000), 
  DOCUMENT_ID             VARCHAR2(4000), 
  DOCUMENT_ISSUE_DATE     VARCHAR2(4000), 
  DOCUMENT_ISSUER         VARCHAR2(4000), 
  DISPLACED_PERSON_FLAG   VARCHAR2(4000), 
  LEGAL_COUNTRY           VARCHAR2(4000), 
  LEGAL_ZIP_CODE          VARCHAR2(4000), 
  LEGAL_REGION            VARCHAR2(4000), 
  LEGAL_DISTRICT          VARCHAR2(4000), 
  LEGAL_SETTLEMENT        VARCHAR2(4000), 
  LEGAL_STREET            VARCHAR2(4000), 
  LEGAL_HOUSE             VARCHAR2(4000), 
  LEGAL_HOUSE_PART        VARCHAR2(4000), 
  LEGAL_APARTMENT         VARCHAR2(4000), 
  ACTUAL_COUNTRY          VARCHAR2(4000), 
  ACTUAL_ZIP_CODE         VARCHAR2(4000), 
  ACTUAL_REGION           VARCHAR2(4000), 
  ACTUAL_DISTRICT         VARCHAR2(4000), 
  ACTUAL_SETTLEMENT       VARCHAR2(4000), 
  ACTUAL_STREET           VARCHAR2(4000), 
  ACTUAL_HOUSE            VARCHAR2(4000), 
  ACTUAL_HOUSE_PART       VARCHAR2(4000), 
  ACTUAL_APARTMENT        VARCHAR2(4000), 
  STATE_ID                NUMBER(5,0), 
  LINE_SIGN               RAW(128), 
  PENS_TYPE               VARCHAR2(4000), 
  COMM                    VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

PROMPT *** Add comments to the table PFU.PFU_EPP_LINE_GUARDIAN ***
COMMENT ON TABLE PFU.PFU_EPP_LINE_GUARDIAN IS 'Рядки файлу ОПІКУНІВ пенсіонерів для відкриття рахунку в Банку та атрибутів файлу з інформацією по ЕПП, які потребують перевипуску';

PROMPT *** Add comments to the columns of table PFU.PFU_EPP_LINE_GUARDIAN *** 
COMMENT ON COLUMN PFU.PFU_EPP_LINE_GUARDIAN.COMM                    IS 'Коментар';
COMMENT ON COLUMN PFU.PFU_EPP_LINE_GUARDIAN.ID                      IS 'ID рядка';
COMMENT ON COLUMN PFU.PFU_EPP_LINE_GUARDIAN.BATCH_REQUEST_ID        IS 'ID запиту';
COMMENT ON COLUMN PFU.PFU_EPP_LINE_GUARDIAN.PERSON_RECORD_NUMBER    IS '<num_zo_g> - Номер облікової картки застрахованої особи в Пенсійному фонді';
COMMENT ON COLUMN PFU.PFU_EPP_LINE_GUARDIAN.LAST_NAME               IS '<ln_g> - Прізвище';
COMMENT ON COLUMN PFU.PFU_EPP_LINE_GUARDIAN.FIRST_NAME              IS '<nm_g> - Ім’я';
COMMENT ON COLUMN PFU.PFU_EPP_LINE_GUARDIAN.MIDDLE_NAME             IS '<ftn_g> - По батькові';
COMMENT ON COLUMN PFU.PFU_EPP_LINE_GUARDIAN.GENDER                  IS '<st_g> - Стать';
COMMENT ON COLUMN PFU.PFU_EPP_LINE_GUARDIAN.DATE_OF_BIRTH           IS '<date_birth_g> - Дата народження';
COMMENT ON COLUMN PFU.PFU_EPP_LINE_GUARDIAN.PHONE_NUMBERS           IS '<num_tel_g> - Контактний номер телефону';
COMMENT ON COLUMN PFU.PFU_EPP_LINE_GUARDIAN.EMBOSSING_NAME          IS '<lnf_lat_g> - Транслітерація ПІБ';
COMMENT ON COLUMN PFU.PFU_EPP_LINE_GUARDIAN.TAX_REGISTRATION_NUMBER IS '<numident_g> - РНОКПП';
COMMENT ON COLUMN PFU.PFU_EPP_LINE_GUARDIAN.DOCUMENT_TYPE           IS '<type_doc_g> - Тип документу';
COMMENT ON COLUMN PFU.PFU_EPP_LINE_GUARDIAN.DOCUMENT_ID             IS '<ser_num_g> - Серія та номер документу';
COMMENT ON COLUMN PFU.PFU_EPP_LINE_GUARDIAN.DOCUMENT_ISSUE_DATE     IS '<date_doc_g> - Дата видачі документу';
COMMENT ON COLUMN PFU.PFU_EPP_LINE_GUARDIAN.DOCUMENT_ISSUER         IS '<issued_doc_g> - Ким видано документ';
COMMENT ON COLUMN PFU.PFU_EPP_LINE_GUARDIAN.DISPLACED_PERSON_FLAG   IS '<type_osob_g> - Ознака «тимчасово переміщена особа»';
COMMENT ON COLUMN PFU.PFU_EPP_LINE_GUARDIAN.LEGAL_COUNTRY           IS '<country_reg_g> - Країна';
COMMENT ON COLUMN PFU.PFU_EPP_LINE_GUARDIAN.LEGAL_ZIP_CODE          IS '<post_reg_g> - індекс';
COMMENT ON COLUMN PFU.PFU_EPP_LINE_GUARDIAN.LEGAL_REGION            IS '<region_reg_g> - область';
COMMENT ON COLUMN PFU.PFU_EPP_LINE_GUARDIAN.LEGAL_DISTRICT          IS '<area_reg_g> - район';
COMMENT ON COLUMN PFU.PFU_EPP_LINE_GUARDIAN.LEGAL_SETTLEMENT        IS '<settl_reg_g> - населений пункт';
COMMENT ON COLUMN PFU.PFU_EPP_LINE_GUARDIAN.LEGAL_STREET            IS '<street_reg_g> - вулиця';
COMMENT ON COLUMN PFU.PFU_EPP_LINE_GUARDIAN.LEGAL_HOUSE             IS '<house_reg_g> - будинок';
COMMENT ON COLUMN PFU.PFU_EPP_LINE_GUARDIAN.LEGAL_HOUSE_PART        IS '<corps_reg_g> - корпус';
COMMENT ON COLUMN PFU.PFU_EPP_LINE_GUARDIAN.LEGAL_APARTMENT         IS '<apart_reg_g> - квартира';
COMMENT ON COLUMN PFU.PFU_EPP_LINE_GUARDIAN.ACTUAL_COUNTRY          IS '<country_act_g> - Країна';
COMMENT ON COLUMN PFU.PFU_EPP_LINE_GUARDIAN.ACTUAL_ZIP_CODE         IS '<post_act_g> - індекс';
COMMENT ON COLUMN PFU.PFU_EPP_LINE_GUARDIAN.ACTUAL_REGION           IS '<region_act_g> - область';
COMMENT ON COLUMN PFU.PFU_EPP_LINE_GUARDIAN.ACTUAL_DISTRICT         IS '<area_act_g> - район';
COMMENT ON COLUMN PFU.PFU_EPP_LINE_GUARDIAN.ACTUAL_SETTLEMENT       IS '<settl_act_g> - населений пункт';
COMMENT ON COLUMN PFU.PFU_EPP_LINE_GUARDIAN.ACTUAL_STREET           IS '<street_act_g> - вулиця';
COMMENT ON COLUMN PFU.PFU_EPP_LINE_GUARDIAN.ACTUAL_HOUSE            IS '<house_act_g> - будинок';
COMMENT ON COLUMN PFU.PFU_EPP_LINE_GUARDIAN.ACTUAL_HOUSE_PART       IS '<corps_act_g> - корпус';
COMMENT ON COLUMN PFU.PFU_EPP_LINE_GUARDIAN.ACTUAL_APARTMENT        IS '<apart_act_g> - квартира';
COMMENT ON COLUMN PFU.PFU_EPP_LINE_GUARDIAN.STATE_ID                IS 'Стан рядка опікуна';
COMMENT ON COLUMN PFU.PFU_EPP_LINE_GUARDIAN.LINE_SIGN               IS '';
COMMENT ON COLUMN PFU.PFU_EPP_LINE_GUARDIAN.PENS_TYPE               IS '<pens_type_g> - Ознака пенсійних виплат';



PROMPT *** Create  constraint CC_GUARDIAN_ID_NN ***
begin   
 execute immediate '
  alter table PFU.PFU_EPP_LINE_GUARDIAN add constraint CC_GUARDIAN_ID_NN check ("ID" IS NOT NULL) ENABLE';
exception when others then
  if sqlcode = -2264 or sqlcode = -2261 then null; else raise; end if;
 end;
/



PROMPT *** Create  constraint CC_GUARD_BATCH_REQUEST_ID_NN ***
begin   
 execute immediate '
  alter table PFU.PFU_EPP_LINE_GUARDIAN add constraint CC_GUARD_BATCH_REQUEST_ID_NN check ("BATCH_REQUEST_ID" IS NOT NULL) ENABLE';
exception when others then
  if sqlcode = -2264 or sqlcode = -2261 then null; else raise; end if;
 end;
/



PROMPT *** Create  constraint PK_PFU_EPP_LINE_GUARDIAN ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_EPP_LINE_GUARDIAN ADD CONSTRAINT PK_PFU_EPP_LINE_GUARDIAN PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PFU_EPP_LINE_GUARDIAN ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX PFU.PK_PFU_EPP_LINE_GUARDIAN ON PFU.PFU_EPP_LINE_GUARDIAN (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_EPP_LINE_GUARDIAN_STATE_ID ***
begin
    execute immediate 'create index I_EPP_LINE_GUARDIAN_STATE_ID on PFU.PFU_EPP_LINE_GUARDIAN (STATE_ID)';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/


PROMPT *** Create  constraint FK_EPP_LINE_GUARDIAN_STATE_ID ***
begin
    execute immediate 'alter table PFU.PFU_EPP_LINE_GUARDIAN add constraint FK_EPP_LINE_GUARDIAN_STATE_ID foreign key (STATE_ID) references PFU.PFU_EPP_LINE_STATE (ID)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table PFU.PFU_EPP_LINE_GUARDIAN add constraint FK_EPP_LINE_GUARDIAN_REF_BATCH foreign key (BATCH_REQUEST_ID) references PFU.PFU_EPP_BATCH_REQUEST (ID)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'create index I_EPP_LINE_GUARDIAN_REF_BATCH on PFU.PFU_EPP_LINE_GUARDIAN (BATCH_REQUEST_ID)';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/


PROMPT *** Create  grants  PFU_EPP_LINE_GUARDIAN ***
grant SELECT                                                                 on PFU_EPP_LINE_GUARDIAN    to BARSREADER_ROLE;
grant SELECT                                                                 on PFU_EPP_LINE_GUARDIAN    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/Table/PFU_EPP_LINE_GUARDIAN.sql =========*** End *** =
PROMPT ===================================================================================== 
