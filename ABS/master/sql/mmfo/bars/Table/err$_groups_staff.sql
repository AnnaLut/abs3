

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_GROUPS_STAFF.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_GROUPS_STAFF ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_GROUPS_STAFF ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_GROUPS_STAFF 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	IDU VARCHAR2(4000), 
	IDG VARCHAR2(4000), 
	SECG VARCHAR2(4000), 
	APPROVE VARCHAR2(4000), 
	ADATE1 VARCHAR2(4000), 
	ADATE2 VARCHAR2(4000), 
	RDATE1 VARCHAR2(4000), 
	RDATE2 VARCHAR2(4000), 
	REVOKED VARCHAR2(4000), 
	GRANTOR VARCHAR2(4000), 
	SEC_SEL VARCHAR2(4000), 
	SEC_CRE VARCHAR2(4000), 
	SEC_DEB VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_GROUPS_STAFF ***
 exec bpa.alter_policies('ERR$_GROUPS_STAFF');


COMMENT ON TABLE BARS.ERR$_GROUPS_STAFF IS 'DML Error Logging table for "GROUPS_STAFF"';
COMMENT ON COLUMN BARS.ERR$_GROUPS_STAFF.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_GROUPS_STAFF.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_GROUPS_STAFF.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_GROUPS_STAFF.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_GROUPS_STAFF.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_GROUPS_STAFF.IDU IS '';
COMMENT ON COLUMN BARS.ERR$_GROUPS_STAFF.IDG IS '';
COMMENT ON COLUMN BARS.ERR$_GROUPS_STAFF.SECG IS '';
COMMENT ON COLUMN BARS.ERR$_GROUPS_STAFF.APPROVE IS '';
COMMENT ON COLUMN BARS.ERR$_GROUPS_STAFF.ADATE1 IS '';
COMMENT ON COLUMN BARS.ERR$_GROUPS_STAFF.ADATE2 IS '';
COMMENT ON COLUMN BARS.ERR$_GROUPS_STAFF.RDATE1 IS '';
COMMENT ON COLUMN BARS.ERR$_GROUPS_STAFF.RDATE2 IS '';
COMMENT ON COLUMN BARS.ERR$_GROUPS_STAFF.REVOKED IS '';
COMMENT ON COLUMN BARS.ERR$_GROUPS_STAFF.GRANTOR IS '';
COMMENT ON COLUMN BARS.ERR$_GROUPS_STAFF.SEC_SEL IS '';
COMMENT ON COLUMN BARS.ERR$_GROUPS_STAFF.SEC_CRE IS '';
COMMENT ON COLUMN BARS.ERR$_GROUPS_STAFF.SEC_DEB IS '';



PROMPT *** Create  grants  ERR$_GROUPS_STAFF ***
grant SELECT                                                                 on ERR$_GROUPS_STAFF to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_GROUPS_STAFF to BARS_DM;
grant SELECT                                                                 on ERR$_GROUPS_STAFF to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_GROUPS_STAFF.sql =========*** End
PROMPT ===================================================================================== 
