

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_PS_TTS.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_PS_TTS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_PS_TTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_PS_TTS 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ID VARCHAR2(4000), 
	TT VARCHAR2(4000), 
	NBS VARCHAR2(4000), 
	DK VARCHAR2(4000), 
	OB22 VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_PS_TTS ***
 exec bpa.alter_policies('ERR$_PS_TTS');


COMMENT ON TABLE BARS.ERR$_PS_TTS IS 'DML Error Logging table for "PS_TTS"';
COMMENT ON COLUMN BARS.ERR$_PS_TTS.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_PS_TTS.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_PS_TTS.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_PS_TTS.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_PS_TTS.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_PS_TTS.ID IS '';
COMMENT ON COLUMN BARS.ERR$_PS_TTS.TT IS '';
COMMENT ON COLUMN BARS.ERR$_PS_TTS.NBS IS '';
COMMENT ON COLUMN BARS.ERR$_PS_TTS.DK IS '';
COMMENT ON COLUMN BARS.ERR$_PS_TTS.OB22 IS '';



PROMPT *** Create  grants  ERR$_PS_TTS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ERR$_PS_TTS     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ERR$_PS_TTS     to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on ERR$_PS_TTS     to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_PS_TTS.sql =========*** End *** =
PROMPT ===================================================================================== 