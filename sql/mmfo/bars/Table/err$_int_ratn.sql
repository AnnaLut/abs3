

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_INT_RATN.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_INT_RATN ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_INT_RATN ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_INT_RATN 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ACC VARCHAR2(4000), 
	ID VARCHAR2(4000), 
	BDAT VARCHAR2(4000), 
	IR VARCHAR2(4000), 
	BR VARCHAR2(4000), 
	OP VARCHAR2(4000), 
	IDU VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_INT_RATN ***
 exec bpa.alter_policies('ERR$_INT_RATN');


COMMENT ON TABLE BARS.ERR$_INT_RATN IS 'DML Error Logging table for "INT_RATN"';
COMMENT ON COLUMN BARS.ERR$_INT_RATN.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_INT_RATN.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_INT_RATN.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_INT_RATN.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_INT_RATN.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_INT_RATN.ACC IS '';
COMMENT ON COLUMN BARS.ERR$_INT_RATN.ID IS '';
COMMENT ON COLUMN BARS.ERR$_INT_RATN.BDAT IS '';
COMMENT ON COLUMN BARS.ERR$_INT_RATN.IR IS '';
COMMENT ON COLUMN BARS.ERR$_INT_RATN.BR IS '';
COMMENT ON COLUMN BARS.ERR$_INT_RATN.OP IS '';
COMMENT ON COLUMN BARS.ERR$_INT_RATN.IDU IS '';
COMMENT ON COLUMN BARS.ERR$_INT_RATN.KF IS '';



PROMPT *** Create  grants  ERR$_INT_RATN ***
grant SELECT                                                                 on ERR$_INT_RATN   to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on ERR$_INT_RATN   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ERR$_INT_RATN   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_INT_RATN.sql =========*** End ***
PROMPT ===================================================================================== 
