

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_RNBU_HISTORY.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_RNBU_HISTORY ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_RNBU_HISTORY ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_RNBU_HISTORY 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	RECID VARCHAR2(4000), 
	ODATE VARCHAR2(4000), 
	NLS VARCHAR2(4000), 
	KV VARCHAR2(4000), 
	CODCAGENT VARCHAR2(4000), 
	INTS VARCHAR2(4000), 
	S180 VARCHAR2(4000), 
	K081 VARCHAR2(4000), 
	K092 VARCHAR2(4000), 
	DOS VARCHAR2(4000), 
	KOS VARCHAR2(4000), 
	MDATE VARCHAR2(4000), 
	K112 VARCHAR2(4000), 
	OST VARCHAR2(4000), 
	MB VARCHAR2(4000), 
	D020 VARCHAR2(4000), 
	ISP VARCHAR2(4000), 
	ACC VARCHAR2(4000), 
	TOBO VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_RNBU_HISTORY ***
 exec bpa.alter_policies('ERR$_RNBU_HISTORY');


COMMENT ON TABLE BARS.ERR$_RNBU_HISTORY IS 'DML Error Logging table for "RNBU_HISTORY"';
COMMENT ON COLUMN BARS.ERR$_RNBU_HISTORY.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_RNBU_HISTORY.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_RNBU_HISTORY.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_RNBU_HISTORY.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_RNBU_HISTORY.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_RNBU_HISTORY.RECID IS '';
COMMENT ON COLUMN BARS.ERR$_RNBU_HISTORY.ODATE IS '';
COMMENT ON COLUMN BARS.ERR$_RNBU_HISTORY.NLS IS '';
COMMENT ON COLUMN BARS.ERR$_RNBU_HISTORY.KV IS '';
COMMENT ON COLUMN BARS.ERR$_RNBU_HISTORY.CODCAGENT IS '';
COMMENT ON COLUMN BARS.ERR$_RNBU_HISTORY.INTS IS '';
COMMENT ON COLUMN BARS.ERR$_RNBU_HISTORY.S180 IS '';
COMMENT ON COLUMN BARS.ERR$_RNBU_HISTORY.K081 IS '';
COMMENT ON COLUMN BARS.ERR$_RNBU_HISTORY.K092 IS '';
COMMENT ON COLUMN BARS.ERR$_RNBU_HISTORY.DOS IS '';
COMMENT ON COLUMN BARS.ERR$_RNBU_HISTORY.KOS IS '';
COMMENT ON COLUMN BARS.ERR$_RNBU_HISTORY.MDATE IS '';
COMMENT ON COLUMN BARS.ERR$_RNBU_HISTORY.K112 IS '';
COMMENT ON COLUMN BARS.ERR$_RNBU_HISTORY.OST IS '';
COMMENT ON COLUMN BARS.ERR$_RNBU_HISTORY.MB IS '';
COMMENT ON COLUMN BARS.ERR$_RNBU_HISTORY.D020 IS '';
COMMENT ON COLUMN BARS.ERR$_RNBU_HISTORY.ISP IS '';
COMMENT ON COLUMN BARS.ERR$_RNBU_HISTORY.ACC IS '';
COMMENT ON COLUMN BARS.ERR$_RNBU_HISTORY.TOBO IS '';
COMMENT ON COLUMN BARS.ERR$_RNBU_HISTORY.KF IS '';



PROMPT *** Create  grants  ERR$_RNBU_HISTORY ***
grant SELECT                                                                 on ERR$_RNBU_HISTORY to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_RNBU_HISTORY to BARS_DM;
grant SELECT                                                                 on ERR$_RNBU_HISTORY to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_RNBU_HISTORY.sql =========*** End
PROMPT ===================================================================================== 
