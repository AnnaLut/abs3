

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_CCK_ISP_NLS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_CCK_ISP_NLS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_CCK_ISP_NLS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_CCK_ISP_NLS 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ID VARCHAR2(4000), 
	ISP VARCHAR2(4000), 
	ORD VARCHAR2(4000), 
	KF VARCHAR2(4000), 
	BRANCH VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_CCK_ISP_NLS ***
 exec bpa.alter_policies('ERR$_CCK_ISP_NLS');


COMMENT ON TABLE BARS.ERR$_CCK_ISP_NLS IS 'DML Error Logging table for "CCK_ISP_NLS"';
COMMENT ON COLUMN BARS.ERR$_CCK_ISP_NLS.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_CCK_ISP_NLS.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CCK_ISP_NLS.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_CCK_ISP_NLS.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_CCK_ISP_NLS.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CCK_ISP_NLS.ID IS '';
COMMENT ON COLUMN BARS.ERR$_CCK_ISP_NLS.ISP IS '';
COMMENT ON COLUMN BARS.ERR$_CCK_ISP_NLS.ORD IS '';
COMMENT ON COLUMN BARS.ERR$_CCK_ISP_NLS.KF IS '';
COMMENT ON COLUMN BARS.ERR$_CCK_ISP_NLS.BRANCH IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_CCK_ISP_NLS.sql =========*** End 
PROMPT ===================================================================================== 
