

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_REFAPP.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_REFAPP ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_REFAPP ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_REFAPP 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	TABID VARCHAR2(4000), 
	CODEAPP VARCHAR2(4000), 
	ACODE VARCHAR2(4000), 
	APPROVE VARCHAR2(4000), 
	ADATE1 VARCHAR2(4000), 
	ADATE2 VARCHAR2(4000), 
	RDATE1 VARCHAR2(4000), 
	RDATE2 VARCHAR2(4000), 
	REVERSE VARCHAR2(4000), 
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




PROMPT *** ALTER_POLICIES to ERR$_REFAPP ***
 exec bpa.alter_policies('ERR$_REFAPP');


COMMENT ON TABLE BARS.ERR$_REFAPP IS 'DML Error Logging table for "REFAPP"';
COMMENT ON COLUMN BARS.ERR$_REFAPP.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_REFAPP.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_REFAPP.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_REFAPP.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_REFAPP.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_REFAPP.TABID IS '';
COMMENT ON COLUMN BARS.ERR$_REFAPP.CODEAPP IS '';
COMMENT ON COLUMN BARS.ERR$_REFAPP.ACODE IS '';
COMMENT ON COLUMN BARS.ERR$_REFAPP.APPROVE IS '';
COMMENT ON COLUMN BARS.ERR$_REFAPP.ADATE1 IS '';
COMMENT ON COLUMN BARS.ERR$_REFAPP.ADATE2 IS '';
COMMENT ON COLUMN BARS.ERR$_REFAPP.RDATE1 IS '';
COMMENT ON COLUMN BARS.ERR$_REFAPP.RDATE2 IS '';
COMMENT ON COLUMN BARS.ERR$_REFAPP.REVERSE IS '';
COMMENT ON COLUMN BARS.ERR$_REFAPP.REVOKED IS '';
COMMENT ON COLUMN BARS.ERR$_REFAPP.GRANTOR IS '';



PROMPT *** Create  grants  ERR$_REFAPP ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ERR$_REFAPP     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ERR$_REFAPP     to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on ERR$_REFAPP     to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_REFAPP.sql =========*** End *** =
PROMPT ===================================================================================== 
