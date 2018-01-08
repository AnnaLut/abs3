

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_SNAP_BALANCES.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_SNAP_BALANCES ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_SNAP_BALANCES ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_SNAP_BALANCES 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	FDAT VARCHAR2(4000), 
	ACC VARCHAR2(4000), 
	RNK VARCHAR2(4000), 
	OST VARCHAR2(4000), 
	DOS VARCHAR2(4000), 
	KOS VARCHAR2(4000), 
	OSTQ VARCHAR2(4000), 
	DOSQ VARCHAR2(4000), 
	KOSQ VARCHAR2(4000), 
	CALDT_ID VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_SNAP_BALANCES ***
 exec bpa.alter_policies('ERR$_SNAP_BALANCES');


COMMENT ON TABLE BARS.ERR$_SNAP_BALANCES IS 'DML Error Logging table for "SNAP_BALANCES"';
COMMENT ON COLUMN BARS.ERR$_SNAP_BALANCES.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_SNAP_BALANCES.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_SNAP_BALANCES.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_SNAP_BALANCES.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_SNAP_BALANCES.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_SNAP_BALANCES.FDAT IS '';
COMMENT ON COLUMN BARS.ERR$_SNAP_BALANCES.ACC IS '';
COMMENT ON COLUMN BARS.ERR$_SNAP_BALANCES.RNK IS '';
COMMENT ON COLUMN BARS.ERR$_SNAP_BALANCES.OST IS '';
COMMENT ON COLUMN BARS.ERR$_SNAP_BALANCES.DOS IS '';
COMMENT ON COLUMN BARS.ERR$_SNAP_BALANCES.KOS IS '';
COMMENT ON COLUMN BARS.ERR$_SNAP_BALANCES.OSTQ IS '';
COMMENT ON COLUMN BARS.ERR$_SNAP_BALANCES.DOSQ IS '';
COMMENT ON COLUMN BARS.ERR$_SNAP_BALANCES.KOSQ IS '';
COMMENT ON COLUMN BARS.ERR$_SNAP_BALANCES.CALDT_ID IS '';



PROMPT *** Create  grants  ERR$_SNAP_BALANCES ***
grant SELECT                                                                 on ERR$_SNAP_BALANCES to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_SNAP_BALANCES to BARS_DM;
grant SELECT                                                                 on ERR$_SNAP_BALANCES to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_SNAP_BALANCES.sql =========*** En
PROMPT ===================================================================================== 
