

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_CM_CLIENT_QUE_ARC.sql =========**
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_CM_CLIENT_QUE_ARC ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_CM_CLIENT_QUE_ARC ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_CM_CLIENT_QUE_ARC 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	IDUPD VARCHAR2(4000), 
	DONEBY VARCHAR2(4000), 
	CHGDATE VARCHAR2(4000), 
	CHGACTION VARCHAR2(4000), 
	ID VARCHAR2(4000), 
	DATEIN VARCHAR2(4000), 
	DATEMOD VARCHAR2(4000), 
	OPER_TYPE VARCHAR2(4000), 
	OPER_STATUS VARCHAR2(4000), 
	RESP_TXT VARCHAR2(4000), 
	BRANCH VARCHAR2(4000), 
	OPENDATE VARCHAR2(4000), 
	CLIENTTYPE VARCHAR2(4000), 
	TAXPAYERIDENTIFIER VARCHAR2(4000), 
	SHORTNAME VARCHAR2(4000), 
	FIRSTNAME VARCHAR2(4000), 
	LASTNAME VARCHAR2(4000), 
	MIDDLENAME VARCHAR2(4000), 
	ENGFIRSTNAME VARCHAR2(4000), 
	ENGLASTNAME VARCHAR2(4000), 
	COUNTRY VARCHAR2(4000), 
	RESIDENT VARCHAR2(4000), 
	WORK VARCHAR2(4000), 
	OFFICE VARCHAR2(4000), 
	DATE_W VARCHAR2(4000), 
	ISVIP VARCHAR2(4000), 
	K060 VARCHAR2(4000), 
	COMPANYNAME VARCHAR2(4000), 
	SHORTCOMPANYNAME VARCHAR2(4000), 
	PERSONALISATIONNAME VARCHAR2(4000), 
	KLAS_CLIENT_ID VARCHAR2(4000), 
	CONTACTPERSON VARCHAR2(4000), 
	BIRTHDATE VARCHAR2(4000), 
	BIRTHPLACE VARCHAR2(4000), 
	GENDER VARCHAR2(4000), 
	ADDR1_CITYNAME VARCHAR2(4000), 
	ADDR1_PCODE VARCHAR2(4000), 
	ADDR1_DOMAIN VARCHAR2(4000), 
	ADDR1_REGION VARCHAR2(4000), 
	ADDR1_STREET VARCHAR2(4000), 
	ADDR2_CITYNAME VARCHAR2(4000), 
	ADDR2_PCODE VARCHAR2(4000), 
	ADDR2_DOMAIN VARCHAR2(4000), 
	ADDR2_REGION VARCHAR2(4000), 
	ADDR2_STREET VARCHAR2(4000), 
	EMAIL VARCHAR2(4000), 
	PHONENUMBER VARCHAR2(4000), 
	PHONENUMBER_MOB VARCHAR2(4000), 
	PHONENUMBER_DOD VARCHAR2(4000), 
	FAX VARCHAR2(4000), 
	TYPEDOC VARCHAR2(4000), 
	PASPNUM VARCHAR2(4000), 
	PASPSERIES VARCHAR2(4000), 
	PASPDATE VARCHAR2(4000), 
	PASPISSUER VARCHAR2(4000), 
	FOREIGNPASPNUM VARCHAR2(4000), 
	FOREIGNPASPSERIES VARCHAR2(4000), 
	FOREIGNPASPDATE VARCHAR2(4000), 
	FOREIGNPASPENDDATE VARCHAR2(4000), 
	FOREIGNPASPISSUER VARCHAR2(4000), 
	CONTRACTNUMBER VARCHAR2(4000), 
	PRODUCTCODE VARCHAR2(4000), 
	CARD_TYPE VARCHAR2(4000), 
	CNTM VARCHAR2(4000), 
	PIND VARCHAR2(4000), 
	OKPO_SYSORG VARCHAR2(4000), 
	KOD_SYSORG VARCHAR2(4000), 
	REGNUMBERCLIENT VARCHAR2(4000), 
	REGNUMBEROWNER VARCHAR2(4000), 
	ACC VARCHAR2(4000), 
	RNK VARCHAR2(4000), 
	CL_RNK VARCHAR2(4000), 
	CL_DT_ISS VARCHAR2(4000), 
	CARD_BR_ISS VARCHAR2(4000), 
	CARD_ADDR_ISS VARCHAR2(4000), 
	DELIVERY_BR VARCHAR2(4000), 
	KK_SECRET_WORD VARCHAR2(4000), 
	KK_FLAG VARCHAR2(4000), 
	KK_REGTYPE VARCHAR2(4000), 
	KK_CITYAREAID VARCHAR2(4000), 
	KK_STREETTYPEID VARCHAR2(4000), 
	KK_STREETNAME VARCHAR2(4000), 
	KK_APARTMENT VARCHAR2(4000), 
	KK_POSTCODE VARCHAR2(4000), 
	ADD_INFO VARCHAR2(4000), 
	IDCARDENDDATE VARCHAR2(4000), 
	EDDR_ID VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_CM_CLIENT_QUE_ARC ***
 exec bpa.alter_policies('ERR$_CM_CLIENT_QUE_ARC');


COMMENT ON TABLE BARS.ERR$_CM_CLIENT_QUE_ARC IS 'DML Error Logging table for "CM_CLIENT_QUE_ARC"';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.FOREIGNPASPISSUER IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.CONTRACTNUMBER IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.PRODUCTCODE IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.CARD_TYPE IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.CNTM IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.PIND IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.OKPO_SYSORG IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.KOD_SYSORG IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.REGNUMBERCLIENT IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.REGNUMBEROWNER IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.ACC IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.RNK IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.CL_RNK IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.CL_DT_ISS IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.CARD_BR_ISS IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.CARD_ADDR_ISS IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.DELIVERY_BR IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.KK_SECRET_WORD IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.KK_FLAG IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.KK_REGTYPE IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.KK_CITYAREAID IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.KK_STREETTYPEID IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.KK_STREETNAME IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.KK_APARTMENT IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.KK_POSTCODE IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.ADD_INFO IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.IDCARDENDDATE IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.EDDR_ID IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.KF IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.FOREIGNPASPENDDATE IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.PASPNUM IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.PASPSERIES IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.PASPDATE IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.PASPISSUER IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.FOREIGNPASPNUM IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.FOREIGNPASPSERIES IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.FOREIGNPASPDATE IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.IDUPD IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.DONEBY IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.CHGDATE IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.CHGACTION IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.ID IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.DATEIN IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.DATEMOD IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.OPER_TYPE IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.OPER_STATUS IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.RESP_TXT IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.BRANCH IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.OPENDATE IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.CLIENTTYPE IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.TAXPAYERIDENTIFIER IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.SHORTNAME IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.FIRSTNAME IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.LASTNAME IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.MIDDLENAME IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.ENGFIRSTNAME IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.ENGLASTNAME IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.COUNTRY IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.RESIDENT IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.WORK IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.OFFICE IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.DATE_W IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.ISVIP IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.K060 IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.COMPANYNAME IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.SHORTCOMPANYNAME IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.PERSONALISATIONNAME IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.KLAS_CLIENT_ID IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.CONTACTPERSON IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.BIRTHDATE IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.BIRTHPLACE IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.GENDER IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.ADDR1_CITYNAME IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.ADDR1_PCODE IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.ADDR1_DOMAIN IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.ADDR1_REGION IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.ADDR1_STREET IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.ADDR2_CITYNAME IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.ADDR2_PCODE IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.ADDR2_DOMAIN IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.ADDR2_REGION IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.ADDR2_STREET IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.EMAIL IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.PHONENUMBER IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.PHONENUMBER_MOB IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.PHONENUMBER_DOD IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.FAX IS '';
COMMENT ON COLUMN BARS.ERR$_CM_CLIENT_QUE_ARC.TYPEDOC IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_CM_CLIENT_QUE_ARC.sql =========**
PROMPT ===================================================================================== 
