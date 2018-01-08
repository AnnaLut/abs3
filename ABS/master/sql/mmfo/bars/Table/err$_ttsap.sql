

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_TTSAP.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_TTSAP ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_TTSAP ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_TTSAP 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	TTAP VARCHAR2(4000), 
	TT VARCHAR2(4000), 
	DK VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_TTSAP ***
 exec bpa.alter_policies('ERR$_TTSAP');


COMMENT ON TABLE BARS.ERR$_TTSAP IS 'DML Error Logging table for "TTSAP"';
COMMENT ON COLUMN BARS.ERR$_TTSAP.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_TTSAP.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_TTSAP.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_TTSAP.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_TTSAP.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_TTSAP.TTAP IS '';
COMMENT ON COLUMN BARS.ERR$_TTSAP.TT IS '';
COMMENT ON COLUMN BARS.ERR$_TTSAP.DK IS '';



PROMPT *** Create  grants  ERR$_TTSAP ***
grant SELECT                                                                 on ERR$_TTSAP      to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on ERR$_TTSAP      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ERR$_TTSAP      to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on ERR$_TTSAP      to START1;
grant SELECT                                                                 on ERR$_TTSAP      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_TTSAP.sql =========*** End *** ==
PROMPT ===================================================================================== 
