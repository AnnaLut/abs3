

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_CP_RYN.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_CP_RYN ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_CP_RYN ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_CP_RYN 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	RYN VARCHAR2(4000), 
	NAME VARCHAR2(4000), 
	KV VARCHAR2(4000), 
	TIPD VARCHAR2(4000), 
	QUALITY VARCHAR2(4000), 
	SERIES VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_CP_RYN ***
 exec bpa.alter_policies('ERR$_CP_RYN');


COMMENT ON TABLE BARS.ERR$_CP_RYN IS 'DML Error Logging table for "CP_RYN"';
COMMENT ON COLUMN BARS.ERR$_CP_RYN.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_CP_RYN.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CP_RYN.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_CP_RYN.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_CP_RYN.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CP_RYN.RYN IS '';
COMMENT ON COLUMN BARS.ERR$_CP_RYN.NAME IS '';
COMMENT ON COLUMN BARS.ERR$_CP_RYN.KV IS '';
COMMENT ON COLUMN BARS.ERR$_CP_RYN.TIPD IS '';
COMMENT ON COLUMN BARS.ERR$_CP_RYN.QUALITY IS '';
COMMENT ON COLUMN BARS.ERR$_CP_RYN.SERIES IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_CP_RYN.sql =========*** End *** =
PROMPT ===================================================================================== 
