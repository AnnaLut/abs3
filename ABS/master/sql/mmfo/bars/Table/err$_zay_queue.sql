

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_ZAY_QUEUE.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_ZAY_QUEUE ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_ZAY_QUEUE ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_ZAY_QUEUE 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ID VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_ZAY_QUEUE ***
 exec bpa.alter_policies('ERR$_ZAY_QUEUE');


COMMENT ON TABLE BARS.ERR$_ZAY_QUEUE IS 'DML Error Logging table for "ZAY_QUEUE"';
COMMENT ON COLUMN BARS.ERR$_ZAY_QUEUE.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_QUEUE.ID IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_QUEUE.KF IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_QUEUE.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_QUEUE.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_QUEUE.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_QUEUE.ORA_ERR_OPTYP$ IS '';



PROMPT *** Create  grants  ERR$_ZAY_QUEUE ***
grant SELECT                                                                 on ERR$_ZAY_QUEUE  to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_ZAY_QUEUE  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_ZAY_QUEUE.sql =========*** End **
PROMPT ===================================================================================== 
