

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_INV_CCK_FL.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_INV_CCK_FL ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_INV_CCK_FL ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_INV_CCK_FL 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	G00 VARCHAR2(4000), 
	G01 VARCHAR2(4000), 
	G02 VARCHAR2(4000), 
	G03 VARCHAR2(4000), 
	G04 VARCHAR2(4000), 
	G05 VARCHAR2(4000), 
	G06 VARCHAR2(4000), 
	G07 VARCHAR2(4000), 
	G08 VARCHAR2(4000), 
	G09 VARCHAR2(4000), 
	G10 VARCHAR2(4000), 
	G11 VARCHAR2(4000), 
	G12 VARCHAR2(4000), 
	G13 VARCHAR2(4000), 
	G13A VARCHAR2(4000), 
	G13B VARCHAR2(4000), 
	G13V VARCHAR2(4000), 
	G13G VARCHAR2(4000), 
	G13D VARCHAR2(4000), 
	G13E VARCHAR2(4000), 
	G13J VARCHAR2(4000), 
	G13Z VARCHAR2(4000), 
	G13I VARCHAR2(4000), 
	G14 VARCHAR2(4000), 
	G16 VARCHAR2(4000), 
	G17 VARCHAR2(4000), 
	G18 VARCHAR2(4000), 
	G19 VARCHAR2(4000), 
	G20 VARCHAR2(4000), 
	G21 VARCHAR2(4000), 
	G22 VARCHAR2(4000), 
	G23 VARCHAR2(4000), 
	G24 VARCHAR2(4000), 
	G25 VARCHAR2(4000), 
	G26 VARCHAR2(4000), 
	G28 VARCHAR2(4000), 
	G29 VARCHAR2(4000), 
	G30 VARCHAR2(4000), 
	G31 VARCHAR2(4000), 
	G32 VARCHAR2(4000), 
	G33 VARCHAR2(4000), 
	G34 VARCHAR2(4000), 
	G35 VARCHAR2(4000), 
	G36 VARCHAR2(4000), 
	G37 VARCHAR2(4000), 
	G38 VARCHAR2(4000), 
	G39 VARCHAR2(4000), 
	G40 VARCHAR2(4000), 
	G41 VARCHAR2(4000), 
	G42 VARCHAR2(4000), 
	G43 VARCHAR2(4000), 
	G44 VARCHAR2(4000), 
	G45 VARCHAR2(4000), 
	G46 VARCHAR2(4000), 
	G47 VARCHAR2(4000), 
	G48 VARCHAR2(4000), 
	G49 VARCHAR2(4000), 
	G50 VARCHAR2(4000), 
	G51 VARCHAR2(4000), 
	G52 VARCHAR2(4000), 
	G53 VARCHAR2(4000), 
	G54 VARCHAR2(4000), 
	G55 VARCHAR2(4000), 
	G56 VARCHAR2(4000), 
	G57 VARCHAR2(4000), 
	G58 VARCHAR2(4000), 
	G59 VARCHAR2(4000), 
	GT VARCHAR2(4000), 
	GR VARCHAR2(4000), 
	ACC VARCHAR2(4000), 
	RNK VARCHAR2(4000), 
	ACC2208 VARCHAR2(4000), 
	ACC9129 VARCHAR2(4000), 
	G101 VARCHAR2(4000), 
	G102 VARCHAR2(4000), 
	G103 VARCHAR2(4000), 
	G104 VARCHAR2(4000), 
	G105 VARCHAR2(4000), 
	G106 VARCHAR2(4000), 
	G107 VARCHAR2(4000), 
	G60 VARCHAR2(4000), 
	G62 VARCHAR2(4000), 
	G61 VARCHAR2(4000), 
	G27 VARCHAR2(4000), 
	G27E VARCHAR2(4000), 
	G15 VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_INV_CCK_FL ***
 exec bpa.alter_policies('ERR$_INV_CCK_FL');


COMMENT ON TABLE BARS.ERR$_INV_CCK_FL IS 'DML Error Logging table for "INV_CCK_FL"';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.G105 IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.G106 IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.G107 IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.G60 IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.G62 IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.G61 IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.G27 IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.G27E IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.G15 IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.KF IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.G00 IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.G01 IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.G02 IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.G03 IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.G04 IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.G05 IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.G06 IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.G07 IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.G08 IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.G09 IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.G10 IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.G11 IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.G12 IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.G13 IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.G13A IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.G13B IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.G13V IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.G13G IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.G13D IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.G13E IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.G13J IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.G13Z IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.G13I IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.G14 IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.G16 IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.G17 IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.G18 IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.G19 IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.G20 IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.G21 IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.G22 IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.G23 IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.G24 IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.G25 IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.G26 IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.G28 IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.G29 IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.G30 IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.G31 IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.G32 IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.G33 IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.G34 IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.G35 IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.G36 IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.G37 IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.G38 IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.G39 IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.G40 IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.G41 IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.G42 IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.G43 IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.G44 IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.G45 IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.G46 IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.G47 IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.G48 IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.G49 IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.G50 IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.G51 IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.G52 IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.G53 IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.G54 IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.G55 IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.G56 IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.G57 IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.G58 IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.G59 IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.GT IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.GR IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.ACC IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.RNK IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.ACC2208 IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.ACC9129 IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.G101 IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.G102 IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.G103 IS '';
COMMENT ON COLUMN BARS.ERR$_INV_CCK_FL.G104 IS '';



PROMPT *** Create  grants  ERR$_INV_CCK_FL ***
grant SELECT                                                                 on ERR$_INV_CCK_FL to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_INV_CCK_FL to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_INV_CCK_FL.sql =========*** End *
PROMPT ===================================================================================== 
