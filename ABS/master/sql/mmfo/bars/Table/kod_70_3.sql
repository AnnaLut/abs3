

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KOD_70_3.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KOD_70_3 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KOD_70_3'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KOD_70_3'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KOD_70_3'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KOD_70_3 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KOD_70_3 
   (	P01 VARCHAR2(1), 
	TXT VARCHAR2(54), 
	DATA_O DATE, 
	DATA_C DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KOD_70_3 ***
 exec bpa.alter_policies('KOD_70_3');


COMMENT ON TABLE BARS.KOD_70_3 IS '';
COMMENT ON COLUMN BARS.KOD_70_3.P01 IS '';
COMMENT ON COLUMN BARS.KOD_70_3.TXT IS '';
COMMENT ON COLUMN BARS.KOD_70_3.DATA_O IS '';
COMMENT ON COLUMN BARS.KOD_70_3.DATA_C IS '';



PROMPT *** Create  grants  KOD_70_3 ***
grant SELECT                                                                 on KOD_70_3        to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KOD_70_3        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KOD_70_3.sql =========*** End *** ====
PROMPT ===================================================================================== 
