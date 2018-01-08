

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_OW_PKK_QUE.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_OW_PKK_QUE ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_OW_PKK_QUE ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_OW_PKK_QUE 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	REF VARCHAR2(4000), 
	ACC VARCHAR2(4000), 
	DK VARCHAR2(4000), 
	SOS VARCHAR2(4000), 
	F_N VARCHAR2(4000), 
	RESP_CLASS VARCHAR2(4000), 
	RESP_CODE VARCHAR2(4000), 
	RESP_TEXT VARCHAR2(4000), 
	UNFORM_FLAG VARCHAR2(4000), 
	UNFORM_USER VARCHAR2(4000), 
	UNFORM_DATE VARCHAR2(4000), 
	DRN VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_OW_PKK_QUE ***
 exec bpa.alter_policies('ERR$_OW_PKK_QUE');


COMMENT ON TABLE BARS.ERR$_OW_PKK_QUE IS 'DML Error Logging table for "OW_PKK_QUE"';
COMMENT ON COLUMN BARS.ERR$_OW_PKK_QUE.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_OW_PKK_QUE.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_OW_PKK_QUE.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_OW_PKK_QUE.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_OW_PKK_QUE.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_OW_PKK_QUE.REF IS '';
COMMENT ON COLUMN BARS.ERR$_OW_PKK_QUE.ACC IS '';
COMMENT ON COLUMN BARS.ERR$_OW_PKK_QUE.DK IS '';
COMMENT ON COLUMN BARS.ERR$_OW_PKK_QUE.SOS IS '';
COMMENT ON COLUMN BARS.ERR$_OW_PKK_QUE.F_N IS '';
COMMENT ON COLUMN BARS.ERR$_OW_PKK_QUE.RESP_CLASS IS '';
COMMENT ON COLUMN BARS.ERR$_OW_PKK_QUE.RESP_CODE IS '';
COMMENT ON COLUMN BARS.ERR$_OW_PKK_QUE.RESP_TEXT IS '';
COMMENT ON COLUMN BARS.ERR$_OW_PKK_QUE.UNFORM_FLAG IS '';
COMMENT ON COLUMN BARS.ERR$_OW_PKK_QUE.UNFORM_USER IS '';
COMMENT ON COLUMN BARS.ERR$_OW_PKK_QUE.UNFORM_DATE IS '';
COMMENT ON COLUMN BARS.ERR$_OW_PKK_QUE.DRN IS '';
COMMENT ON COLUMN BARS.ERR$_OW_PKK_QUE.KF IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_OW_PKK_QUE.sql =========*** End *
PROMPT ===================================================================================== 
