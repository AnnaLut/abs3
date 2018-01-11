

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_EMI_LOT1.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_EMI_LOT1 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_EMI_LOT1 ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_EMI_LOT1 
   (	EMI CHAR(2), 
	NAME_EMI VARCHAR2(45), 
	SV_2905 NUMBER, 
	SI_2905 NUMBER, 
	SV_2805 NUMBER, 
	SI_2805 NUMBER, 
	LOT CHAR(6), 
	NAME_LOT VARCHAR2(45), 
	KV_9819 NUMBER, 
	KI_9819 NUMBER, 
	KD_9819 NUMBER, 
	KK_9819 NUMBER, 
	SK_2905 NUMBER, 
	KD_9812 NUMBER, 
	SD_2805 NUMBER, 
	BRANCH VARCHAR2(30), 
	CENA NUMBER, 
	KZ_9819 NUMBER, 
	SD_2805XX NUMBER, 
	SD_2805PFU NUMBER, 
	SD_2805VZ NUMBER
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_EMI_LOT1 ***
 exec bpa.alter_policies('TMP_EMI_LOT1');


COMMENT ON TABLE BARS.TMP_EMI_LOT1 IS '';
COMMENT ON COLUMN BARS.TMP_EMI_LOT1.EMI IS '';
COMMENT ON COLUMN BARS.TMP_EMI_LOT1.NAME_EMI IS '';
COMMENT ON COLUMN BARS.TMP_EMI_LOT1.SV_2905 IS '';
COMMENT ON COLUMN BARS.TMP_EMI_LOT1.SI_2905 IS '';
COMMENT ON COLUMN BARS.TMP_EMI_LOT1.SV_2805 IS '';
COMMENT ON COLUMN BARS.TMP_EMI_LOT1.SI_2805 IS '';
COMMENT ON COLUMN BARS.TMP_EMI_LOT1.LOT IS '';
COMMENT ON COLUMN BARS.TMP_EMI_LOT1.NAME_LOT IS '';
COMMENT ON COLUMN BARS.TMP_EMI_LOT1.KV_9819 IS '';
COMMENT ON COLUMN BARS.TMP_EMI_LOT1.KI_9819 IS '';
COMMENT ON COLUMN BARS.TMP_EMI_LOT1.KD_9819 IS '';
COMMENT ON COLUMN BARS.TMP_EMI_LOT1.KK_9819 IS '';
COMMENT ON COLUMN BARS.TMP_EMI_LOT1.SK_2905 IS '';
COMMENT ON COLUMN BARS.TMP_EMI_LOT1.KD_9812 IS '';
COMMENT ON COLUMN BARS.TMP_EMI_LOT1.SD_2805 IS '';
COMMENT ON COLUMN BARS.TMP_EMI_LOT1.BRANCH IS '';
COMMENT ON COLUMN BARS.TMP_EMI_LOT1.CENA IS '';
COMMENT ON COLUMN BARS.TMP_EMI_LOT1.KZ_9819 IS '';
COMMENT ON COLUMN BARS.TMP_EMI_LOT1.SD_2805XX IS '';
COMMENT ON COLUMN BARS.TMP_EMI_LOT1.SD_2805PFU IS '';
COMMENT ON COLUMN BARS.TMP_EMI_LOT1.SD_2805VZ IS '';



PROMPT *** Create  grants  TMP_EMI_LOT1 ***
grant SELECT                                                                 on TMP_EMI_LOT1    to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_EMI_LOT1    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_EMI_LOT1    to RPBN001;
grant SELECT                                                                 on TMP_EMI_LOT1    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_EMI_LOT1.sql =========*** End *** 
PROMPT ===================================================================================== 
