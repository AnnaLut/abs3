

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_PAWN_ACC.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_PAWN_ACC ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_PAWN_ACC ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_PAWN_ACC 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ACC VARCHAR2(4000), 
	PAWN VARCHAR2(4000), 
	MPAWN VARCHAR2(4000), 
	NREE VARCHAR2(4000), 
	IDZ VARCHAR2(4000), 
	NDZ VARCHAR2(4000), 
	DEPOSIT_ID VARCHAR2(4000), 
	KF VARCHAR2(4000), 
	SV VARCHAR2(4000), 
	CC_IDZ VARCHAR2(4000), 
	SDATZ VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_PAWN_ACC ***
 exec bpa.alter_policies('ERR$_PAWN_ACC');


COMMENT ON TABLE BARS.ERR$_PAWN_ACC IS 'DML Error Logging table for "PAWN_ACC"';
COMMENT ON COLUMN BARS.ERR$_PAWN_ACC.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_PAWN_ACC.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_PAWN_ACC.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_PAWN_ACC.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_PAWN_ACC.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_PAWN_ACC.ACC IS '';
COMMENT ON COLUMN BARS.ERR$_PAWN_ACC.PAWN IS '';
COMMENT ON COLUMN BARS.ERR$_PAWN_ACC.MPAWN IS '';
COMMENT ON COLUMN BARS.ERR$_PAWN_ACC.NREE IS '';
COMMENT ON COLUMN BARS.ERR$_PAWN_ACC.IDZ IS '';
COMMENT ON COLUMN BARS.ERR$_PAWN_ACC.NDZ IS '';
COMMENT ON COLUMN BARS.ERR$_PAWN_ACC.DEPOSIT_ID IS '';
COMMENT ON COLUMN BARS.ERR$_PAWN_ACC.KF IS '';
COMMENT ON COLUMN BARS.ERR$_PAWN_ACC.SV IS '';
COMMENT ON COLUMN BARS.ERR$_PAWN_ACC.CC_IDZ IS '';
COMMENT ON COLUMN BARS.ERR$_PAWN_ACC.SDATZ IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_PAWN_ACC.sql =========*** End ***
PROMPT ===================================================================================== 
