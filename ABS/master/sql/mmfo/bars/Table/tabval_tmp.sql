

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TABVAL_TMP.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TABVAL_TMP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TABVAL_TMP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TABVAL_TMP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TABVAL_TMP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TABVAL_TMP ***
begin 
  execute immediate '
  CREATE TABLE BARS.TABVAL_TMP 
   (	KVISO CHAR(2), 
	KV NUMBER(*,0), 
	KODSTR CHAR(3), 
	NAMSTR VARCHAR2(15), 
	ETALSUM NUMBER(*,0), 
	DATA1 DATE, 
	DATA2 DATE, 
	KOMM1 NUMBER(12,4), 
	KOMM2 NUMBER(12,4), 
	S0000 VARCHAR2(14), 
	S3800 VARCHAR2(14), 
	S3801 VARCHAR2(14), 
	S3802 VARCHAR2(14), 
	S6201 VARCHAR2(14), 
	S7201 VARCHAR2(14), 
	POKU1 NUMBER(12,4), 
	POKU2 NUMBER(12,4), 
	PROD1 NUMBER(12,4), 
	PROD2 NUMBER(12,4), 
	DEM1 NUMBER(12,4), 
	NKOP CHAR(3), 
	K_VA CHAR(1), 
	NLS_CMR VARCHAR2(14), 
	DIG NUMBER(*,0), 
	S9280 VARCHAR2(14), 
	S9281 VARCHAR2(14), 
	S9282 VARCHAR2(14), 
	EMI CHAR(3)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TABVAL_TMP ***
 exec bpa.alter_policies('TABVAL_TMP');


COMMENT ON TABLE BARS.TABVAL_TMP IS '';
COMMENT ON COLUMN BARS.TABVAL_TMP.KVISO IS '';
COMMENT ON COLUMN BARS.TABVAL_TMP.KV IS '';
COMMENT ON COLUMN BARS.TABVAL_TMP.KODSTR IS '';
COMMENT ON COLUMN BARS.TABVAL_TMP.NAMSTR IS '';
COMMENT ON COLUMN BARS.TABVAL_TMP.ETALSUM IS '';
COMMENT ON COLUMN BARS.TABVAL_TMP.DATA1 IS '';
COMMENT ON COLUMN BARS.TABVAL_TMP.DATA2 IS '';
COMMENT ON COLUMN BARS.TABVAL_TMP.KOMM1 IS '';
COMMENT ON COLUMN BARS.TABVAL_TMP.KOMM2 IS '';
COMMENT ON COLUMN BARS.TABVAL_TMP.S0000 IS '';
COMMENT ON COLUMN BARS.TABVAL_TMP.S3800 IS '';
COMMENT ON COLUMN BARS.TABVAL_TMP.S3801 IS '';
COMMENT ON COLUMN BARS.TABVAL_TMP.S3802 IS '';
COMMENT ON COLUMN BARS.TABVAL_TMP.S6201 IS '';
COMMENT ON COLUMN BARS.TABVAL_TMP.S7201 IS '';
COMMENT ON COLUMN BARS.TABVAL_TMP.POKU1 IS '';
COMMENT ON COLUMN BARS.TABVAL_TMP.POKU2 IS '';
COMMENT ON COLUMN BARS.TABVAL_TMP.PROD1 IS '';
COMMENT ON COLUMN BARS.TABVAL_TMP.PROD2 IS '';
COMMENT ON COLUMN BARS.TABVAL_TMP.DEM1 IS '';
COMMENT ON COLUMN BARS.TABVAL_TMP.NKOP IS '';
COMMENT ON COLUMN BARS.TABVAL_TMP.K_VA IS '';
COMMENT ON COLUMN BARS.TABVAL_TMP.NLS_CMR IS '';
COMMENT ON COLUMN BARS.TABVAL_TMP.DIG IS '';
COMMENT ON COLUMN BARS.TABVAL_TMP.S9280 IS '';
COMMENT ON COLUMN BARS.TABVAL_TMP.S9281 IS '';
COMMENT ON COLUMN BARS.TABVAL_TMP.S9282 IS '';
COMMENT ON COLUMN BARS.TABVAL_TMP.EMI IS '';



PROMPT *** Create  grants  TABVAL_TMP ***
grant SELECT                                                                 on TABVAL_TMP      to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TABVAL_TMP      to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TABVAL_TMP      to START1;
grant SELECT                                                                 on TABVAL_TMP      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TABVAL_TMP.sql =========*** End *** ==
PROMPT ===================================================================================== 
