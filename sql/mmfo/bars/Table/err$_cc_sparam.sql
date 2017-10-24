

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_CC_SPARAM.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_CC_SPARAM ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_CC_SPARAM ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_CC_SPARAM 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ACC VARCHAR2(4000), 
	VIDD_9129 VARCHAR2(4000), 
	DATG VARCHAR2(4000), 
	SUMG VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_CC_SPARAM ***
 exec bpa.alter_policies('ERR$_CC_SPARAM');


COMMENT ON TABLE BARS.ERR$_CC_SPARAM IS 'DML Error Logging table for "CC_SPARAM"';
COMMENT ON COLUMN BARS.ERR$_CC_SPARAM.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_CC_SPARAM.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CC_SPARAM.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_CC_SPARAM.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_CC_SPARAM.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CC_SPARAM.ACC IS '';
COMMENT ON COLUMN BARS.ERR$_CC_SPARAM.VIDD_9129 IS '';
COMMENT ON COLUMN BARS.ERR$_CC_SPARAM.DATG IS '';
COMMENT ON COLUMN BARS.ERR$_CC_SPARAM.SUMG IS '';
COMMENT ON COLUMN BARS.ERR$_CC_SPARAM.KF IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_CC_SPARAM.sql =========*** End **
PROMPT ===================================================================================== 
