

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/IMPORT_FILES.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to IMPORT_FILES ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table IMPORT_FILES ***
begin 
  execute immediate '
  CREATE TABLE BARS.IMPORT_FILES 
   (	FN VARCHAR2(30), 
	DAT DATE, 
	FILE_TYPE NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to IMPORT_FILES ***
 exec bpa.alter_policies('IMPORT_FILES');


COMMENT ON TABLE BARS.IMPORT_FILES IS 'Архів прийнятих файлів з документами із зовнішніх задач';
COMMENT ON COLUMN BARS.IMPORT_FILES.FN IS 'Імя файлу ';
COMMENT ON COLUMN BARS.IMPORT_FILES.DAT IS 'Банкывська дата обробки файлу';
COMMENT ON COLUMN BARS.IMPORT_FILES.FILE_TYPE IS '';



PROMPT *** Create  grants  IMPORT_FILES ***
grant SELECT                                                                 on IMPORT_FILES    to BARSREADER_ROLE;
grant SELECT                                                                 on IMPORT_FILES    to BARS_DM;
grant SELECT                                                                 on IMPORT_FILES    to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on IMPORT_FILES    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/IMPORT_FILES.sql =========*** End *** 
PROMPT ===================================================================================== 
