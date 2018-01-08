

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_NBU23_CCK_UL_KOR.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_NBU23_CCK_UL_KOR ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_NBU23_CCK_UL_KOR ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_NBU23_CCK_UL_KOR 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ID VARCHAR2(4000), 
	MOD VARCHAR2(4000), 
	ND VARCHAR2(4000), 
	PDAT VARCHAR2(4000), 
	ZDAT VARCHAR2(4000), 
	FIN23 VARCHAR2(4000), 
	OBS23 VARCHAR2(4000), 
	KAT23 VARCHAR2(4000), 
	K23 VARCHAR2(4000), 
	ISP VARCHAR2(4000), 
	COMM VARCHAR2(4000), 
	FIN_351 VARCHAR2(4000), 
	PD VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_NBU23_CCK_UL_KOR ***
 exec bpa.alter_policies('ERR$_NBU23_CCK_UL_KOR');


COMMENT ON TABLE BARS.ERR$_NBU23_CCK_UL_KOR IS 'DML Error Logging table for "NBU23_CCK_UL_KOR"';
COMMENT ON COLUMN BARS.ERR$_NBU23_CCK_UL_KOR.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_CCK_UL_KOR.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_CCK_UL_KOR.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_CCK_UL_KOR.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_CCK_UL_KOR.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_CCK_UL_KOR.ID IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_CCK_UL_KOR.MOD IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_CCK_UL_KOR.ND IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_CCK_UL_KOR.PDAT IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_CCK_UL_KOR.ZDAT IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_CCK_UL_KOR.FIN23 IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_CCK_UL_KOR.OBS23 IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_CCK_UL_KOR.KAT23 IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_CCK_UL_KOR.K23 IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_CCK_UL_KOR.ISP IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_CCK_UL_KOR.COMM IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_CCK_UL_KOR.FIN_351 IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_CCK_UL_KOR.PD IS '';
COMMENT ON COLUMN BARS.ERR$_NBU23_CCK_UL_KOR.KF IS '';



PROMPT *** Create  grants  ERR$_NBU23_CCK_UL_KOR ***
grant SELECT                                                                 on ERR$_NBU23_CCK_UL_KOR to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_NBU23_CCK_UL_KOR to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_NBU23_CCK_UL_KOR.sql =========***
PROMPT ===================================================================================== 
