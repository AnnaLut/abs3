

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_SALDOA.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_SALDOA ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_SALDOA ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_SALDOA 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ACC VARCHAR2(4000), 
	FDAT VARCHAR2(4000), 
	PDAT VARCHAR2(4000), 
	OSTF VARCHAR2(4000), 
	DOS VARCHAR2(4000), 
	KOS VARCHAR2(4000), 
	TRCN VARCHAR2(4000), 
	OSTQ VARCHAR2(4000), 
	DOSQ VARCHAR2(4000), 
	KOSQ VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_SALDOA ***
 exec bpa.alter_policies('ERR$_SALDOA');


COMMENT ON TABLE BARS.ERR$_SALDOA IS 'DML Error Logging table for "SALDOA"';
COMMENT ON COLUMN BARS.ERR$_SALDOA.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_SALDOA.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_SALDOA.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_SALDOA.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_SALDOA.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_SALDOA.ACC IS '';
COMMENT ON COLUMN BARS.ERR$_SALDOA.FDAT IS '';
COMMENT ON COLUMN BARS.ERR$_SALDOA.PDAT IS '';
COMMENT ON COLUMN BARS.ERR$_SALDOA.OSTF IS '';
COMMENT ON COLUMN BARS.ERR$_SALDOA.DOS IS '';
COMMENT ON COLUMN BARS.ERR$_SALDOA.KOS IS '';
COMMENT ON COLUMN BARS.ERR$_SALDOA.TRCN IS '';
COMMENT ON COLUMN BARS.ERR$_SALDOA.OSTQ IS '';
COMMENT ON COLUMN BARS.ERR$_SALDOA.DOSQ IS '';
COMMENT ON COLUMN BARS.ERR$_SALDOA.KOSQ IS '';
COMMENT ON COLUMN BARS.ERR$_SALDOA.KF IS '';



PROMPT *** Create  grants  ERR$_SALDOA ***
grant SELECT                                                                 on ERR$_SALDOA     to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_SALDOA.sql =========*** End *** =
PROMPT ===================================================================================== 
