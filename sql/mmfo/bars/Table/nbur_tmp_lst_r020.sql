

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBUR_TMP_LST_R020.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NBUR_TMP_LST_R020 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBUR_TMP_LST_R020'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBUR_TMP_LST_R020 ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.NBUR_TMP_LST_R020 
   (	R020 CHAR(4)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NBUR_TMP_LST_R020 ***
 exec bpa.alter_policies('NBUR_TMP_LST_R020');


COMMENT ON TABLE BARS.NBUR_TMP_LST_R020 IS '“имчасова таблиц€ дл€ A7 та ≥нших файл≥в';
COMMENT ON COLUMN BARS.NBUR_TMP_LST_R020.R020 IS '';



PROMPT *** Create  grants  NBUR_TMP_LST_R020 ***
grant SELECT                                                                 on NBUR_TMP_LST_R020 to BARSREADER_ROLE;
grant SELECT                                                                 on NBUR_TMP_LST_R020 to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NBUR_TMP_LST_R020 to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBUR_TMP_LST_R020.sql =========*** End
PROMPT ===================================================================================== 
