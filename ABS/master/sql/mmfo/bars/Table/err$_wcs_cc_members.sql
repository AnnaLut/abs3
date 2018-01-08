

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_WCS_CC_MEMBERS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_WCS_CC_MEMBERS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_WCS_CC_MEMBERS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_WCS_CC_MEMBERS 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	BRANCH VARCHAR2(4000), 
	HEAD VARCHAR2(4000), 
	MBR1 VARCHAR2(4000), 
	MBR2 VARCHAR2(4000), 
	MBR3 VARCHAR2(4000), 
	MBR4 VARCHAR2(4000), 
	MBR5 VARCHAR2(4000), 
	MBR6 VARCHAR2(4000), 
	MBR7 VARCHAR2(4000), 
	MBR8 VARCHAR2(4000), 
	MBR9 VARCHAR2(4000), 
	MBR10 VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_WCS_CC_MEMBERS ***
 exec bpa.alter_policies('ERR$_WCS_CC_MEMBERS');


COMMENT ON TABLE BARS.ERR$_WCS_CC_MEMBERS IS 'DML Error Logging table for "WCS_CC_MEMBERS"';
COMMENT ON COLUMN BARS.ERR$_WCS_CC_MEMBERS.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_CC_MEMBERS.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_CC_MEMBERS.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_CC_MEMBERS.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_CC_MEMBERS.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_CC_MEMBERS.BRANCH IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_CC_MEMBERS.HEAD IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_CC_MEMBERS.MBR1 IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_CC_MEMBERS.MBR2 IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_CC_MEMBERS.MBR3 IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_CC_MEMBERS.MBR4 IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_CC_MEMBERS.MBR5 IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_CC_MEMBERS.MBR6 IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_CC_MEMBERS.MBR7 IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_CC_MEMBERS.MBR8 IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_CC_MEMBERS.MBR9 IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_CC_MEMBERS.MBR10 IS '';



PROMPT *** Create  grants  ERR$_WCS_CC_MEMBERS ***
grant SELECT                                                                 on ERR$_WCS_CC_MEMBERS to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_WCS_CC_MEMBERS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_WCS_CC_MEMBERS.sql =========*** E
PROMPT ===================================================================================== 
