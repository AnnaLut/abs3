

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_STAFF_CHK.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_STAFF_CHK ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_STAFF_CHK ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_STAFF_CHK 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ID VARCHAR2(4000), 
	CHKID VARCHAR2(4000), 
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




PROMPT *** ALTER_POLICIES to ERR$_STAFF_CHK ***
 exec bpa.alter_policies('ERR$_STAFF_CHK');


COMMENT ON TABLE BARS.ERR$_STAFF_CHK IS 'DML Error Logging table for "STAFF_CHK"';
COMMENT ON COLUMN BARS.ERR$_STAFF_CHK.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_STAFF_CHK.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_STAFF_CHK.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_STAFF_CHK.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_STAFF_CHK.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_STAFF_CHK.ID IS '';
COMMENT ON COLUMN BARS.ERR$_STAFF_CHK.CHKID IS '';
COMMENT ON COLUMN BARS.ERR$_STAFF_CHK.APPROVE IS '';
COMMENT ON COLUMN BARS.ERR$_STAFF_CHK.ADATE1 IS '';
COMMENT ON COLUMN BARS.ERR$_STAFF_CHK.ADATE2 IS '';
COMMENT ON COLUMN BARS.ERR$_STAFF_CHK.RDATE1 IS '';
COMMENT ON COLUMN BARS.ERR$_STAFF_CHK.RDATE2 IS '';
COMMENT ON COLUMN BARS.ERR$_STAFF_CHK.REVOKED IS '';
COMMENT ON COLUMN BARS.ERR$_STAFF_CHK.GRANTOR IS '';



PROMPT *** Create  grants  ERR$_STAFF_CHK ***
grant SELECT                                                                 on ERR$_STAFF_CHK  to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_STAFF_CHK  to BARS_DM;
grant SELECT                                                                 on ERR$_STAFF_CHK  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_STAFF_CHK.sql =========*** End **
PROMPT ===================================================================================== 
