

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_REZ_DMARK.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_REZ_DMARK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMP_REZ_DMARK'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_REZ_DMARK'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_REZ_DMARK'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_REZ_DMARK ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_REZ_DMARK 
   (	RNK NUMBER, 
	NMK VARCHAR2(70), 
	NDOG VARCHAR2(30), 
	DATD DATE, 
	DATP DATE, 
	SK NUMBER, 
	SZ NUMBER, 
	SV NUMBER, 
	KV NUMBER, 
	PR NUMBER, 
	ZDEP NUMBER, 
	ZCP NUMBER, 
	ZNER NUMBER, 
	ZRUH NUMBER, 
	ZV1 NUMBER, 
	ZV2 NUMBER, 
	S080 NUMBER, 
	SRISK NUMBER, 
	REZ NUMBER, 
	REZK NUMBER, 
	REZZ NUMBER, 
	ISP NUMBER, 
	OTD NUMBER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_REZ_DMARK ***
 exec bpa.alter_policies('TMP_REZ_DMARK');


COMMENT ON TABLE BARS.TMP_REZ_DMARK IS '';
COMMENT ON COLUMN BARS.TMP_REZ_DMARK.RNK IS '';
COMMENT ON COLUMN BARS.TMP_REZ_DMARK.NMK IS '';
COMMENT ON COLUMN BARS.TMP_REZ_DMARK.NDOG IS '';
COMMENT ON COLUMN BARS.TMP_REZ_DMARK.DATD IS '';
COMMENT ON COLUMN BARS.TMP_REZ_DMARK.DATP IS '';
COMMENT ON COLUMN BARS.TMP_REZ_DMARK.SK IS '';
COMMENT ON COLUMN BARS.TMP_REZ_DMARK.SZ IS '';
COMMENT ON COLUMN BARS.TMP_REZ_DMARK.SV IS '';
COMMENT ON COLUMN BARS.TMP_REZ_DMARK.KV IS '';
COMMENT ON COLUMN BARS.TMP_REZ_DMARK.PR IS '';
COMMENT ON COLUMN BARS.TMP_REZ_DMARK.ZDEP IS '';
COMMENT ON COLUMN BARS.TMP_REZ_DMARK.ZCP IS '';
COMMENT ON COLUMN BARS.TMP_REZ_DMARK.ZNER IS '';
COMMENT ON COLUMN BARS.TMP_REZ_DMARK.ZRUH IS '';
COMMENT ON COLUMN BARS.TMP_REZ_DMARK.ZV1 IS '';
COMMENT ON COLUMN BARS.TMP_REZ_DMARK.ZV2 IS '';
COMMENT ON COLUMN BARS.TMP_REZ_DMARK.S080 IS '';
COMMENT ON COLUMN BARS.TMP_REZ_DMARK.SRISK IS '';
COMMENT ON COLUMN BARS.TMP_REZ_DMARK.REZ IS '';
COMMENT ON COLUMN BARS.TMP_REZ_DMARK.REZK IS '';
COMMENT ON COLUMN BARS.TMP_REZ_DMARK.REZZ IS '';
COMMENT ON COLUMN BARS.TMP_REZ_DMARK.ISP IS '';
COMMENT ON COLUMN BARS.TMP_REZ_DMARK.OTD IS '';



PROMPT *** Create  grants  TMP_REZ_DMARK ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_REZ_DMARK   to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_REZ_DMARK   to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_REZ_DMARK.sql =========*** End ***
PROMPT ===================================================================================== 
