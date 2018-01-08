

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_ZAY_TRACK_RU.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_ZAY_TRACK_RU ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_ZAY_TRACK_RU ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_ZAY_TRACK_RU 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	MFO VARCHAR2(4000), 
	TRACK_ID VARCHAR2(4000), 
	REQ_ID VARCHAR2(4000), 
	CHANGE_TIME VARCHAR2(4000), 
	FIO VARCHAR2(4000), 
	SOS VARCHAR2(4000), 
	VIZA VARCHAR2(4000), 
	VIZA_NAME VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_ZAY_TRACK_RU ***
 exec bpa.alter_policies('ERR$_ZAY_TRACK_RU');


COMMENT ON TABLE BARS.ERR$_ZAY_TRACK_RU IS 'DML Error Logging table for "ZAY_TRACK_RU"';
COMMENT ON COLUMN BARS.ERR$_ZAY_TRACK_RU.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_TRACK_RU.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_TRACK_RU.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_TRACK_RU.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_TRACK_RU.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_TRACK_RU.MFO IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_TRACK_RU.TRACK_ID IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_TRACK_RU.REQ_ID IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_TRACK_RU.CHANGE_TIME IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_TRACK_RU.FIO IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_TRACK_RU.SOS IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_TRACK_RU.VIZA IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_TRACK_RU.VIZA_NAME IS '';



PROMPT *** Create  grants  ERR$_ZAY_TRACK_RU ***
grant SELECT                                                                 on ERR$_ZAY_TRACK_RU to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_ZAY_TRACK_RU to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_ZAY_TRACK_RU.sql =========*** End
PROMPT ===================================================================================== 
