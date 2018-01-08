

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_OTCN_TRACE_12.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_OTCN_TRACE_12 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_OTCN_TRACE_12 ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_OTCN_TRACE_12 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	DATF VARCHAR2(4000), 
	USERID VARCHAR2(4000), 
	NLS VARCHAR2(4000), 
	KV VARCHAR2(4000), 
	ODATE VARCHAR2(4000), 
	KODP VARCHAR2(4000), 
	ZNAP VARCHAR2(4000), 
	NBUC VARCHAR2(4000), 
	ISP VARCHAR2(4000), 
	RNK VARCHAR2(4000), 
	ACC VARCHAR2(4000), 
	REF VARCHAR2(4000), 
	COMM VARCHAR2(4000), 
	ND VARCHAR2(4000), 
	MDATE VARCHAR2(4000), 
	TOBO VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_OTCN_TRACE_12 ***
 exec bpa.alter_policies('ERR$_OTCN_TRACE_12');


COMMENT ON TABLE BARS.ERR$_OTCN_TRACE_12 IS 'DML Error Logging table for "OTCN_TRACE_12"';
COMMENT ON COLUMN BARS.ERR$_OTCN_TRACE_12.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_TRACE_12.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_TRACE_12.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_TRACE_12.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_TRACE_12.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_TRACE_12.DATF IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_TRACE_12.USERID IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_TRACE_12.NLS IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_TRACE_12.KV IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_TRACE_12.ODATE IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_TRACE_12.KODP IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_TRACE_12.ZNAP IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_TRACE_12.NBUC IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_TRACE_12.ISP IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_TRACE_12.RNK IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_TRACE_12.ACC IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_TRACE_12.REF IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_TRACE_12.COMM IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_TRACE_12.ND IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_TRACE_12.MDATE IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_TRACE_12.TOBO IS '';



PROMPT *** Create  grants  ERR$_OTCN_TRACE_12 ***
grant SELECT                                                                 on ERR$_OTCN_TRACE_12 to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_OTCN_TRACE_12 to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_OTCN_TRACE_12.sql =========*** En
PROMPT ===================================================================================== 
