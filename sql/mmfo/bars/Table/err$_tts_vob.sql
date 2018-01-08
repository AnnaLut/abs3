

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_TTS_VOB.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_TTS_VOB ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_TTS_VOB ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_TTS_VOB 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	TT VARCHAR2(4000), 
	VOB VARCHAR2(4000), 
	ORD VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_TTS_VOB ***
 exec bpa.alter_policies('ERR$_TTS_VOB');


COMMENT ON TABLE BARS.ERR$_TTS_VOB IS 'DML Error Logging table for "TTS_VOB"';
COMMENT ON COLUMN BARS.ERR$_TTS_VOB.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_TTS_VOB.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_TTS_VOB.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_TTS_VOB.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_TTS_VOB.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_TTS_VOB.TT IS '';
COMMENT ON COLUMN BARS.ERR$_TTS_VOB.VOB IS '';
COMMENT ON COLUMN BARS.ERR$_TTS_VOB.ORD IS '';



PROMPT *** Create  grants  ERR$_TTS_VOB ***
grant SELECT                                                                 on ERR$_TTS_VOB    to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on ERR$_TTS_VOB    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ERR$_TTS_VOB    to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on ERR$_TTS_VOB    to START1;
grant SELECT                                                                 on ERR$_TTS_VOB    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_TTS_VOB.sql =========*** End *** 
PROMPT ===================================================================================== 
