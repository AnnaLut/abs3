

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_ACC_OVER_PAR.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_ACC_OVER_PAR ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_ACC_OVER_PAR ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_ACC_OVER_PAR 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	PAR VARCHAR2(4000), 
	VAL VARCHAR2(4000), 
	COMM VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_ACC_OVER_PAR ***
 exec bpa.alter_policies('ERR$_ACC_OVER_PAR');


COMMENT ON TABLE BARS.ERR$_ACC_OVER_PAR IS 'DML Error Logging table for "ACC_OVER_PAR"';
COMMENT ON COLUMN BARS.ERR$_ACC_OVER_PAR.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_OVER_PAR.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_OVER_PAR.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_OVER_PAR.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_OVER_PAR.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_OVER_PAR.PAR IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_OVER_PAR.VAL IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_OVER_PAR.COMM IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_OVER_PAR.KF IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_ACC_OVER_PAR.sql =========*** End
PROMPT ===================================================================================== 
