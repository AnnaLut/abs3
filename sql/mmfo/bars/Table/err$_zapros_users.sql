

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_ZAPROS_USERS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_ZAPROS_USERS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_ZAPROS_USERS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_ZAPROS_USERS 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	KODZ VARCHAR2(4000), 
	USER_ID VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_ZAPROS_USERS ***
 exec bpa.alter_policies('ERR$_ZAPROS_USERS');


COMMENT ON TABLE BARS.ERR$_ZAPROS_USERS IS 'DML Error Logging table for "ZAPROS_USERS"';
COMMENT ON COLUMN BARS.ERR$_ZAPROS_USERS.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_ZAPROS_USERS.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_ZAPROS_USERS.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_ZAPROS_USERS.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_ZAPROS_USERS.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_ZAPROS_USERS.KODZ IS '';
COMMENT ON COLUMN BARS.ERR$_ZAPROS_USERS.USER_ID IS '';



PROMPT *** Create  grants  ERR$_ZAPROS_USERS ***
grant SELECT                                                                 on ERR$_ZAPROS_USERS to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_ZAPROS_USERS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_ZAPROS_USERS.sql =========*** End
PROMPT ===================================================================================== 
