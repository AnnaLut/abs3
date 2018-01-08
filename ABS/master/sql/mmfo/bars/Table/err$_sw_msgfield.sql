

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_SW_MSGFIELD.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_SW_MSGFIELD ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_SW_MSGFIELD ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_SW_MSGFIELD 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	SWREF VARCHAR2(4000), 
	RECNUM VARCHAR2(4000), 
	MSGBLK VARCHAR2(4000), 
	MSGTAG VARCHAR2(4000), 
	VALUE VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_SW_MSGFIELD ***
 exec bpa.alter_policies('ERR$_SW_MSGFIELD');


COMMENT ON TABLE BARS.ERR$_SW_MSGFIELD IS 'DML Error Logging table for "SW_MSGFIELD"';
COMMENT ON COLUMN BARS.ERR$_SW_MSGFIELD.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_SW_MSGFIELD.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_SW_MSGFIELD.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_SW_MSGFIELD.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_SW_MSGFIELD.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_SW_MSGFIELD.SWREF IS '';
COMMENT ON COLUMN BARS.ERR$_SW_MSGFIELD.RECNUM IS '';
COMMENT ON COLUMN BARS.ERR$_SW_MSGFIELD.MSGBLK IS '';
COMMENT ON COLUMN BARS.ERR$_SW_MSGFIELD.MSGTAG IS '';
COMMENT ON COLUMN BARS.ERR$_SW_MSGFIELD.VALUE IS '';
COMMENT ON COLUMN BARS.ERR$_SW_MSGFIELD.KF IS '';



PROMPT *** Create  grants  ERR$_SW_MSGFIELD ***
grant SELECT                                                                 on ERR$_SW_MSGFIELD to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_SW_MSGFIELD to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_SW_MSGFIELD.sql =========*** End 
PROMPT ===================================================================================== 
