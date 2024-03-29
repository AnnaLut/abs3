

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_RNBU_TRACE_ARCH.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_RNBU_TRACE_ARCH ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_RNBU_TRACE_ARCH ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_RNBU_TRACE_ARCH 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	KODF VARCHAR2(4000), 
	DATF VARCHAR2(4000), 
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




PROMPT *** ALTER_POLICIES to ERR$_RNBU_TRACE_ARCH ***
 exec bpa.alter_policies('ERR$_RNBU_TRACE_ARCH');


COMMENT ON TABLE BARS.ERR$_RNBU_TRACE_ARCH IS 'DML Error Logging table for "RNBU_TRACE_ARCH"';
COMMENT ON COLUMN BARS.ERR$_RNBU_TRACE_ARCH.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_RNBU_TRACE_ARCH.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_RNBU_TRACE_ARCH.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_RNBU_TRACE_ARCH.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_RNBU_TRACE_ARCH.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_RNBU_TRACE_ARCH.KODF IS '';
COMMENT ON COLUMN BARS.ERR$_RNBU_TRACE_ARCH.DATF IS '';
COMMENT ON COLUMN BARS.ERR$_RNBU_TRACE_ARCH.NLS IS '';
COMMENT ON COLUMN BARS.ERR$_RNBU_TRACE_ARCH.KV IS '';
COMMENT ON COLUMN BARS.ERR$_RNBU_TRACE_ARCH.ODATE IS '';
COMMENT ON COLUMN BARS.ERR$_RNBU_TRACE_ARCH.KODP IS '';
COMMENT ON COLUMN BARS.ERR$_RNBU_TRACE_ARCH.ZNAP IS '';
COMMENT ON COLUMN BARS.ERR$_RNBU_TRACE_ARCH.NBUC IS '';
COMMENT ON COLUMN BARS.ERR$_RNBU_TRACE_ARCH.ISP IS '';
COMMENT ON COLUMN BARS.ERR$_RNBU_TRACE_ARCH.RNK IS '';
COMMENT ON COLUMN BARS.ERR$_RNBU_TRACE_ARCH.ACC IS '';
COMMENT ON COLUMN BARS.ERR$_RNBU_TRACE_ARCH.REF IS '';
COMMENT ON COLUMN BARS.ERR$_RNBU_TRACE_ARCH.COMM IS '';
COMMENT ON COLUMN BARS.ERR$_RNBU_TRACE_ARCH.ND IS '';
COMMENT ON COLUMN BARS.ERR$_RNBU_TRACE_ARCH.MDATE IS '';
COMMENT ON COLUMN BARS.ERR$_RNBU_TRACE_ARCH.TOBO IS '';



PROMPT *** Create  grants  ERR$_RNBU_TRACE_ARCH ***
grant SELECT                                                                 on ERR$_RNBU_TRACE_ARCH to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_RNBU_TRACE_ARCH.sql =========*** 
PROMPT ===================================================================================== 
