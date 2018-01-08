

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_VOB.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_VOB ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_VOB ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_VOB 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	VOB VARCHAR2(4000), 
	NAME VARCHAR2(4000), 
	FLV VARCHAR2(4000), 
	REP_PREFIX VARCHAR2(4000), 
	OVRD4IPMT VARCHAR2(4000), 
	KDOC VARCHAR2(4000), 
	REP_PREFIX_FR VARCHAR2(4000), 
	KOD VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_VOB ***
 exec bpa.alter_policies('ERR$_VOB');


COMMENT ON TABLE BARS.ERR$_VOB IS 'DML Error Logging table for "VOB"';
COMMENT ON COLUMN BARS.ERR$_VOB.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_VOB.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_VOB.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_VOB.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_VOB.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_VOB.VOB IS '';
COMMENT ON COLUMN BARS.ERR$_VOB.NAME IS '';
COMMENT ON COLUMN BARS.ERR$_VOB.FLV IS '';
COMMENT ON COLUMN BARS.ERR$_VOB.REP_PREFIX IS '';
COMMENT ON COLUMN BARS.ERR$_VOB.OVRD4IPMT IS '';
COMMENT ON COLUMN BARS.ERR$_VOB.KDOC IS '';
COMMENT ON COLUMN BARS.ERR$_VOB.REP_PREFIX_FR IS '';
COMMENT ON COLUMN BARS.ERR$_VOB.KOD IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_VOB.sql =========*** End *** ====
PROMPT ===================================================================================== 
