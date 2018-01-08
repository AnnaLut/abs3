

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/MBK_GPK0.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to MBK_GPK0 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''MBK_GPK0'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''MBK_GPK0'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''MBK_GPK0'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table MBK_GPK0 ***
begin 
  execute immediate '
  CREATE TABLE BARS.MBK_GPK0 
   (	KF CHAR(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	USR_ID NUMBER(*,0) DEFAULT sys_context(''bars_global'',''user_id''), 
	NPP NUMBER(*,0), 
	DAT1 DATE, 
	DAT2 DATE, 
	FDAT DATE, 
	SUMT NUMBER, 
	SUMP NUMBER, 
	LIM2 NUMBER, 
	LIM1 NUMBER, 
	OSTC NUMBER, 
	ND NUMBER, 
	OSTI NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to MBK_GPK0 ***
 exec bpa.alter_policies('MBK_GPK0');


COMMENT ON TABLE BARS.MBK_GPK0 IS '';
COMMENT ON COLUMN BARS.MBK_GPK0.KF IS '';
COMMENT ON COLUMN BARS.MBK_GPK0.USR_ID IS '';
COMMENT ON COLUMN BARS.MBK_GPK0.NPP IS '';
COMMENT ON COLUMN BARS.MBK_GPK0.DAT1 IS '';
COMMENT ON COLUMN BARS.MBK_GPK0.DAT2 IS '';
COMMENT ON COLUMN BARS.MBK_GPK0.FDAT IS '';
COMMENT ON COLUMN BARS.MBK_GPK0.SUMT IS '';
COMMENT ON COLUMN BARS.MBK_GPK0.SUMP IS '';
COMMENT ON COLUMN BARS.MBK_GPK0.LIM2 IS '';
COMMENT ON COLUMN BARS.MBK_GPK0.LIM1 IS '';
COMMENT ON COLUMN BARS.MBK_GPK0.OSTC IS '';
COMMENT ON COLUMN BARS.MBK_GPK0.ND IS '';
COMMENT ON COLUMN BARS.MBK_GPK0.OSTI IS '';



PROMPT *** Create  grants  MBK_GPK0 ***
grant SELECT                                                                 on MBK_GPK0        to BARSREADER_ROLE;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on MBK_GPK0        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on MBK_GPK0        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/MBK_GPK0.sql =========*** End *** ====
PROMPT ===================================================================================== 
