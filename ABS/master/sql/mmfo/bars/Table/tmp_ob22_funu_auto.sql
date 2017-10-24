

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_OB22_FUNU_AUTO.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_OB22_FUNU_AUTO ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMP_OB22_FUNU_AUTO'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_OB22_FUNU_AUTO'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_OB22_FUNU_AUTO'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_OB22_FUNU_AUTO ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_OB22_FUNU_AUTO 
   (	PRIZN CHAR(1), 
	PRIZN_D CHAR(1), 
	ACCD NUMBER, 
	NLSN_D VARCHAR2(15), 
	OB22_D VARCHAR2(2), 
	PRIZN_K CHAR(1), 
	ACCK NUMBER, 
	NLSN_K VARCHAR2(15), 
	OB22_K VARCHAR2(2), 
	FDAT DATE, 
	REF NUMBER, 
	NLSD VARCHAR2(15), 
	NLSK VARCHAR2(15), 
	S NUMBER, 
	NAZN VARCHAR2(160), 
	VOB NUMBER, 
	VDAT DATE, 
	STMT NUMBER, 
	OTM NUMBER(*,0), 
	TT CHAR(3), 
	KSN_D VARCHAR2(15), 
	KSN_K VARCHAR2(15), 
	NMSN_D VARCHAR2(70), 
	NMSN_K VARCHAR2(70)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_OB22_FUNU_AUTO ***
 exec bpa.alter_policies('TMP_OB22_FUNU_AUTO');


COMMENT ON TABLE BARS.TMP_OB22_FUNU_AUTO IS '';
COMMENT ON COLUMN BARS.TMP_OB22_FUNU_AUTO.PRIZN IS '';
COMMENT ON COLUMN BARS.TMP_OB22_FUNU_AUTO.PRIZN_D IS '';
COMMENT ON COLUMN BARS.TMP_OB22_FUNU_AUTO.ACCD IS '';
COMMENT ON COLUMN BARS.TMP_OB22_FUNU_AUTO.NLSN_D IS '';
COMMENT ON COLUMN BARS.TMP_OB22_FUNU_AUTO.OB22_D IS '';
COMMENT ON COLUMN BARS.TMP_OB22_FUNU_AUTO.PRIZN_K IS '';
COMMENT ON COLUMN BARS.TMP_OB22_FUNU_AUTO.ACCK IS '';
COMMENT ON COLUMN BARS.TMP_OB22_FUNU_AUTO.NLSN_K IS '';
COMMENT ON COLUMN BARS.TMP_OB22_FUNU_AUTO.OB22_K IS '';
COMMENT ON COLUMN BARS.TMP_OB22_FUNU_AUTO.FDAT IS '';
COMMENT ON COLUMN BARS.TMP_OB22_FUNU_AUTO.REF IS '';
COMMENT ON COLUMN BARS.TMP_OB22_FUNU_AUTO.NLSD IS '';
COMMENT ON COLUMN BARS.TMP_OB22_FUNU_AUTO.NLSK IS '';
COMMENT ON COLUMN BARS.TMP_OB22_FUNU_AUTO.S IS '';
COMMENT ON COLUMN BARS.TMP_OB22_FUNU_AUTO.NAZN IS '';
COMMENT ON COLUMN BARS.TMP_OB22_FUNU_AUTO.VOB IS '';
COMMENT ON COLUMN BARS.TMP_OB22_FUNU_AUTO.VDAT IS '';
COMMENT ON COLUMN BARS.TMP_OB22_FUNU_AUTO.STMT IS '';
COMMENT ON COLUMN BARS.TMP_OB22_FUNU_AUTO.OTM IS '';
COMMENT ON COLUMN BARS.TMP_OB22_FUNU_AUTO.TT IS '';
COMMENT ON COLUMN BARS.TMP_OB22_FUNU_AUTO.KSN_D IS '';
COMMENT ON COLUMN BARS.TMP_OB22_FUNU_AUTO.KSN_K IS '';
COMMENT ON COLUMN BARS.TMP_OB22_FUNU_AUTO.NMSN_D IS '';
COMMENT ON COLUMN BARS.TMP_OB22_FUNU_AUTO.NMSN_K IS '';



PROMPT *** Create  grants  TMP_OB22_FUNU_AUTO ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_OB22_FUNU_AUTO to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_OB22_FUNU_AUTO to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_OB22_FUNU_AUTO to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_OB22_FUNU_AUTO.sql =========*** En
PROMPT ===================================================================================== 
