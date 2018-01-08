

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_CP_EMIW.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_CP_EMIW ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_CP_EMIW ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_CP_EMIW 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	RNK VARCHAR2(4000), 
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




PROMPT *** ALTER_POLICIES to ERR$_CP_EMIW ***
 exec bpa.alter_policies('ERR$_CP_EMIW');


COMMENT ON TABLE BARS.ERR$_CP_EMIW IS 'DML Error Logging table for "CP_EMIW"';
COMMENT ON COLUMN BARS.ERR$_CP_EMIW.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_CP_EMIW.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CP_EMIW.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_CP_EMIW.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_CP_EMIW.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CP_EMIW.RNK IS '';
COMMENT ON COLUMN BARS.ERR$_CP_EMIW.TAG IS '';
COMMENT ON COLUMN BARS.ERR$_CP_EMIW.VALUE IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_CP_EMIW.sql =========*** End *** 
PROMPT ===================================================================================== 
