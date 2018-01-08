

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_CIM_CONTRACT_DEADLINES.sql ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_CIM_CONTRACT_DEADLINES ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_CIM_CONTRACT_DEADLINES ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_CIM_CONTRACT_DEADLINES 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	DEADLINE VARCHAR2(4000), 
	COMMENTS VARCHAR2(4000), 
	DELETE_DATE VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_CIM_CONTRACT_DEADLINES ***
 exec bpa.alter_policies('ERR$_CIM_CONTRACT_DEADLINES');


COMMENT ON TABLE BARS.ERR$_CIM_CONTRACT_DEADLINES IS 'DML Error Logging table for "CIM_CONTRACT_DEADLINES"';
COMMENT ON COLUMN BARS.ERR$_CIM_CONTRACT_DEADLINES.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_CONTRACT_DEADLINES.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_CONTRACT_DEADLINES.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_CONTRACT_DEADLINES.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_CONTRACT_DEADLINES.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_CONTRACT_DEADLINES.DEADLINE IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_CONTRACT_DEADLINES.COMMENTS IS '';
COMMENT ON COLUMN BARS.ERR$_CIM_CONTRACT_DEADLINES.DELETE_DATE IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_CIM_CONTRACT_DEADLINES.sql ======
PROMPT ===================================================================================== 
