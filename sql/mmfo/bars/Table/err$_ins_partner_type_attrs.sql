

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_INS_PARTNER_TYPE_ATTRS.sql ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_INS_PARTNER_TYPE_ATTRS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_INS_PARTNER_TYPE_ATTRS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_INS_PARTNER_TYPE_ATTRS 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ID VARCHAR2(4000), 
	ATTR_ID VARCHAR2(4000), 
	PARTNER_ID VARCHAR2(4000), 
	TYPE_ID VARCHAR2(4000), 
	IS_REQUIRED VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_INS_PARTNER_TYPE_ATTRS ***
 exec bpa.alter_policies('ERR$_INS_PARTNER_TYPE_ATTRS');


COMMENT ON TABLE BARS.ERR$_INS_PARTNER_TYPE_ATTRS IS 'DML Error Logging table for "INS_PARTNER_TYPE_ATTRS"';
COMMENT ON COLUMN BARS.ERR$_INS_PARTNER_TYPE_ATTRS.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_INS_PARTNER_TYPE_ATTRS.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_INS_PARTNER_TYPE_ATTRS.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_INS_PARTNER_TYPE_ATTRS.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_INS_PARTNER_TYPE_ATTRS.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_INS_PARTNER_TYPE_ATTRS.ID IS '';
COMMENT ON COLUMN BARS.ERR$_INS_PARTNER_TYPE_ATTRS.ATTR_ID IS '';
COMMENT ON COLUMN BARS.ERR$_INS_PARTNER_TYPE_ATTRS.PARTNER_ID IS '';
COMMENT ON COLUMN BARS.ERR$_INS_PARTNER_TYPE_ATTRS.TYPE_ID IS '';
COMMENT ON COLUMN BARS.ERR$_INS_PARTNER_TYPE_ATTRS.IS_REQUIRED IS '';



PROMPT *** Create  grants  ERR$_INS_PARTNER_TYPE_ATTRS ***
grant SELECT                                                                 on ERR$_INS_PARTNER_TYPE_ATTRS to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_INS_PARTNER_TYPE_ATTRS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_INS_PARTNER_TYPE_ATTRS.sql ======
PROMPT ===================================================================================== 
