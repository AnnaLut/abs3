

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_OTCN_DEL_3A.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_OTCN_DEL_3A ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_OTCN_DEL_3A ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_OTCN_DEL_3A 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	DATF VARCHAR2(4000), 
	ISP VARCHAR2(4000), 
	ACC VARCHAR2(4000), 
	NLS VARCHAR2(4000), 
	KV VARCHAR2(4000), 
	TPF VARCHAR2(4000), 
	SUMO VARCHAR2(4000), 
	SUMF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_OTCN_DEL_3A ***
 exec bpa.alter_policies('ERR$_OTCN_DEL_3A');


COMMENT ON TABLE BARS.ERR$_OTCN_DEL_3A IS 'DML Error Logging table for "OTCN_DEL_3A"';
COMMENT ON COLUMN BARS.ERR$_OTCN_DEL_3A.SUMO IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_DEL_3A.SUMF IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_DEL_3A.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_DEL_3A.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_DEL_3A.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_DEL_3A.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_DEL_3A.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_DEL_3A.DATF IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_DEL_3A.ISP IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_DEL_3A.ACC IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_DEL_3A.NLS IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_DEL_3A.KV IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_DEL_3A.TPF IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_OTCN_DEL_3A.sql =========*** End 
PROMPT ===================================================================================== 
