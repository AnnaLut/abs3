

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_XOZ_REF.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_XOZ_REF ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_XOZ_REF ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_XOZ_REF 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	REF1 VARCHAR2(4000), 
	STMT1 VARCHAR2(4000), 
	REF2 VARCHAR2(4000), 
	ACC VARCHAR2(4000), 
	MDATE VARCHAR2(4000), 
	S VARCHAR2(4000), 
	FDAT VARCHAR2(4000), 
	S0 VARCHAR2(4000), 
	NOTP VARCHAR2(4000), 
	PRG VARCHAR2(4000), 
	BU VARCHAR2(4000), 
	DATZ VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_XOZ_REF ***
 exec bpa.alter_policies('ERR$_XOZ_REF');


COMMENT ON TABLE BARS.ERR$_XOZ_REF IS 'DML Error Logging table for "XOZ_REF"';
COMMENT ON COLUMN BARS.ERR$_XOZ_REF.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_XOZ_REF.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_XOZ_REF.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_XOZ_REF.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_XOZ_REF.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_XOZ_REF.REF1 IS '';
COMMENT ON COLUMN BARS.ERR$_XOZ_REF.STMT1 IS '';
COMMENT ON COLUMN BARS.ERR$_XOZ_REF.REF2 IS '';
COMMENT ON COLUMN BARS.ERR$_XOZ_REF.ACC IS '';
COMMENT ON COLUMN BARS.ERR$_XOZ_REF.MDATE IS '';
COMMENT ON COLUMN BARS.ERR$_XOZ_REF.S IS '';
COMMENT ON COLUMN BARS.ERR$_XOZ_REF.FDAT IS '';
COMMENT ON COLUMN BARS.ERR$_XOZ_REF.S0 IS '';
COMMENT ON COLUMN BARS.ERR$_XOZ_REF.NOTP IS '';
COMMENT ON COLUMN BARS.ERR$_XOZ_REF.PRG IS '';
COMMENT ON COLUMN BARS.ERR$_XOZ_REF.BU IS '';
COMMENT ON COLUMN BARS.ERR$_XOZ_REF.DATZ IS '';



PROMPT *** Create  grants  ERR$_XOZ_REF ***
grant SELECT                                                                 on ERR$_XOZ_REF    to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_XOZ_REF    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_XOZ_REF.sql =========*** End *** 
PROMPT ===================================================================================== 
