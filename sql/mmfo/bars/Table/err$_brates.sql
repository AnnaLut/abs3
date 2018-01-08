

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_BRATES.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_BRATES ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_BRATES ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_BRATES 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	BR_ID VARCHAR2(4000), 
	BR_TYPE VARCHAR2(4000), 
	NAME VARCHAR2(4000), 
	FORMULA VARCHAR2(4000), 
	INUSE VARCHAR2(4000), 
	COMM VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_BRATES ***
 exec bpa.alter_policies('ERR$_BRATES');


COMMENT ON TABLE BARS.ERR$_BRATES IS 'DML Error Logging table for "BRATES"';
COMMENT ON COLUMN BARS.ERR$_BRATES.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_BRATES.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_BRATES.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_BRATES.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_BRATES.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_BRATES.BR_ID IS '';
COMMENT ON COLUMN BARS.ERR$_BRATES.BR_TYPE IS '';
COMMENT ON COLUMN BARS.ERR$_BRATES.NAME IS '';
COMMENT ON COLUMN BARS.ERR$_BRATES.FORMULA IS '';
COMMENT ON COLUMN BARS.ERR$_BRATES.INUSE IS '';
COMMENT ON COLUMN BARS.ERR$_BRATES.COMM IS '';
COMMENT ON COLUMN BARS.ERR$_BRATES.KF IS '';



PROMPT *** Create  grants  ERR$_BRATES ***
grant SELECT                                                                 on ERR$_BRATES     to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_BRATES.sql =========*** End *** =
PROMPT ===================================================================================== 
