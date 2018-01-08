

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_KOD_R020.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_KOD_R020 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_KOD_R020 ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_KOD_R020 
   (	R020 CHAR(4)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_KOD_R020 ***
 exec bpa.alter_policies('TMP_KOD_R020');


COMMENT ON TABLE BARS.TMP_KOD_R020 IS 'Временная таблица для бал.счетов начисленных процентов';
COMMENT ON COLUMN BARS.TMP_KOD_R020.R020 IS '';



PROMPT *** Create  grants  TMP_KOD_R020 ***
grant SELECT                                                                 on TMP_KOD_R020    to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_KOD_R020    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_KOD_R020.sql =========*** End *** 
PROMPT ===================================================================================== 
