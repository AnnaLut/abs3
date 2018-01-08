

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_EBKC_SENDCARDS_HIST.sql =========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_EBKC_SENDCARDS_HIST ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_EBKC_SENDCARDS_HIST ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_EBKC_SENDCARDS_HIST 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	RNK VARCHAR2(4000), 
	SEND_DATE VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_EBKC_SENDCARDS_HIST ***
 exec bpa.alter_policies('ERR$_EBKC_SENDCARDS_HIST');


COMMENT ON TABLE BARS.ERR$_EBKC_SENDCARDS_HIST IS 'DML Error Logging table for "EBKC_SENDCARDS_HIST"';
COMMENT ON COLUMN BARS.ERR$_EBKC_SENDCARDS_HIST.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_EBKC_SENDCARDS_HIST.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_EBKC_SENDCARDS_HIST.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_EBKC_SENDCARDS_HIST.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_EBKC_SENDCARDS_HIST.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_EBKC_SENDCARDS_HIST.RNK IS '';
COMMENT ON COLUMN BARS.ERR$_EBKC_SENDCARDS_HIST.SEND_DATE IS '';
COMMENT ON COLUMN BARS.ERR$_EBKC_SENDCARDS_HIST.KF IS '';



PROMPT *** Create  grants  ERR$_EBKC_SENDCARDS_HIST ***
grant SELECT                                                                 on ERR$_EBKC_SENDCARDS_HIST to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_EBKC_SENDCARDS_HIST to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_EBKC_SENDCARDS_HIST.sql =========
PROMPT ===================================================================================== 
