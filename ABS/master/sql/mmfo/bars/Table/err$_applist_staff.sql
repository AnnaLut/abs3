

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_APPLIST_STAFF.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_APPLIST_STAFF ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_APPLIST_STAFF ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_APPLIST_STAFF 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ID VARCHAR2(4000), 
	CODEAPP VARCHAR2(4000), 
	APPROVE VARCHAR2(4000), 
	ADATE1 VARCHAR2(4000), 
	ADATE2 VARCHAR2(4000), 
	RDATE1 VARCHAR2(4000), 
	RDATE2 VARCHAR2(4000), 
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




PROMPT *** ALTER_POLICIES to ERR$_APPLIST_STAFF ***
 exec bpa.alter_policies('ERR$_APPLIST_STAFF');


COMMENT ON TABLE BARS.ERR$_APPLIST_STAFF IS 'DML Error Logging table for "APPLIST_STAFF"';
COMMENT ON COLUMN BARS.ERR$_APPLIST_STAFF.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_APPLIST_STAFF.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_APPLIST_STAFF.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_APPLIST_STAFF.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_APPLIST_STAFF.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_APPLIST_STAFF.ID IS '';
COMMENT ON COLUMN BARS.ERR$_APPLIST_STAFF.CODEAPP IS '';
COMMENT ON COLUMN BARS.ERR$_APPLIST_STAFF.APPROVE IS '';
COMMENT ON COLUMN BARS.ERR$_APPLIST_STAFF.ADATE1 IS '';
COMMENT ON COLUMN BARS.ERR$_APPLIST_STAFF.ADATE2 IS '';
COMMENT ON COLUMN BARS.ERR$_APPLIST_STAFF.RDATE1 IS '';
COMMENT ON COLUMN BARS.ERR$_APPLIST_STAFF.RDATE2 IS '';
COMMENT ON COLUMN BARS.ERR$_APPLIST_STAFF.REVOKED IS '';
COMMENT ON COLUMN BARS.ERR$_APPLIST_STAFF.GRANTOR IS '';



PROMPT *** Create  grants  ERR$_APPLIST_STAFF ***
grant SELECT                                                                 on ERR$_APPLIST_STAFF to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_APPLIST_STAFF to BARS_DM;
grant SELECT                                                                 on ERR$_APPLIST_STAFF to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_APPLIST_STAFF.sql =========*** En
PROMPT ===================================================================================== 
