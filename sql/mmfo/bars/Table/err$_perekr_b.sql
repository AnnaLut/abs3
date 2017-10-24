

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_PEREKR_B.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_PEREKR_B ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_PEREKR_B ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_PEREKR_B 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	IDS VARCHAR2(4000), 
	TT VARCHAR2(4000), 
	MFOB VARCHAR2(4000), 
	NLSB VARCHAR2(4000), 
	POLU VARCHAR2(4000), 
	NAZN VARCHAR2(4000), 
	KV VARCHAR2(4000), 
	S VARCHAR2(4000), 
	OKPO VARCHAR2(4000), 
	IDR VARCHAR2(4000), 
	KOEF VARCHAR2(4000), 
	VOB VARCHAR2(4000), 
	ID VARCHAR2(4000), 
	FORMULA VARCHAR2(4000), 
	KOD VARCHAR2(4000), 
	ORD VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_PEREKR_B ***
 exec bpa.alter_policies('ERR$_PEREKR_B');


COMMENT ON TABLE BARS.ERR$_PEREKR_B IS 'DML Error Logging table for "PEREKR_B"';
COMMENT ON COLUMN BARS.ERR$_PEREKR_B.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_PEREKR_B.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_PEREKR_B.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_PEREKR_B.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_PEREKR_B.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_PEREKR_B.IDS IS '';
COMMENT ON COLUMN BARS.ERR$_PEREKR_B.TT IS '';
COMMENT ON COLUMN BARS.ERR$_PEREKR_B.MFOB IS '';
COMMENT ON COLUMN BARS.ERR$_PEREKR_B.NLSB IS '';
COMMENT ON COLUMN BARS.ERR$_PEREKR_B.POLU IS '';
COMMENT ON COLUMN BARS.ERR$_PEREKR_B.NAZN IS '';
COMMENT ON COLUMN BARS.ERR$_PEREKR_B.KV IS '';
COMMENT ON COLUMN BARS.ERR$_PEREKR_B.S IS '';
COMMENT ON COLUMN BARS.ERR$_PEREKR_B.OKPO IS '';
COMMENT ON COLUMN BARS.ERR$_PEREKR_B.IDR IS '';
COMMENT ON COLUMN BARS.ERR$_PEREKR_B.KOEF IS '';
COMMENT ON COLUMN BARS.ERR$_PEREKR_B.VOB IS '';
COMMENT ON COLUMN BARS.ERR$_PEREKR_B.ID IS '';
COMMENT ON COLUMN BARS.ERR$_PEREKR_B.FORMULA IS '';
COMMENT ON COLUMN BARS.ERR$_PEREKR_B.KOD IS '';
COMMENT ON COLUMN BARS.ERR$_PEREKR_B.ORD IS '';
COMMENT ON COLUMN BARS.ERR$_PEREKR_B.KF IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_PEREKR_B.sql =========*** End ***
PROMPT ===================================================================================== 
