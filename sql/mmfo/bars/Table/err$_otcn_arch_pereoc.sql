

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_OTCN_ARCH_PEREOC.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_OTCN_ARCH_PEREOC ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_OTCN_ARCH_PEREOC ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_OTCN_ARCH_PEREOC 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	DATF VARCHAR2(4000), 
	KODF VARCHAR2(4000), 
	ACC VARCHAR2(4000), 
	NLS VARCHAR2(4000), 
	KV VARCHAR2(4000), 
	ODATE VARCHAR2(4000), 
	KODP VARCHAR2(4000), 
	ZNAP VARCHAR2(4000), 
	SKOR VARCHAR2(4000), 
	COMM VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_OTCN_ARCH_PEREOC ***
 exec bpa.alter_policies('ERR$_OTCN_ARCH_PEREOC');


COMMENT ON TABLE BARS.ERR$_OTCN_ARCH_PEREOC IS 'DML Error Logging table for "OTCN_ARCH_PEREOC"';
COMMENT ON COLUMN BARS.ERR$_OTCN_ARCH_PEREOC.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_ARCH_PEREOC.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_ARCH_PEREOC.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_ARCH_PEREOC.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_ARCH_PEREOC.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_ARCH_PEREOC.DATF IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_ARCH_PEREOC.KODF IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_ARCH_PEREOC.ACC IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_ARCH_PEREOC.NLS IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_ARCH_PEREOC.KV IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_ARCH_PEREOC.ODATE IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_ARCH_PEREOC.KODP IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_ARCH_PEREOC.ZNAP IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_ARCH_PEREOC.SKOR IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_ARCH_PEREOC.COMM IS '';
COMMENT ON COLUMN BARS.ERR$_OTCN_ARCH_PEREOC.KF IS '';



PROMPT *** Create  grants  ERR$_OTCN_ARCH_PEREOC ***
grant SELECT                                                                 on ERR$_OTCN_ARCH_PEREOC to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_OTCN_ARCH_PEREOC to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_OTCN_ARCH_PEREOC.sql =========***
PROMPT ===================================================================================== 
