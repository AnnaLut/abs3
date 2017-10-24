

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KOD_PER.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KOD_PER ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KOD_PER'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KOD_PER'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KOD_PER'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KOD_PER ***
begin 
  execute immediate '
  CREATE TABLE BARS.KOD_PER 
   (	KOD_PER CHAR(1), 
	TXT VARCHAR2(48)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KOD_PER ***
 exec bpa.alter_policies('KOD_PER');


COMMENT ON TABLE BARS.KOD_PER IS '';
COMMENT ON COLUMN BARS.KOD_PER.KOD_PER IS '';
COMMENT ON COLUMN BARS.KOD_PER.TXT IS '';



PROMPT *** Create  grants  KOD_PER ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KOD_PER         to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KOD_PER         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KOD_PER.sql =========*** End *** =====
PROMPT ===================================================================================== 
