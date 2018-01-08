

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_SW_ACC_SPARAM.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_SW_ACC_SPARAM ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_SW_ACC_SPARAM ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_SW_ACC_SPARAM 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ACC VARCHAR2(4000), 
	USE4MT950 VARCHAR2(4000), 
	USE4MT900 VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_SW_ACC_SPARAM ***
 exec bpa.alter_policies('ERR$_SW_ACC_SPARAM');


COMMENT ON TABLE BARS.ERR$_SW_ACC_SPARAM IS 'DML Error Logging table for "SW_ACC_SPARAM"';
COMMENT ON COLUMN BARS.ERR$_SW_ACC_SPARAM.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_SW_ACC_SPARAM.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_SW_ACC_SPARAM.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_SW_ACC_SPARAM.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_SW_ACC_SPARAM.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_SW_ACC_SPARAM.ACC IS '';
COMMENT ON COLUMN BARS.ERR$_SW_ACC_SPARAM.USE4MT950 IS '';
COMMENT ON COLUMN BARS.ERR$_SW_ACC_SPARAM.USE4MT900 IS '';
COMMENT ON COLUMN BARS.ERR$_SW_ACC_SPARAM.KF IS '';



PROMPT *** Create  grants  ERR$_SW_ACC_SPARAM ***
grant SELECT                                                                 on ERR$_SW_ACC_SPARAM to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_SW_ACC_SPARAM to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_SW_ACC_SPARAM.sql =========*** En
PROMPT ===================================================================================== 
