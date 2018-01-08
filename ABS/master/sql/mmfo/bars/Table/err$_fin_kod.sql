

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_FIN_KOD.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_FIN_KOD ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_FIN_KOD ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_FIN_KOD 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	NAME VARCHAR2(4000), 
	ORD VARCHAR2(4000), 
	KOD VARCHAR2(4000), 
	IDF VARCHAR2(4000), 
	FM VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_FIN_KOD ***
 exec bpa.alter_policies('ERR$_FIN_KOD');


COMMENT ON TABLE BARS.ERR$_FIN_KOD IS 'DML Error Logging table for "FIN_KOD"';
COMMENT ON COLUMN BARS.ERR$_FIN_KOD.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_KOD.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_KOD.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_KOD.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_KOD.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_KOD.NAME IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_KOD.ORD IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_KOD.KOD IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_KOD.IDF IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_KOD.FM IS '';



PROMPT *** Create  grants  ERR$_FIN_KOD ***
grant SELECT                                                                 on ERR$_FIN_KOD    to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_FIN_KOD    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_FIN_KOD.sql =========*** End *** 
PROMPT ===================================================================================== 
