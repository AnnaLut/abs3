

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_DPT_FILE_SUBST.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_DPT_FILE_SUBST ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_DPT_FILE_SUBST ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_DPT_FILE_SUBST 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	PARENT_BRANCH VARCHAR2(4000), 
	CHILD_BRANCH VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_DPT_FILE_SUBST ***
 exec bpa.alter_policies('ERR$_DPT_FILE_SUBST');


COMMENT ON TABLE BARS.ERR$_DPT_FILE_SUBST IS 'DML Error Logging table for "DPT_FILE_SUBST"';
COMMENT ON COLUMN BARS.ERR$_DPT_FILE_SUBST.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_FILE_SUBST.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_FILE_SUBST.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_FILE_SUBST.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_FILE_SUBST.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_FILE_SUBST.PARENT_BRANCH IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_FILE_SUBST.CHILD_BRANCH IS '';



PROMPT *** Create  grants  ERR$_DPT_FILE_SUBST ***
grant SELECT                                                                 on ERR$_DPT_FILE_SUBST to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_DPT_FILE_SUBST to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_DPT_FILE_SUBST.sql =========*** E
PROMPT ===================================================================================== 
