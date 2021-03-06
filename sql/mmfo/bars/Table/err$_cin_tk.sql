

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_CIN_TK.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_CIN_TK ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_CIN_TK ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_CIN_TK 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ID VARCHAR2(4000), 
	RNK VARCHAR2(4000), 
	MFO VARCHAR2(4000), 
	NLS VARCHAR2(4000), 
	S_A2 VARCHAR2(4000), 
	NLSR VARCHAR2(4000), 
	S_B2 VARCHAR2(4000), 
	NAME VARCHAR2(4000), 
	PR_B1 VARCHAR2(4000), 
	S_C0 VARCHAR2(4000), 
	BRANCH VARCHAR2(4000), 
	SB1_MIN VARCHAR2(4000), 
	KORR VARCHAR2(4000), 
	S_B3 VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_CIN_TK ***
 exec bpa.alter_policies('ERR$_CIN_TK');


COMMENT ON TABLE BARS.ERR$_CIN_TK IS 'DML Error Logging table for "CIN_TK"';
COMMENT ON COLUMN BARS.ERR$_CIN_TK.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIN_TK.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIN_TK.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIN_TK.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIN_TK.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CIN_TK.ID IS '';
COMMENT ON COLUMN BARS.ERR$_CIN_TK.RNK IS '';
COMMENT ON COLUMN BARS.ERR$_CIN_TK.MFO IS '';
COMMENT ON COLUMN BARS.ERR$_CIN_TK.NLS IS '';
COMMENT ON COLUMN BARS.ERR$_CIN_TK.S_A2 IS '';
COMMENT ON COLUMN BARS.ERR$_CIN_TK.NLSR IS '';
COMMENT ON COLUMN BARS.ERR$_CIN_TK.S_B2 IS '';
COMMENT ON COLUMN BARS.ERR$_CIN_TK.NAME IS '';
COMMENT ON COLUMN BARS.ERR$_CIN_TK.PR_B1 IS '';
COMMENT ON COLUMN BARS.ERR$_CIN_TK.S_C0 IS '';
COMMENT ON COLUMN BARS.ERR$_CIN_TK.BRANCH IS '';
COMMENT ON COLUMN BARS.ERR$_CIN_TK.SB1_MIN IS '';
COMMENT ON COLUMN BARS.ERR$_CIN_TK.KORR IS '';
COMMENT ON COLUMN BARS.ERR$_CIN_TK.S_B3 IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_CIN_TK.sql =========*** End *** =
PROMPT ===================================================================================== 
