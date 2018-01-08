

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_ALIEN.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_ALIEN ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_ALIEN ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_ALIEN 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	MFO VARCHAR2(4000), 
	NLS VARCHAR2(4000), 
	NLSALT VARCHAR2(4000), 
	KV VARCHAR2(4000), 
	OKPO VARCHAR2(4000), 
	NAME VARCHAR2(4000), 
	CRISK VARCHAR2(4000), 
	NOTESEC RAW(2000), 
	ID VARCHAR2(4000), 
	REC_ID VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_ALIEN ***
 exec bpa.alter_policies('ERR$_ALIEN');


COMMENT ON TABLE BARS.ERR$_ALIEN IS 'DML Error Logging table for "ALIEN"';
COMMENT ON COLUMN BARS.ERR$_ALIEN.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_ALIEN.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_ALIEN.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_ALIEN.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_ALIEN.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_ALIEN.MFO IS '';
COMMENT ON COLUMN BARS.ERR$_ALIEN.NLS IS '';
COMMENT ON COLUMN BARS.ERR$_ALIEN.NLSALT IS '';
COMMENT ON COLUMN BARS.ERR$_ALIEN.KV IS '';
COMMENT ON COLUMN BARS.ERR$_ALIEN.OKPO IS '';
COMMENT ON COLUMN BARS.ERR$_ALIEN.NAME IS '';
COMMENT ON COLUMN BARS.ERR$_ALIEN.CRISK IS '';
COMMENT ON COLUMN BARS.ERR$_ALIEN.NOTESEC IS '';
COMMENT ON COLUMN BARS.ERR$_ALIEN.ID IS '';
COMMENT ON COLUMN BARS.ERR$_ALIEN.REC_ID IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_ALIEN.sql =========*** End *** ==
PROMPT ===================================================================================== 
