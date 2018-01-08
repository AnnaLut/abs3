

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_WCS_BCK_RESULTS.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_WCS_BCK_RESULTS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_WCS_BCK_RESULTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_WCS_BCK_RESULTS 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ID VARCHAR2(4000), 
	REP_ID VARCHAR2(4000), 
	TAG_NAME VARCHAR2(4000), 
	TAG_BLOCK VARCHAR2(4000), 
	TAG_VALUE VARCHAR2(4000), 
	SEQ_ID VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_WCS_BCK_RESULTS ***
 exec bpa.alter_policies('ERR$_WCS_BCK_RESULTS');


COMMENT ON TABLE BARS.ERR$_WCS_BCK_RESULTS IS 'DML Error Logging table for "WCS_BCK_RESULTS"';
COMMENT ON COLUMN BARS.ERR$_WCS_BCK_RESULTS.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_BCK_RESULTS.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_BCK_RESULTS.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_BCK_RESULTS.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_BCK_RESULTS.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_BCK_RESULTS.ID IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_BCK_RESULTS.REP_ID IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_BCK_RESULTS.TAG_NAME IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_BCK_RESULTS.TAG_BLOCK IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_BCK_RESULTS.TAG_VALUE IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_BCK_RESULTS.SEQ_ID IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_WCS_BCK_RESULTS.sql =========*** 
PROMPT ===================================================================================== 
