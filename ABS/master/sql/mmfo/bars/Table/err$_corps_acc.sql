

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_CORPS_ACC.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_CORPS_ACC ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_CORPS_ACC ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_CORPS_ACC 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ID VARCHAR2(4000), 
	RNK VARCHAR2(4000), 
	MFO VARCHAR2(4000), 
	NLS VARCHAR2(4000), 
	KV VARCHAR2(4000), 
	COMMENTS VARCHAR2(4000), 
	SW56_NAME VARCHAR2(4000), 
	SW56_ADR VARCHAR2(4000), 
	SW56_CODE VARCHAR2(4000), 
	SW57_NAME VARCHAR2(4000), 
	SW57_ADR VARCHAR2(4000), 
	SW57_CODE VARCHAR2(4000), 
	SW57_ACC VARCHAR2(4000), 
	SW59_NAME VARCHAR2(4000), 
	SW59_ADR VARCHAR2(4000), 
	SW59_ACC VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_CORPS_ACC ***
 exec bpa.alter_policies('ERR$_CORPS_ACC');


COMMENT ON TABLE BARS.ERR$_CORPS_ACC IS 'DML Error Logging table for "CORPS_ACC"';
COMMENT ON COLUMN BARS.ERR$_CORPS_ACC.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_CORPS_ACC.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_CORPS_ACC.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CORPS_ACC.ID IS '';
COMMENT ON COLUMN BARS.ERR$_CORPS_ACC.RNK IS '';
COMMENT ON COLUMN BARS.ERR$_CORPS_ACC.MFO IS '';
COMMENT ON COLUMN BARS.ERR$_CORPS_ACC.NLS IS '';
COMMENT ON COLUMN BARS.ERR$_CORPS_ACC.KV IS '';
COMMENT ON COLUMN BARS.ERR$_CORPS_ACC.COMMENTS IS '';
COMMENT ON COLUMN BARS.ERR$_CORPS_ACC.SW56_NAME IS '';
COMMENT ON COLUMN BARS.ERR$_CORPS_ACC.SW56_ADR IS '';
COMMENT ON COLUMN BARS.ERR$_CORPS_ACC.SW56_CODE IS '';
COMMENT ON COLUMN BARS.ERR$_CORPS_ACC.SW57_NAME IS '';
COMMENT ON COLUMN BARS.ERR$_CORPS_ACC.SW57_ADR IS '';
COMMENT ON COLUMN BARS.ERR$_CORPS_ACC.SW57_CODE IS '';
COMMENT ON COLUMN BARS.ERR$_CORPS_ACC.SW57_ACC IS '';
COMMENT ON COLUMN BARS.ERR$_CORPS_ACC.SW59_NAME IS '';
COMMENT ON COLUMN BARS.ERR$_CORPS_ACC.SW59_ADR IS '';
COMMENT ON COLUMN BARS.ERR$_CORPS_ACC.SW59_ACC IS '';
COMMENT ON COLUMN BARS.ERR$_CORPS_ACC.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_CORPS_ACC.ORA_ERR_MESG$ IS '';



PROMPT *** Create  grants  ERR$_CORPS_ACC ***
grant SELECT                                                                 on ERR$_CORPS_ACC  to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_CORPS_ACC  to BARS_DM;
grant SELECT                                                                 on ERR$_CORPS_ACC  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_CORPS_ACC.sql =========*** End **
PROMPT ===================================================================================== 
