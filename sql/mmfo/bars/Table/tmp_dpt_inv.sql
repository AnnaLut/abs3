

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_DPT_INV.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_DPT_INV ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_DPT_INV ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_DPT_INV 
   (	BRANCH VARCHAR2(30), 
	NBS CHAR(4), 
	NLS VARCHAR2(15), 
	NLSN VARCHAR2(15), 
	KV NUMBER(*,0), 
	OB22 VARCHAR2(30), 
	VIDD NUMBER(*,0), 
	KOL NUMBER(*,0), 
	OST NUMBER, 
	OSTQ NUMBER, 
	NOST NUMBER, 
	NOSTQ NUMBER, 
	DOS NUMBER, 
	DOSQ NUMBER, 
	KOS NUMBER, 
	KOSQ NUMBER, 
	OSTI NUMBER, 
	OSTIQ NUMBER, 
	ND NUMBER, 
	NMK VARCHAR2(35), 
	NLSALT VARCHAR2(15), 
	PRIZN NUMBER
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_DPT_INV ***
 exec bpa.alter_policies('TMP_DPT_INV');


COMMENT ON TABLE BARS.TMP_DPT_INV IS '';
COMMENT ON COLUMN BARS.TMP_DPT_INV.BRANCH IS '';
COMMENT ON COLUMN BARS.TMP_DPT_INV.NBS IS '';
COMMENT ON COLUMN BARS.TMP_DPT_INV.NLS IS '';
COMMENT ON COLUMN BARS.TMP_DPT_INV.NLSN IS '';
COMMENT ON COLUMN BARS.TMP_DPT_INV.KV IS '';
COMMENT ON COLUMN BARS.TMP_DPT_INV.OB22 IS '';
COMMENT ON COLUMN BARS.TMP_DPT_INV.VIDD IS '';
COMMENT ON COLUMN BARS.TMP_DPT_INV.KOL IS '';
COMMENT ON COLUMN BARS.TMP_DPT_INV.OST IS '';
COMMENT ON COLUMN BARS.TMP_DPT_INV.OSTQ IS '';
COMMENT ON COLUMN BARS.TMP_DPT_INV.NOST IS '';
COMMENT ON COLUMN BARS.TMP_DPT_INV.NOSTQ IS '';
COMMENT ON COLUMN BARS.TMP_DPT_INV.DOS IS '';
COMMENT ON COLUMN BARS.TMP_DPT_INV.DOSQ IS '';
COMMENT ON COLUMN BARS.TMP_DPT_INV.KOS IS '';
COMMENT ON COLUMN BARS.TMP_DPT_INV.KOSQ IS '';
COMMENT ON COLUMN BARS.TMP_DPT_INV.OSTI IS '';
COMMENT ON COLUMN BARS.TMP_DPT_INV.OSTIQ IS '';
COMMENT ON COLUMN BARS.TMP_DPT_INV.ND IS '';
COMMENT ON COLUMN BARS.TMP_DPT_INV.NMK IS '';
COMMENT ON COLUMN BARS.TMP_DPT_INV.NLSALT IS '';
COMMENT ON COLUMN BARS.TMP_DPT_INV.PRIZN IS '';



PROMPT *** Create  grants  TMP_DPT_INV ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_DPT_INV     to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_DPT_INV     to RPBN001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_DPT_INV.sql =========*** End *** =
PROMPT ===================================================================================== 
