

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KOD_R032.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KOD_R032 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KOD_R032'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KOD_R032'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KOD_R032'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KOD_R032 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KOD_R032 
   (	IND CHAR(1), 
	R030 CHAR(3), 
	Z050 CHAR(2), 
	NOMINAL CHAR(9), 
	TXT VARCHAR2(27)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KOD_R032 ***
 exec bpa.alter_policies('KOD_R032');


COMMENT ON TABLE BARS.KOD_R032 IS '';
COMMENT ON COLUMN BARS.KOD_R032.IND IS '';
COMMENT ON COLUMN BARS.KOD_R032.R030 IS '';
COMMENT ON COLUMN BARS.KOD_R032.Z050 IS '';
COMMENT ON COLUMN BARS.KOD_R032.NOMINAL IS '';
COMMENT ON COLUMN BARS.KOD_R032.TXT IS '';



PROMPT *** Create  grants  KOD_R032 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KOD_R032        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KOD_R032        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on KOD_R032        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KOD_R032.sql =========*** End *** ====
PROMPT ===================================================================================== 
