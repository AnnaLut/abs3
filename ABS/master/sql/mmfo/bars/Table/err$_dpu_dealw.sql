

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_DPU_DEALW.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_DPU_DEALW ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_DPU_DEALW ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_DPU_DEALW 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	DPU_ID VARCHAR2(4000), 
	TAG VARCHAR2(4000), 
	VALUE VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_DPU_DEALW ***
 exec bpa.alter_policies('ERR$_DPU_DEALW');


COMMENT ON TABLE BARS.ERR$_DPU_DEALW IS 'DML Error Logging table for "DPU_DEALW"';
COMMENT ON COLUMN BARS.ERR$_DPU_DEALW.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_DEALW.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_DEALW.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_DEALW.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_DEALW.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_DEALW.DPU_ID IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_DEALW.TAG IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_DEALW.VALUE IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_DEALW.KF IS '';



PROMPT *** Create  grants  ERR$_DPU_DEALW ***
grant SELECT                                                                 on ERR$_DPU_DEALW  to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_DPU_DEALW  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_DPU_DEALW.sql =========*** End **
PROMPT ===================================================================================== 
