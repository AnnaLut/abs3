

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_CF_LOG.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_CF_LOG ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_CF_LOG ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_CF_LOG 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ID VARCHAR2(4000), 
	SYSTIME VARCHAR2(4000), 
	IN_PAR VARCHAR2(4000), 
	OUT_PAR VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_CF_LOG ***
 exec bpa.alter_policies('ERR$_CF_LOG');


COMMENT ON TABLE BARS.ERR$_CF_LOG IS 'DML Error Logging table for "CF_LOG"';
COMMENT ON COLUMN BARS.ERR$_CF_LOG.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_CF_LOG.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CF_LOG.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_CF_LOG.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_CF_LOG.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CF_LOG.ID IS '';
COMMENT ON COLUMN BARS.ERR$_CF_LOG.SYSTIME IS '';
COMMENT ON COLUMN BARS.ERR$_CF_LOG.IN_PAR IS '';
COMMENT ON COLUMN BARS.ERR$_CF_LOG.OUT_PAR IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_CF_LOG.sql =========*** End *** =
PROMPT ===================================================================================== 
