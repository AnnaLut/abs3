

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_CM_ACC_REQUEST.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_CM_ACC_REQUEST ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_CM_ACC_REQUEST ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_CM_ACC_REQUEST 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	OPER_TYPE VARCHAR2(4000), 
	DATE_IN VARCHAR2(4000), 
	CONTRACT_NUMBER VARCHAR2(4000), 
	PRODUCT_CODE VARCHAR2(4000), 
	CARD_TYPE VARCHAR2(4000), 
	OPER_DATE VARCHAR2(4000), 
	ABS_STATUS VARCHAR2(4000), 
	ABS_MSG VARCHAR2(4000), 
	OKPO VARCHAR2(4000), 
	OKPO_N VARCHAR2(4000), 
	CARD_EXPIRE VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_CM_ACC_REQUEST ***
 exec bpa.alter_policies('ERR$_CM_ACC_REQUEST');


COMMENT ON TABLE BARS.ERR$_CM_ACC_REQUEST IS 'DML Error Logging table for "CM_ACC_REQUEST"';
COMMENT ON COLUMN BARS.ERR$_CM_ACC_REQUEST.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_CM_ACC_REQUEST.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CM_ACC_REQUEST.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_CM_ACC_REQUEST.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_CM_ACC_REQUEST.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CM_ACC_REQUEST.OPER_TYPE IS '';
COMMENT ON COLUMN BARS.ERR$_CM_ACC_REQUEST.DATE_IN IS '';
COMMENT ON COLUMN BARS.ERR$_CM_ACC_REQUEST.CONTRACT_NUMBER IS '';
COMMENT ON COLUMN BARS.ERR$_CM_ACC_REQUEST.PRODUCT_CODE IS '';
COMMENT ON COLUMN BARS.ERR$_CM_ACC_REQUEST.CARD_TYPE IS '';
COMMENT ON COLUMN BARS.ERR$_CM_ACC_REQUEST.OPER_DATE IS '';
COMMENT ON COLUMN BARS.ERR$_CM_ACC_REQUEST.ABS_STATUS IS '';
COMMENT ON COLUMN BARS.ERR$_CM_ACC_REQUEST.ABS_MSG IS '';
COMMENT ON COLUMN BARS.ERR$_CM_ACC_REQUEST.OKPO IS '';
COMMENT ON COLUMN BARS.ERR$_CM_ACC_REQUEST.OKPO_N IS '';
COMMENT ON COLUMN BARS.ERR$_CM_ACC_REQUEST.CARD_EXPIRE IS '';
COMMENT ON COLUMN BARS.ERR$_CM_ACC_REQUEST.KF IS '';



PROMPT *** Create  grants  ERR$_CM_ACC_REQUEST ***
grant SELECT                                                                 on ERR$_CM_ACC_REQUEST to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_CM_ACC_REQUEST to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_CM_ACC_REQUEST.sql =========*** E
PROMPT ===================================================================================== 
