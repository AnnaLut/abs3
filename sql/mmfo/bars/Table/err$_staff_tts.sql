

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_STAFF_TTS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_STAFF_TTS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_STAFF_TTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_STAFF_TTS 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	TT VARCHAR2(4000), 
	ID VARCHAR2(4000), 
	APPROVE VARCHAR2(4000), 
	ADATE1 VARCHAR2(4000), 
	ADATE2 VARCHAR2(4000), 
	RDATE1 VARCHAR2(4000), 
	RDATE2 VARCHAR2(4000), 
	REVOKED VARCHAR2(4000), 
	GRANTOR VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_STAFF_TTS ***
 exec bpa.alter_policies('ERR$_STAFF_TTS');


COMMENT ON TABLE BARS.ERR$_STAFF_TTS IS 'DML Error Logging table for "STAFF_TTS"';
COMMENT ON COLUMN BARS.ERR$_STAFF_TTS.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_STAFF_TTS.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_STAFF_TTS.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_STAFF_TTS.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_STAFF_TTS.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_STAFF_TTS.TT IS '';
COMMENT ON COLUMN BARS.ERR$_STAFF_TTS.ID IS '';
COMMENT ON COLUMN BARS.ERR$_STAFF_TTS.APPROVE IS '';
COMMENT ON COLUMN BARS.ERR$_STAFF_TTS.ADATE1 IS '';
COMMENT ON COLUMN BARS.ERR$_STAFF_TTS.ADATE2 IS '';
COMMENT ON COLUMN BARS.ERR$_STAFF_TTS.RDATE1 IS '';
COMMENT ON COLUMN BARS.ERR$_STAFF_TTS.RDATE2 IS '';
COMMENT ON COLUMN BARS.ERR$_STAFF_TTS.REVOKED IS '';
COMMENT ON COLUMN BARS.ERR$_STAFF_TTS.GRANTOR IS '';



PROMPT *** Create  grants  ERR$_STAFF_TTS ***
grant SELECT                                                                 on ERR$_STAFF_TTS  to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_STAFF_TTS.sql =========*** End **
PROMPT ===================================================================================== 
