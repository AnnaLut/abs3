

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_NIGHT_LIM.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_NIGHT_LIM ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_NIGHT_LIM ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_NIGHT_LIM 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	KV VARCHAR2(4000), 
	NLS VARCHAR2(4000), 
	LIM VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_NIGHT_LIM ***
 exec bpa.alter_policies('ERR$_NIGHT_LIM');


COMMENT ON TABLE BARS.ERR$_NIGHT_LIM IS 'DML Error Logging table for "NIGHT_LIM"';
COMMENT ON COLUMN BARS.ERR$_NIGHT_LIM.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_NIGHT_LIM.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_NIGHT_LIM.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_NIGHT_LIM.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_NIGHT_LIM.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_NIGHT_LIM.KV IS '';
COMMENT ON COLUMN BARS.ERR$_NIGHT_LIM.NLS IS '';
COMMENT ON COLUMN BARS.ERR$_NIGHT_LIM.LIM IS '';
COMMENT ON COLUMN BARS.ERR$_NIGHT_LIM.KF IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_NIGHT_LIM.sql =========*** End **
PROMPT ===================================================================================== 
