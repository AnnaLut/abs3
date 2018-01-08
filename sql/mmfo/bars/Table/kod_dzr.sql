

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KOD_DZR.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KOD_DZR ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KOD_DZR'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KOD_DZR'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KOD_DZR'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KOD_DZR ***
begin 
  execute immediate '
  CREATE TABLE BARS.KOD_DZR 
   (	N1 NUMBER(*,0), 
	PLAN_PREV NUMBER, 
	PLAN_CUR NUMBER, 
	FACT_PREV NUMBER, 
	FACT_CUR NUMBER, 
	KOD VARCHAR2(10), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KOD_DZR ***
 exec bpa.alter_policies('KOD_DZR');


COMMENT ON TABLE BARS.KOD_DZR IS '';
COMMENT ON COLUMN BARS.KOD_DZR.KF IS '';
COMMENT ON COLUMN BARS.KOD_DZR.N1 IS '';
COMMENT ON COLUMN BARS.KOD_DZR.PLAN_PREV IS '';
COMMENT ON COLUMN BARS.KOD_DZR.PLAN_CUR IS '';
COMMENT ON COLUMN BARS.KOD_DZR.FACT_PREV IS '';
COMMENT ON COLUMN BARS.KOD_DZR.FACT_CUR IS '';
COMMENT ON COLUMN BARS.KOD_DZR.KOD IS '';



PROMPT *** Create  grants  KOD_DZR ***
grant SELECT                                                                 on KOD_DZR         to BARSREADER_ROLE;
grant SELECT,UPDATE                                                          on KOD_DZR         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KOD_DZR         to BARS_DM;
grant SELECT,UPDATE                                                          on KOD_DZR         to START1;
grant SELECT                                                                 on KOD_DZR         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KOD_DZR.sql =========*** End *** =====
PROMPT ===================================================================================== 
