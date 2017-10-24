

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_BPK_ARSENAL57.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_BPK_ARSENAL57 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_BPK_ARSENAL57 ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_BPK_ARSENAL57 
   (	CARD_ACCT VARCHAR2(10), 
	OPEN_DATE DATE, 
	EXPIRY DATE, 
	BRANCH VARCHAR2(30), 
	ACC NUMBER(38,0), 
	NLS VARCHAR2(14), 
	LCV VARCHAR2(3), 
	NMK VARCHAR2(40), 
	LIM_BEGIN NUMBER(38,0), 
	LIM NUMBER(38,0), 
	BDAY DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_BPK_ARSENAL57 ***
 exec bpa.alter_policies('TMP_BPK_ARSENAL57');


COMMENT ON TABLE BARS.TMP_BPK_ARSENAL57 IS '';
COMMENT ON COLUMN BARS.TMP_BPK_ARSENAL57.CARD_ACCT IS '';
COMMENT ON COLUMN BARS.TMP_BPK_ARSENAL57.OPEN_DATE IS '';
COMMENT ON COLUMN BARS.TMP_BPK_ARSENAL57.EXPIRY IS '';
COMMENT ON COLUMN BARS.TMP_BPK_ARSENAL57.BRANCH IS '';
COMMENT ON COLUMN BARS.TMP_BPK_ARSENAL57.ACC IS '';
COMMENT ON COLUMN BARS.TMP_BPK_ARSENAL57.NLS IS '';
COMMENT ON COLUMN BARS.TMP_BPK_ARSENAL57.LCV IS '';
COMMENT ON COLUMN BARS.TMP_BPK_ARSENAL57.NMK IS '';
COMMENT ON COLUMN BARS.TMP_BPK_ARSENAL57.LIM_BEGIN IS '';
COMMENT ON COLUMN BARS.TMP_BPK_ARSENAL57.LIM IS '';
COMMENT ON COLUMN BARS.TMP_BPK_ARSENAL57.BDAY IS '';



PROMPT *** Create  grants  TMP_BPK_ARSENAL57 ***
grant SELECT                                                                 on TMP_BPK_ARSENAL57 to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_BPK_ARSENAL57 to BARS_DM;
grant SELECT                                                                 on TMP_BPK_ARSENAL57 to RPBN001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_BPK_ARSENAL57.sql =========*** End
PROMPT ===================================================================================== 
