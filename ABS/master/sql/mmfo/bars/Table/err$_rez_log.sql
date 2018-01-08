

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_REZ_LOG.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_REZ_LOG ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_REZ_LOG ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_REZ_LOG 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	KOD VARCHAR2(4000), 
	ROW_ID VARCHAR2(4000), 
	USER_ID VARCHAR2(4000), 
	CHGDATE VARCHAR2(4000), 
	TXT VARCHAR2(4000), 
	FDAT VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_REZ_LOG ***
 exec bpa.alter_policies('ERR$_REZ_LOG');


COMMENT ON TABLE BARS.ERR$_REZ_LOG IS 'DML Error Logging table for "REZ_LOG"';
COMMENT ON COLUMN BARS.ERR$_REZ_LOG.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_LOG.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_LOG.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_LOG.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_LOG.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_LOG.KOD IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_LOG.ROW_ID IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_LOG.USER_ID IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_LOG.CHGDATE IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_LOG.TXT IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_LOG.FDAT IS '';
COMMENT ON COLUMN BARS.ERR$_REZ_LOG.KF IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_REZ_LOG.sql =========*** End *** 
PROMPT ===================================================================================== 
