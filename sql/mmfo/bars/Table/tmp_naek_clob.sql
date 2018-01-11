

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_NAEK_CLOB.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_NAEK_CLOB ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_NAEK_CLOB ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_NAEK_CLOB 
   (	FILE_NAME VARCHAR2(12), 
	C CLOB
   ) ON COMMIT DELETE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_NAEK_CLOB ***
 exec bpa.alter_policies('TMP_NAEK_CLOB');


COMMENT ON TABLE BARS.TMP_NAEK_CLOB IS 'Временная таблица для записи CLOB';
COMMENT ON COLUMN BARS.TMP_NAEK_CLOB.FILE_NAME IS '';
COMMENT ON COLUMN BARS.TMP_NAEK_CLOB.C IS '';



PROMPT *** Create  grants  TMP_NAEK_CLOB ***
grant SELECT                                                                 on TMP_NAEK_CLOB   to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_NAEK_CLOB   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_NAEK_CLOB   to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_NAEK_CLOB   to TOSS;
grant SELECT                                                                 on TMP_NAEK_CLOB   to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_NAEK_CLOB   to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_NAEK_CLOB.sql =========*** End ***
PROMPT ===================================================================================== 
