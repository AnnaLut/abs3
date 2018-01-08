

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_CP_REFW.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_CP_REFW ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_CP_REFW ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_CP_REFW 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	REF VARCHAR2(4000), 
	TAG VARCHAR2(4000), 
	VALUE VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_CP_REFW ***
 exec bpa.alter_policies('ERR$_CP_REFW');


COMMENT ON TABLE BARS.ERR$_CP_REFW IS 'DML Error Logging table for "CP_REFW"';
COMMENT ON COLUMN BARS.ERR$_CP_REFW.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_CP_REFW.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CP_REFW.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_CP_REFW.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_CP_REFW.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CP_REFW.REF IS '';
COMMENT ON COLUMN BARS.ERR$_CP_REFW.TAG IS '';
COMMENT ON COLUMN BARS.ERR$_CP_REFW.VALUE IS '';



PROMPT *** Create  grants  ERR$_CP_REFW ***
grant SELECT                                                                 on ERR$_CP_REFW    to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_CP_REFW    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_CP_REFW.sql =========*** End *** 
PROMPT ===================================================================================== 
