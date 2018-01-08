

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_CIM_CUSTOMER_UPD.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_CIM_CUSTOMER_UPD ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_CIM_CUSTOMER_UPD ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_CIM_CUSTOMER_UPD 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	RNK VARCHAR2(4000), 
	MODIFY_DATE VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_CIM_CUSTOMER_UPD ***
 exec bpa.alter_policies('ERR$_CIM_CUSTOMER_UPD');


COMMENT ON TABLE BARS.ERR$_CIM_CUSTOMER_UPD IS 'DML Error Logging table for "CIM_CUSTOMER_UPD"';
COMMENT ON COLUMN BARS.ERR$_CIM_CUSTOMER_UPD.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_CUSTOMER_UPD.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_CUSTOMER_UPD.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_CUSTOMER_UPD.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_CUSTOMER_UPD.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_CUSTOMER_UPD.RNK IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_CUSTOMER_UPD.MODIFY_DATE IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_CIM_CUSTOMER_UPD.sql =========***
PROMPT ===================================================================================== 
