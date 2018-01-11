

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_KLP_CLOB.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_KLP_CLOB ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_KLP_CLOB ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_KLP_CLOB 
   (	NAMEF VARCHAR2(12), 
	C CLOB
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




PROMPT *** ALTER_POLICIES to TMP_KLP_CLOB ***
 exec bpa.alter_policies('TMP_KLP_CLOB');


COMMENT ON TABLE BARS.TMP_KLP_CLOB IS 'Временная таблица для записи CLOB вал.КБ';
COMMENT ON COLUMN BARS.TMP_KLP_CLOB.NAMEF IS '';
COMMENT ON COLUMN BARS.TMP_KLP_CLOB.C IS '';



PROMPT *** Create  grants  TMP_KLP_CLOB ***
grant SELECT                                                                 on TMP_KLP_CLOB    to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_KLP_CLOB    to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_KLP_CLOB    to TECH_MOM1;
grant SELECT                                                                 on TMP_KLP_CLOB    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_KLP_CLOB.sql =========*** End *** 
PROMPT ===================================================================================== 
