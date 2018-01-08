

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_STAFF_KLF00.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_STAFF_KLF00 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_STAFF_KLF00 ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_STAFF_KLF00 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ID VARCHAR2(4000), 
	KODF VARCHAR2(4000), 
	A017 VARCHAR2(4000), 
	APPROVE VARCHAR2(4000), 
	ADATE1 VARCHAR2(4000), 
	ADATE2 VARCHAR2(4000), 
	RDATE1 VARCHAR2(4000), 
	RDATE2 VARCHAR2(4000), 
	REVERSE VARCHAR2(4000), 
	REVOKED VARCHAR2(4000), 
	GRANTOR VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_STAFF_KLF00 ***
 exec bpa.alter_policies('ERR$_STAFF_KLF00');


COMMENT ON TABLE BARS.ERR$_STAFF_KLF00 IS 'DML Error Logging table for "STAFF_KLF00"';
COMMENT ON COLUMN BARS.ERR$_STAFF_KLF00.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_STAFF_KLF00.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_STAFF_KLF00.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_STAFF_KLF00.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_STAFF_KLF00.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_STAFF_KLF00.ID IS '';
COMMENT ON COLUMN BARS.ERR$_STAFF_KLF00.KODF IS '';
COMMENT ON COLUMN BARS.ERR$_STAFF_KLF00.A017 IS '';
COMMENT ON COLUMN BARS.ERR$_STAFF_KLF00.APPROVE IS '';
COMMENT ON COLUMN BARS.ERR$_STAFF_KLF00.ADATE1 IS '';
COMMENT ON COLUMN BARS.ERR$_STAFF_KLF00.ADATE2 IS '';
COMMENT ON COLUMN BARS.ERR$_STAFF_KLF00.RDATE1 IS '';
COMMENT ON COLUMN BARS.ERR$_STAFF_KLF00.RDATE2 IS '';
COMMENT ON COLUMN BARS.ERR$_STAFF_KLF00.REVERSE IS '';
COMMENT ON COLUMN BARS.ERR$_STAFF_KLF00.REVOKED IS '';
COMMENT ON COLUMN BARS.ERR$_STAFF_KLF00.GRANTOR IS '';



PROMPT *** Create  grants  ERR$_STAFF_KLF00 ***
grant SELECT                                                                 on ERR$_STAFF_KLF00 to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_STAFF_KLF00 to BARS_DM;
grant SELECT                                                                 on ERR$_STAFF_KLF00 to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_STAFF_KLF00.sql =========*** End 
PROMPT ===================================================================================== 
