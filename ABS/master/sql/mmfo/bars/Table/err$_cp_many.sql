

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_CP_MANY.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_CP_MANY ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_CP_MANY ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_CP_MANY 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	REF VARCHAR2(4000), 
	FDAT VARCHAR2(4000), 
	SS1 VARCHAR2(4000), 
	SDP VARCHAR2(4000), 
	SN2 VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_CP_MANY ***
 exec bpa.alter_policies('ERR$_CP_MANY');


COMMENT ON TABLE BARS.ERR$_CP_MANY IS 'DML Error Logging table for "CP_MANY"';
COMMENT ON COLUMN BARS.ERR$_CP_MANY.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_CP_MANY.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CP_MANY.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_CP_MANY.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_CP_MANY.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CP_MANY.REF IS '';
COMMENT ON COLUMN BARS.ERR$_CP_MANY.FDAT IS '';
COMMENT ON COLUMN BARS.ERR$_CP_MANY.SS1 IS '';
COMMENT ON COLUMN BARS.ERR$_CP_MANY.SDP IS '';
COMMENT ON COLUMN BARS.ERR$_CP_MANY.SN2 IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_CP_MANY.sql =========*** End *** 
PROMPT ===================================================================================== 