

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ADR_HOUSES_ERRLOG.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ADR_HOUSES_ERRLOG ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ADR_HOUSES_ERRLOG'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ADR_HOUSES_ERRLOG'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ADR_HOUSES_ERRLOG ***
begin 
  execute immediate '
  CREATE TABLE BARS.ADR_HOUSES_ERRLOG 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	HOUSE_ID VARCHAR2(4000), 
	STREET_ID VARCHAR2(4000), 
	DISTRICT_ID VARCHAR2(4000), 
	HOUSE_NUM VARCHAR2(4000), 
	HOUSE_NUM_ADD VARCHAR2(4000), 
	POSTAL_CODE VARCHAR2(4000), 
	LATITUDE VARCHAR2(4000), 
	LONGITUDE VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ADR_HOUSES_ERRLOG ***
 exec bpa.alter_policies('ADR_HOUSES_ERRLOG');


COMMENT ON TABLE BARS.ADR_HOUSES_ERRLOG IS 'DML Error Logging table for "ADR_HOUSES"';
COMMENT ON COLUMN BARS.ADR_HOUSES_ERRLOG.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ADR_HOUSES_ERRLOG.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ADR_HOUSES_ERRLOG.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ADR_HOUSES_ERRLOG.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ADR_HOUSES_ERRLOG.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ADR_HOUSES_ERRLOG.HOUSE_ID IS '';
COMMENT ON COLUMN BARS.ADR_HOUSES_ERRLOG.STREET_ID IS '';
COMMENT ON COLUMN BARS.ADR_HOUSES_ERRLOG.DISTRICT_ID IS '';
COMMENT ON COLUMN BARS.ADR_HOUSES_ERRLOG.HOUSE_NUM IS '';
COMMENT ON COLUMN BARS.ADR_HOUSES_ERRLOG.HOUSE_NUM_ADD IS '';
COMMENT ON COLUMN BARS.ADR_HOUSES_ERRLOG.POSTAL_CODE IS '';
COMMENT ON COLUMN BARS.ADR_HOUSES_ERRLOG.LATITUDE IS '';
COMMENT ON COLUMN BARS.ADR_HOUSES_ERRLOG.LONGITUDE IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ADR_HOUSES_ERRLOG.sql =========*** End
PROMPT ===================================================================================== 
