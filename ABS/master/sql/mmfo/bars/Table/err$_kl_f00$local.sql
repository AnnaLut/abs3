

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_KL_F00$LOCAL.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_KL_F00$LOCAL ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_KL_F00$LOCAL ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_KL_F00$LOCAL 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	POLICY_GROUP VARCHAR2(4000), 
	BRANCH VARCHAR2(4000), 
	KODF VARCHAR2(4000), 
	A017 VARCHAR2(4000), 
	UUU VARCHAR2(4000), 
	ZZZ VARCHAR2(4000), 
	PATH_O VARCHAR2(4000), 
	DATF VARCHAR2(4000), 
	NOM VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_KL_F00$LOCAL ***
 exec bpa.alter_policies('ERR$_KL_F00$LOCAL');


COMMENT ON TABLE BARS.ERR$_KL_F00$LOCAL IS 'DML Error Logging table for "KL_F00$LOCAL"';
COMMENT ON COLUMN BARS.ERR$_KL_F00$LOCAL.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_KL_F00$LOCAL.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_KL_F00$LOCAL.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_KL_F00$LOCAL.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_KL_F00$LOCAL.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_KL_F00$LOCAL.POLICY_GROUP IS '';
COMMENT ON COLUMN BARS.ERR$_KL_F00$LOCAL.BRANCH IS '';
COMMENT ON COLUMN BARS.ERR$_KL_F00$LOCAL.KODF IS '';
COMMENT ON COLUMN BARS.ERR$_KL_F00$LOCAL.A017 IS '';
COMMENT ON COLUMN BARS.ERR$_KL_F00$LOCAL.UUU IS '';
COMMENT ON COLUMN BARS.ERR$_KL_F00$LOCAL.ZZZ IS '';
COMMENT ON COLUMN BARS.ERR$_KL_F00$LOCAL.PATH_O IS '';
COMMENT ON COLUMN BARS.ERR$_KL_F00$LOCAL.DATF IS '';
COMMENT ON COLUMN BARS.ERR$_KL_F00$LOCAL.NOM IS '';
COMMENT ON COLUMN BARS.ERR$_KL_F00$LOCAL.KF IS '';



PROMPT *** Create  grants  ERR$_KL_F00$LOCAL ***
grant SELECT                                                                 on ERR$_KL_F00$LOCAL to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_KL_F00$LOCAL to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_KL_F00$LOCAL.sql =========*** End
PROMPT ===================================================================================== 
