

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_SALDOZ.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_SALDOZ ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_SALDOZ ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_SALDOZ 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	KF VARCHAR2(4000), 
	FDAT VARCHAR2(4000), 
	ACC VARCHAR2(4000), 
	DOS VARCHAR2(4000), 
	DOSQ VARCHAR2(4000), 
	KOS VARCHAR2(4000), 
	KOSQ VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_SALDOZ ***
 exec bpa.alter_policies('ERR$_SALDOZ');


COMMENT ON TABLE BARS.ERR$_SALDOZ IS 'DML Error Logging table for "SALDOZ"';
COMMENT ON COLUMN BARS.ERR$_SALDOZ.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_SALDOZ.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_SALDOZ.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_SALDOZ.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_SALDOZ.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_SALDOZ.KF IS '';
COMMENT ON COLUMN BARS.ERR$_SALDOZ.FDAT IS '';
COMMENT ON COLUMN BARS.ERR$_SALDOZ.ACC IS '';
COMMENT ON COLUMN BARS.ERR$_SALDOZ.DOS IS '';
COMMENT ON COLUMN BARS.ERR$_SALDOZ.DOSQ IS '';
COMMENT ON COLUMN BARS.ERR$_SALDOZ.KOS IS '';
COMMENT ON COLUMN BARS.ERR$_SALDOZ.KOSQ IS '';



PROMPT *** Create  grants  ERR$_SALDOZ ***
grant SELECT                                                                 on ERR$_SALDOZ     to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_SALDOZ     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_SALDOZ.sql =========*** End *** =
PROMPT ===================================================================================== 
