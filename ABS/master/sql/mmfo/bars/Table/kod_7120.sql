

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KOD_7120.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KOD_7120 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KOD_7120'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KOD_7120'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KOD_7120'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KOD_7120 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KOD_7120 
   (	K071 CHAR(1), 
	R020 CHAR(4), 
	K030 CHAR(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KOD_7120 ***
 exec bpa.alter_policies('KOD_7120');


COMMENT ON TABLE BARS.KOD_7120 IS '';
COMMENT ON COLUMN BARS.KOD_7120.K071 IS '';
COMMENT ON COLUMN BARS.KOD_7120.R020 IS '';
COMMENT ON COLUMN BARS.KOD_7120.K030 IS '';



PROMPT *** Create  grants  KOD_7120 ***
grant FLASHBACK,SELECT                                                       on KOD_7120        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KOD_7120        to BARS_DM;
grant FLASHBACK,SELECT                                                       on KOD_7120        to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KOD_7120.sql =========*** End *** ====
PROMPT ===================================================================================== 
