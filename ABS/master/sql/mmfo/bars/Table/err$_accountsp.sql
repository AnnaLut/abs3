

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_ACCOUNTSP.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_ACCOUNTSP ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_ACCOUNTSP ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_ACCOUNTSP 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ACC VARCHAR2(4000), 
	DAT1 VARCHAR2(4000), 
	DAT2 VARCHAR2(4000), 
	PARID VARCHAR2(4000), 
	VAL VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_ACCOUNTSP ***
 exec bpa.alter_policies('ERR$_ACCOUNTSP');


COMMENT ON TABLE BARS.ERR$_ACCOUNTSP IS 'DML Error Logging table for "ACCOUNTSP"';
COMMENT ON COLUMN BARS.ERR$_ACCOUNTSP.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_ACCOUNTSP.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_ACCOUNTSP.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_ACCOUNTSP.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_ACCOUNTSP.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_ACCOUNTSP.ACC IS '';
COMMENT ON COLUMN BARS.ERR$_ACCOUNTSP.DAT1 IS '';
COMMENT ON COLUMN BARS.ERR$_ACCOUNTSP.DAT2 IS '';
COMMENT ON COLUMN BARS.ERR$_ACCOUNTSP.PARID IS '';
COMMENT ON COLUMN BARS.ERR$_ACCOUNTSP.VAL IS '';
COMMENT ON COLUMN BARS.ERR$_ACCOUNTSP.KF IS '';



PROMPT *** Create  grants  ERR$_ACCOUNTSP ***
grant SELECT                                                                 on ERR$_ACCOUNTSP  to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_ACCOUNTSP  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_ACCOUNTSP.sql =========*** End **
PROMPT ===================================================================================== 
