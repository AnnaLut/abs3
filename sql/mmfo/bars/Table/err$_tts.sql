

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_TTS.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_TTS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_TTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_TTS 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	TT VARCHAR2(4000), 
	NAME VARCHAR2(4000), 
	DK VARCHAR2(4000), 
	NLSM VARCHAR2(4000), 
	KV VARCHAR2(4000), 
	NLSK VARCHAR2(4000), 
	KVK VARCHAR2(4000), 
	NLSS VARCHAR2(4000), 
	NLSA VARCHAR2(4000), 
	NLSB VARCHAR2(4000), 
	MFOB VARCHAR2(4000), 
	FLC VARCHAR2(4000), 
	FLI VARCHAR2(4000), 
	FLV VARCHAR2(4000), 
	FLR VARCHAR2(4000), 
	S VARCHAR2(4000), 
	S2 VARCHAR2(4000), 
	SK VARCHAR2(4000), 
	PROC VARCHAR2(4000), 
	S3800 VARCHAR2(4000), 
	S6201 VARCHAR2(4000), 
	S7201 VARCHAR2(4000), 
	RANG VARCHAR2(4000), 
	FLAGS VARCHAR2(4000), 
	NAZN VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_TTS ***
 exec bpa.alter_policies('ERR$_TTS');


COMMENT ON TABLE BARS.ERR$_TTS IS 'DML Error Logging table for "TTS"';
COMMENT ON COLUMN BARS.ERR$_TTS.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_TTS.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_TTS.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_TTS.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_TTS.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_TTS.TT IS '';
COMMENT ON COLUMN BARS.ERR$_TTS.NAME IS '';
COMMENT ON COLUMN BARS.ERR$_TTS.DK IS '';
COMMENT ON COLUMN BARS.ERR$_TTS.NLSM IS '';
COMMENT ON COLUMN BARS.ERR$_TTS.KV IS '';
COMMENT ON COLUMN BARS.ERR$_TTS.NLSK IS '';
COMMENT ON COLUMN BARS.ERR$_TTS.KVK IS '';
COMMENT ON COLUMN BARS.ERR$_TTS.NLSS IS '';
COMMENT ON COLUMN BARS.ERR$_TTS.NLSA IS '';
COMMENT ON COLUMN BARS.ERR$_TTS.NLSB IS '';
COMMENT ON COLUMN BARS.ERR$_TTS.MFOB IS '';
COMMENT ON COLUMN BARS.ERR$_TTS.FLC IS '';
COMMENT ON COLUMN BARS.ERR$_TTS.FLI IS '';
COMMENT ON COLUMN BARS.ERR$_TTS.FLV IS '';
COMMENT ON COLUMN BARS.ERR$_TTS.FLR IS '';
COMMENT ON COLUMN BARS.ERR$_TTS.S IS '';
COMMENT ON COLUMN BARS.ERR$_TTS.S2 IS '';
COMMENT ON COLUMN BARS.ERR$_TTS.SK IS '';
COMMENT ON COLUMN BARS.ERR$_TTS.PROC IS '';
COMMENT ON COLUMN BARS.ERR$_TTS.S3800 IS '';
COMMENT ON COLUMN BARS.ERR$_TTS.S6201 IS '';
COMMENT ON COLUMN BARS.ERR$_TTS.S7201 IS '';
COMMENT ON COLUMN BARS.ERR$_TTS.RANG IS '';
COMMENT ON COLUMN BARS.ERR$_TTS.FLAGS IS '';
COMMENT ON COLUMN BARS.ERR$_TTS.NAZN IS '';



PROMPT *** Create  grants  ERR$_TTS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ERR$_TTS        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ERR$_TTS        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on ERR$_TTS        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_TTS.sql =========*** End *** ====
PROMPT ===================================================================================== 
