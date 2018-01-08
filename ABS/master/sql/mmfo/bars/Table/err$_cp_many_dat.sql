

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_CP_MANY_DAT.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_CP_MANY_DAT ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_CP_MANY_DAT ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_CP_MANY_DAT 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	REF1 VARCHAR2(4000), 
	REF2 VARCHAR2(4000), 
	VDAT VARCHAR2(4000), 
	SS VARCHAR2(4000), 
	SN VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_CP_MANY_DAT ***
 exec bpa.alter_policies('ERR$_CP_MANY_DAT');


COMMENT ON TABLE BARS.ERR$_CP_MANY_DAT IS 'DML Error Logging table for "CP_MANY_DAT"';
COMMENT ON COLUMN BARS.ERR$_CP_MANY_DAT.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_CP_MANY_DAT.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CP_MANY_DAT.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_CP_MANY_DAT.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_CP_MANY_DAT.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CP_MANY_DAT.REF1 IS '';
COMMENT ON COLUMN BARS.ERR$_CP_MANY_DAT.REF2 IS '';
COMMENT ON COLUMN BARS.ERR$_CP_MANY_DAT.VDAT IS '';
COMMENT ON COLUMN BARS.ERR$_CP_MANY_DAT.SS IS '';
COMMENT ON COLUMN BARS.ERR$_CP_MANY_DAT.SN IS '';



PROMPT *** Create  grants  ERR$_CP_MANY_DAT ***
grant SELECT                                                                 on ERR$_CP_MANY_DAT to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_CP_MANY_DAT to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_CP_MANY_DAT.sql =========*** End 
PROMPT ===================================================================================== 
