

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIN_TK_2.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIN_TK_2 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIN_TK_2'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIN_TK_2'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIN_TK_2'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIN_TK_2 ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIN_TK_2 
   (	RNK NUMBER, 
	NMK VARCHAR2(80), 
	NAME VARCHAR2(60), 
	MFO VARCHAR2(6), 
	NAME_MFO VARCHAR2(40), 
	NLS VARCHAR2(15), 
	BRANCH VARCHAR2(22), 
	NAME_BR VARCHAR2(40), 
	S_A2 NUMBER, 
	NLSR VARCHAR2(15), 
	PR_B1 NUMBER, 
	SB1_MIN NUMBER, 
	S_C0 NUMBER, 
	S_B2 NUMBER, 
	ID NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIN_TK_2 ***
 exec bpa.alter_policies('CIN_TK_2');


COMMENT ON TABLE BARS.CIN_TK_2 IS '';
COMMENT ON COLUMN BARS.CIN_TK_2.RNK IS '';
COMMENT ON COLUMN BARS.CIN_TK_2.NMK IS '';
COMMENT ON COLUMN BARS.CIN_TK_2.NAME IS '';
COMMENT ON COLUMN BARS.CIN_TK_2.MFO IS '';
COMMENT ON COLUMN BARS.CIN_TK_2.NAME_MFO IS '';
COMMENT ON COLUMN BARS.CIN_TK_2.NLS IS '';
COMMENT ON COLUMN BARS.CIN_TK_2.BRANCH IS '';
COMMENT ON COLUMN BARS.CIN_TK_2.NAME_BR IS '';
COMMENT ON COLUMN BARS.CIN_TK_2.S_A2 IS '';
COMMENT ON COLUMN BARS.CIN_TK_2.NLSR IS '';
COMMENT ON COLUMN BARS.CIN_TK_2.PR_B1 IS '';
COMMENT ON COLUMN BARS.CIN_TK_2.SB1_MIN IS '';
COMMENT ON COLUMN BARS.CIN_TK_2.S_C0 IS '';
COMMENT ON COLUMN BARS.CIN_TK_2.S_B2 IS '';
COMMENT ON COLUMN BARS.CIN_TK_2.ID IS '';



PROMPT *** Create  grants  CIN_TK_2 ***
grant SELECT                                                                 on CIN_TK_2        to BARSREADER_ROLE;
grant SELECT                                                                 on CIN_TK_2        to BARS_DM;
grant SELECT                                                                 on CIN_TK_2        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIN_TK_2.sql =========*** End *** ====
PROMPT ===================================================================================== 
