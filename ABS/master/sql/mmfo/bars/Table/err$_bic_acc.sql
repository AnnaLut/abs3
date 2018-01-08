

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_BIC_ACC.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_BIC_ACC ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_BIC_ACC ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_BIC_ACC 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	BIC VARCHAR2(4000), 
	ACC VARCHAR2(4000), 
	TRANSIT VARCHAR2(4000), 
	THEIR_ACC VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_BIC_ACC ***
 exec bpa.alter_policies('ERR$_BIC_ACC');


COMMENT ON TABLE BARS.ERR$_BIC_ACC IS 'DML Error Logging table for "BIC_ACC"';
COMMENT ON COLUMN BARS.ERR$_BIC_ACC.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_BIC_ACC.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_BIC_ACC.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_BIC_ACC.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_BIC_ACC.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_BIC_ACC.BIC IS '';
COMMENT ON COLUMN BARS.ERR$_BIC_ACC.ACC IS '';
COMMENT ON COLUMN BARS.ERR$_BIC_ACC.TRANSIT IS '';
COMMENT ON COLUMN BARS.ERR$_BIC_ACC.THEIR_ACC IS '';
COMMENT ON COLUMN BARS.ERR$_BIC_ACC.KF IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_BIC_ACC.sql =========*** End *** 
PROMPT ===================================================================================== 
