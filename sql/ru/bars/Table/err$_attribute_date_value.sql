

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_ATTRIBUTE_DATE_VALUE.sql ========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_ATTRIBUTE_DATE_VALUE ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_ATTRIBUTE_DATE_VALUE ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_ATTRIBUTE_DATE_VALUE 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	OBJECT_ID VARCHAR2(4000), 
	ATTRIBUTE_ID VARCHAR2(4000), 
	VALUE VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_ATTRIBUTE_DATE_VALUE ***
 exec bpa.alter_policies('ERR$_ATTRIBUTE_DATE_VALUE');


COMMENT ON TABLE BARS.ERR$_ATTRIBUTE_DATE_VALUE IS 'DML Error Logging table for "ATTRIBUTE_DATE_VALUE"';
COMMENT ON COLUMN BARS.ERR$_ATTRIBUTE_DATE_VALUE.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_ATTRIBUTE_DATE_VALUE.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_ATTRIBUTE_DATE_VALUE.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_ATTRIBUTE_DATE_VALUE.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_ATTRIBUTE_DATE_VALUE.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_ATTRIBUTE_DATE_VALUE.OBJECT_ID IS '';
COMMENT ON COLUMN BARS.ERR$_ATTRIBUTE_DATE_VALUE.ATTRIBUTE_ID IS '';
COMMENT ON COLUMN BARS.ERR$_ATTRIBUTE_DATE_VALUE.VALUE IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_ATTRIBUTE_DATE_VALUE.sql ========
PROMPT ===================================================================================== 
