

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_TMP_6_7.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_TMP_6_7 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_TMP_6_7 ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_TMP_6_7 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	REF VARCHAR2(4000), 
	NLSA VARCHAR2(4000), 
	NLSB VARCHAR2(4000), 
	S VARCHAR2(4000), 
	ERR VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_TMP_6_7 ***
 exec bpa.alter_policies('ERR$_TMP_6_7');


COMMENT ON TABLE BARS.ERR$_TMP_6_7 IS 'DML Error Logging table for "TMP_6_7"';
COMMENT ON COLUMN BARS.ERR$_TMP_6_7.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_6_7.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_6_7.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_6_7.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_6_7.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_6_7.REF IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_6_7.NLSA IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_6_7.NLSB IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_6_7.S IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_6_7.ERR IS '';



PROMPT *** Create  grants  ERR$_TMP_6_7 ***
grant SELECT                                                                 on ERR$_TMP_6_7    to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_TMP_6_7    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_TMP_6_7.sql =========*** End *** 
PROMPT ===================================================================================== 
