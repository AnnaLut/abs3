

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_WAY4_NLS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_WAY4_NLS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_WAY4_NLS ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_WAY4_NLS 
   (	KF VARCHAR2(6), 
	NLS VARCHAR2(19), 
	OSTW_NLS NUMBER(38,0), 
	OSTA_NLS NUMBER(38,0), 
	NLS_2627 VARCHAR2(19), 
	OSTW_NLS_2627 NUMBER(38,0), 
	OSTA_NLS_2627 NUMBER(38,0), 
	NLS_3570 VARCHAR2(19), 
	OSTW_NLS_3570 NUMBER(38,0), 
	OSTA_NLS_3570 NUMBER(38,0), 
	NLS_3579 VARCHAR2(19), 
	OSTW_NLS_3579 NUMBER(38,0), 
	OSTA_NLS_3579 NUMBER(38,0), 
	NLS_2625D VARCHAR2(19), 
	OSTW_NLS_2625D NUMBER(38,0), 
	OSTA_NLS_2625D NUMBER(38,0), 
	STATE_ID VARCHAR2(2), 
	TXT VARCHAR2(120)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_WAY4_NLS ***
 exec bpa.alter_policies('TMP_WAY4_NLS');


COMMENT ON TABLE BARS.TMP_WAY4_NLS IS '';
COMMENT ON COLUMN BARS.TMP_WAY4_NLS.KF IS '';
COMMENT ON COLUMN BARS.TMP_WAY4_NLS.NLS IS '';
COMMENT ON COLUMN BARS.TMP_WAY4_NLS.OSTW_NLS IS '';
COMMENT ON COLUMN BARS.TMP_WAY4_NLS.OSTA_NLS IS '';
COMMENT ON COLUMN BARS.TMP_WAY4_NLS.NLS_2627 IS '';
COMMENT ON COLUMN BARS.TMP_WAY4_NLS.OSTW_NLS_2627 IS '';
COMMENT ON COLUMN BARS.TMP_WAY4_NLS.OSTA_NLS_2627 IS '';
COMMENT ON COLUMN BARS.TMP_WAY4_NLS.NLS_3570 IS '';
COMMENT ON COLUMN BARS.TMP_WAY4_NLS.OSTW_NLS_3570 IS '';
COMMENT ON COLUMN BARS.TMP_WAY4_NLS.OSTA_NLS_3570 IS '';
COMMENT ON COLUMN BARS.TMP_WAY4_NLS.NLS_3579 IS '';
COMMENT ON COLUMN BARS.TMP_WAY4_NLS.OSTW_NLS_3579 IS '';
COMMENT ON COLUMN BARS.TMP_WAY4_NLS.OSTA_NLS_3579 IS '';
COMMENT ON COLUMN BARS.TMP_WAY4_NLS.NLS_2625D IS '';
COMMENT ON COLUMN BARS.TMP_WAY4_NLS.OSTW_NLS_2625D IS '';
COMMENT ON COLUMN BARS.TMP_WAY4_NLS.OSTA_NLS_2625D IS '';
COMMENT ON COLUMN BARS.TMP_WAY4_NLS.STATE_ID IS '';
COMMENT ON COLUMN BARS.TMP_WAY4_NLS.TXT IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_WAY4_NLS.sql =========*** End *** 
PROMPT ===================================================================================== 
