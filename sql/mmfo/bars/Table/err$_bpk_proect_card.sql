

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_BPK_PROECT_CARD.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_BPK_PROECT_CARD ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_BPK_PROECT_CARD ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_BPK_PROECT_CARD 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	OKPO VARCHAR2(4000), 
	OKPO_N VARCHAR2(4000), 
	CARD_CODE VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_BPK_PROECT_CARD ***
 exec bpa.alter_policies('ERR$_BPK_PROECT_CARD');


COMMENT ON TABLE BARS.ERR$_BPK_PROECT_CARD IS 'DML Error Logging table for "BPK_PROECT_CARD"';
COMMENT ON COLUMN BARS.ERR$_BPK_PROECT_CARD.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_BPK_PROECT_CARD.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_BPK_PROECT_CARD.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_BPK_PROECT_CARD.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_BPK_PROECT_CARD.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_BPK_PROECT_CARD.OKPO IS '';
COMMENT ON COLUMN BARS.ERR$_BPK_PROECT_CARD.OKPO_N IS '';
COMMENT ON COLUMN BARS.ERR$_BPK_PROECT_CARD.CARD_CODE IS '';
COMMENT ON COLUMN BARS.ERR$_BPK_PROECT_CARD.KF IS '';



PROMPT *** Create  grants  ERR$_BPK_PROECT_CARD ***
grant SELECT                                                                 on ERR$_BPK_PROECT_CARD to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_BPK_PROECT_CARD to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_BPK_PROECT_CARD.sql =========*** 
PROMPT ===================================================================================== 
