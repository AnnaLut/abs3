

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_DYN_FILTER.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_DYN_FILTER ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_DYN_FILTER ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_DYN_FILTER 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	FILTER_ID VARCHAR2(4000), 
	TABID VARCHAR2(4000), 
	USERID VARCHAR2(4000), 
	SEMANTIC VARCHAR2(4000), 
	FROM_CLAUSE VARCHAR2(4000), 
	WHERE_CLAUSE VARCHAR2(4000), 
	PKEY VARCHAR2(4000), 
	BRANCH VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_DYN_FILTER ***
 exec bpa.alter_policies('ERR$_DYN_FILTER');


COMMENT ON TABLE BARS.ERR$_DYN_FILTER IS 'DML Error Logging table for "DYN_FILTER"';
COMMENT ON COLUMN BARS.ERR$_DYN_FILTER.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_DYN_FILTER.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_DYN_FILTER.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_DYN_FILTER.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_DYN_FILTER.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_DYN_FILTER.FILTER_ID IS '';
COMMENT ON COLUMN BARS.ERR$_DYN_FILTER.TABID IS '';
COMMENT ON COLUMN BARS.ERR$_DYN_FILTER.USERID IS '';
COMMENT ON COLUMN BARS.ERR$_DYN_FILTER.SEMANTIC IS '';
COMMENT ON COLUMN BARS.ERR$_DYN_FILTER.FROM_CLAUSE IS '';
COMMENT ON COLUMN BARS.ERR$_DYN_FILTER.WHERE_CLAUSE IS '';
COMMENT ON COLUMN BARS.ERR$_DYN_FILTER.PKEY IS '';
COMMENT ON COLUMN BARS.ERR$_DYN_FILTER.BRANCH IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_DYN_FILTER.sql =========*** End *
PROMPT ===================================================================================== 
