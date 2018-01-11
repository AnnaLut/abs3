

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_RI_CLOB.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_RI_CLOB ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_RI_CLOB ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_RI_CLOB 
   (	C CLOB, 
	NAMEF NUMBER(22,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND 
 LOB (C) STORE AS BASICFILE (
  TABLESPACE BRSDYND ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_RI_CLOB ***
 exec bpa.alter_policies('TMP_RI_CLOB');


COMMENT ON TABLE BARS.TMP_RI_CLOB IS 'Тимчасова таблиця для XML-файлів реєстру інсайдерів';
COMMENT ON COLUMN BARS.TMP_RI_CLOB.C IS 'Тіло файлу';
COMMENT ON COLUMN BARS.TMP_RI_CLOB.NAMEF IS 'Ключ';




PROMPT *** Create  constraint PK_TMP_RI_CLOB_NAMEF ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_RI_CLOB ADD CONSTRAINT PK_TMP_RI_CLOB_NAMEF PRIMARY KEY (NAMEF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMP_RI_CLOB_NAMEF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_RI_CLOB MODIFY (NAMEF CONSTRAINT CC_TMP_RI_CLOB_NAMEF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TMP_RI_CLOB_NAMEF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TMP_RI_CLOB_NAMEF ON BARS.TMP_RI_CLOB (NAMEF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_RI_CLOB ***
grant SELECT                                                                 on TMP_RI_CLOB     to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_RI_CLOB     to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_RI_CLOB     to TECH005;
grant SELECT                                                                 on TMP_RI_CLOB     to UPLD;



PROMPT *** Create SYNONYM  to TMP_RI_CLOB ***

  CREATE OR REPLACE PUBLIC SYNONYM TMP_RI_CLOB FOR BARS.TMP_RI_CLOB;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_RI_CLOB.sql =========*** End *** =
PROMPT ===================================================================================== 
