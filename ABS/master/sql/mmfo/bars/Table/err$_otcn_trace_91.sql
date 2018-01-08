

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_OTCN_TRACE_91.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_OTCN_TRACE_91 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_OTCN_TRACE_91 ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_OTCN_TRACE_91 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	RECID VARCHAR2(4000), 
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




PROMPT *** ALTER_POLICIES to ERR$_OTCN_TRACE_91 ***
 exec bpa.alter_policies('ERR$_OTCN_TRACE_91');


COMMENT ON TABLE BARS.ERR$_OTCN_TRACE_91 IS 'DML Error Logging table for "OTCN_TRACE_91"';
COMMENT ON COLUMN BARS.ERR$_OTCN_TRACE_91.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_TRACE_91.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_TRACE_91.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_TRACE_91.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_TRACE_91.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_TRACE_91.RECID IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_TRACE_91.USERID IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_TRACE_91.NLS IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_TRACE_91.KV IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_TRACE_91.ODATE IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_TRACE_91.KODP IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_TRACE_91.ZNAP IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_TRACE_91.NBUC IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_TRACE_91.ISP IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_TRACE_91.RNK IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_TRACE_91.ACC IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_TRACE_91.REF IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_TRACE_91.COMM IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_TRACE_91.ND IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_TRACE_91.MDATE IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_TRACE_91.TOBO IS '';



PROMPT *** Create  grants  ERR$_OTCN_TRACE_91 ***
grant SELECT                                                                 on ERR$_OTCN_TRACE_91 to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_OTCN_TRACE_91 to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_OTCN_TRACE_91.sql =========*** En
PROMPT ===================================================================================== 
