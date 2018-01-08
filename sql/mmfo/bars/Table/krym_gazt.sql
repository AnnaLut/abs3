

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KRYM_GAZT.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KRYM_GAZT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KRYM_GAZT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KRYM_GAZT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KRYM_GAZT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KRYM_GAZT ***
begin 
  execute immediate '
  CREATE TABLE BARS.KRYM_GAZT 
   (	NLSA VARCHAR2(14), 
	KVA NUMBER(*,0), 
	MFOB VARCHAR2(12), 
	NLSB VARCHAR2(14), 
	KVB NUMBER(*,0), 
	TT CHAR(3), 
	VOB NUMBER(*,0), 
	ND VARCHAR2(10), 
	DATD DATE, 
	S NUMBER, 
	NAM_A VARCHAR2(38), 
	NAM_B VARCHAR2(38), 
	NAZN VARCHAR2(160), 
	OKPOA VARCHAR2(14), 
	OKPOB VARCHAR2(14), 
	GRP NUMBER(*,0), 
	REF NUMBER(*,0), 
	SOS NUMBER(*,0), 
	ID NUMBER(*,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KRYM_GAZT ***
 exec bpa.alter_policies('KRYM_GAZT');


COMMENT ON TABLE BARS.KRYM_GAZT IS '';
COMMENT ON COLUMN BARS.KRYM_GAZT.NLSA IS '';
COMMENT ON COLUMN BARS.KRYM_GAZT.KVA IS '';
COMMENT ON COLUMN BARS.KRYM_GAZT.MFOB IS '';
COMMENT ON COLUMN BARS.KRYM_GAZT.NLSB IS '';
COMMENT ON COLUMN BARS.KRYM_GAZT.KVB IS '';
COMMENT ON COLUMN BARS.KRYM_GAZT.TT IS '';
COMMENT ON COLUMN BARS.KRYM_GAZT.VOB IS '';
COMMENT ON COLUMN BARS.KRYM_GAZT.ND IS '';
COMMENT ON COLUMN BARS.KRYM_GAZT.DATD IS '';
COMMENT ON COLUMN BARS.KRYM_GAZT.S IS '';
COMMENT ON COLUMN BARS.KRYM_GAZT.NAM_A IS '';
COMMENT ON COLUMN BARS.KRYM_GAZT.NAM_B IS '';
COMMENT ON COLUMN BARS.KRYM_GAZT.NAZN IS '';
COMMENT ON COLUMN BARS.KRYM_GAZT.OKPOA IS '';
COMMENT ON COLUMN BARS.KRYM_GAZT.OKPOB IS '';
COMMENT ON COLUMN BARS.KRYM_GAZT.GRP IS '';
COMMENT ON COLUMN BARS.KRYM_GAZT.REF IS '';
COMMENT ON COLUMN BARS.KRYM_GAZT.SOS IS '';
COMMENT ON COLUMN BARS.KRYM_GAZT.ID IS '';



PROMPT *** Create  grants  KRYM_GAZT ***
grant DELETE,SELECT,UPDATE                                                   on KRYM_GAZT       to BARS015;
grant SELECT                                                                 on KRYM_GAZT       to BARSREADER_ROLE;
grant DELETE,SELECT,UPDATE                                                   on KRYM_GAZT       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KRYM_GAZT       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KRYM_GAZT.sql =========*** End *** ===
PROMPT ===================================================================================== 
