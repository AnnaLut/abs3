

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_VIDD_FLAGS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_VIDD_FLAGS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_VIDD_FLAGS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_VIDD_FLAGS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DPT_VIDD_FLAGS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_VIDD_FLAGS ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_VIDD_FLAGS 
   (	ID NUMBER(38,0), 
	NAME VARCHAR2(100), 
	DESCRIPTION VARCHAR2(254), 
	MAIN_TT CHAR(3), 
	ONLY_ONE NUMBER(1,0), 
	MOD_PROC VARCHAR2(60), 
	ACTIVITY NUMBER(1,0), 
	REQUEST_TYPECODE VARCHAR2(30), 
	USED_EBP NUMBER(1,0) DEFAULT 0
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_VIDD_FLAGS ***
 exec bpa.alter_policies('DPT_VIDD_FLAGS');


COMMENT ON TABLE BARS.DPT_VIDD_FLAGS IS 'Виды дополнительных соглашений (ДС) по депозитам ФЛ';
COMMENT ON COLUMN BARS.DPT_VIDD_FLAGS.ID IS 'Ид. ДС';
COMMENT ON COLUMN BARS.DPT_VIDD_FLAGS.NAME IS 'Наименование ДС';
COMMENT ON COLUMN BARS.DPT_VIDD_FLAGS.DESCRIPTION IS 'Описание ДС';
COMMENT ON COLUMN BARS.DPT_VIDD_FLAGS.MAIN_TT IS 'Ид. операции';
COMMENT ON COLUMN BARS.DPT_VIDD_FLAGS.ONLY_ONE IS 'Флаг уникальности ДС';
COMMENT ON COLUMN BARS.DPT_VIDD_FLAGS.MOD_PROC IS 'Процедура модификации параметров договора в связи с даным ДС';
COMMENT ON COLUMN BARS.DPT_VIDD_FLAGS.ACTIVITY IS 'Признак активности';
COMMENT ON COLUMN BARS.DPT_VIDD_FLAGS.REQUEST_TYPECODE IS 'Мнемонический код типа запроса';
COMMENT ON COLUMN BARS.DPT_VIDD_FLAGS.USED_EBP IS 'Ознака використання ДУ при роботі по ЕПБ (Ощадбанк): 1 - дод.угода/2 - дод.дії';




PROMPT *** Create  constraint CC_DPTVIDDFLAGS_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_FLAGS MODIFY (ID CONSTRAINT CC_DPTVIDDFLAGS_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDDFLAGS_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_FLAGS MODIFY (NAME CONSTRAINT CC_DPTVIDDFLAGS_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDDFLAGS_ONLYONE ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_FLAGS ADD CONSTRAINT CC_DPTVIDDFLAGS_ONLYONE CHECK ( ONLY_ONE IN (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_DPTVIDDFLAGS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_FLAGS ADD CONSTRAINT PK_DPTVIDDFLAGS PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDDFLAGS_ACTIVITY ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_FLAGS ADD CONSTRAINT CC_DPTVIDDFLAGS_ACTIVITY CHECK (activity in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDDFLAGS_ACTIVITY_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_FLAGS ADD CONSTRAINT CC_DPTVIDDFLAGS_ACTIVITY_NN CHECK (activity is not null) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPTVIDDFLAGS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPTVIDDFLAGS ON BARS.DPT_VIDD_FLAGS (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_VIDD_FLAGS ***
grant SELECT                                                                 on DPT_VIDD_FLAGS  to BARSREADER_ROLE;
grant SELECT                                                                 on DPT_VIDD_FLAGS  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_VIDD_FLAGS  to BARS_DM;
grant SELECT                                                                 on DPT_VIDD_FLAGS  to DPT_ADMIN;
grant SELECT                                                                 on DPT_VIDD_FLAGS  to DPT_ROLE;
grant SELECT                                                                 on DPT_VIDD_FLAGS  to KLBX;
grant SELECT                                                                 on DPT_VIDD_FLAGS  to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_VIDD_FLAGS  to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_VIDD_FLAGS.sql =========*** End **
PROMPT ===================================================================================== 
