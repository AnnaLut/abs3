

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_EXPDPTYPE.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_EXPDPTYPE ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_EXPDPTYPE ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_EXPDPTYPE 
   (	MODCODE CHAR(3), 
	TYPEID NUMBER(38,0), 
	CLOBDATA CLOB, 
	CLOBLENG NUMBER(38,0)
   ) ON COMMIT DELETE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_EXPDPTYPE ***
 exec bpa.alter_policies('TMP_EXPDPTYPE');


COMMENT ON TABLE BARS.TMP_EXPDPTYPE IS 'Временная таблица для экспорта вида деп.договора ФЛ/ЮЛ';
COMMENT ON COLUMN BARS.TMP_EXPDPTYPE.MODCODE IS 'Код модуля';
COMMENT ON COLUMN BARS.TMP_EXPDPTYPE.TYPEID IS 'Код вида договора';
COMMENT ON COLUMN BARS.TMP_EXPDPTYPE.CLOBDATA IS 'Сценарий';
COMMENT ON COLUMN BARS.TMP_EXPDPTYPE.CLOBLENG IS 'Длина сценария';




PROMPT *** Create  constraint PK_TMPEXPDPTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_EXPDPTYPE ADD CONSTRAINT PK_TMPEXPDPTYPE PRIMARY KEY (MODCODE, TYPEID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPEXPDPTYPE_TYPEID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_EXPDPTYPE MODIFY (TYPEID CONSTRAINT CC_TMPEXPDPTYPE_TYPEID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPEXPDPTYPE_MODCODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_EXPDPTYPE MODIFY (MODCODE CONSTRAINT CC_TMPEXPDPTYPE_MODCODE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TMPEXPDPTYPE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TMPEXPDPTYPE ON BARS.TMP_EXPDPTYPE (MODCODE, TYPEID) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_EXPDPTYPE ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_EXPDPTYPE   to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_EXPDPTYPE   to DPT;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_EXPDPTYPE   to DPT_ADMIN;



PROMPT *** Create SYNONYM  to TMP_EXPDPTYPE ***

  CREATE OR REPLACE PUBLIC SYNONYM TMP_EXPDPTYPE FOR BARS.TMP_EXPDPTYPE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_EXPDPTYPE.sql =========*** End ***
PROMPT ===================================================================================== 
