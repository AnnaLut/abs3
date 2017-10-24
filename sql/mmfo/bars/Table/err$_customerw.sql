

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_CUSTOMERW.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_CUSTOMERW ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_CUSTOMERW ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_CUSTOMERW 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	RNK VARCHAR2(4000), 
	TAG VARCHAR2(4000), 
	VALUE VARCHAR2(4000), 
	ISP VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_CUSTOMERW ***
 exec bpa.alter_policies('ERR$_CUSTOMERW');


COMMENT ON TABLE BARS.ERR$_CUSTOMERW IS 'DML Error Logging table for "CUSTOMERW"';
COMMENT ON COLUMN BARS.ERR$_CUSTOMERW.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMERW.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMERW.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMERW.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMERW.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMERW.RNK IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMERW.TAG IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMERW.VALUE IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTOMERW.ISP IS '';



PROMPT *** Create  grants  ERR$_CUSTOMERW ***
grant SELECT                                                                 on ERR$_CUSTOMERW  to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_CUSTOMERW.sql =========*** End **
PROMPT ===================================================================================== 
