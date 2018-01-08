

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_TMP_NBU.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_TMP_NBU ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_TMP_NBU ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_TMP_NBU 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	KODP VARCHAR2(4000), 
	DATF VARCHAR2(4000), 
	KODF VARCHAR2(4000), 
	ZNAP VARCHAR2(4000), 
	NBUC VARCHAR2(4000), 
	KF VARCHAR2(4000), 
	ERR_MSG VARCHAR2(4000), 
	FL_MOD VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_TMP_NBU ***
 exec bpa.alter_policies('ERR$_TMP_NBU');


COMMENT ON TABLE BARS.ERR$_TMP_NBU IS 'DML Error Logging table for "TMP_NBU"';
COMMENT ON COLUMN BARS.ERR$_TMP_NBU.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_NBU.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_NBU.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_NBU.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_NBU.KODP IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_NBU.DATF IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_NBU.KODF IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_NBU.ZNAP IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_NBU.NBUC IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_NBU.KF IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_NBU.ERR_MSG IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_NBU.FL_MOD IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_NBU.ORA_ERR_NUMBER$ IS '';



PROMPT *** Create  grants  ERR$_TMP_NBU ***
grant SELECT                                                                 on ERR$_TMP_NBU    to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_TMP_NBU    to BARS_DM;
grant SELECT                                                                 on ERR$_TMP_NBU    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_TMP_NBU.sql =========*** End *** 
PROMPT ===================================================================================== 
