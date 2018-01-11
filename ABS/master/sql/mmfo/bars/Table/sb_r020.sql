

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SB_R020.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SB_R020 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SB_R020'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SB_R020'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SB_R020'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SB_R020 ***
begin 
  execute immediate '
  CREATE TABLE BARS.SB_R020 
   (	KL VARCHAR2(1), 
	RAZD VARCHAR2(2), 
	GR VARCHAR2(3), 
	PR VARCHAR2(1), 
	R020 VARCHAR2(4), 
	T020 VARCHAR2(1), 
	R050 VARCHAR2(2), 
	A090 VARCHAR2(1), 
	K030 VARCHAR2(1), 
	R031 VARCHAR2(1), 
	S181 VARCHAR2(1), 
	K091 VARCHAR2(1), 
	F_11 VARCHAR2(1), 
	F_17 VARCHAR2(1), 
	F_21 VARCHAR2(1), 
	F_22 VARCHAR2(1), 
	F_27 VARCHAR2(1), 
	F_28 VARCHAR2(1), 
	F_33 VARCHAR2(1), 
	F_37 VARCHAR2(1), 
	F_40 VARCHAR2(1), 
	F_41 VARCHAR2(1), 
	F_42 VARCHAR2(1), 
	F_50 VARCHAR2(1), 
	F_56 VARCHAR2(1), 
	F_67 VARCHAR2(1), 
	F_75 VARCHAR2(1), 
	F_81 VARCHAR2(1), 
	F_82 VARCHAR2(1), 
	TXT VARCHAR2(192), 
	D_OPEN DATE, 
	D_CLOSE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SB_R020 ***
 exec bpa.alter_policies('SB_R020');


COMMENT ON TABLE BARS.SB_R020 IS '';
COMMENT ON COLUMN BARS.SB_R020.KL IS '';
COMMENT ON COLUMN BARS.SB_R020.RAZD IS '';
COMMENT ON COLUMN BARS.SB_R020.GR IS '';
COMMENT ON COLUMN BARS.SB_R020.PR IS '';
COMMENT ON COLUMN BARS.SB_R020.R020 IS '';
COMMENT ON COLUMN BARS.SB_R020.T020 IS '';
COMMENT ON COLUMN BARS.SB_R020.R050 IS '';
COMMENT ON COLUMN BARS.SB_R020.A090 IS '';
COMMENT ON COLUMN BARS.SB_R020.K030 IS '';
COMMENT ON COLUMN BARS.SB_R020.R031 IS '';
COMMENT ON COLUMN BARS.SB_R020.S181 IS '';
COMMENT ON COLUMN BARS.SB_R020.K091 IS '';
COMMENT ON COLUMN BARS.SB_R020.F_11 IS '';
COMMENT ON COLUMN BARS.SB_R020.F_17 IS '';
COMMENT ON COLUMN BARS.SB_R020.F_21 IS '';
COMMENT ON COLUMN BARS.SB_R020.F_22 IS '';
COMMENT ON COLUMN BARS.SB_R020.F_27 IS '';
COMMENT ON COLUMN BARS.SB_R020.F_28 IS '';
COMMENT ON COLUMN BARS.SB_R020.F_33 IS '';
COMMENT ON COLUMN BARS.SB_R020.F_37 IS '';
COMMENT ON COLUMN BARS.SB_R020.F_40 IS '';
COMMENT ON COLUMN BARS.SB_R020.F_41 IS '';
COMMENT ON COLUMN BARS.SB_R020.F_42 IS '';
COMMENT ON COLUMN BARS.SB_R020.F_50 IS '';
COMMENT ON COLUMN BARS.SB_R020.F_56 IS '';
COMMENT ON COLUMN BARS.SB_R020.F_67 IS '';
COMMENT ON COLUMN BARS.SB_R020.F_75 IS '';
COMMENT ON COLUMN BARS.SB_R020.F_81 IS '';
COMMENT ON COLUMN BARS.SB_R020.F_82 IS '';
COMMENT ON COLUMN BARS.SB_R020.TXT IS '';
COMMENT ON COLUMN BARS.SB_R020.D_OPEN IS '';
COMMENT ON COLUMN BARS.SB_R020.D_CLOSE IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SB_R020.sql =========*** End *** =====
PROMPT ===================================================================================== 
