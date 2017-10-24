

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_CIG_DOG_STOP.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_CIG_DOG_STOP ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_CIG_DOG_STOP ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_CIG_DOG_STOP 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	DOG_ID VARCHAR2(4000), 
	STOP_DATE VARCHAR2(4000), 
	STAFF_ID VARCHAR2(4000), 
	BRANCH VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_CIG_DOG_STOP ***
 exec bpa.alter_policies('ERR$_CIG_DOG_STOP');


COMMENT ON TABLE BARS.ERR$_CIG_DOG_STOP IS 'DML Error Logging table for "CIG_DOG_STOP"';
COMMENT ON COLUMN BARS.ERR$_CIG_DOG_STOP.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIG_DOG_STOP.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIG_DOG_STOP.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIG_DOG_STOP.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIG_DOG_STOP.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIG_DOG_STOP.DOG_ID IS '';
COMMENT ON COLUMN BARS.ERR$_CIG_DOG_STOP.STOP_DATE IS '';
COMMENT ON COLUMN BARS.ERR$_CIG_DOG_STOP.STAFF_ID IS '';
COMMENT ON COLUMN BARS.ERR$_CIG_DOG_STOP.BRANCH IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_CIG_DOG_STOP.sql =========*** End
PROMPT ===================================================================================== 
