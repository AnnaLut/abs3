

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_ZAY_MFO_NLS29.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_ZAY_MFO_NLS29 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_ZAY_MFO_NLS29 ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_ZAY_MFO_NLS29 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	MFO VARCHAR2(4000), 
	NLS29 VARCHAR2(4000), 
	NLS29CA VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_ZAY_MFO_NLS29 ***
 exec bpa.alter_policies('ERR$_ZAY_MFO_NLS29');


COMMENT ON TABLE BARS.ERR$_ZAY_MFO_NLS29 IS 'DML Error Logging table for "ZAY_MFO_NLS29"';
COMMENT ON COLUMN BARS.ERR$_ZAY_MFO_NLS29.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_MFO_NLS29.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_MFO_NLS29.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_MFO_NLS29.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_MFO_NLS29.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_MFO_NLS29.MFO IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_MFO_NLS29.NLS29 IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_MFO_NLS29.NLS29CA IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_ZAY_MFO_NLS29.sql =========*** En
PROMPT ===================================================================================== 
