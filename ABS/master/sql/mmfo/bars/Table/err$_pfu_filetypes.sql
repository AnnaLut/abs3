

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_PFU_FILETYPES.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_PFU_FILETYPES ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_PFU_FILETYPES ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_PFU_FILETYPES 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ID VARCHAR2(4000), 
	NAME VARCHAR2(4000), 
	CODE VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_PFU_FILETYPES ***
 exec bpa.alter_policies('ERR$_PFU_FILETYPES');


COMMENT ON TABLE BARS.ERR$_PFU_FILETYPES IS 'DML Error Logging table for "PFU_FILETYPES"';
COMMENT ON COLUMN BARS.ERR$_PFU_FILETYPES.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_PFU_FILETYPES.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_PFU_FILETYPES.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_PFU_FILETYPES.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_PFU_FILETYPES.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_PFU_FILETYPES.ID IS '';
COMMENT ON COLUMN BARS.ERR$_PFU_FILETYPES.NAME IS '';
COMMENT ON COLUMN BARS.ERR$_PFU_FILETYPES.CODE IS '';



PROMPT *** Create  grants  ERR$_PFU_FILETYPES ***
grant SELECT                                                                 on ERR$_PFU_FILETYPES to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_PFU_FILETYPES to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_PFU_FILETYPES.sql =========*** En
PROMPT ===================================================================================== 
