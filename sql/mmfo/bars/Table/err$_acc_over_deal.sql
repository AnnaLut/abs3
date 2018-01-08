

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_ACC_OVER_DEAL.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_ACC_OVER_DEAL ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_ACC_OVER_DEAL ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_ACC_OVER_DEAL 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ACC VARCHAR2(4000), 
	NLS VARCHAR2(4000), 
	ACCO VARCHAR2(4000), 
	NLSO VARCHAR2(4000), 
	DAT VARCHAR2(4000), 
	DAT2 VARCHAR2(4000), 
	ND VARCHAR2(4000), 
	STATUS VARCHAR2(4000), 
	DT_ACTION VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_ACC_OVER_DEAL ***
 exec bpa.alter_policies('ERR$_ACC_OVER_DEAL');


COMMENT ON TABLE BARS.ERR$_ACC_OVER_DEAL IS 'DML Error Logging table for "ACC_OVER_DEAL"';
COMMENT ON COLUMN BARS.ERR$_ACC_OVER_DEAL.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_OVER_DEAL.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_OVER_DEAL.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_OVER_DEAL.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_OVER_DEAL.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_OVER_DEAL.ACC IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_OVER_DEAL.NLS IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_OVER_DEAL.ACCO IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_OVER_DEAL.NLSO IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_OVER_DEAL.DAT IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_OVER_DEAL.DAT2 IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_OVER_DEAL.ND IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_OVER_DEAL.STATUS IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_OVER_DEAL.DT_ACTION IS '';



PROMPT *** Create  grants  ERR$_ACC_OVER_DEAL ***
grant SELECT                                                                 on ERR$_ACC_OVER_DEAL to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_ACC_OVER_DEAL to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_ACC_OVER_DEAL.sql =========*** En
PROMPT ===================================================================================== 
