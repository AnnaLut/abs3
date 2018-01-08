

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_W4_SUBPRODUCT.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_W4_SUBPRODUCT ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_W4_SUBPRODUCT ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_W4_SUBPRODUCT 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	CODE VARCHAR2(4000), 
	NAME VARCHAR2(4000), 
	FLAG_KK VARCHAR2(4000), 
	FLAG_INSTANT VARCHAR2(4000), 
	DATE_INSTANT VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_W4_SUBPRODUCT ***
 exec bpa.alter_policies('ERR$_W4_SUBPRODUCT');


COMMENT ON TABLE BARS.ERR$_W4_SUBPRODUCT IS 'DML Error Logging table for "W4_SUBPRODUCT"';
COMMENT ON COLUMN BARS.ERR$_W4_SUBPRODUCT.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_W4_SUBPRODUCT.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_W4_SUBPRODUCT.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_W4_SUBPRODUCT.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_W4_SUBPRODUCT.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_W4_SUBPRODUCT.CODE IS '';
COMMENT ON COLUMN BARS.ERR$_W4_SUBPRODUCT.NAME IS '';
COMMENT ON COLUMN BARS.ERR$_W4_SUBPRODUCT.FLAG_KK IS '';
COMMENT ON COLUMN BARS.ERR$_W4_SUBPRODUCT.FLAG_INSTANT IS '';
COMMENT ON COLUMN BARS.ERR$_W4_SUBPRODUCT.DATE_INSTANT IS '';



PROMPT *** Create  grants  ERR$_W4_SUBPRODUCT ***
grant SELECT                                                                 on ERR$_W4_SUBPRODUCT to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_W4_SUBPRODUCT to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_W4_SUBPRODUCT.sql =========*** En
PROMPT ===================================================================================== 
