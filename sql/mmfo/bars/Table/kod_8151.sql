

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KOD_8151.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KOD_8151 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KOD_8151'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KOD_8151'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KOD_8151'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KOD_8151 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KOD_8151 
   (	K081 CHAR(1), 
	K071 CHAR(1), 
	K051 CHAR(2), 
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




PROMPT *** ALTER_POLICIES to KOD_8151 ***
 exec bpa.alter_policies('KOD_8151');


COMMENT ON TABLE BARS.KOD_8151 IS '';
COMMENT ON COLUMN BARS.KOD_8151.K081 IS '';
COMMENT ON COLUMN BARS.KOD_8151.K071 IS '';
COMMENT ON COLUMN BARS.KOD_8151.K051 IS '';
COMMENT ON COLUMN BARS.KOD_8151.D_OPEN IS '';
COMMENT ON COLUMN BARS.KOD_8151.D_CLOSE IS '';



PROMPT *** Create  grants  KOD_8151 ***
grant SELECT                                                                 on KOD_8151        to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KOD_8151        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KOD_8151        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on KOD_8151        to START1;
grant SELECT                                                                 on KOD_8151        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KOD_8151.sql =========*** End *** ====
PROMPT ===================================================================================== 
