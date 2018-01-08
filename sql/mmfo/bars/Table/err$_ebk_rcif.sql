

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_EBK_RCIF.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_EBK_RCIF ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_EBK_RCIF ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_EBK_RCIF 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	KF VARCHAR2(4000), 
	RCIF VARCHAR2(4000), 
	SEND VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_EBK_RCIF ***
 exec bpa.alter_policies('ERR$_EBK_RCIF');


COMMENT ON TABLE BARS.ERR$_EBK_RCIF IS 'DML Error Logging table for "EBK_RCIF"';
COMMENT ON COLUMN BARS.ERR$_EBK_RCIF.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_EBK_RCIF.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_EBK_RCIF.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_EBK_RCIF.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_EBK_RCIF.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_EBK_RCIF.KF IS '';
COMMENT ON COLUMN BARS.ERR$_EBK_RCIF.RCIF IS '';
COMMENT ON COLUMN BARS.ERR$_EBK_RCIF.SEND IS '';



PROMPT *** Create  grants  ERR$_EBK_RCIF ***
grant SELECT                                                                 on ERR$_EBK_RCIF   to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_EBK_RCIF   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_EBK_RCIF.sql =========*** End ***
PROMPT ===================================================================================== 
