

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_VP_LIST.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_VP_LIST ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_VP_LIST ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_VP_LIST 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ACC3800 VARCHAR2(4000), 
	ACC3801 VARCHAR2(4000), 
	ACC6204 VARCHAR2(4000), 
	COMM VARCHAR2(4000), 
	ACC_RRD VARCHAR2(4000), 
	ACC_RRR VARCHAR2(4000), 
	ACC_RRS VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_VP_LIST ***
 exec bpa.alter_policies('ERR$_VP_LIST');


COMMENT ON TABLE BARS.ERR$_VP_LIST IS 'DML Error Logging table for "VP_LIST"';
COMMENT ON COLUMN BARS.ERR$_VP_LIST.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_VP_LIST.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_VP_LIST.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_VP_LIST.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_VP_LIST.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_VP_LIST.ACC3800 IS '';
COMMENT ON COLUMN BARS.ERR$_VP_LIST.ACC3801 IS '';
COMMENT ON COLUMN BARS.ERR$_VP_LIST.ACC6204 IS '';
COMMENT ON COLUMN BARS.ERR$_VP_LIST.COMM IS '';
COMMENT ON COLUMN BARS.ERR$_VP_LIST.ACC_RRD IS '';
COMMENT ON COLUMN BARS.ERR$_VP_LIST.ACC_RRR IS '';
COMMENT ON COLUMN BARS.ERR$_VP_LIST.ACC_RRS IS '';
COMMENT ON COLUMN BARS.ERR$_VP_LIST.KF IS '';



PROMPT *** Create  grants  ERR$_VP_LIST ***
grant SELECT                                                                 on ERR$_VP_LIST    to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_VP_LIST    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_VP_LIST.sql =========*** End *** 
PROMPT ===================================================================================== 
