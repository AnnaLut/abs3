

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_CP_TICKET.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_CP_TICKET ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_CP_TICKET ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_CP_TICKET 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	REF VARCHAR2(4000), 
	KOL VARCHAR2(4000), 
	VIDDN VARCHAR2(4000), 
	NTIK VARCHAR2(4000), 
	DAT_UG VARCHAR2(4000), 
	DAT_OPL VARCHAR2(4000), 
	DAT_ROZ VARCHAR2(4000), 
	DAT_KOM VARCHAR2(4000), 
	MFOB VARCHAR2(4000), 
	OKPOB VARCHAR2(4000), 
	NLSB VARCHAR2(4000), 
	NBB VARCHAR2(4000), 
	BICB VARCHAR2(4000), 
	MFOB_ VARCHAR2(4000), 
	OKPOB_ VARCHAR2(4000), 
	NLSB_ VARCHAR2(4000), 
	NBB_ VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_CP_TICKET ***
 exec bpa.alter_policies('ERR$_CP_TICKET');


COMMENT ON TABLE BARS.ERR$_CP_TICKET IS 'DML Error Logging table for "CP_TICKET"';
COMMENT ON COLUMN BARS.ERR$_CP_TICKET.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_CP_TICKET.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CP_TICKET.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_CP_TICKET.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_CP_TICKET.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CP_TICKET.REF IS '';
COMMENT ON COLUMN BARS.ERR$_CP_TICKET.KOL IS '';
COMMENT ON COLUMN BARS.ERR$_CP_TICKET.VIDDN IS '';
COMMENT ON COLUMN BARS.ERR$_CP_TICKET.NTIK IS '';
COMMENT ON COLUMN BARS.ERR$_CP_TICKET.DAT_UG IS '';
COMMENT ON COLUMN BARS.ERR$_CP_TICKET.DAT_OPL IS '';
COMMENT ON COLUMN BARS.ERR$_CP_TICKET.DAT_ROZ IS '';
COMMENT ON COLUMN BARS.ERR$_CP_TICKET.DAT_KOM IS '';
COMMENT ON COLUMN BARS.ERR$_CP_TICKET.MFOB IS '';
COMMENT ON COLUMN BARS.ERR$_CP_TICKET.OKPOB IS '';
COMMENT ON COLUMN BARS.ERR$_CP_TICKET.NLSB IS '';
COMMENT ON COLUMN BARS.ERR$_CP_TICKET.NBB IS '';
COMMENT ON COLUMN BARS.ERR$_CP_TICKET.BICB IS '';
COMMENT ON COLUMN BARS.ERR$_CP_TICKET.MFOB_ IS '';
COMMENT ON COLUMN BARS.ERR$_CP_TICKET.OKPOB_ IS '';
COMMENT ON COLUMN BARS.ERR$_CP_TICKET.NLSB_ IS '';
COMMENT ON COLUMN BARS.ERR$_CP_TICKET.NBB_ IS '';



PROMPT *** Create  grants  ERR$_CP_TICKET ***
grant SELECT                                                                 on ERR$_CP_TICKET  to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_CP_TICKET  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_CP_TICKET.sql =========*** End **
PROMPT ===================================================================================== 
