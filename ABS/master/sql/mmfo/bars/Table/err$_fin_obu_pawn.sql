

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_FIN_OBU_PAWN.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_FIN_OBU_PAWN ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_FIN_OBU_PAWN ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_FIN_OBU_PAWN 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ID VARCHAR2(4000), 
	ND VARCHAR2(4000), 
	RNK VARCHAR2(4000), 
	ACC VARCHAR2(4000), 
	PAWN VARCHAR2(4000), 
	KV VARCHAR2(4000), 
	S_SPV VARCHAR2(4000), 
	P_ZAST VARCHAR2(4000), 
	DATP VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_FIN_OBU_PAWN ***
 exec bpa.alter_policies('ERR$_FIN_OBU_PAWN');


COMMENT ON TABLE BARS.ERR$_FIN_OBU_PAWN IS 'DML Error Logging table for "FIN_OBU_PAWN"';
COMMENT ON COLUMN BARS.ERR$_FIN_OBU_PAWN.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_OBU_PAWN.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_OBU_PAWN.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_OBU_PAWN.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_OBU_PAWN.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_OBU_PAWN.ID IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_OBU_PAWN.ND IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_OBU_PAWN.RNK IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_OBU_PAWN.ACC IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_OBU_PAWN.PAWN IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_OBU_PAWN.KV IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_OBU_PAWN.S_SPV IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_OBU_PAWN.P_ZAST IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_OBU_PAWN.DATP IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_OBU_PAWN.KF IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_FIN_OBU_PAWN.sql =========*** End
PROMPT ===================================================================================== 
