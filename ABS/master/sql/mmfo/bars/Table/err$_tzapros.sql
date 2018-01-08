

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_TZAPROS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_TZAPROS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_TZAPROS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_TZAPROS 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	REC VARCHAR2(4000), 
	ISP VARCHAR2(4000), 
	OTM VARCHAR2(4000), 
	DAT VARCHAR2(4000), 
	REC_O VARCHAR2(4000), 
	STMP VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_TZAPROS ***
 exec bpa.alter_policies('ERR$_TZAPROS');


COMMENT ON TABLE BARS.ERR$_TZAPROS IS 'DML Error Logging table for "TZAPROS"';
COMMENT ON COLUMN BARS.ERR$_TZAPROS.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_TZAPROS.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_TZAPROS.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_TZAPROS.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_TZAPROS.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_TZAPROS.REC IS '';
COMMENT ON COLUMN BARS.ERR$_TZAPROS.ISP IS '';
COMMENT ON COLUMN BARS.ERR$_TZAPROS.OTM IS '';
COMMENT ON COLUMN BARS.ERR$_TZAPROS.DAT IS '';
COMMENT ON COLUMN BARS.ERR$_TZAPROS.REC_O IS '';
COMMENT ON COLUMN BARS.ERR$_TZAPROS.STMP IS '';
COMMENT ON COLUMN BARS.ERR$_TZAPROS.KF IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_TZAPROS.sql =========*** End *** 
PROMPT ===================================================================================== 
