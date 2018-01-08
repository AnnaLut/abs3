

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_SPOT.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_SPOT ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_SPOT ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_SPOT 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	KV VARCHAR2(4000), 
	VDATE VARCHAR2(4000), 
	ACC VARCHAR2(4000), 
	RATE_K VARCHAR2(4000), 
	RATE_P VARCHAR2(4000), 
	BRANCH VARCHAR2(4000), 
	RATE_SPOT VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_SPOT ***
 exec bpa.alter_policies('ERR$_SPOT');


COMMENT ON TABLE BARS.ERR$_SPOT IS 'DML Error Logging table for "SPOT"';
COMMENT ON COLUMN BARS.ERR$_SPOT.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_SPOT.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_SPOT.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_SPOT.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_SPOT.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_SPOT.KV IS '';
COMMENT ON COLUMN BARS.ERR$_SPOT.VDATE IS '';
COMMENT ON COLUMN BARS.ERR$_SPOT.ACC IS '';
COMMENT ON COLUMN BARS.ERR$_SPOT.RATE_K IS '';
COMMENT ON COLUMN BARS.ERR$_SPOT.RATE_P IS '';
COMMENT ON COLUMN BARS.ERR$_SPOT.BRANCH IS '';
COMMENT ON COLUMN BARS.ERR$_SPOT.RATE_SPOT IS '';



PROMPT *** Create  grants  ERR$_SPOT ***
grant SELECT                                                                 on ERR$_SPOT       to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_SPOT       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_SPOT.sql =========*** End *** ===
PROMPT ===================================================================================== 
