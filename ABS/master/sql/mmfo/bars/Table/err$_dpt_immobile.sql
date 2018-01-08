

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_DPT_IMMOBILE.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_DPT_IMMOBILE ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_DPT_IMMOBILE ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_DPT_IMMOBILE 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	DPT_ID VARCHAR2(4000), 
	TRANSFER_REF VARCHAR2(4000), 
	TRANSFER_DATE VARCHAR2(4000), 
	TRANSFER_AUTHOR VARCHAR2(4000), 
	BANK_DATE VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_DPT_IMMOBILE ***
 exec bpa.alter_policies('ERR$_DPT_IMMOBILE');


COMMENT ON TABLE BARS.ERR$_DPT_IMMOBILE IS 'DML Error Logging table for "DPT_IMMOBILE"';
COMMENT ON COLUMN BARS.ERR$_DPT_IMMOBILE.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_IMMOBILE.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_IMMOBILE.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_IMMOBILE.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_IMMOBILE.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_IMMOBILE.DPT_ID IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_IMMOBILE.TRANSFER_REF IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_IMMOBILE.TRANSFER_DATE IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_IMMOBILE.TRANSFER_AUTHOR IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_IMMOBILE.BANK_DATE IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_IMMOBILE.KF IS '';



PROMPT *** Create  grants  ERR$_DPT_IMMOBILE ***
grant SELECT                                                                 on ERR$_DPT_IMMOBILE to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_DPT_IMMOBILE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_DPT_IMMOBILE.sql =========*** End
PROMPT ===================================================================================== 
