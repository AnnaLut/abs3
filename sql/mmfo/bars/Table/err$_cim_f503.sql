

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_CIM_F503.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_CIM_F503 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_CIM_F503 ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_CIM_F503 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	F503_ID VARCHAR2(4000), 
	CONTR_ID VARCHAR2(4000), 
	P_DATE_TO VARCHAR2(4000), 
	DATE_REG VARCHAR2(4000), 
	USER_REG VARCHAR2(4000), 
	DATE_CH VARCHAR2(4000), 
	USER_CH VARCHAR2(4000), 
	BRANCH VARCHAR2(4000), 
	KF VARCHAR2(4000), 
	P1000 VARCHAR2(4000), 
	Z VARCHAR2(4000), 
	P0100 VARCHAR2(4000), 
	P1300 VARCHAR2(4000), 
	P0300 VARCHAR2(4000), 
	P1400 VARCHAR2(4000), 
	P1900 VARCHAR2(4000), 
	PVAL VARCHAR2(4000), 
	P1500 VARCHAR2(4000), 
	M VARCHAR2(4000), 
	P1600 VARCHAR2(4000), 
	P9800 VARCHAR2(4000), 
	P1700 VARCHAR2(4000), 
	P0200 VARCHAR2(4000), 
	R_AGREE_NO VARCHAR2(4000), 
	P1200 VARCHAR2(4000), 
	P1800 VARCHAR2(4000), 
	T VARCHAR2(4000), 
	P9500 VARCHAR2(4000), 
	P9600 VARCHAR2(4000), 
	P3100 VARCHAR2(4000), 
	P9900 VARCHAR2(4000), 
	P0400 VARCHAR2(4000), 
	P0800_1 VARCHAR2(4000), 
	P0800_2 VARCHAR2(4000), 
	P0800_3 VARCHAR2(4000), 
	P0700 VARCHAR2(4000), 
	P0900 VARCHAR2(4000), 
	P0500 VARCHAR2(4000), 
	P0600 VARCHAR2(4000), 
	P2010 VARCHAR2(4000), 
	P2011 VARCHAR2(4000), 
	P2012 VARCHAR2(4000), 
	P2013 VARCHAR2(4000), 
	P2014 VARCHAR2(4000), 
	P2016 VARCHAR2(4000), 
	P2017 VARCHAR2(4000), 
	P2018 VARCHAR2(4000), 
	P2020 VARCHAR2(4000), 
	P2021 VARCHAR2(4000), 
	P2022 VARCHAR2(4000), 
	P2023 VARCHAR2(4000), 
	P2024 VARCHAR2(4000), 
	P2025 VARCHAR2(4000), 
	P2026 VARCHAR2(4000), 
	P2027 VARCHAR2(4000), 
	P2028 VARCHAR2(4000), 
	P2029 VARCHAR2(4000), 
	P2030 VARCHAR2(4000), 
	P2031 VARCHAR2(4000), 
	P2032 VARCHAR2(4000), 
	P2033 VARCHAR2(4000), 
	P2034 VARCHAR2(4000), 
	P2035 VARCHAR2(4000), 
	P2036 VARCHAR2(4000), 
	P2037 VARCHAR2(4000), 
	P2038 VARCHAR2(4000), 
	P2042 VARCHAR2(4000), 
	P3000 VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_CIM_F503 ***
 exec bpa.alter_policies('ERR$_CIM_F503');


COMMENT ON TABLE BARS.ERR$_CIM_F503 IS 'DML Error Logging table for "CIM_F503"';
COMMENT ON COLUMN BARS.ERR$_CIM_F503.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F503.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F503.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F503.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F503.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F503.F503_ID IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F503.CONTR_ID IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F503.P_DATE_TO IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F503.DATE_REG IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F503.USER_REG IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F503.DATE_CH IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F503.USER_CH IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F503.BRANCH IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F503.KF IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F503.P1000 IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F503.Z IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F503.P0100 IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F503.P1300 IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F503.P0300 IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F503.P1400 IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F503.P1900 IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F503.PVAL IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F503.P1500 IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F503.M IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F503.P1600 IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F503.P9800 IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F503.P1700 IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F503.P0200 IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F503.R_AGREE_NO IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F503.P1200 IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F503.P1800 IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F503.T IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F503.P9500 IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F503.P9600 IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F503.P3100 IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F503.P9900 IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F503.P0400 IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F503.P0800_1 IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F503.P0800_2 IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F503.P0800_3 IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F503.P0700 IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F503.P0900 IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F503.P0500 IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F503.P0600 IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F503.P2010 IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F503.P2011 IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F503.P2012 IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F503.P2013 IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F503.P2014 IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F503.P2016 IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F503.P2017 IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F503.P2018 IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F503.P2020 IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F503.P2021 IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F503.P2022 IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F503.P2023 IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F503.P2024 IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F503.P2025 IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F503.P2026 IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F503.P2027 IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F503.P2028 IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F503.P2029 IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F503.P2030 IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F503.P2031 IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F503.P2032 IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F503.P2033 IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F503.P2034 IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F503.P2035 IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F503.P2036 IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F503.P2037 IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F503.P2038 IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F503.P2042 IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F503.P3000 IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_CIM_F503.sql =========*** End ***
PROMPT ===================================================================================== 
