

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_P12_2C.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_P12_2C ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_P12_2C ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_P12_2C 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	CODE VARCHAR2(4000), 
	TXT VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_P12_2C ***
 exec bpa.alter_policies('ERR$_P12_2C');


COMMENT ON TABLE BARS.ERR$_P12_2C IS 'DML Error Logging table for "P12_2C"';
COMMENT ON COLUMN BARS.ERR$_P12_2C.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_P12_2C.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_P12_2C.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_P12_2C.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_P12_2C.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_P12_2C.CODE IS '';
COMMENT ON COLUMN BARS.ERR$_P12_2C.TXT IS '';



PROMPT *** Create  grants  ERR$_P12_2C ***
grant SELECT                                                                 on ERR$_P12_2C     to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_P12_2C     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_P12_2C.sql =========*** End *** =
PROMPT ===================================================================================== 
