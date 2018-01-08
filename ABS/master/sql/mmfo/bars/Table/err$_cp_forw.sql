

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_CP_FORW.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_CP_FORW ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_CP_FORW ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_CP_FORW 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	REF VARCHAR2(4000), 
	TT VARCHAR2(4000), 
	DK VARCHAR2(4000), 
	ACC VARCHAR2(4000), 
	FDAT VARCHAR2(4000), 
	S VARCHAR2(4000), 
	SQ VARCHAR2(4000), 
	TXT VARCHAR2(4000), 
	STMT VARCHAR2(4000), 
	SOS VARCHAR2(4000), 
	ID VARCHAR2(4000), 
	OTM VARCHAR2(4000), 
	SS VARCHAR2(4000), 
	SSQ VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_CP_FORW ***
 exec bpa.alter_policies('ERR$_CP_FORW');


COMMENT ON TABLE BARS.ERR$_CP_FORW IS 'DML Error Logging table for "CP_FORW"';
COMMENT ON COLUMN BARS.ERR$_CP_FORW.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_CP_FORW.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CP_FORW.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_CP_FORW.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_CP_FORW.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CP_FORW.REF IS '';
COMMENT ON COLUMN BARS.ERR$_CP_FORW.TT IS '';
COMMENT ON COLUMN BARS.ERR$_CP_FORW.DK IS '';
COMMENT ON COLUMN BARS.ERR$_CP_FORW.ACC IS '';
COMMENT ON COLUMN BARS.ERR$_CP_FORW.FDAT IS '';
COMMENT ON COLUMN BARS.ERR$_CP_FORW.S IS '';
COMMENT ON COLUMN BARS.ERR$_CP_FORW.SQ IS '';
COMMENT ON COLUMN BARS.ERR$_CP_FORW.TXT IS '';
COMMENT ON COLUMN BARS.ERR$_CP_FORW.STMT IS '';
COMMENT ON COLUMN BARS.ERR$_CP_FORW.SOS IS '';
COMMENT ON COLUMN BARS.ERR$_CP_FORW.ID IS '';
COMMENT ON COLUMN BARS.ERR$_CP_FORW.OTM IS '';
COMMENT ON COLUMN BARS.ERR$_CP_FORW.SS IS '';
COMMENT ON COLUMN BARS.ERR$_CP_FORW.SSQ IS '';



PROMPT *** Create  grants  ERR$_CP_FORW ***
grant SELECT                                                                 on ERR$_CP_FORW    to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_CP_FORW    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_CP_FORW.sql =========*** End *** 
PROMPT ===================================================================================== 
