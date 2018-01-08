

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_TARIF_SCHEME_ACCBRANCH.sql ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_TARIF_SCHEME_ACCBRANCH ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_TARIF_SCHEME_ACCBRANCH ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_TARIF_SCHEME_ACCBRANCH 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ID VARCHAR2(4000), 
	BRANCH VARCHAR2(4000), 
	DAT_BEGIN VARCHAR2(4000), 
	DAT_END VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_TARIF_SCHEME_ACCBRANCH ***
 exec bpa.alter_policies('ERR$_TARIF_SCHEME_ACCBRANCH');


COMMENT ON TABLE BARS.ERR$_TARIF_SCHEME_ACCBRANCH IS 'DML Error Logging table for "TARIF_SCHEME_ACCBRANCH"';
COMMENT ON COLUMN BARS.ERR$_TARIF_SCHEME_ACCBRANCH.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_TARIF_SCHEME_ACCBRANCH.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_TARIF_SCHEME_ACCBRANCH.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_TARIF_SCHEME_ACCBRANCH.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_TARIF_SCHEME_ACCBRANCH.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_TARIF_SCHEME_ACCBRANCH.ID IS '';
COMMENT ON COLUMN BARS.ERR$_TARIF_SCHEME_ACCBRANCH.BRANCH IS '';
COMMENT ON COLUMN BARS.ERR$_TARIF_SCHEME_ACCBRANCH.DAT_BEGIN IS '';
COMMENT ON COLUMN BARS.ERR$_TARIF_SCHEME_ACCBRANCH.DAT_END IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_TARIF_SCHEME_ACCBRANCH.sql ======
PROMPT ===================================================================================== 
