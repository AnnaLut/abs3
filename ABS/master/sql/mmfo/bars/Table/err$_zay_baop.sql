

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_ZAY_BAOP.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_ZAY_BAOP ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_ZAY_BAOP ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_ZAY_BAOP 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ID VARCHAR2(4000), 
	TIPKB VARCHAR2(4000), 
	KOD VARCHAR2(4000), 
	TEXTBACK VARCHAR2(4000), 
	IDENTKB VARCHAR2(4000), 
	FNAMEKB VARCHAR2(4000), 
	OTM VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_ZAY_BAOP ***
 exec bpa.alter_policies('ERR$_ZAY_BAOP');


COMMENT ON TABLE BARS.ERR$_ZAY_BAOP IS 'DML Error Logging table for "ZAY_BAOP"';
COMMENT ON COLUMN BARS.ERR$_ZAY_BAOP.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_BAOP.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_BAOP.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_BAOP.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_BAOP.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_BAOP.ID IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_BAOP.TIPKB IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_BAOP.KOD IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_BAOP.TEXTBACK IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_BAOP.IDENTKB IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_BAOP.FNAMEKB IS '';
COMMENT ON COLUMN BARS.ERR$_ZAY_BAOP.OTM IS '';



PROMPT *** Create  grants  ERR$_ZAY_BAOP ***
grant SELECT                                                                 on ERR$_ZAY_BAOP   to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_ZAY_BAOP   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_ZAY_BAOP.sql =========*** End ***
PROMPT ===================================================================================== 
