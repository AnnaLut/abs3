

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_CC_MANY.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_CC_MANY ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_CC_MANY ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_CC_MANY 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ND VARCHAR2(4000), 
	FDAT VARCHAR2(4000), 
	SS1 VARCHAR2(4000), 
	SDP VARCHAR2(4000), 
	SS2 VARCHAR2(4000), 
	SN2 VARCHAR2(4000), 
	KF VARCHAR2(4000), 
	P_SS VARCHAR2(4000), 
	P_SN VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_CC_MANY ***
 exec bpa.alter_policies('ERR$_CC_MANY');


COMMENT ON TABLE BARS.ERR$_CC_MANY IS 'DML Error Logging table for "CC_MANY"';
COMMENT ON COLUMN BARS.ERR$_CC_MANY.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_CC_MANY.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CC_MANY.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_CC_MANY.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_CC_MANY.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CC_MANY.ND IS '';
COMMENT ON COLUMN BARS.ERR$_CC_MANY.FDAT IS '';
COMMENT ON COLUMN BARS.ERR$_CC_MANY.SS1 IS '';
COMMENT ON COLUMN BARS.ERR$_CC_MANY.SDP IS '';
COMMENT ON COLUMN BARS.ERR$_CC_MANY.SS2 IS '';
COMMENT ON COLUMN BARS.ERR$_CC_MANY.SN2 IS '';
COMMENT ON COLUMN BARS.ERR$_CC_MANY.KF IS '';
COMMENT ON COLUMN BARS.ERR$_CC_MANY.P_SS IS '';
COMMENT ON COLUMN BARS.ERR$_CC_MANY.P_SN IS '';



PROMPT *** Create  grants  ERR$_CC_MANY ***
grant SELECT                                                                 on ERR$_CC_MANY    to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_CC_MANY    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_CC_MANY.sql =========*** End *** 
PROMPT ===================================================================================== 
