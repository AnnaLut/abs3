

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_OTCN_FLAG_BLK.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_OTCN_FLAG_BLK ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_OTCN_FLAG_BLK ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_OTCN_FLAG_BLK 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	TP VARCHAR2(4000), 
	DATF VARCHAR2(4000), 
	KODF VARCHAR2(4000), 
	ISP VARCHAR2(4000), 
	DAT_BLK VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_OTCN_FLAG_BLK ***
 exec bpa.alter_policies('ERR$_OTCN_FLAG_BLK');


COMMENT ON TABLE BARS.ERR$_OTCN_FLAG_BLK IS 'DML Error Logging table for "OTCN_FLAG_BLK"';
COMMENT ON COLUMN BARS.ERR$_OTCN_FLAG_BLK.DAT_BLK IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_FLAG_BLK.KF IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_FLAG_BLK.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_FLAG_BLK.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_FLAG_BLK.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_FLAG_BLK.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_FLAG_BLK.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_FLAG_BLK.TP IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_FLAG_BLK.DATF IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_FLAG_BLK.KODF IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_FLAG_BLK.ISP IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_OTCN_FLAG_BLK.sql =========*** En
PROMPT ===================================================================================== 
