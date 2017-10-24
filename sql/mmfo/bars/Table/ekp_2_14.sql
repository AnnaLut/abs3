

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EKP_2_14.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EKP_2_14 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''EKP_2_14'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''EKP_2_14'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''EKP_2_14'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EKP_2_14 ***
begin 
  execute immediate '
  CREATE TABLE BARS.EKP_2_14 
   (	A010 CHAR(2), 
	KUDA CHAR(10), 
	EK_POK VARCHAR2(16), 
	TXT VARCHAR2(96), 
	PRM1 VARCHAR2(24), 
	PRM2 VARCHAR2(250), 
	PRM3 CHAR(10), 
	PRM4 VARCHAR2(60), 
	PRM5 VARCHAR2(44), 
	PRM6 VARCHAR2(86), 
	FILT_REP2 VARCHAR2(48), 
	SUBDIR CHAR(3), 
	OTKUDA CHAR(10), 
	UROVEN CHAR(1), 
	PREM VARCHAR2(48), 
	DATA_O DATE, 
	DATA_C DATE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to EKP_2_14 ***
 exec bpa.alter_policies('EKP_2_14');


COMMENT ON TABLE BARS.EKP_2_14 IS '';
COMMENT ON COLUMN BARS.EKP_2_14.A010 IS '';
COMMENT ON COLUMN BARS.EKP_2_14.KUDA IS '';
COMMENT ON COLUMN BARS.EKP_2_14.EK_POK IS '';
COMMENT ON COLUMN BARS.EKP_2_14.TXT IS '';
COMMENT ON COLUMN BARS.EKP_2_14.PRM1 IS '';
COMMENT ON COLUMN BARS.EKP_2_14.PRM2 IS '';
COMMENT ON COLUMN BARS.EKP_2_14.PRM3 IS '';
COMMENT ON COLUMN BARS.EKP_2_14.PRM4 IS '';
COMMENT ON COLUMN BARS.EKP_2_14.PRM5 IS '';
COMMENT ON COLUMN BARS.EKP_2_14.PRM6 IS '';
COMMENT ON COLUMN BARS.EKP_2_14.FILT_REP2 IS '';
COMMENT ON COLUMN BARS.EKP_2_14.SUBDIR IS '';
COMMENT ON COLUMN BARS.EKP_2_14.OTKUDA IS '';
COMMENT ON COLUMN BARS.EKP_2_14.UROVEN IS '';
COMMENT ON COLUMN BARS.EKP_2_14.PREM IS '';
COMMENT ON COLUMN BARS.EKP_2_14.DATA_O IS '';
COMMENT ON COLUMN BARS.EKP_2_14.DATA_C IS '';



PROMPT *** Create  grants  EKP_2_14 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on EKP_2_14        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on EKP_2_14        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on EKP_2_14        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EKP_2_14.sql =========*** End *** ====
PROMPT ===================================================================================== 
