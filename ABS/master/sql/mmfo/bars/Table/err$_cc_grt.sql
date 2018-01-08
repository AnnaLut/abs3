

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_CC_GRT.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_CC_GRT ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_CC_GRT ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_CC_GRT 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ND VARCHAR2(4000), 
	GRT_DEAL_ID VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_CC_GRT ***
 exec bpa.alter_policies('ERR$_CC_GRT');


COMMENT ON TABLE BARS.ERR$_CC_GRT IS 'DML Error Logging table for "CC_GRT"';
COMMENT ON COLUMN BARS.ERR$_CC_GRT.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_CC_GRT.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_CC_GRT.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CC_GRT.ND IS '';
COMMENT ON COLUMN BARS.ERR$_CC_GRT.GRT_DEAL_ID IS '';
COMMENT ON COLUMN BARS.ERR$_CC_GRT.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_CC_GRT.ORA_ERR_MESG$ IS '';



PROMPT *** Create  grants  ERR$_CC_GRT ***
grant SELECT                                                                 on ERR$_CC_GRT     to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_CC_GRT     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_CC_GRT.sql =========*** End *** =
PROMPT ===================================================================================== 
