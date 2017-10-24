

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KOD_S250.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KOD_S250 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KOD_S250'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KOD_S250'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KOD_S250 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KOD_S250 
   (	S081 CHAR(1), 
	S080 CHAR(1), 
	S250 CHAR(1), 
	P040 CHAR(1), 
	REZ CHAR(3), 
	DATA_O DATE, 
	DATA_C DATE, 
	DATA_M DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KOD_S250 ***
 exec bpa.alter_policies('KOD_S250');


COMMENT ON TABLE BARS.KOD_S250 IS '';
COMMENT ON COLUMN BARS.KOD_S250.S081 IS '';
COMMENT ON COLUMN BARS.KOD_S250.S080 IS '';
COMMENT ON COLUMN BARS.KOD_S250.S250 IS '';
COMMENT ON COLUMN BARS.KOD_S250.P040 IS '';
COMMENT ON COLUMN BARS.KOD_S250.REZ IS '';
COMMENT ON COLUMN BARS.KOD_S250.DATA_O IS '';
COMMENT ON COLUMN BARS.KOD_S250.DATA_C IS '';
COMMENT ON COLUMN BARS.KOD_S250.DATA_M IS '';



PROMPT *** Create  grants  KOD_S250 ***
grant SELECT                                                                 on KOD_S250        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KOD_S250        to BARS_DM;
grant SELECT                                                                 on KOD_S250        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KOD_S250.sql =========*** End *** ====
PROMPT ===================================================================================== 
