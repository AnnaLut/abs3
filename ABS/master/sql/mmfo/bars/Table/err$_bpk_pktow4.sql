

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_BPK_PKTOW4.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_BPK_PKTOW4 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_BPK_PKTOW4 ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_BPK_PKTOW4 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ID VARCHAR2(4000), 
	ND VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_BPK_PKTOW4 ***
 exec bpa.alter_policies('ERR$_BPK_PKTOW4');


COMMENT ON TABLE BARS.ERR$_BPK_PKTOW4 IS 'DML Error Logging table for "BPK_PKTOW4"';
COMMENT ON COLUMN BARS.ERR$_BPK_PKTOW4.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_BPK_PKTOW4.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_BPK_PKTOW4.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_BPK_PKTOW4.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_BPK_PKTOW4.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_BPK_PKTOW4.ID IS '';
COMMENT ON COLUMN BARS.ERR$_BPK_PKTOW4.ND IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_BPK_PKTOW4.sql =========*** End *
PROMPT ===================================================================================== 
