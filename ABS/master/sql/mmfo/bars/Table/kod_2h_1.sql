

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KOD_2H_1.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KOD_2H_1 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KOD_2H_1'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KOD_2H_1'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KOD_2H_1'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KOD_2H_1 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KOD_2H_1 
   (	P001 CHAR(3), 
	N_PP CHAR(3), 
	TXT VARCHAR2(252), 
	P002 VARCHAR2(30), 
	DATA_O DATE, 
	DATA_C DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYNI ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KOD_2H_1 ***
 exec bpa.alter_policies('KOD_2H_1');


COMMENT ON TABLE BARS.KOD_2H_1 IS '';
COMMENT ON COLUMN BARS.KOD_2H_1.P001 IS '';
COMMENT ON COLUMN BARS.KOD_2H_1.N_PP IS '';
COMMENT ON COLUMN BARS.KOD_2H_1.TXT IS '';
COMMENT ON COLUMN BARS.KOD_2H_1.P002 IS '';
COMMENT ON COLUMN BARS.KOD_2H_1.DATA_O IS '';
COMMENT ON COLUMN BARS.KOD_2H_1.DATA_C IS '';



PROMPT *** Create  grants  KOD_2H_1 ***
grant SELECT                                                                 on KOD_2H_1        to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KOD_2H_1        to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KOD_2H_1        to RPBN002;
grant SELECT                                                                 on KOD_2H_1        to START1;
grant SELECT                                                                 on KOD_2H_1        to UPLD;
grant FLASHBACK,SELECT                                                       on KOD_2H_1        to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KOD_2H_1.sql =========*** End *** ====
PROMPT ===================================================================================== 
