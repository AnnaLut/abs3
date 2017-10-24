

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_SOS_TRACK.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_SOS_TRACK ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_SOS_TRACK ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_SOS_TRACK 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	REF VARCHAR2(4000), 
	SOS_TRACKER VARCHAR2(4000), 
	OLD_SOS VARCHAR2(4000), 
	NEW_SOS VARCHAR2(4000), 
	CHANGE_TIME VARCHAR2(4000), 
	USERID VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_SOS_TRACK ***
 exec bpa.alter_policies('ERR$_SOS_TRACK');


COMMENT ON TABLE BARS.ERR$_SOS_TRACK IS 'DML Error Logging table for "SOS_TRACK"';
COMMENT ON COLUMN BARS.ERR$_SOS_TRACK.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_SOS_TRACK.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_SOS_TRACK.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_SOS_TRACK.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_SOS_TRACK.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_SOS_TRACK.REF IS '';
COMMENT ON COLUMN BARS.ERR$_SOS_TRACK.SOS_TRACKER IS '';
COMMENT ON COLUMN BARS.ERR$_SOS_TRACK.OLD_SOS IS '';
COMMENT ON COLUMN BARS.ERR$_SOS_TRACK.NEW_SOS IS '';
COMMENT ON COLUMN BARS.ERR$_SOS_TRACK.CHANGE_TIME IS '';
COMMENT ON COLUMN BARS.ERR$_SOS_TRACK.USERID IS '';
COMMENT ON COLUMN BARS.ERR$_SOS_TRACK.KF IS '';



PROMPT *** Create  grants  ERR$_SOS_TRACK ***
grant SELECT                                                                 on ERR$_SOS_TRACK  to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_SOS_TRACK.sql =========*** End **
PROMPT ===================================================================================== 
