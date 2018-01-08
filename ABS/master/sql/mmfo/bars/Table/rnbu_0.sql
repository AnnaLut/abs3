

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/RNBU_0.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to RNBU_0 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''RNBU_0'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''RNBU_0'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''RNBU_0'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table RNBU_0 ***
begin 
  execute immediate '
  CREATE TABLE BARS.RNBU_0 
   (	KOD NUMBER(*,0), 
	NAME VARCHAR2(35), 
	VIEW_NAME VARCHAR2(35)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to RNBU_0 ***
 exec bpa.alter_policies('RNBU_0');


COMMENT ON TABLE BARS.RNBU_0 IS 'Классификатор типов консолидации показателей отчетов ';
COMMENT ON COLUMN BARS.RNBU_0.KOD IS '';
COMMENT ON COLUMN BARS.RNBU_0.NAME IS '';
COMMENT ON COLUMN BARS.RNBU_0.VIEW_NAME IS '';



PROMPT *** Create  grants  RNBU_0 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on RNBU_0          to ABS_ADMIN;
grant ALTER,DELETE,FLASHBACK,INSERT,SELECT,UPDATE                            on RNBU_0          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on RNBU_0          to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on RNBU_0          to RNBU_0;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on RNBU_0          to RPBN002;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on RNBU_0          to SALGL;
grant SELECT                                                                 on RNBU_0          to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on RNBU_0          to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on RNBU_0          to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/RNBU_0.sql =========*** End *** ======
PROMPT ===================================================================================== 
