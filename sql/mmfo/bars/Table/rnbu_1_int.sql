

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/RNBU_1_INT.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to RNBU_1_INT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''RNBU_1_INT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''RNBU_1_INT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''RNBU_1_INT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table RNBU_1_INT ***
begin 
  execute immediate '
  CREATE TABLE BARS.RNBU_1_INT 
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




PROMPT *** ALTER_POLICIES to RNBU_1_INT ***
 exec bpa.alter_policies('RNBU_1_INT');


COMMENT ON TABLE BARS.RNBU_1_INT IS 'Классификатор спец. консолидации показателей файлов отчетности Сбербанка';
COMMENT ON COLUMN BARS.RNBU_1_INT.KODF IS 'Код файлу звiтностi';
COMMENT ON COLUMN BARS.RNBU_1_INT.KOD_MASKA IS 'Маска коду показника';
COMMENT ON COLUMN BARS.RNBU_1_INT.KOD IS 'Спосiб консолiдацiї';



PROMPT *** Create  grants  RNBU_1_INT ***
grant DELETE,INSERT,SELECT,UPDATE                                            on RNBU_1_INT      to ABS_ADMIN;
grant SELECT                                                                 on RNBU_1_INT      to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on RNBU_1_INT      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on RNBU_1_INT      to BARS_DM;
grant SELECT                                                                 on RNBU_1_INT      to START1;
grant SELECT                                                                 on RNBU_1_INT      to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on RNBU_1_INT      to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on RNBU_1_INT      to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/RNBU_1_INT.sql =========*** End *** ==
PROMPT ===================================================================================== 
