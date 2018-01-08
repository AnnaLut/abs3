

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_TMP_SW_MESSAGE.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_TMP_SW_MESSAGE ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_TMP_SW_MESSAGE ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_TMP_SW_MESSAGE 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	NUM VARCHAR2(4000), 
	SEQ VARCHAR2(4000), 
	SUBSEQ VARCHAR2(4000), 
	TAG VARCHAR2(4000), 
	OPT VARCHAR2(4000), 
	STATUS VARCHAR2(4000), 
	EMPTY VARCHAR2(4000), 
	SEQSTAT VARCHAR2(4000), 
	VALUE VARCHAR2(4000), 
	OPTMODEL VARCHAR2(4000), 
	EDITVAL VARCHAR2(4000), 
	SWREF VARCHAR2(4000), 
	USERID VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_TMP_SW_MESSAGE ***
 exec bpa.alter_policies('ERR$_TMP_SW_MESSAGE');


COMMENT ON TABLE BARS.ERR$_TMP_SW_MESSAGE IS 'DML Error Logging table for "TMP_SW_MESSAGE"';
COMMENT ON COLUMN BARS.ERR$_TMP_SW_MESSAGE.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_SW_MESSAGE.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_SW_MESSAGE.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_SW_MESSAGE.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_SW_MESSAGE.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_SW_MESSAGE.NUM IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_SW_MESSAGE.SEQ IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_SW_MESSAGE.SUBSEQ IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_SW_MESSAGE.TAG IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_SW_MESSAGE.OPT IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_SW_MESSAGE.STATUS IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_SW_MESSAGE.EMPTY IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_SW_MESSAGE.SEQSTAT IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_SW_MESSAGE.VALUE IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_SW_MESSAGE.OPTMODEL IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_SW_MESSAGE.EDITVAL IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_SW_MESSAGE.SWREF IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_SW_MESSAGE.USERID IS '';



PROMPT *** Create  grants  ERR$_TMP_SW_MESSAGE ***
grant SELECT                                                                 on ERR$_TMP_SW_MESSAGE to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_TMP_SW_MESSAGE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_TMP_SW_MESSAGE.sql =========*** E
PROMPT ===================================================================================== 
