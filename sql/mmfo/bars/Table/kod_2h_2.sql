

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KOD_2H_2.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KOD_2H_2 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KOD_2H_2'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KOD_2H_2'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KOD_2H_2'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KOD_2H_2 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KOD_2H_2 
   (	P002 VARCHAR2(3), 
	TXT VARCHAR2(254), 
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




PROMPT *** ALTER_POLICIES to KOD_2H_2 ***
 exec bpa.alter_policies('KOD_2H_2');


COMMENT ON TABLE BARS.KOD_2H_2 IS '';
COMMENT ON COLUMN BARS.KOD_2H_2.P002 IS '';
COMMENT ON COLUMN BARS.KOD_2H_2.TXT IS '';
COMMENT ON COLUMN BARS.KOD_2H_2.DATA_O IS '';
COMMENT ON COLUMN BARS.KOD_2H_2.DATA_C IS '';



PROMPT *** Create  grants  KOD_2H_2 ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KOD_2H_2        to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KOD_2H_2        to RPBN002;
grant SELECT                                                                 on KOD_2H_2        to START1;
grant FLASHBACK,SELECT                                                       on KOD_2H_2        to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KOD_2H_2.sql =========*** End *** ====
PROMPT ===================================================================================== 
