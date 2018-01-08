

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_SPECPARAM_CP_OB.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_SPECPARAM_CP_OB ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_SPECPARAM_CP_OB ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_SPECPARAM_CP_OB 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ACC VARCHAR2(4000), 
	INITIATOR VARCHAR2(4000), 
	MARKET VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_SPECPARAM_CP_OB ***
 exec bpa.alter_policies('ERR$_SPECPARAM_CP_OB');


COMMENT ON TABLE BARS.ERR$_SPECPARAM_CP_OB IS 'DML Error Logging table for "SPECPARAM_CP_OB"';
COMMENT ON COLUMN BARS.ERR$_SPECPARAM_CP_OB.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_SPECPARAM_CP_OB.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_SPECPARAM_CP_OB.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_SPECPARAM_CP_OB.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_SPECPARAM_CP_OB.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_SPECPARAM_CP_OB.ACC IS '';
COMMENT ON COLUMN BARS.ERR$_SPECPARAM_CP_OB.INITIATOR IS '';
COMMENT ON COLUMN BARS.ERR$_SPECPARAM_CP_OB.MARKET IS '';



PROMPT *** Create  grants  ERR$_SPECPARAM_CP_OB ***
grant SELECT                                                                 on ERR$_SPECPARAM_CP_OB to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_SPECPARAM_CP_OB to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_SPECPARAM_CP_OB.sql =========*** 
PROMPT ===================================================================================== 
