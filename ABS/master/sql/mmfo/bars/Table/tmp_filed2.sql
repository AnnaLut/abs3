

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_FILED2.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_FILED2 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_FILED2 ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_FILED2 
   (	Z_DATE DATE, 
	N_SYSTEM NUMBER(*,0), 
	N_PP NUMBER(10,0), 
	RNK NUMBER(*,0), 
	ID_KOD CHAR(10), 
	NUMDOC CHAR(10), 
	NLS NUMBER(18,0), 
	KV NUMBER(*,0), 
	K013 CHAR(1), 
	ID_N NUMBER(15,0)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_FILED2 ***
 exec bpa.alter_policies('TMP_FILED2');


COMMENT ON TABLE BARS.TMP_FILED2 IS 'Временная таблица для типов контрагентов с локальных задач';
COMMENT ON COLUMN BARS.TMP_FILED2.Z_DATE IS 'Звiтна дата';
COMMENT ON COLUMN BARS.TMP_FILED2.N_SYSTEM IS 'Код системи';
COMMENT ON COLUMN BARS.TMP_FILED2.N_PP IS 'N п/п';
COMMENT ON COLUMN BARS.TMP_FILED2.RNK IS 'РНК контрагента';
COMMENT ON COLUMN BARS.TMP_FILED2.ID_KOD IS 'Код ОКПО';
COMMENT ON COLUMN BARS.TMP_FILED2.NUMDOC IS 'Номер документа';
COMMENT ON COLUMN BARS.TMP_FILED2.NLS IS 'Особовий рах.';
COMMENT ON COLUMN BARS.TMP_FILED2.KV IS 'Код валюти';
COMMENT ON COLUMN BARS.TMP_FILED2.K013 IS 'Код контрагента';
COMMENT ON COLUMN BARS.TMP_FILED2.ID_N IS 'Номер ID';



PROMPT *** Create  grants  TMP_FILED2 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_FILED2      to ABS_ADMIN;
grant SELECT                                                                 on TMP_FILED2      to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_FILED2      to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_FILED2      to RPBN002;
grant SELECT                                                                 on TMP_FILED2      to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_FILED2      to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_FILED2.sql =========*** End *** ==
PROMPT ===================================================================================== 
