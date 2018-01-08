

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_BIZNESPR_NAZN.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_BIZNESPR_NAZN ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_BIZNESPR_NAZN ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_BIZNESPR_NAZN 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	SLOVO VARCHAR2(4000), 
	COMM VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_BIZNESPR_NAZN ***
 exec bpa.alter_policies('ERR$_BIZNESPR_NAZN');


COMMENT ON TABLE BARS.ERR$_BIZNESPR_NAZN IS 'DML Error Logging table for "BIZNESPR_NAZN"';
COMMENT ON COLUMN BARS.ERR$_BIZNESPR_NAZN.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_BIZNESPR_NAZN.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_BIZNESPR_NAZN.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_BIZNESPR_NAZN.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_BIZNESPR_NAZN.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_BIZNESPR_NAZN.SLOVO IS '';
COMMENT ON COLUMN BARS.ERR$_BIZNESPR_NAZN.COMM IS '';



PROMPT *** Create  grants  ERR$_BIZNESPR_NAZN ***
grant SELECT                                                                 on ERR$_BIZNESPR_NAZN to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_BIZNESPR_NAZN.sql =========*** En
PROMPT ===================================================================================== 
