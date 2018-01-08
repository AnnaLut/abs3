

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_OW_ACC_QUE.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_OW_ACC_QUE ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_OW_ACC_QUE ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_OW_ACC_QUE 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ACC VARCHAR2(4000), 
	S VARCHAR2(4000), 
	DAT VARCHAR2(4000), 
	SOS VARCHAR2(4000), 
	F_N VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_OW_ACC_QUE ***
 exec bpa.alter_policies('ERR$_OW_ACC_QUE');


COMMENT ON TABLE BARS.ERR$_OW_ACC_QUE IS 'DML Error Logging table for "OW_ACC_QUE"';
COMMENT ON COLUMN BARS.ERR$_OW_ACC_QUE.SOS IS '';
COMMENT ON COLUMN BARS.ERR$_OW_ACC_QUE.F_N IS '';
COMMENT ON COLUMN BARS.ERR$_OW_ACC_QUE.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_OW_ACC_QUE.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_OW_ACC_QUE.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_OW_ACC_QUE.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_OW_ACC_QUE.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_OW_ACC_QUE.ACC IS '';
COMMENT ON COLUMN BARS.ERR$_OW_ACC_QUE.S IS '';
COMMENT ON COLUMN BARS.ERR$_OW_ACC_QUE.DAT IS '';



PROMPT *** Create  grants  ERR$_OW_ACC_QUE ***
grant SELECT                                                                 on ERR$_OW_ACC_QUE to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_OW_ACC_QUE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_OW_ACC_QUE.sql =========*** End *
PROMPT ===================================================================================== 
