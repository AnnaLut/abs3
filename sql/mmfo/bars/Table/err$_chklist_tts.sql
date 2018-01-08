

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_CHKLIST_TTS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_CHKLIST_TTS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_CHKLIST_TTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_CHKLIST_TTS 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	TT VARCHAR2(4000), 
	IDCHK VARCHAR2(4000), 
	PRIORITY VARCHAR2(4000), 
	F_BIG_AMOUNT VARCHAR2(4000), 
	SQLVAL VARCHAR2(4000), 
	F_IN_CHARGE VARCHAR2(4000), 
	FLAGS VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_CHKLIST_TTS ***
 exec bpa.alter_policies('ERR$_CHKLIST_TTS');


COMMENT ON TABLE BARS.ERR$_CHKLIST_TTS IS 'DML Error Logging table for "CHKLIST_TTS"';
COMMENT ON COLUMN BARS.ERR$_CHKLIST_TTS.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_CHKLIST_TTS.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CHKLIST_TTS.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_CHKLIST_TTS.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_CHKLIST_TTS.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CHKLIST_TTS.TT IS '';
COMMENT ON COLUMN BARS.ERR$_CHKLIST_TTS.IDCHK IS '';
COMMENT ON COLUMN BARS.ERR$_CHKLIST_TTS.PRIORITY IS '';
COMMENT ON COLUMN BARS.ERR$_CHKLIST_TTS.F_BIG_AMOUNT IS '';
COMMENT ON COLUMN BARS.ERR$_CHKLIST_TTS.SQLVAL IS '';
COMMENT ON COLUMN BARS.ERR$_CHKLIST_TTS.F_IN_CHARGE IS '';
COMMENT ON COLUMN BARS.ERR$_CHKLIST_TTS.FLAGS IS '';



PROMPT *** Create  grants  ERR$_CHKLIST_TTS ***
grant SELECT                                                                 on ERR$_CHKLIST_TTS to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on ERR$_CHKLIST_TTS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ERR$_CHKLIST_TTS to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on ERR$_CHKLIST_TTS to START1;
grant SELECT                                                                 on ERR$_CHKLIST_TTS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_CHKLIST_TTS.sql =========*** End 
PROMPT ===================================================================================== 
