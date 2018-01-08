

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_CM_SALARY_CARD.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_CM_SALARY_CARD ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_CM_SALARY_CARD ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_CM_SALARY_CARD 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ID VARCHAR2(4000), 
	CARD_CODE VARCHAR2(4000), 
	CHG_DATE VARCHAR2(4000), 
	CHG_USER VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_CM_SALARY_CARD ***
 exec bpa.alter_policies('ERR$_CM_SALARY_CARD');


COMMENT ON TABLE BARS.ERR$_CM_SALARY_CARD IS 'DML Error Logging table for "CM_SALARY_CARD"';
COMMENT ON COLUMN BARS.ERR$_CM_SALARY_CARD.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_CM_SALARY_CARD.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CM_SALARY_CARD.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_CM_SALARY_CARD.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_CM_SALARY_CARD.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CM_SALARY_CARD.ID IS '';
COMMENT ON COLUMN BARS.ERR$_CM_SALARY_CARD.CARD_CODE IS '';
COMMENT ON COLUMN BARS.ERR$_CM_SALARY_CARD.CHG_DATE IS '';
COMMENT ON COLUMN BARS.ERR$_CM_SALARY_CARD.CHG_USER IS '';
COMMENT ON COLUMN BARS.ERR$_CM_SALARY_CARD.KF IS '';



PROMPT *** Create  grants  ERR$_CM_SALARY_CARD ***
grant SELECT                                                                 on ERR$_CM_SALARY_CARD to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_CM_SALARY_CARD to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_CM_SALARY_CARD.sql =========*** E
PROMPT ===================================================================================== 
