

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CUSTOMER_FIELD.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CUSTOMER_FIELD ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CUSTOMER_FIELD'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CUSTOMER_FIELD'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CUSTOMER_FIELD'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CUSTOMER_FIELD ***
begin 
  execute immediate '
  CREATE TABLE BARS.CUSTOMER_FIELD 
   (	TAG CHAR(5), 
	NAME VARCHAR2(70), 
	B NUMBER(1,0), 
	U NUMBER(1,0), 
	F NUMBER(1,0), 
	TABNAME VARCHAR2(60), 
	BYISP NUMBER(1,0), 
	TYPE CHAR(1), 
	OPT NUMBER(1,0), 
	TABCOLUMN_CHECK VARCHAR2(30), 
	SQLVAL VARCHAR2(254), 
	CODE VARCHAR2(30) DEFAULT ''OTHERS'', 
	NOT_TO_EDIT NUMBER(1,0) DEFAULT 0, 
	HIST NUMBER(1,0), 
	PARID NUMBER(22,0), 
	U_NREZ NUMBER(1,0), 
	F_NREZ NUMBER(1,0), 
	F_SPD NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CUSTOMER_FIELD ***
 exec bpa.alter_policies('CUSTOMER_FIELD');


COMMENT ON TABLE BARS.CUSTOMER_FIELD IS 'Справочник доп. реквизитов клиентов';
COMMENT ON COLUMN BARS.CUSTOMER_FIELD.TAG IS 'Код реквизита';
COMMENT ON COLUMN BARS.CUSTOMER_FIELD.NAME IS 'Наименование реквизита';
COMMENT ON COLUMN BARS.CUSTOMER_FIELD.B IS 'Признак заполнения для клиента Банк (0-не заполнять, 1-заполнять, 2-заполнять обязательно)';
COMMENT ON COLUMN BARS.CUSTOMER_FIELD.U IS 'Признак заполнения для клиента ЮЛ (0-не заполнять, 1-заполнять, 2-заполнять обязательно)';
COMMENT ON COLUMN BARS.CUSTOMER_FIELD.F IS 'Признак заполнения для клиента ФЛ (0-не заполнять, 1-заполнять, 2-заполнять обязательно)';
COMMENT ON COLUMN BARS.CUSTOMER_FIELD.TABNAME IS 'Справочник';
COMMENT ON COLUMN BARS.CUSTOMER_FIELD.BYISP IS 'Учитывать доступ по исполнителю';
COMMENT ON COLUMN BARS.CUSTOMER_FIELD.TYPE IS 'Тип реквизита (N, D, S)';
COMMENT ON COLUMN BARS.CUSTOMER_FIELD.OPT IS 'Обязательность заполнения доп.реквизита(1/0)';
COMMENT ON COLUMN BARS.CUSTOMER_FIELD.TABCOLUMN_CHECK IS 'Контроль значения по полю';
COMMENT ON COLUMN BARS.CUSTOMER_FIELD.SQLVAL IS 'Sql-выражение для умолчательного значения доп.реквизита (напр., select '1' from dual)';
COMMENT ON COLUMN BARS.CUSTOMER_FIELD.CODE IS '';
COMMENT ON COLUMN BARS.CUSTOMER_FIELD.NOT_TO_EDIT IS 'Запретить редактировать в карточке клиента';
COMMENT ON COLUMN BARS.CUSTOMER_FIELD.HIST IS 'Признак: используется в историзированной таблице параметров';
COMMENT ON COLUMN BARS.CUSTOMER_FIELD.PARID IS 'Код параметра';
COMMENT ON COLUMN BARS.CUSTOMER_FIELD.U_NREZ IS 'Признак заполнения для клиента ЮЛ-нерезидент (0-не заполнять, 1-заполнять, 2-заполнять обязательно)';
COMMENT ON COLUMN BARS.CUSTOMER_FIELD.F_NREZ IS 'Признак заполнения для клиента ФЛ-нерезидент (0-не заполнять, 1-заполнять, 2-заполнять обязательно)';
COMMENT ON COLUMN BARS.CUSTOMER_FIELD.F_SPD IS 'Признак заполнения для клиента ФЛ-СПД (0-не заполнять, 1-заполнять, 2-заполнять обязательно)';




PROMPT *** Create  constraint CC_CUSTOMERFIELD_B ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_FIELD ADD CONSTRAINT CC_CUSTOMERFIELD_B CHECK (b in (0, 1, 2)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERFIELD_U ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_FIELD ADD CONSTRAINT CC_CUSTOMERFIELD_U CHECK (u in (0, 1, 2)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERFIELD_NOTTOEDIT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_FIELD MODIFY (NOT_TO_EDIT CONSTRAINT CC_CUSTOMERFIELD_NOTTOEDIT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERFIELD_CODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_FIELD MODIFY (CODE CONSTRAINT CC_CUSTOMERFIELD_CODE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERFIELD_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_FIELD MODIFY (NAME CONSTRAINT CC_CUSTOMERFIELD_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERFIELD_TAG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_FIELD MODIFY (TAG CONSTRAINT CC_CUSTOMERFIELD_TAG_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMERFIELD_CODES ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_FIELD ADD CONSTRAINT FK_CUSTOMERFIELD_CODES FOREIGN KEY (CODE)
	  REFERENCES BARS.CUSTOMER_FIELD_CODES (CODE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMERFIELD_METACOLTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_FIELD ADD CONSTRAINT FK_CUSTOMERFIELD_METACOLTYPES FOREIGN KEY (TYPE)
	  REFERENCES BARS.META_COLTYPES (COLTYPE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERFIELD_OPT ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_FIELD ADD CONSTRAINT CC_CUSTOMERFIELD_OPT CHECK (opt in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERFIELD_F ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_FIELD ADD CONSTRAINT CC_CUSTOMERFIELD_F CHECK (f in (0, 1, 2)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERFIELD_UNREZ ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_FIELD ADD CONSTRAINT CC_CUSTOMERFIELD_UNREZ CHECK (u_nrez in (0, 1, 2)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERFIELD_FNREZ ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_FIELD ADD CONSTRAINT CC_CUSTOMERFIELD_FNREZ CHECK (f_nrez in (0, 1, 2)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERFIELD_FSPD ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_FIELD ADD CONSTRAINT CC_CUSTOMERFIELD_FSPD CHECK (f_spd in (0, 1, 2)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_CUSTOMERFIELD_PARID ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_FIELD ADD CONSTRAINT UK_CUSTOMERFIELD_PARID UNIQUE (PARID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_CUSTOMERFIELD ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_FIELD ADD CONSTRAINT PK_CUSTOMERFIELD PRIMARY KEY (TAG)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERFIELD_BYISP ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_FIELD ADD CONSTRAINT CC_CUSTOMERFIELD_BYISP CHECK (byisp in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CUSTOMERFIELD ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CUSTOMERFIELD ON BARS.CUSTOMER_FIELD (TAG) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_CUSTOMERFIELD_PARID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_CUSTOMERFIELD_PARID ON BARS.CUSTOMER_FIELD (PARID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CUSTOMER_FIELD ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CUSTOMER_FIELD  to ABS_ADMIN;
grant SELECT                                                                 on CUSTOMER_FIELD  to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CUSTOMER_FIELD  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CUSTOMER_FIELD  to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CUSTOMER_FIELD  to CUSTOMER_FIELD;
grant SELECT                                                                 on CUSTOMER_FIELD  to RCC_DEAL;
grant SELECT                                                                 on CUSTOMER_FIELD  to START1;
grant SELECT                                                                 on CUSTOMER_FIELD  to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CUSTOMER_FIELD  to WR_ALL_RIGHTS;
grant SELECT                                                                 on CUSTOMER_FIELD  to WR_CUSTREG;
grant FLASHBACK,SELECT                                                       on CUSTOMER_FIELD  to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CUSTOMER_FIELD.sql =========*** End **
PROMPT ===================================================================================== 
