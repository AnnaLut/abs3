

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KOD_DZ.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KOD_DZ ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KOD_DZ'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KOD_DZ'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''KOD_DZ'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KOD_DZ ***
begin 
  execute immediate '
  CREATE TABLE BARS.KOD_DZ 
   (	N1 VARCHAR2(20), 
	N2 VARCHAR2(200)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KOD_DZ ***
 exec bpa.alter_policies('KOD_DZ');


COMMENT ON TABLE BARS.KOD_DZ IS '';
COMMENT ON COLUMN BARS.KOD_DZ.N1 IS '';
COMMENT ON COLUMN BARS.KOD_DZ.N2 IS '';



PROMPT *** Create  grants  KOD_DZ ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KOD_DZ          to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KOD_DZ          to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KOD_DZ          to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KOD_DZ          to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on KOD_DZ          to WR_REFREAD;



PROMPT *** Create SYNONYM  to KOD_DZ ***

  CREATE OR REPLACE PUBLIC SYNONYM KOD_DZ FOR BARS.KOD_DZ;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KOD_DZ.sql =========*** End *** ======
PROMPT ===================================================================================== 
