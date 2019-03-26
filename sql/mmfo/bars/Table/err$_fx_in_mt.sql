

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_FX_IN_MT.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_FX_IN_MT ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_FX_IN_MT ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_FX_IN_MT 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ACC VARCHAR2(4000), 
	NBS VARCHAR2(4000), 
	NLS VARCHAR2(4000), 
	KV VARCHAR2(4000), 
	IN10 VARCHAR2(4000), 
	OST10 VARCHAR2(4000), 
	OST10Q VARCHAR2(4000), 
	IN11 VARCHAR2(4000), 
	OST11 VARCHAR2(4000), 
	OST11Q VARCHAR2(4000), 
	IN12 VARCHAR2(4000), 
	OST12 VARCHAR2(4000), 
	OST12Q VARCHAR2(4000), 
	IN13 VARCHAR2(4000), 
	OST13 VARCHAR2(4000), 
	OST13Q VARCHAR2(4000), 
	IN14 VARCHAR2(4000), 
	OST14 VARCHAR2(4000), 
	OST14Q VARCHAR2(4000), 
	IN15 VARCHAR2(4000), 
	OST15 VARCHAR2(4000), 
	OST15Q VARCHAR2(4000), 
	FDAT VARCHAR2(4000), 
	I_OST VARCHAR2(4000), 
	I_OSTQ VARCHAR2(4000), 
	DAY_O VARCHAR2(4000), 
	DAY VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_FX_IN_MT ***
 exec bpa.alter_policies('ERR$_FX_IN_MT');


COMMENT ON TABLE BARS.ERR$_FX_IN_MT IS 'DML Error Logging table for "FX_IN_MT"';
COMMENT ON COLUMN BARS.ERR$_FX_IN_MT.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_FX_IN_MT.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_FX_IN_MT.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_FX_IN_MT.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_FX_IN_MT.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_FX_IN_MT.ACC IS '';
COMMENT ON COLUMN BARS.ERR$_FX_IN_MT.NBS IS '';
COMMENT ON COLUMN BARS.ERR$_FX_IN_MT.NLS IS '';
COMMENT ON COLUMN BARS.ERR$_FX_IN_MT.KV IS '';
COMMENT ON COLUMN BARS.ERR$_FX_IN_MT.IN10 IS '';
COMMENT ON COLUMN BARS.ERR$_FX_IN_MT.OST10 IS '';
COMMENT ON COLUMN BARS.ERR$_FX_IN_MT.OST10Q IS '';
COMMENT ON COLUMN BARS.ERR$_FX_IN_MT.IN11 IS '';
COMMENT ON COLUMN BARS.ERR$_FX_IN_MT.OST11 IS '';
COMMENT ON COLUMN BARS.ERR$_FX_IN_MT.OST11Q IS '';
COMMENT ON COLUMN BARS.ERR$_FX_IN_MT.IN12 IS '';
COMMENT ON COLUMN BARS.ERR$_FX_IN_MT.OST12 IS '';
COMMENT ON COLUMN BARS.ERR$_FX_IN_MT.OST12Q IS '';
COMMENT ON COLUMN BARS.ERR$_FX_IN_MT.IN13 IS '';
COMMENT ON COLUMN BARS.ERR$_FX_IN_MT.OST13 IS '';
COMMENT ON COLUMN BARS.ERR$_FX_IN_MT.OST13Q IS '';
COMMENT ON COLUMN BARS.ERR$_FX_IN_MT.IN14 IS '';
COMMENT ON COLUMN BARS.ERR$_FX_IN_MT.OST14 IS '';
COMMENT ON COLUMN BARS.ERR$_FX_IN_MT.OST14Q IS '';
COMMENT ON COLUMN BARS.ERR$_FX_IN_MT.IN15 IS '';
COMMENT ON COLUMN BARS.ERR$_FX_IN_MT.OST15 IS '';
COMMENT ON COLUMN BARS.ERR$_FX_IN_MT.OST15Q IS '';
COMMENT ON COLUMN BARS.ERR$_FX_IN_MT.FDAT IS '';
COMMENT ON COLUMN BARS.ERR$_FX_IN_MT.I_OST IS '';
COMMENT ON COLUMN BARS.ERR$_FX_IN_MT.I_OSTQ IS '';
COMMENT ON COLUMN BARS.ERR$_FX_IN_MT.DAY_O IS '';
COMMENT ON COLUMN BARS.ERR$_FX_IN_MT.DAY IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_FX_IN_MT.sql =========*** End ***
PROMPT ===================================================================================== 