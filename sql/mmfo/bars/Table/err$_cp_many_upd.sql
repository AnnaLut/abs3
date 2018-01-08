

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_CP_MANY_UPD.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_CP_MANY_UPD ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_CP_MANY_UPD ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_CP_MANY_UPD 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	U_ID VARCHAR2(4000), 
	U_DAT VARCHAR2(4000), 
	REF VARCHAR2(4000), 
	FDAT VARCHAR2(4000), 
	SS1 VARCHAR2(4000), 
	SDP VARCHAR2(4000), 
	SN2 VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_CP_MANY_UPD ***
 exec bpa.alter_policies('ERR$_CP_MANY_UPD');


COMMENT ON TABLE BARS.ERR$_CP_MANY_UPD IS 'DML Error Logging table for "CP_MANY_UPD"';
COMMENT ON COLUMN BARS.ERR$_CP_MANY_UPD.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_CP_MANY_UPD.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CP_MANY_UPD.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_CP_MANY_UPD.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_CP_MANY_UPD.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CP_MANY_UPD.U_ID IS '';
COMMENT ON COLUMN BARS.ERR$_CP_MANY_UPD.U_DAT IS '';
COMMENT ON COLUMN BARS.ERR$_CP_MANY_UPD.REF IS '';
COMMENT ON COLUMN BARS.ERR$_CP_MANY_UPD.FDAT IS '';
COMMENT ON COLUMN BARS.ERR$_CP_MANY_UPD.SS1 IS '';
COMMENT ON COLUMN BARS.ERR$_CP_MANY_UPD.SDP IS '';
COMMENT ON COLUMN BARS.ERR$_CP_MANY_UPD.SN2 IS '';



PROMPT *** Create  grants  ERR$_CP_MANY_UPD ***
grant SELECT                                                                 on ERR$_CP_MANY_UPD to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_CP_MANY_UPD to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_CP_MANY_UPD.sql =========*** End 
PROMPT ===================================================================================== 
