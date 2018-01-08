

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EKP_2_20.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EKP_2_20 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EKP_2_20 ***
begin 
  execute immediate '
  CREATE TABLE BARS.EKP_2_20 
   (	A010 VARCHAR2(2), 
	KUDA VARCHAR2(10), 
	EK_POK VARCHAR2(16), 
	TXT VARCHAR2(96), 
	PRM1 VARCHAR2(24), 
	PRM2 VARCHAR2(250), 
	PRM3 VARCHAR2(10), 
	PRM4 VARCHAR2(64), 
	PRM5 VARCHAR2(40), 
	PRM6 VARCHAR2(80), 
	FILT_REP2 VARCHAR2(48), 
	SUBDIR VARCHAR2(3), 
	OTKUDA VARCHAR2(14), 
	A012 VARCHAR2(3), 
	UROVEN VARCHAR2(1), 
	PR_NO NUMBER(1,0), 
	PREM VARCHAR2(48), 
	DATA_O DATE, 
	DATA_C DATE, 
	DATA_M DATE, 
	PR_NO3 NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to EKP_2_20 ***
 exec bpa.alter_policies('EKP_2_20');


COMMENT ON TABLE BARS.EKP_2_20 IS '';
COMMENT ON COLUMN BARS.EKP_2_20.A010 IS '';
COMMENT ON COLUMN BARS.EKP_2_20.KUDA IS '';
COMMENT ON COLUMN BARS.EKP_2_20.EK_POK IS '';
COMMENT ON COLUMN BARS.EKP_2_20.TXT IS '';
COMMENT ON COLUMN BARS.EKP_2_20.PRM1 IS '';
COMMENT ON COLUMN BARS.EKP_2_20.PRM2 IS '';
COMMENT ON COLUMN BARS.EKP_2_20.PRM3 IS '';
COMMENT ON COLUMN BARS.EKP_2_20.PRM4 IS '';
COMMENT ON COLUMN BARS.EKP_2_20.PRM5 IS '';
COMMENT ON COLUMN BARS.EKP_2_20.PRM6 IS '';
COMMENT ON COLUMN BARS.EKP_2_20.FILT_REP2 IS '';
COMMENT ON COLUMN BARS.EKP_2_20.SUBDIR IS '';
COMMENT ON COLUMN BARS.EKP_2_20.OTKUDA IS '';
COMMENT ON COLUMN BARS.EKP_2_20.A012 IS '';
COMMENT ON COLUMN BARS.EKP_2_20.UROVEN IS '';
COMMENT ON COLUMN BARS.EKP_2_20.PR_NO IS '';
COMMENT ON COLUMN BARS.EKP_2_20.PREM IS '';
COMMENT ON COLUMN BARS.EKP_2_20.DATA_O IS '';
COMMENT ON COLUMN BARS.EKP_2_20.DATA_C IS '';
COMMENT ON COLUMN BARS.EKP_2_20.DATA_M IS '';
COMMENT ON COLUMN BARS.EKP_2_20.PR_NO3 IS '';



PROMPT *** Create  grants  EKP_2_20 ***
grant SELECT                                                                 on EKP_2_20        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EKP_2_20.sql =========*** End *** ====
PROMPT ===================================================================================== 
