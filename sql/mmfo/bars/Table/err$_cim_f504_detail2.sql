

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_CIM_F504_DETAIL2.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_CIM_F504_DETAIL2 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_CIM_F504_DETAIL2 ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_CIM_F504_DETAIL2 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	F504_DET_ID VARCHAR2(4000), 
	F504_ID VARCHAR2(4000), 
	INDICATOR_ID VARCHAR2(4000), 
	INDICATOR_NAME VARCHAR2(4000), 
	RRRR VARCHAR2(4000), 
	W VARCHAR2(4000), 
	VAL VARCHAR2(4000), 
	DATE_REG VARCHAR2(4000), 
	USER_REG VARCHAR2(4000), 
	DATE_CH VARCHAR2(4000), 
	USER_CH VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_CIM_F504_DETAIL2 ***
 exec bpa.alter_policies('ERR$_CIM_F504_DETAIL2');


COMMENT ON TABLE BARS.ERR$_CIM_F504_DETAIL2 IS 'DML Error Logging table for "CIM_F504_DETAIL2"';
COMMENT ON COLUMN BARS.ERR$_CIM_F504_DETAIL2.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F504_DETAIL2.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F504_DETAIL2.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F504_DETAIL2.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F504_DETAIL2.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F504_DETAIL2.F504_DET_ID IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F504_DETAIL2.F504_ID IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F504_DETAIL2.INDICATOR_ID IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F504_DETAIL2.INDICATOR_NAME IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F504_DETAIL2.RRRR IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F504_DETAIL2.W IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F504_DETAIL2.VAL IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F504_DETAIL2.DATE_REG IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F504_DETAIL2.USER_REG IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F504_DETAIL2.DATE_CH IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_F504_DETAIL2.USER_CH IS '';



PROMPT *** Create  grants  ERR$_CIM_F504_DETAIL2 ***
grant SELECT                                                                 on ERR$_CIM_F504_DETAIL2 to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_CIM_F504_DETAIL2 to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_CIM_F504_DETAIL2.sql =========***
PROMPT ===================================================================================== 
