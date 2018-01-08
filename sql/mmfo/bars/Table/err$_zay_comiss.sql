

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_ZAY_COMISS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_ZAY_COMISS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_ZAY_COMISS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_ZAY_COMISS 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ID VARCHAR2(4000), 
	RNK VARCHAR2(4000), 
	DK VARCHAR2(4000), 
	KV_GRP VARCHAR2(4000), 
	KV VARCHAR2(4000), 
	LIMIT VARCHAR2(4000), 
	RATE VARCHAR2(4000), 
	FIX_SUM VARCHAR2(4000), 
	DATE_ON VARCHAR2(4000), 
	DATE_OFF VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_ZAY_COMISS ***
 exec bpa.alter_policies('ERR$_ZAY_COMISS');


COMMENT ON TABLE BARS.ERR$_ZAY_COMISS IS 'DML Error Logging table for "ZAY_COMISS"';
COMMENT ON COLUMN BARS.ERR$_ZAY_COMISS.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_COMISS.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_COMISS.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_COMISS.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_COMISS.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_COMISS.ID IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_COMISS.RNK IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_COMISS.DK IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_COMISS.KV_GRP IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_COMISS.KV IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_COMISS.LIMIT IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_COMISS.RATE IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_COMISS.FIX_SUM IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_COMISS.DATE_ON IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_COMISS.DATE_OFF IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_COMISS.KF IS '';



PROMPT *** Create  grants  ERR$_ZAY_COMISS ***
grant SELECT                                                                 on ERR$_ZAY_COMISS to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_ZAY_COMISS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_ZAY_COMISS.sql =========*** End *
PROMPT ===================================================================================== 
