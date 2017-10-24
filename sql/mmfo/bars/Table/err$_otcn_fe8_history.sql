

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_OTCN_FE8_HISTORY.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_OTCN_FE8_HISTORY ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_OTCN_FE8_HISTORY ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_OTCN_FE8_HISTORY 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	DATF VARCHAR2(4000), 
	ACC VARCHAR2(4000), 
	OSTF VARCHAR2(4000), 
	ND VARCHAR2(4000), 
	P090 VARCHAR2(4000), 
	P110 VARCHAR2(4000), 
	P111 VARCHAR2(4000), 
	P112 VARCHAR2(4000), 
	P130 VARCHAR2(4000), 
	RNK VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_OTCN_FE8_HISTORY ***
 exec bpa.alter_policies('ERR$_OTCN_FE8_HISTORY');


COMMENT ON TABLE BARS.ERR$_OTCN_FE8_HISTORY IS 'DML Error Logging table for "OTCN_FE8_HISTORY"';
COMMENT ON COLUMN BARS.ERR$_OTCN_FE8_HISTORY.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_FE8_HISTORY.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_FE8_HISTORY.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_FE8_HISTORY.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_FE8_HISTORY.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_FE8_HISTORY.DATF IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_FE8_HISTORY.ACC IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_FE8_HISTORY.OSTF IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_FE8_HISTORY.ND IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_FE8_HISTORY.P090 IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_FE8_HISTORY.P110 IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_FE8_HISTORY.P111 IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_FE8_HISTORY.P112 IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_FE8_HISTORY.P130 IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_FE8_HISTORY.RNK IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_FE8_HISTORY.KF IS '';



PROMPT *** Create  grants  ERR$_OTCN_FE8_HISTORY ***
grant SELECT                                                                 on ERR$_OTCN_FE8_HISTORY to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_OTCN_FE8_HISTORY.sql =========***
PROMPT ===================================================================================== 
