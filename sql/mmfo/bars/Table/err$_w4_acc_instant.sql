

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_W4_ACC_INSTANT.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_W4_ACC_INSTANT ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_W4_ACC_INSTANT ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_W4_ACC_INSTANT 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ACC VARCHAR2(4000), 
	CARD_CODE VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_W4_ACC_INSTANT ***
 exec bpa.alter_policies('ERR$_W4_ACC_INSTANT');


COMMENT ON TABLE BARS.ERR$_W4_ACC_INSTANT IS 'DML Error Logging table for "W4_ACC_INSTANT"';
COMMENT ON COLUMN BARS.ERR$_W4_ACC_INSTANT.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_W4_ACC_INSTANT.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_W4_ACC_INSTANT.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_W4_ACC_INSTANT.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_W4_ACC_INSTANT.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_W4_ACC_INSTANT.ACC IS '';
COMMENT ON COLUMN BARS.ERR$_W4_ACC_INSTANT.CARD_CODE IS '';
COMMENT ON COLUMN BARS.ERR$_W4_ACC_INSTANT.KF IS '';



PROMPT *** Create  grants  ERR$_W4_ACC_INSTANT ***
grant SELECT                                                                 on ERR$_W4_ACC_INSTANT to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_W4_ACC_INSTANT to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_W4_ACC_INSTANT.sql =========*** E
PROMPT ===================================================================================== 
