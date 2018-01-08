

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_EBK_QUALITYATTR_GOURPS.sql ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_EBK_QUALITYATTR_GOURPS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_EBK_QUALITYATTR_GOURPS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_EBK_QUALITYATTR_GOURPS 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	BATCHID VARCHAR2(4000), 
	KF VARCHAR2(4000), 
	RNK VARCHAR2(4000), 
	NAME VARCHAR2(4000), 
	QUALITY VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_EBK_QUALITYATTR_GOURPS ***
 exec bpa.alter_policies('ERR$_EBK_QUALITYATTR_GOURPS');


COMMENT ON TABLE BARS.ERR$_EBK_QUALITYATTR_GOURPS IS 'DML Error Logging table for "EBK_QUALITYATTR_GOURPS"';
COMMENT ON COLUMN BARS.ERR$_EBK_QUALITYATTR_GOURPS.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_EBK_QUALITYATTR_GOURPS.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_EBK_QUALITYATTR_GOURPS.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_EBK_QUALITYATTR_GOURPS.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_EBK_QUALITYATTR_GOURPS.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_EBK_QUALITYATTR_GOURPS.BATCHID IS '';
COMMENT ON COLUMN BARS.ERR$_EBK_QUALITYATTR_GOURPS.KF IS '';
COMMENT ON COLUMN BARS.ERR$_EBK_QUALITYATTR_GOURPS.RNK IS '';
COMMENT ON COLUMN BARS.ERR$_EBK_QUALITYATTR_GOURPS.NAME IS '';
COMMENT ON COLUMN BARS.ERR$_EBK_QUALITYATTR_GOURPS.QUALITY IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_EBK_QUALITYATTR_GOURPS.sql ======
PROMPT ===================================================================================== 
