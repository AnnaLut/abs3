

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_CC_LIM_ARC.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_CC_LIM_ARC ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_CC_LIM_ARC ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_CC_LIM_ARC 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ND VARCHAR2(4000), 
	MDAT VARCHAR2(4000), 
	FDAT VARCHAR2(4000), 
	LIM2 VARCHAR2(4000), 
	ACC VARCHAR2(4000), 
	NOT_9129 VARCHAR2(4000), 
	SUMG VARCHAR2(4000), 
	SUMO VARCHAR2(4000), 
	OTM VARCHAR2(4000), 
	SUMK VARCHAR2(4000), 
	NOT_SN VARCHAR2(4000), 
	TYPM VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_CC_LIM_ARC ***
 exec bpa.alter_policies('ERR$_CC_LIM_ARC');


COMMENT ON TABLE BARS.ERR$_CC_LIM_ARC IS 'DML Error Logging table for "CC_LIM_ARC"';
COMMENT ON COLUMN BARS.ERR$_CC_LIM_ARC.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_CC_LIM_ARC.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CC_LIM_ARC.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_CC_LIM_ARC.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_CC_LIM_ARC.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CC_LIM_ARC.ND IS '';
COMMENT ON COLUMN BARS.ERR$_CC_LIM_ARC.MDAT IS '';
COMMENT ON COLUMN BARS.ERR$_CC_LIM_ARC.FDAT IS '';
COMMENT ON COLUMN BARS.ERR$_CC_LIM_ARC.LIM2 IS '';
COMMENT ON COLUMN BARS.ERR$_CC_LIM_ARC.ACC IS '';
COMMENT ON COLUMN BARS.ERR$_CC_LIM_ARC.NOT_9129 IS '';
COMMENT ON COLUMN BARS.ERR$_CC_LIM_ARC.SUMG IS '';
COMMENT ON COLUMN BARS.ERR$_CC_LIM_ARC.SUMO IS '';
COMMENT ON COLUMN BARS.ERR$_CC_LIM_ARC.OTM IS '';
COMMENT ON COLUMN BARS.ERR$_CC_LIM_ARC.SUMK IS '';
COMMENT ON COLUMN BARS.ERR$_CC_LIM_ARC.NOT_SN IS '';
COMMENT ON COLUMN BARS.ERR$_CC_LIM_ARC.TYPM IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_CC_LIM_ARC.sql =========*** End *
PROMPT ===================================================================================== 
