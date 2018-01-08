

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/RNBU_1.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to RNBU_1 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''RNBU_1'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''RNBU_1'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''RNBU_1'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table RNBU_1 ***
begin 
  execute immediate '
  CREATE TABLE BARS.RNBU_1 
   (	KODF VARCHAR2(2), 
	KOD_MASKA VARCHAR2(35), 
	KOD NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to RNBU_1 ***
 exec bpa.alter_policies('RNBU_1');


COMMENT ON TABLE BARS.RNBU_1 IS 'Классификатор спец. консолидации показателей файлов отчетности';
COMMENT ON COLUMN BARS.RNBU_1.KODF IS '';
COMMENT ON COLUMN BARS.RNBU_1.KOD_MASKA IS '';
COMMENT ON COLUMN BARS.RNBU_1.KOD IS '';



PROMPT *** Create  grants  RNBU_1 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on RNBU_1          to ABS_ADMIN;
grant SELECT                                                                 on RNBU_1          to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on RNBU_1          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on RNBU_1          to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on RNBU_1          to RNBU_1;
grant SELECT                                                                 on RNBU_1          to START1;
grant SELECT                                                                 on RNBU_1          to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on RNBU_1          to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on RNBU_1          to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/RNBU_1.sql =========*** End *** ======
PROMPT ===================================================================================== 
