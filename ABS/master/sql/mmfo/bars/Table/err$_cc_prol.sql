

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_CC_PROL.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_CC_PROL ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_CC_PROL ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_CC_PROL 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ND VARCHAR2(4000), 
	FDAT VARCHAR2(4000), 
	NPP VARCHAR2(4000), 
	MDATE VARCHAR2(4000), 
	TXT VARCHAR2(4000), 
	ACC VARCHAR2(4000), 
	KF VARCHAR2(4000), 
	DMDAT VARCHAR2(4000), 
	PROL_TYPE VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_CC_PROL ***
 exec bpa.alter_policies('ERR$_CC_PROL');


COMMENT ON TABLE BARS.ERR$_CC_PROL IS 'DML Error Logging table for "CC_PROL"';
COMMENT ON COLUMN BARS.ERR$_CC_PROL.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_CC_PROL.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CC_PROL.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_CC_PROL.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_CC_PROL.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CC_PROL.ND IS '';
COMMENT ON COLUMN BARS.ERR$_CC_PROL.FDAT IS '';
COMMENT ON COLUMN BARS.ERR$_CC_PROL.NPP IS '';
COMMENT ON COLUMN BARS.ERR$_CC_PROL.MDATE IS '';
COMMENT ON COLUMN BARS.ERR$_CC_PROL.TXT IS '';
COMMENT ON COLUMN BARS.ERR$_CC_PROL.ACC IS '';
COMMENT ON COLUMN BARS.ERR$_CC_PROL.KF IS '';
COMMENT ON COLUMN BARS.ERR$_CC_PROL.DMDAT IS '';
COMMENT ON COLUMN BARS.ERR$_CC_PROL.PROL_TYPE IS '';



PROMPT *** Create  grants  ERR$_CC_PROL ***
grant SELECT                                                                 on ERR$_CC_PROL    to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_CC_PROL    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_CC_PROL.sql =========*** End *** 
PROMPT ===================================================================================== 
