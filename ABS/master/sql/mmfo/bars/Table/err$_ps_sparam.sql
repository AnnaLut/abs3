

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_PS_SPARAM.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_PS_SPARAM ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_PS_SPARAM ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_PS_SPARAM 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	NBS VARCHAR2(4000), 
	SPID VARCHAR2(4000), 
	OPT VARCHAR2(4000), 
	SQLVAL VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_PS_SPARAM ***
 exec bpa.alter_policies('ERR$_PS_SPARAM');


COMMENT ON TABLE BARS.ERR$_PS_SPARAM IS 'DML Error Logging table for "PS_SPARAM"';
COMMENT ON COLUMN BARS.ERR$_PS_SPARAM.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_PS_SPARAM.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_PS_SPARAM.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_PS_SPARAM.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_PS_SPARAM.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_PS_SPARAM.NBS IS '';
COMMENT ON COLUMN BARS.ERR$_PS_SPARAM.SPID IS '';
COMMENT ON COLUMN BARS.ERR$_PS_SPARAM.OPT IS '';
COMMENT ON COLUMN BARS.ERR$_PS_SPARAM.SQLVAL IS '';



PROMPT *** Create  grants  ERR$_PS_SPARAM ***
grant SELECT                                                                 on ERR$_PS_SPARAM  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_PS_SPARAM.sql =========*** End **
PROMPT ===================================================================================== 
