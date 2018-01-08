

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_POVID.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_POVID ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_POVID ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_POVID 
   (	RNK NUMBER(*,0), 
	NMK VARCHAR2(70), 
	ADR VARCHAR2(70), 
	OKPO VARCHAR2(16), 
	NAME_FIL VARCHAR2(70), 
	FILIAL VARCHAR2(12), 
	DATX DATE, 
	NLS_FIL VARCHAR2(14), 
	NLS_BARS VARCHAR2(14), 
	KV NUMBER, 
	MFO_G VARCHAR2(12), 
	NAME_G VARCHAR2(70), 
	ADR_G VARCHAR2(70), 
	OKPO_G VARCHAR2(14), 
	BOSS VARCHAR2(70)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_POVID ***
 exec bpa.alter_policies('TMP_POVID');


COMMENT ON TABLE BARS.TMP_POVID IS '';
COMMENT ON COLUMN BARS.TMP_POVID.RNK IS '';
COMMENT ON COLUMN BARS.TMP_POVID.NMK IS '';
COMMENT ON COLUMN BARS.TMP_POVID.ADR IS '';
COMMENT ON COLUMN BARS.TMP_POVID.OKPO IS '';
COMMENT ON COLUMN BARS.TMP_POVID.NAME_FIL IS '';
COMMENT ON COLUMN BARS.TMP_POVID.FILIAL IS '';
COMMENT ON COLUMN BARS.TMP_POVID.DATX IS '';
COMMENT ON COLUMN BARS.TMP_POVID.NLS_FIL IS '';
COMMENT ON COLUMN BARS.TMP_POVID.NLS_BARS IS '';
COMMENT ON COLUMN BARS.TMP_POVID.KV IS '';
COMMENT ON COLUMN BARS.TMP_POVID.MFO_G IS '';
COMMENT ON COLUMN BARS.TMP_POVID.NAME_G IS '';
COMMENT ON COLUMN BARS.TMP_POVID.ADR_G IS '';
COMMENT ON COLUMN BARS.TMP_POVID.OKPO_G IS '';
COMMENT ON COLUMN BARS.TMP_POVID.BOSS IS '';



PROMPT *** Create  grants  TMP_POVID ***
grant SELECT                                                                 on TMP_POVID       to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_POVID       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_POVID       to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_POVID       to RPBN001;
grant SELECT                                                                 on TMP_POVID       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_POVID.sql =========*** End *** ===
PROMPT ===================================================================================== 
