

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_FIN_KVED.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_FIN_KVED ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_FIN_KVED ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_FIN_KVED 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	OKPO VARCHAR2(4000), 
	DAT VARCHAR2(4000), 
	KVED VARCHAR2(4000), 
	VOLME_SALES VARCHAR2(4000), 
	WEIGHT VARCHAR2(4000), 
	FLAG VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_FIN_KVED ***
 exec bpa.alter_policies('ERR$_FIN_KVED');


COMMENT ON TABLE BARS.ERR$_FIN_KVED IS 'DML Error Logging table for "FIN_KVED"';
COMMENT ON COLUMN BARS.ERR$_FIN_KVED.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_KVED.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_KVED.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_KVED.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_KVED.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_KVED.OKPO IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_KVED.DAT IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_KVED.KVED IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_KVED.VOLME_SALES IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_KVED.WEIGHT IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_KVED.FLAG IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_FIN_KVED.sql =========*** End ***
PROMPT ===================================================================================== 
