

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_OB529.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_OB529 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMP_OB529'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_OB529'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_OB529'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_OB529 ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_OB529 
   (	ID NUMBER, 
	ACC NUMBER, 
	NLS VARCHAR2(15), 
	KV NUMBER(*,0), 
	NMS VARCHAR2(70), 
	KOLK NUMBER, 
	KOLD NUMBER, 
	SUMK NUMBER, 
	SUMD NUMBER, 
	QUMK NUMBER, 
	QUMD NUMBER, 
	MFOB VARCHAR2(12), 
	NLSB VARCHAR2(15), 
	NAM_B VARCHAR2(38), 
	KOL NUMBER, 
	S NUMBER, 
	Q NUMBER, 
	RU NUMBER(*,0), 
	NAME VARCHAR2(38), 
	TKOLK NUMBER, 
	TKOLD NUMBER, 
	TQUMD NUMBER, 
	TQUMK NUMBER
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_OB529 ***
 exec bpa.alter_policies('TMP_OB529');


COMMENT ON TABLE BARS.TMP_OB529 IS '';
COMMENT ON COLUMN BARS.TMP_OB529.KV IS '';
COMMENT ON COLUMN BARS.TMP_OB529.NMS IS '';
COMMENT ON COLUMN BARS.TMP_OB529.KOLK IS '';
COMMENT ON COLUMN BARS.TMP_OB529.KOLD IS '';
COMMENT ON COLUMN BARS.TMP_OB529.SUMK IS '';
COMMENT ON COLUMN BARS.TMP_OB529.SUMD IS '';
COMMENT ON COLUMN BARS.TMP_OB529.QUMK IS '';
COMMENT ON COLUMN BARS.TMP_OB529.QUMD IS '';
COMMENT ON COLUMN BARS.TMP_OB529.MFOB IS '';
COMMENT ON COLUMN BARS.TMP_OB529.NLSB IS '';
COMMENT ON COLUMN BARS.TMP_OB529.NAM_B IS '';
COMMENT ON COLUMN BARS.TMP_OB529.KOL IS '';
COMMENT ON COLUMN BARS.TMP_OB529.S IS '';
COMMENT ON COLUMN BARS.TMP_OB529.Q IS '';
COMMENT ON COLUMN BARS.TMP_OB529.RU IS '';
COMMENT ON COLUMN BARS.TMP_OB529.NAME IS '';
COMMENT ON COLUMN BARS.TMP_OB529.TKOLK IS '';
COMMENT ON COLUMN BARS.TMP_OB529.TKOLD IS '';
COMMENT ON COLUMN BARS.TMP_OB529.TQUMD IS '';
COMMENT ON COLUMN BARS.TMP_OB529.TQUMK IS '';
COMMENT ON COLUMN BARS.TMP_OB529.ID IS '';
COMMENT ON COLUMN BARS.TMP_OB529.ACC IS '';
COMMENT ON COLUMN BARS.TMP_OB529.NLS IS '';



PROMPT *** Create  grants  TMP_OB529 ***
grant SELECT                                                                 on TMP_OB529       to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_OB529       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_OB529       to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_OB529       to START1;
grant SELECT                                                                 on TMP_OB529       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_OB529.sql =========*** End *** ===
PROMPT ===================================================================================== 
