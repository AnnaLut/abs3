

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_CIN_KOM1.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_CIN_KOM1 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_CIN_KOM1 ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_CIN_KOM1 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	RNK VARCHAR2(4000), 
	NMK VARCHAR2(4000), 
	NLS_2909 VARCHAR2(4000), 
	ID VARCHAR2(4000), 
	NAME VARCHAR2(4000), 
	MFO VARCHAR2(4000), 
	NLS VARCHAR2(4000), 
	REF VARCHAR2(4000), 
	S VARCHAR2(4000), 
	KA2 VARCHAR2(4000), 
	KA1 VARCHAR2(4000), 
	KB2 VARCHAR2(4000), 
	KB1 VARCHAR2(4000), 
	DAT1 VARCHAR2(4000), 
	DAT2 VARCHAR2(4000), 
	VDAT VARCHAR2(4000), 
	KC0 VARCHAR2(4000), 
	A2 VARCHAR2(4000), 
	B1 VARCHAR2(4000), 
	B2 VARCHAR2(4000), 
	C0 VARCHAR2(4000), 
	NLSR VARCHAR2(4000), 
	REC VARCHAR2(4000), 
	SR VARCHAR2(4000), 
	BRANCH VARCHAR2(4000), 
	SB1_MIN VARCHAR2(4000), 
	B3 VARCHAR2(4000), 
	KB3 VARCHAR2(4000), 
	S3 VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_CIN_KOM1 ***
 exec bpa.alter_policies('ERR$_CIN_KOM1');


COMMENT ON TABLE BARS.ERR$_CIN_KOM1 IS 'DML Error Logging table for "CIN_KOM1"';
COMMENT ON COLUMN BARS.ERR$_CIN_KOM1.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIN_KOM1.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIN_KOM1.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIN_KOM1.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIN_KOM1.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIN_KOM1.RNK IS '';
COMMENT ON COLUMN BARS.ERR$_CIN_KOM1.NMK IS '';
COMMENT ON COLUMN BARS.ERR$_CIN_KOM1.NLS_2909 IS '';
COMMENT ON COLUMN BARS.ERR$_CIN_KOM1.ID IS '';
COMMENT ON COLUMN BARS.ERR$_CIN_KOM1.NAME IS '';
COMMENT ON COLUMN BARS.ERR$_CIN_KOM1.MFO IS '';
COMMENT ON COLUMN BARS.ERR$_CIN_KOM1.NLS IS '';
COMMENT ON COLUMN BARS.ERR$_CIN_KOM1.REF IS '';
COMMENT ON COLUMN BARS.ERR$_CIN_KOM1.S IS '';
COMMENT ON COLUMN BARS.ERR$_CIN_KOM1.KA2 IS '';
COMMENT ON COLUMN BARS.ERR$_CIN_KOM1.KA1 IS '';
COMMENT ON COLUMN BARS.ERR$_CIN_KOM1.KB2 IS '';
COMMENT ON COLUMN BARS.ERR$_CIN_KOM1.KB1 IS '';
COMMENT ON COLUMN BARS.ERR$_CIN_KOM1.DAT1 IS '';
COMMENT ON COLUMN BARS.ERR$_CIN_KOM1.DAT2 IS '';
COMMENT ON COLUMN BARS.ERR$_CIN_KOM1.VDAT IS '';
COMMENT ON COLUMN BARS.ERR$_CIN_KOM1.KC0 IS '';
COMMENT ON COLUMN BARS.ERR$_CIN_KOM1.A2 IS '';
COMMENT ON COLUMN BARS.ERR$_CIN_KOM1.B1 IS '';
COMMENT ON COLUMN BARS.ERR$_CIN_KOM1.B2 IS '';
COMMENT ON COLUMN BARS.ERR$_CIN_KOM1.C0 IS '';
COMMENT ON COLUMN BARS.ERR$_CIN_KOM1.NLSR IS '';
COMMENT ON COLUMN BARS.ERR$_CIN_KOM1.REC IS '';
COMMENT ON COLUMN BARS.ERR$_CIN_KOM1.SR IS '';
COMMENT ON COLUMN BARS.ERR$_CIN_KOM1.BRANCH IS '';
COMMENT ON COLUMN BARS.ERR$_CIN_KOM1.SB1_MIN IS '';
COMMENT ON COLUMN BARS.ERR$_CIN_KOM1.B3 IS '';
COMMENT ON COLUMN BARS.ERR$_CIN_KOM1.KB3 IS '';
COMMENT ON COLUMN BARS.ERR$_CIN_KOM1.S3 IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_CIN_KOM1.sql =========*** End ***
PROMPT ===================================================================================== 