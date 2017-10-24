

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SB_KOD75.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SB_KOD75 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SB_KOD75'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SB_KOD75'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SB_KOD75'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SB_KOD75 ***
begin 
  execute immediate '
  CREATE TABLE BARS.SB_KOD75 
   (	T020 VARCHAR2(2), 
	R020 VARCHAR2(90), 
	OB22 VARCHAR2(50), 
	OB75 VARCHAR2(40), 
	D_OPEN DATE, 
	D_CLOSE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SB_KOD75 ***
 exec bpa.alter_policies('SB_KOD75');


COMMENT ON TABLE BARS.SB_KOD75 IS '';
COMMENT ON COLUMN BARS.SB_KOD75.T020 IS '';
COMMENT ON COLUMN BARS.SB_KOD75.R020 IS '';
COMMENT ON COLUMN BARS.SB_KOD75.OB22 IS '';
COMMENT ON COLUMN BARS.SB_KOD75.OB75 IS '';
COMMENT ON COLUMN BARS.SB_KOD75.D_OPEN IS '';
COMMENT ON COLUMN BARS.SB_KOD75.D_CLOSE IS '';



PROMPT *** Create  grants  SB_KOD75 ***
grant SELECT                                                                 on SB_KOD75        to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SB_KOD75.sql =========*** End *** ====
PROMPT ===================================================================================== 
