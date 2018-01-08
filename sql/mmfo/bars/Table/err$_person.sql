

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_PERSON.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_PERSON ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_PERSON ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_PERSON 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	RNK VARCHAR2(4000), 
	SEX VARCHAR2(4000), 
	PASSP VARCHAR2(4000), 
	SER VARCHAR2(4000), 
	NUMDOC VARCHAR2(4000), 
	PDATE VARCHAR2(4000), 
	ORGAN VARCHAR2(4000), 
	BDAY VARCHAR2(4000), 
	BPLACE VARCHAR2(4000), 
	TELD VARCHAR2(4000), 
	TELW VARCHAR2(4000), 
	CELLPHONE VARCHAR2(4000), 
	BDOV VARCHAR2(4000), 
	EDOV VARCHAR2(4000), 
	DATE_PHOTO VARCHAR2(4000), 
	DOV VARCHAR2(4000), 
	CELLPHONE_CONFIRMED VARCHAR2(4000), 
	ACTUAL_DATE VARCHAR2(4000), 
	EDDR_ID VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_PERSON ***
 exec bpa.alter_policies('ERR$_PERSON');


COMMENT ON TABLE BARS.ERR$_PERSON IS 'DML Error Logging table for "PERSON"';
COMMENT ON COLUMN BARS.ERR$_PERSON.PDATE IS '';
COMMENT ON COLUMN BARS.ERR$_PERSON.ORGAN IS '';
COMMENT ON COLUMN BARS.ERR$_PERSON.BDAY IS '';
COMMENT ON COLUMN BARS.ERR$_PERSON.BPLACE IS '';
COMMENT ON COLUMN BARS.ERR$_PERSON.TELD IS '';
COMMENT ON COLUMN BARS.ERR$_PERSON.TELW IS '';
COMMENT ON COLUMN BARS.ERR$_PERSON.CELLPHONE IS '';
COMMENT ON COLUMN BARS.ERR$_PERSON.BDOV IS '';
COMMENT ON COLUMN BARS.ERR$_PERSON.EDOV IS '';
COMMENT ON COLUMN BARS.ERR$_PERSON.DATE_PHOTO IS '';
COMMENT ON COLUMN BARS.ERR$_PERSON.DOV IS '';
COMMENT ON COLUMN BARS.ERR$_PERSON.CELLPHONE_CONFIRMED IS '';
COMMENT ON COLUMN BARS.ERR$_PERSON.ACTUAL_DATE IS '';
COMMENT ON COLUMN BARS.ERR$_PERSON.EDDR_ID IS '';
COMMENT ON COLUMN BARS.ERR$_PERSON.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_PERSON.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_PERSON.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_PERSON.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_PERSON.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_PERSON.RNK IS '';
COMMENT ON COLUMN BARS.ERR$_PERSON.SEX IS '';
COMMENT ON COLUMN BARS.ERR$_PERSON.PASSP IS '';
COMMENT ON COLUMN BARS.ERR$_PERSON.SER IS '';
COMMENT ON COLUMN BARS.ERR$_PERSON.NUMDOC IS '';



PROMPT *** Create  grants  ERR$_PERSON ***
grant SELECT                                                                 on ERR$_PERSON     to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_PERSON     to BARS_DM;
grant SELECT                                                                 on ERR$_PERSON     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_PERSON.sql =========*** End *** =
PROMPT ===================================================================================== 
