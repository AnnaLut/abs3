

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_DPT_AGRW.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_DPT_AGRW ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_DPT_AGRW ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_DPT_AGRW 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	AGREEMENT_ID VARCHAR2(4000), 
	TAG_ID VARCHAR2(4000), 
	VALUE VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_DPT_AGRW ***
 exec bpa.alter_policies('ERR$_DPT_AGRW');


COMMENT ON TABLE BARS.ERR$_DPT_AGRW IS 'DML Error Logging table for "DPT_AGRW"';
COMMENT ON COLUMN BARS.ERR$_DPT_AGRW.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_AGRW.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_AGRW.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_AGRW.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_AGRW.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_AGRW.AGREEMENT_ID IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_AGRW.TAG_ID IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_AGRW.VALUE IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_AGRW.KF IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_DPT_AGRW.sql =========*** End ***
PROMPT ===================================================================================== 