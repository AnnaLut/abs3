

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_STAFFTIP_TTS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_STAFFTIP_TTS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_STAFFTIP_TTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_STAFFTIP_TTS 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ID VARCHAR2(4000), 
	TT VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_STAFFTIP_TTS ***
 exec bpa.alter_policies('ERR$_STAFFTIP_TTS');


COMMENT ON TABLE BARS.ERR$_STAFFTIP_TTS IS 'DML Error Logging table for "STAFFTIP_TTS"';
COMMENT ON COLUMN BARS.ERR$_STAFFTIP_TTS.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_STAFFTIP_TTS.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_STAFFTIP_TTS.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_STAFFTIP_TTS.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_STAFFTIP_TTS.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_STAFFTIP_TTS.ID IS '';
COMMENT ON COLUMN BARS.ERR$_STAFFTIP_TTS.TT IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_STAFFTIP_TTS.sql =========*** End
PROMPT ===================================================================================== 
