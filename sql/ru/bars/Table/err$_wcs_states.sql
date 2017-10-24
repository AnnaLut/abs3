

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_WCS_STATES.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_WCS_STATES ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_WCS_STATES ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_WCS_STATES 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ID VARCHAR2(4000), 
	NAME VARCHAR2(4000), 
	PARENT VARCHAR2(4000), 
	BEFORE_PROC VARCHAR2(4000), 
	AFTER_PROC VARCHAR2(4000), 
	IS_DISP VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_WCS_STATES ***
 exec bpa.alter_policies('ERR$_WCS_STATES');


COMMENT ON TABLE BARS.ERR$_WCS_STATES IS 'DML Error Logging table for "WCS_STATES"';
COMMENT ON COLUMN BARS.ERR$_WCS_STATES.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_STATES.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_STATES.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_STATES.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_STATES.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_STATES.ID IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_STATES.NAME IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_STATES.PARENT IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_STATES.BEFORE_PROC IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_STATES.AFTER_PROC IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_STATES.IS_DISP IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_WCS_STATES.sql =========*** End *
PROMPT ===================================================================================== 
