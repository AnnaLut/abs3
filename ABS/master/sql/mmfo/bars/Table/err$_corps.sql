

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_CORPS.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_CORPS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_CORPS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_CORPS 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	RNK VARCHAR2(4000), 
	NMKU VARCHAR2(4000), 
	RUK VARCHAR2(4000), 
	TELR VARCHAR2(4000), 
	BUH VARCHAR2(4000), 
	TELB VARCHAR2(4000), 
	DOV VARCHAR2(4000), 
	BDOV VARCHAR2(4000), 
	EDOV VARCHAR2(4000), 
	NLSNEW VARCHAR2(4000), 
	MAINNLS VARCHAR2(4000), 
	MAINMFO VARCHAR2(4000), 
	MFONEW VARCHAR2(4000), 
	TEL_FAX VARCHAR2(4000), 
	E_MAIL VARCHAR2(4000), 
	SEAL_ID VARCHAR2(4000), 
	NMK VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_CORPS ***
 exec bpa.alter_policies('ERR$_CORPS');


COMMENT ON TABLE BARS.ERR$_CORPS IS 'DML Error Logging table for "CORPS"';
COMMENT ON COLUMN BARS.ERR$_CORPS.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_CORPS.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CORPS.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_CORPS.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_CORPS.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CORPS.RNK IS '';
COMMENT ON COLUMN BARS.ERR$_CORPS.NMKU IS '';
COMMENT ON COLUMN BARS.ERR$_CORPS.RUK IS '';
COMMENT ON COLUMN BARS.ERR$_CORPS.TELR IS '';
COMMENT ON COLUMN BARS.ERR$_CORPS.BUH IS '';
COMMENT ON COLUMN BARS.ERR$_CORPS.TELB IS '';
COMMENT ON COLUMN BARS.ERR$_CORPS.DOV IS '';
COMMENT ON COLUMN BARS.ERR$_CORPS.BDOV IS '';
COMMENT ON COLUMN BARS.ERR$_CORPS.EDOV IS '';
COMMENT ON COLUMN BARS.ERR$_CORPS.NLSNEW IS '';
COMMENT ON COLUMN BARS.ERR$_CORPS.MAINNLS IS '';
COMMENT ON COLUMN BARS.ERR$_CORPS.MAINMFO IS '';
COMMENT ON COLUMN BARS.ERR$_CORPS.MFONEW IS '';
COMMENT ON COLUMN BARS.ERR$_CORPS.TEL_FAX IS '';
COMMENT ON COLUMN BARS.ERR$_CORPS.E_MAIL IS '';
COMMENT ON COLUMN BARS.ERR$_CORPS.SEAL_ID IS '';
COMMENT ON COLUMN BARS.ERR$_CORPS.NMK IS '';



PROMPT *** Create  grants  ERR$_CORPS ***
grant SELECT                                                                 on ERR$_CORPS      to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_CORPS      to BARS_DM;
grant SELECT                                                                 on ERR$_CORPS      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_CORPS.sql =========*** End *** ==
PROMPT ===================================================================================== 
