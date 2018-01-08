

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_FIN_ND_HIST.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_FIN_ND_HIST ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_FIN_ND_HIST ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_FIN_ND_HIST 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	FDAT VARCHAR2(4000), 
	IDF VARCHAR2(4000), 
	KOD VARCHAR2(4000), 
	S VARCHAR2(4000), 
	ND VARCHAR2(4000), 
	RNK VARCHAR2(4000), 
	VAL_DATE VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_FIN_ND_HIST ***
 exec bpa.alter_policies('ERR$_FIN_ND_HIST');


COMMENT ON TABLE BARS.ERR$_FIN_ND_HIST IS 'DML Error Logging table for "FIN_ND_HIST"';
COMMENT ON COLUMN BARS.ERR$_FIN_ND_HIST.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_ND_HIST.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_ND_HIST.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_ND_HIST.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_ND_HIST.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_ND_HIST.FDAT IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_ND_HIST.IDF IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_ND_HIST.KOD IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_ND_HIST.S IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_ND_HIST.ND IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_ND_HIST.RNK IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_ND_HIST.VAL_DATE IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_FIN_ND_HIST.sql =========*** End 
PROMPT ===================================================================================== 
