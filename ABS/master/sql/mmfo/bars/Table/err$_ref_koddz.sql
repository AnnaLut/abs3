

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_REF_KODDZ.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_REF_KODDZ ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_REF_KODDZ ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_REF_KODDZ 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	REF VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_REF_KODDZ ***
 exec bpa.alter_policies('ERR$_REF_KODDZ');


COMMENT ON TABLE BARS.ERR$_REF_KODDZ IS 'DML Error Logging table for "REF_KODDZ"';
COMMENT ON COLUMN BARS.ERR$_REF_KODDZ.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_REF_KODDZ.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_REF_KODDZ.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_REF_KODDZ.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_REF_KODDZ.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_REF_KODDZ.REF IS '';
COMMENT ON COLUMN BARS.ERR$_REF_KODDZ.KF IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_REF_KODDZ.sql =========*** End **
PROMPT ===================================================================================== 
