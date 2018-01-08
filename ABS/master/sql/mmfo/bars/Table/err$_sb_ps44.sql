

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_SB_PS44.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_SB_PS44 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_SB_PS44 ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_SB_PS44 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	T020 VARCHAR2(4000), 
	R020 VARCHAR2(4000), 
	OB22 VARCHAR2(4000), 
	OB40 VARCHAR2(4000), 
	D_OPEN VARCHAR2(4000), 
	D_CLOSE VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_SB_PS44 ***
 exec bpa.alter_policies('ERR$_SB_PS44');


COMMENT ON TABLE BARS.ERR$_SB_PS44 IS 'DML Error Logging table for "SB_PS44"';
COMMENT ON COLUMN BARS.ERR$_SB_PS44.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_SB_PS44.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_SB_PS44.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_SB_PS44.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_SB_PS44.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_SB_PS44.T020 IS '';
COMMENT ON COLUMN BARS.ERR$_SB_PS44.R020 IS '';
COMMENT ON COLUMN BARS.ERR$_SB_PS44.OB22 IS '';
COMMENT ON COLUMN BARS.ERR$_SB_PS44.OB40 IS '';
COMMENT ON COLUMN BARS.ERR$_SB_PS44.D_OPEN IS '';
COMMENT ON COLUMN BARS.ERR$_SB_PS44.D_CLOSE IS '';



PROMPT *** Create  grants  ERR$_SB_PS44 ***
grant SELECT                                                                 on ERR$_SB_PS44    to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_SB_PS44    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_SB_PS44.sql =========*** End *** 
PROMPT ===================================================================================== 
