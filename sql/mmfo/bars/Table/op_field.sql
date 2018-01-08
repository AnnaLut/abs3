

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OP_FIELD.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OP_FIELD ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OP_FIELD'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''OP_FIELD'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''OP_FIELD'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OP_FIELD ***
begin 
  execute immediate '
  CREATE TABLE BARS.OP_FIELD 
   (	TAG CHAR(5), 
	NAME VARCHAR2(35), 
	FMT VARCHAR2(35), 
	BROWSER VARCHAR2(250), 
	NOMODIFY NUMBER(1,0), 
	VSPO_CHAR VARCHAR2(1), 
	CHKR VARCHAR2(250), 
	DEFAULT_VALUE VARCHAR2(500), 
	TYPE CHAR(1), 
	USE_IN_ARCH NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OP_FIELD ***
 exec bpa.alter_policies('OP_FIELD');


COMMENT ON TABLE BARS.OP_FIELD IS 'Расшифровка полей SWIFT-сообщений';
COMMENT ON COLUMN BARS.OP_FIELD.TAG IS 'Код';
COMMENT ON COLUMN BARS.OP_FIELD.NAME IS 'Наименование';
COMMENT ON COLUMN BARS.OP_FIELD.FMT IS 'Формат';
COMMENT ON COLUMN BARS.OP_FIELD.BROWSER IS 'Строка вызова справочника';
COMMENT ON COLUMN BARS.OP_FIELD.NOMODIFY IS '';
COMMENT ON COLUMN BARS.OP_FIELD.VSPO_CHAR IS '';
COMMENT ON COLUMN BARS.OP_FIELD.CHKR IS 'Строка вызова процедуры проверки значения';
COMMENT ON COLUMN BARS.OP_FIELD.DEFAULT_VALUE IS '';
COMMENT ON COLUMN BARS.OP_FIELD.TYPE IS 'Тип доп.реквизита';
COMMENT ON COLUMN BARS.OP_FIELD.USE_IN_ARCH IS 'Перенос реквизита в архивную схему';




PROMPT *** Create  constraint PK_OPFIELD ***
begin   
 execute immediate '
  ALTER TABLE BARS.OP_FIELD ADD CONSTRAINT PK_OPFIELD PRIMARY KEY (TAG)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OPFIELDS_INARCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OP_FIELD ADD CONSTRAINT CC_OPFIELDS_INARCH_NN CHECK (use_in_arch is not null) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007419 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OP_FIELD MODIFY (TAG NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OPFIELD_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OP_FIELD MODIFY (NAME CONSTRAINT CC_OPFIELD_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OPFIELD ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OPFIELD ON BARS.OP_FIELD (TAG) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OP_FIELD ***
grant DELETE,INSERT,SELECT,UPDATE                                            on OP_FIELD        to ABS_ADMIN;
grant FLASHBACK,REFERENCES,SELECT                                            on OP_FIELD        to BARSAQ with grant option;
grant REFERENCES,SELECT                                                      on OP_FIELD        to BARSAQ_ADM with grant option;
grant SELECT                                                                 on OP_FIELD        to BARSREADER_ROLE;
grant SELECT                                                                 on OP_FIELD        to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OP_FIELD        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OP_FIELD        to BARS_DM;
grant SELECT                                                                 on OP_FIELD        to KLBX;
grant DELETE,INSERT,SELECT,UPDATE                                            on OP_FIELD        to OP_FIELD;
grant SELECT                                                                 on OP_FIELD        to START1;
grant SELECT                                                                 on OP_FIELD        to TECH005;
grant SELECT                                                                 on OP_FIELD        to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OP_FIELD        to WR_ALL_RIGHTS;
grant SELECT                                                                 on OP_FIELD        to WR_DOCVIEW;
grant SELECT                                                                 on OP_FIELD        to WR_DOC_INPUT;
grant SELECT                                                                 on OP_FIELD        to WR_KP;
grant FLASHBACK,SELECT                                                       on OP_FIELD        to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OP_FIELD.sql =========*** End *** ====
PROMPT ===================================================================================== 
