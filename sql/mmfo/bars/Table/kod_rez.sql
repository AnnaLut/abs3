

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KOD_REZ.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KOD_REZ ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KOD_REZ'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KOD_REZ'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KOD_REZ'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KOD_REZ ***
begin 
  execute immediate '
  CREATE TABLE BARS.KOD_REZ 
   (	KOD_REZ CHAR(1), 
	TXT VARCHAR2(48)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KOD_REZ ***
 exec bpa.alter_policies('KOD_REZ');


COMMENT ON TABLE BARS.KOD_REZ IS '';
COMMENT ON COLUMN BARS.KOD_REZ.KOD_REZ IS '';
COMMENT ON COLUMN BARS.KOD_REZ.TXT IS '';



PROMPT *** Create  grants  KOD_REZ ***
grant SELECT                                                                 on KOD_REZ         to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KOD_REZ         to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KOD_REZ         to START1;
grant SELECT                                                                 on KOD_REZ         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KOD_REZ.sql =========*** End *** =====
PROMPT ===================================================================================== 
