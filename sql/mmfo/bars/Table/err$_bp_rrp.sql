

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_BP_RRP.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_BP_RRP ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_BP_RRP ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_BP_RRP 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	RULE VARCHAR2(4000), 
	MFO VARCHAR2(4000), 
	FA VARCHAR2(4000), 
	BODY VARCHAR2(4000), 
	NAME VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_BP_RRP ***
 exec bpa.alter_policies('ERR$_BP_RRP');


COMMENT ON TABLE BARS.ERR$_BP_RRP IS 'DML Error Logging table for "BP_RRP"';
COMMENT ON COLUMN BARS.ERR$_BP_RRP.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_BP_RRP.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_BP_RRP.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_BP_RRP.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_BP_RRP.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_BP_RRP.RULE IS '';
COMMENT ON COLUMN BARS.ERR$_BP_RRP.MFO IS '';
COMMENT ON COLUMN BARS.ERR$_BP_RRP.FA IS '';
COMMENT ON COLUMN BARS.ERR$_BP_RRP.BODY IS '';
COMMENT ON COLUMN BARS.ERR$_BP_RRP.NAME IS '';
COMMENT ON COLUMN BARS.ERR$_BP_RRP.KF IS '';



PROMPT *** Create  grants  ERR$_BP_RRP ***
grant SELECT                                                                 on ERR$_BP_RRP     to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_BP_RRP.sql =========*** End *** =
PROMPT ===================================================================================== 
