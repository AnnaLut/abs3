

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_SP_B040.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_SP_B040 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_SP_B040 ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_SP_B040 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	B040 VARCHAR2(4000), 
	NAME VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_SP_B040 ***
 exec bpa.alter_policies('ERR$_SP_B040');


COMMENT ON TABLE BARS.ERR$_SP_B040 IS 'DML Error Logging table for "SP_B040"';
COMMENT ON COLUMN BARS.ERR$_SP_B040.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_SP_B040.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_SP_B040.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_SP_B040.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_SP_B040.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_SP_B040.B040 IS '';
COMMENT ON COLUMN BARS.ERR$_SP_B040.NAME IS '';



PROMPT *** Create  grants  ERR$_SP_B040 ***
grant SELECT                                                                 on ERR$_SP_B040    to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_SP_B040    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_SP_B040.sql =========*** End *** 
PROMPT ===================================================================================== 
