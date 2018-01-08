

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_TMP_IREP.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_TMP_IREP ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_TMP_IREP ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_TMP_IREP 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	KODP VARCHAR2(4000), 
	DATF VARCHAR2(4000), 
	KODF VARCHAR2(4000), 
	ZNAP VARCHAR2(4000), 
	NBUC VARCHAR2(4000), 
	KF VARCHAR2(4000), 
	ERR_MSG VARCHAR2(4000), 
	FL_MOD VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_TMP_IREP ***
 exec bpa.alter_policies('ERR$_TMP_IREP');


COMMENT ON TABLE BARS.ERR$_TMP_IREP IS 'DML Error Logging table for "TMP_IREP"';
COMMENT ON COLUMN BARS.ERR$_TMP_IREP.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_IREP.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_IREP.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_IREP.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_IREP.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_IREP.KODP IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_IREP.DATF IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_IREP.KODF IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_IREP.ZNAP IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_IREP.NBUC IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_IREP.KF IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_IREP.ERR_MSG IS '';
COMMENT ON COLUMN BARS.ERR$_TMP_IREP.FL_MOD IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_TMP_IREP.sql =========*** End ***
PROMPT ===================================================================================== 
