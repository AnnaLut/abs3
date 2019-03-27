

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_RNKP_KOD.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_RNKP_KOD ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_RNKP_KOD ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_RNKP_KOD 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	RNK VARCHAR2(4000), 
	KODK VARCHAR2(4000), 
	KODU VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_RNKP_KOD ***
 exec bpa.alter_policies('ERR$_RNKP_KOD');


COMMENT ON TABLE BARS.ERR$_RNKP_KOD IS 'DML Error Logging table for "RNKP_KOD"';
COMMENT ON COLUMN BARS.ERR$_RNKP_KOD.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_RNKP_KOD.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_RNKP_KOD.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_RNKP_KOD.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_RNKP_KOD.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_RNKP_KOD.RNK IS '';
COMMENT ON COLUMN BARS.ERR$_RNKP_KOD.KODK IS '';
COMMENT ON COLUMN BARS.ERR$_RNKP_KOD.KODU IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_RNKP_KOD.sql =========*** End ***
PROMPT ===================================================================================== 