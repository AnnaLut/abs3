

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_MBK_CP.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_MBK_CP ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_MBK_CP ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_MBK_CP 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ND VARCHAR2(4000), 
	ID VARCHAR2(4000), 
	KOL VARCHAR2(4000), 
	SASIN VARCHAR2(4000), 
	ACC VARCHAR2(4000), 
	REF VARCHAR2(4000), 
	TIPD VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_MBK_CP ***
 exec bpa.alter_policies('ERR$_MBK_CP');


COMMENT ON TABLE BARS.ERR$_MBK_CP IS 'DML Error Logging table for "MBK_CP"';
COMMENT ON COLUMN BARS.ERR$_MBK_CP.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_MBK_CP.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_MBK_CP.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_MBK_CP.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_MBK_CP.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_MBK_CP.ND IS '';
COMMENT ON COLUMN BARS.ERR$_MBK_CP.ID IS '';
COMMENT ON COLUMN BARS.ERR$_MBK_CP.KOL IS '';
COMMENT ON COLUMN BARS.ERR$_MBK_CP.SASIN IS '';
COMMENT ON COLUMN BARS.ERR$_MBK_CP.ACC IS '';
COMMENT ON COLUMN BARS.ERR$_MBK_CP.REF IS '';
COMMENT ON COLUMN BARS.ERR$_MBK_CP.TIPD IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_MBK_CP.sql =========*** End *** =
PROMPT ===================================================================================== 
