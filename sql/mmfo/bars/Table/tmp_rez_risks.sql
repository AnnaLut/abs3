

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_REZ_RISKS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_REZ_RISKS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMP_REZ_RISKS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_REZ_RISKS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_REZ_RISKS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_REZ_RISKS ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_REZ_RISKS 
   (	DAT DATE, 
	DAT_ DATE, 
	ID NUMBER(*,0), 
	S080 CHAR(1), 
	S080_NAME VARCHAR2(35), 
	CUSTTYPE NUMBER(*,0), 
	RNK NUMBER(*,0), 
	NMK VARCHAR2(35), 
	KV NUMBER(*,0), 
	NLS VARCHAR2(15), 
	SK NUMBER, 
	SK_ NUMBER, 
	SKQ NUMBER, 
	SKQ_ NUMBER, 
	SOQ NUMBER, 
	SOQ_ NUMBER, 
	SRQ NUMBER, 
	SRQ_ NUMBER, 
	CC_ID VARCHAR2(20), 
	SZQ NUMBER, 
	SZQ_ NUMBER, 
	SZ NUMBER, 
	SZ_ NUMBER, 
	SZ1 NUMBER, 
	SZ1_ NUMBER, 
	FIN NUMBER(*,0), 
	OBS NUMBER(*,0), 
	IDR NUMBER(*,0), 
	RS080 CHAR(1), 
	FL NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_REZ_RISKS ***
 exec bpa.alter_policies('TMP_REZ_RISKS');


COMMENT ON TABLE BARS.TMP_REZ_RISKS IS '';
COMMENT ON COLUMN BARS.TMP_REZ_RISKS.DAT IS '';
COMMENT ON COLUMN BARS.TMP_REZ_RISKS.DAT_ IS '';
COMMENT ON COLUMN BARS.TMP_REZ_RISKS.ID IS '';
COMMENT ON COLUMN BARS.TMP_REZ_RISKS.S080 IS '';
COMMENT ON COLUMN BARS.TMP_REZ_RISKS.S080_NAME IS '';
COMMENT ON COLUMN BARS.TMP_REZ_RISKS.CUSTTYPE IS '';
COMMENT ON COLUMN BARS.TMP_REZ_RISKS.RNK IS '';
COMMENT ON COLUMN BARS.TMP_REZ_RISKS.NMK IS '';
COMMENT ON COLUMN BARS.TMP_REZ_RISKS.KV IS '';
COMMENT ON COLUMN BARS.TMP_REZ_RISKS.NLS IS '';
COMMENT ON COLUMN BARS.TMP_REZ_RISKS.SK IS '';
COMMENT ON COLUMN BARS.TMP_REZ_RISKS.SK_ IS '';
COMMENT ON COLUMN BARS.TMP_REZ_RISKS.SKQ IS '';
COMMENT ON COLUMN BARS.TMP_REZ_RISKS.SKQ_ IS '';
COMMENT ON COLUMN BARS.TMP_REZ_RISKS.SOQ IS '';
COMMENT ON COLUMN BARS.TMP_REZ_RISKS.SOQ_ IS '';
COMMENT ON COLUMN BARS.TMP_REZ_RISKS.SRQ IS '';
COMMENT ON COLUMN BARS.TMP_REZ_RISKS.SRQ_ IS '';
COMMENT ON COLUMN BARS.TMP_REZ_RISKS.CC_ID IS '';
COMMENT ON COLUMN BARS.TMP_REZ_RISKS.SZQ IS '';
COMMENT ON COLUMN BARS.TMP_REZ_RISKS.SZQ_ IS '';
COMMENT ON COLUMN BARS.TMP_REZ_RISKS.SZ IS '';
COMMENT ON COLUMN BARS.TMP_REZ_RISKS.SZ_ IS '';
COMMENT ON COLUMN BARS.TMP_REZ_RISKS.SZ1 IS '';
COMMENT ON COLUMN BARS.TMP_REZ_RISKS.SZ1_ IS '';
COMMENT ON COLUMN BARS.TMP_REZ_RISKS.FIN IS '';
COMMENT ON COLUMN BARS.TMP_REZ_RISKS.OBS IS '';
COMMENT ON COLUMN BARS.TMP_REZ_RISKS.IDR IS '';
COMMENT ON COLUMN BARS.TMP_REZ_RISKS.RS080 IS '';
COMMENT ON COLUMN BARS.TMP_REZ_RISKS.FL IS '';



PROMPT *** Create  grants  TMP_REZ_RISKS ***
grant SELECT                                                                 on TMP_REZ_RISKS   to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_REZ_RISKS   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_REZ_RISKS   to RCC_DEAL;
grant SELECT                                                                 on TMP_REZ_RISKS   to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_REZ_RISKS   to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to TMP_REZ_RISKS ***

  CREATE OR REPLACE PUBLIC SYNONYM TMP_REZ_RISKS FOR BARS.TMP_REZ_RISKS;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_REZ_RISKS.sql =========*** End ***
PROMPT ===================================================================================== 
