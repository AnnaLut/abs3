

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_SB_POK_1.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_SB_POK_1 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_SB_POK_1 ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_SB_POK_1 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	A010 VARCHAR2(4000), 
	KOD_EKPOK VARCHAR2(4000), 
	TXT VARCHAR2(4000), 
	PRM1 VARCHAR2(4000), 
	PRM2 VARCHAR2(4000), 
	PRM3 VARCHAR2(4000), 
	PRM4 VARCHAR2(4000), 
	PRM5 VARCHAR2(4000), 
	TYP VARCHAR2(4000), 
	WIDTH VARCHAR2(4000), 
	DEC VARCHAR2(4000), 
	FORMA VARCHAR2(4000), 
	DATA_O VARCHAR2(4000), 
	TELEFON VARCHAR2(4000), 
	DEPARTAM VARCHAR2(4000), 
	FIO VARCHAR2(4000), 
	PRIZNAK VARCHAR2(4000), 
	REM VARCHAR2(4000), 
	DATA_C VARCHAR2(4000), 
	DATA_M VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_SB_POK_1 ***
 exec bpa.alter_policies('ERR$_SB_POK_1');


COMMENT ON TABLE BARS.ERR$_SB_POK_1 IS 'DML Error Logging table for "SB_POK_1"';
COMMENT ON COLUMN BARS.ERR$_SB_POK_1.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_SB_POK_1.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_SB_POK_1.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_SB_POK_1.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_SB_POK_1.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_SB_POK_1.A010 IS '';
COMMENT ON COLUMN BARS.ERR$_SB_POK_1.KOD_EKPOK IS '';
COMMENT ON COLUMN BARS.ERR$_SB_POK_1.TXT IS '';
COMMENT ON COLUMN BARS.ERR$_SB_POK_1.PRM1 IS '';
COMMENT ON COLUMN BARS.ERR$_SB_POK_1.PRM2 IS '';
COMMENT ON COLUMN BARS.ERR$_SB_POK_1.PRM3 IS '';
COMMENT ON COLUMN BARS.ERR$_SB_POK_1.PRM4 IS '';
COMMENT ON COLUMN BARS.ERR$_SB_POK_1.PRM5 IS '';
COMMENT ON COLUMN BARS.ERR$_SB_POK_1.TYP IS '';
COMMENT ON COLUMN BARS.ERR$_SB_POK_1.WIDTH IS '';
COMMENT ON COLUMN BARS.ERR$_SB_POK_1.DEC IS '';
COMMENT ON COLUMN BARS.ERR$_SB_POK_1.FORMA IS '';
COMMENT ON COLUMN BARS.ERR$_SB_POK_1.DATA_O IS '';
COMMENT ON COLUMN BARS.ERR$_SB_POK_1.TELEFON IS '';
COMMENT ON COLUMN BARS.ERR$_SB_POK_1.DEPARTAM IS '';
COMMENT ON COLUMN BARS.ERR$_SB_POK_1.FIO IS '';
COMMENT ON COLUMN BARS.ERR$_SB_POK_1.PRIZNAK IS '';
COMMENT ON COLUMN BARS.ERR$_SB_POK_1.REM IS '';
COMMENT ON COLUMN BARS.ERR$_SB_POK_1.DATA_C IS '';
COMMENT ON COLUMN BARS.ERR$_SB_POK_1.DATA_M IS '';



PROMPT *** Create  grants  ERR$_SB_POK_1 ***
grant SELECT                                                                 on ERR$_SB_POK_1   to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_SB_POK_1   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_SB_POK_1.sql =========*** End ***
PROMPT ===================================================================================== 
