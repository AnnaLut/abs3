

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/RNBU_0_INT.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to RNBU_0_INT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''RNBU_0_INT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''RNBU_0_INT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''RNBU_0_INT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table RNBU_0_INT ***
begin 
  execute immediate '
  CREATE TABLE BARS.RNBU_0_INT 
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




PROMPT *** ALTER_POLICIES to RNBU_0_INT ***
 exec bpa.alter_policies('RNBU_0_INT');


COMMENT ON TABLE BARS.RNBU_0_INT IS 'Классификатор типов консолидации показателей отчетов Сбербанка ';
COMMENT ON COLUMN BARS.RNBU_0_INT.KOD IS 'Код способу консолiдацiї';
COMMENT ON COLUMN BARS.RNBU_0_INT.NAME IS 'Назва способу консолiдацiї';
COMMENT ON COLUMN BARS.RNBU_0_INT.VIEW_NAME IS 'Iм'я консолiдованого 'уявлення'(VIEW)';



PROMPT *** Create  grants  RNBU_0_INT ***
grant DELETE,INSERT,SELECT,UPDATE                                            on RNBU_0_INT      to ABS_ADMIN;
grant SELECT                                                                 on RNBU_0_INT      to BARSREADER_ROLE;
grant ALTER,DELETE,FLASHBACK,INSERT,SELECT,UPDATE                            on RNBU_0_INT      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on RNBU_0_INT      to BARS_DM;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on RNBU_0_INT      to RPBN002;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on RNBU_0_INT      to SALGL;
grant SELECT                                                                 on RNBU_0_INT      to START1;
grant SELECT                                                                 on RNBU_0_INT      to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on RNBU_0_INT      to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on RNBU_0_INT      to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/RNBU_0_INT.sql =========*** End *** ==
PROMPT ===================================================================================== 
