

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KOD_NAD.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KOD_NAD ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KOD_NAD'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KOD_NAD'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KOD_NAD'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KOD_NAD ***
begin 
  execute immediate '
  CREATE TABLE BARS.KOD_NAD 
   (	KOD_NAD CHAR(1), 
	TXT VARCHAR2(48)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KOD_NAD ***
 exec bpa.alter_policies('KOD_NAD');


COMMENT ON TABLE BARS.KOD_NAD IS '';
COMMENT ON COLUMN BARS.KOD_NAD.KOD_NAD IS '';
COMMENT ON COLUMN BARS.KOD_NAD.TXT IS '';



PROMPT *** Create  grants  KOD_NAD ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KOD_NAD         to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KOD_NAD         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KOD_NAD.sql =========*** End *** =====
PROMPT ===================================================================================== 
