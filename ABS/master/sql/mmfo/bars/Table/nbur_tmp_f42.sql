

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBUR_TMP_F42.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NBUR_TMP_F42 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBUR_TMP_F42'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBUR_TMP_F42 ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.NBUR_TMP_F42 
   (	ACC NUMBER, 
	KV NUMBER(*,0), 
	FDAT DATE, 
	NBS CHAR(4), 
	NLS VARCHAR2(15), 
	OST_NOM NUMBER, 
	OST_EQV NUMBER, 
	AP NUMBER, 
	R012 CHAR(1), 
	R013 CHAR(1), 
	DDD CHAR(3), 
	R020 CHAR(4), 
	ACCC NUMBER(*,0), 
	ZAL NUMBER, 
	K060 CHAR(2), 
	RNK NUMBER, 
	RNKP NUMBER, 
	OKPO VARCHAR2(10)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NBUR_TMP_F42 ***
 exec bpa.alter_policies('NBUR_TMP_F42');


COMMENT ON TABLE BARS.NBUR_TMP_F42 IS 'Тимчасова таблиця рахунків та залишків для файлу #42';
COMMENT ON COLUMN BARS.NBUR_TMP_F42.ACC IS '';
COMMENT ON COLUMN BARS.NBUR_TMP_F42.KV IS '';
COMMENT ON COLUMN BARS.NBUR_TMP_F42.FDAT IS '';
COMMENT ON COLUMN BARS.NBUR_TMP_F42.NBS IS '';
COMMENT ON COLUMN BARS.NBUR_TMP_F42.NLS IS '';
COMMENT ON COLUMN BARS.NBUR_TMP_F42.OST_NOM IS '';
COMMENT ON COLUMN BARS.NBUR_TMP_F42.OST_EQV IS '';
COMMENT ON COLUMN BARS.NBUR_TMP_F42.AP IS '';
COMMENT ON COLUMN BARS.NBUR_TMP_F42.R012 IS '';
COMMENT ON COLUMN BARS.NBUR_TMP_F42.R013 IS '';
COMMENT ON COLUMN BARS.NBUR_TMP_F42.DDD IS '';
COMMENT ON COLUMN BARS.NBUR_TMP_F42.R020 IS '';
COMMENT ON COLUMN BARS.NBUR_TMP_F42.ACCC IS '';
COMMENT ON COLUMN BARS.NBUR_TMP_F42.ZAL IS '';
COMMENT ON COLUMN BARS.NBUR_TMP_F42.K060 IS '';
COMMENT ON COLUMN BARS.NBUR_TMP_F42.RNK IS '';
COMMENT ON COLUMN BARS.NBUR_TMP_F42.RNKP IS '';
COMMENT ON COLUMN BARS.NBUR_TMP_F42.OKPO IS '';



PROMPT *** Create  grants  NBUR_TMP_F42 ***
grant SELECT                                                                 on NBUR_TMP_F42    to BARSREADER_ROLE;
grant SELECT                                                                 on NBUR_TMP_F42    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBUR_TMP_F42.sql =========*** End *** 
PROMPT ===================================================================================== 
