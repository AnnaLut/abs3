

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_BATCH_IMMOBILE.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_BATCH_IMMOBILE ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_BATCH_IMMOBILE ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_BATCH_IMMOBILE 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ID VARCHAR2(4000), 
	CREATE_DATE VARCHAR2(4000), 
	STATUS VARCHAR2(4000), 
	LAST_TIME_REFRESH VARCHAR2(4000), 
	DIRECTION VARCHAR2(4000), 
	BSD VARCHAR2(4000), 
	OB22 VARCHAR2(4000), 
	KV VARCHAR2(4000), 
	BRANCH VARCHAR2(4000), 
	USERID VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_BATCH_IMMOBILE ***
 exec bpa.alter_policies('ERR$_BATCH_IMMOBILE');


COMMENT ON TABLE BARS.ERR$_BATCH_IMMOBILE IS 'DML Error Logging table for "BATCH_IMMOBILE"';
COMMENT ON COLUMN BARS.ERR$_BATCH_IMMOBILE.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_BATCH_IMMOBILE.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_BATCH_IMMOBILE.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_BATCH_IMMOBILE.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_BATCH_IMMOBILE.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_BATCH_IMMOBILE.ID IS '';
COMMENT ON COLUMN BARS.ERR$_BATCH_IMMOBILE.CREATE_DATE IS '';
COMMENT ON COLUMN BARS.ERR$_BATCH_IMMOBILE.STATUS IS '';
COMMENT ON COLUMN BARS.ERR$_BATCH_IMMOBILE.LAST_TIME_REFRESH IS '';
COMMENT ON COLUMN BARS.ERR$_BATCH_IMMOBILE.DIRECTION IS '';
COMMENT ON COLUMN BARS.ERR$_BATCH_IMMOBILE.BSD IS '';
COMMENT ON COLUMN BARS.ERR$_BATCH_IMMOBILE.OB22 IS '';
COMMENT ON COLUMN BARS.ERR$_BATCH_IMMOBILE.KV IS '';
COMMENT ON COLUMN BARS.ERR$_BATCH_IMMOBILE.BRANCH IS '';
COMMENT ON COLUMN BARS.ERR$_BATCH_IMMOBILE.USERID IS '';



PROMPT *** Create  grants  ERR$_BATCH_IMMOBILE ***
grant SELECT                                                                 on ERR$_BATCH_IMMOBILE to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_BATCH_IMMOBILE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_BATCH_IMMOBILE.sql =========*** E
PROMPT ===================================================================================== 
