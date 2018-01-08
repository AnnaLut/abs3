

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_SW_OPER.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_SW_OPER ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_SW_OPER ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_SW_OPER 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	REF VARCHAR2(4000), 
	SWREF VARCHAR2(4000), 
	KF VARCHAR2(4000), 
	SWRNUM VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_SW_OPER ***
 exec bpa.alter_policies('ERR$_SW_OPER');


COMMENT ON TABLE BARS.ERR$_SW_OPER IS 'DML Error Logging table for "SW_OPER"';
COMMENT ON COLUMN BARS.ERR$_SW_OPER.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_SW_OPER.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_SW_OPER.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_SW_OPER.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_SW_OPER.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_SW_OPER.REF IS '';
COMMENT ON COLUMN BARS.ERR$_SW_OPER.SWREF IS '';
COMMENT ON COLUMN BARS.ERR$_SW_OPER.KF IS '';
COMMENT ON COLUMN BARS.ERR$_SW_OPER.SWRNUM IS '';



PROMPT *** Create  grants  ERR$_SW_OPER ***
grant SELECT                                                                 on ERR$_SW_OPER    to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_SW_OPER    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_SW_OPER.sql =========*** End *** 
PROMPT ===================================================================================== 
