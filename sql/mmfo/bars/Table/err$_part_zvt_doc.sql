

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_PART_ZVT_DOC.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_PART_ZVT_DOC ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_PART_ZVT_DOC ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_PART_ZVT_DOC 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	FDAT VARCHAR2(4000), 
	BRANCH VARCHAR2(4000), 
	TEMA VARCHAR2(4000), 
	ISP VARCHAR2(4000), 
	KV VARCHAR2(4000), 
	TT VARCHAR2(4000), 
	REF VARCHAR2(4000), 
	STMT VARCHAR2(4000), 
	NLSD VARCHAR2(4000), 
	NLSK VARCHAR2(4000), 
	S VARCHAR2(4000), 
	SQ VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_PART_ZVT_DOC ***
 exec bpa.alter_policies('ERR$_PART_ZVT_DOC');


COMMENT ON TABLE BARS.ERR$_PART_ZVT_DOC IS 'DML Error Logging table for "PART_ZVT_DOC"';
COMMENT ON COLUMN BARS.ERR$_PART_ZVT_DOC.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_PART_ZVT_DOC.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_PART_ZVT_DOC.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_PART_ZVT_DOC.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_PART_ZVT_DOC.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_PART_ZVT_DOC.FDAT IS '';
COMMENT ON COLUMN BARS.ERR$_PART_ZVT_DOC.BRANCH IS '';
COMMENT ON COLUMN BARS.ERR$_PART_ZVT_DOC.TEMA IS '';
COMMENT ON COLUMN BARS.ERR$_PART_ZVT_DOC.ISP IS '';
COMMENT ON COLUMN BARS.ERR$_PART_ZVT_DOC.KV IS '';
COMMENT ON COLUMN BARS.ERR$_PART_ZVT_DOC.TT IS '';
COMMENT ON COLUMN BARS.ERR$_PART_ZVT_DOC.REF IS '';
COMMENT ON COLUMN BARS.ERR$_PART_ZVT_DOC.STMT IS '';
COMMENT ON COLUMN BARS.ERR$_PART_ZVT_DOC.NLSD IS '';
COMMENT ON COLUMN BARS.ERR$_PART_ZVT_DOC.NLSK IS '';
COMMENT ON COLUMN BARS.ERR$_PART_ZVT_DOC.S IS '';
COMMENT ON COLUMN BARS.ERR$_PART_ZVT_DOC.SQ IS '';
COMMENT ON COLUMN BARS.ERR$_PART_ZVT_DOC.KF IS '';



PROMPT *** Create  grants  ERR$_PART_ZVT_DOC ***
grant SELECT                                                                 on ERR$_PART_ZVT_DOC to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_PART_ZVT_DOC.sql =========*** End
PROMPT ===================================================================================== 
