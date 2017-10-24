

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_INT_RATN_ARC.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_INT_RATN_ARC ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_INT_RATN_ARC ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_INT_RATN_ARC 
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
	FDAT VARCHAR2(4000), 
	VID VARCHAR2(4000), 
	IDUPD VARCHAR2(4000), 
	KF VARCHAR2(4000), 
	EFFECTDATE VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_INT_RATN_ARC ***
 exec bpa.alter_policies('ERR$_INT_RATN_ARC');


COMMENT ON TABLE BARS.ERR$_INT_RATN_ARC IS 'DML Error Logging table for "INT_RATN_ARC"';
COMMENT ON COLUMN BARS.ERR$_INT_RATN_ARC.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_INT_RATN_ARC.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_INT_RATN_ARC.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_INT_RATN_ARC.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_INT_RATN_ARC.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_INT_RATN_ARC.ACC IS '';
COMMENT ON COLUMN BARS.ERR$_INT_RATN_ARC.ID IS '';
COMMENT ON COLUMN BARS.ERR$_INT_RATN_ARC.BDAT IS '';
COMMENT ON COLUMN BARS.ERR$_INT_RATN_ARC.IR IS '';
COMMENT ON COLUMN BARS.ERR$_INT_RATN_ARC.BR IS '';
COMMENT ON COLUMN BARS.ERR$_INT_RATN_ARC.OP IS '';
COMMENT ON COLUMN BARS.ERR$_INT_RATN_ARC.IDU IS '';
COMMENT ON COLUMN BARS.ERR$_INT_RATN_ARC.FDAT IS '';
COMMENT ON COLUMN BARS.ERR$_INT_RATN_ARC.VID IS '';
COMMENT ON COLUMN BARS.ERR$_INT_RATN_ARC.IDUPD IS '';
COMMENT ON COLUMN BARS.ERR$_INT_RATN_ARC.KF IS '';
COMMENT ON COLUMN BARS.ERR$_INT_RATN_ARC.EFFECTDATE IS '';



PROMPT *** Create  grants  ERR$_INT_RATN_ARC ***
grant SELECT                                                                 on ERR$_INT_RATN_ARC to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_INT_RATN_ARC.sql =========*** End
PROMPT ===================================================================================== 
