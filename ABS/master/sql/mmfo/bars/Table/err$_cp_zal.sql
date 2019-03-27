

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_CP_ZAL.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_CP_ZAL ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_CP_ZAL ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_CP_ZAL 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	REF VARCHAR2(4000), 
	ID VARCHAR2(4000), 
	KOLZ VARCHAR2(4000), 
	DATZ VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_CP_ZAL ***
 exec bpa.alter_policies('ERR$_CP_ZAL');


COMMENT ON TABLE BARS.ERR$_CP_ZAL IS 'DML Error Logging table for "CP_ZAL"';
COMMENT ON COLUMN BARS.ERR$_CP_ZAL.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_CP_ZAL.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CP_ZAL.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_CP_ZAL.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_CP_ZAL.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CP_ZAL.REF IS '';
COMMENT ON COLUMN BARS.ERR$_CP_ZAL.ID IS '';
COMMENT ON COLUMN BARS.ERR$_CP_ZAL.KOLZ IS '';
COMMENT ON COLUMN BARS.ERR$_CP_ZAL.DATZ IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_CP_ZAL.sql =========*** End *** =
PROMPT ===================================================================================== 