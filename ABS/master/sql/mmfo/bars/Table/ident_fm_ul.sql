

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/IDENT_FM_UL.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to IDENT_FM_UL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''IDENT_FM_UL'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''IDENT_FM_UL'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''IDENT_FM_UL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table IDENT_FM_UL ***
begin 
  execute immediate '
  CREATE TABLE BARS.IDENT_FM_UL 
   (	G00 DATE, 
	G01 NUMBER, 
	G02 VARCHAR2(70), 
	G03 VARCHAR2(70), 
	G04 VARCHAR2(14), 
	G05 DATE, 
	G06 DATE, 
	G07 DATE, 
	G08 DATE, 
	G09 DATE, 
	G10 DATE, 
	G11 DATE, 
	G12 VARCHAR2(50)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to IDENT_FM_UL ***
 exec bpa.alter_policies('IDENT_FM_UL');


COMMENT ON TABLE BARS.IDENT_FM_UL IS '';
COMMENT ON COLUMN BARS.IDENT_FM_UL.G00 IS '';
COMMENT ON COLUMN BARS.IDENT_FM_UL.G01 IS '';
COMMENT ON COLUMN BARS.IDENT_FM_UL.G02 IS '';
COMMENT ON COLUMN BARS.IDENT_FM_UL.G03 IS '';
COMMENT ON COLUMN BARS.IDENT_FM_UL.G04 IS '';
COMMENT ON COLUMN BARS.IDENT_FM_UL.G05 IS '';
COMMENT ON COLUMN BARS.IDENT_FM_UL.G06 IS '';
COMMENT ON COLUMN BARS.IDENT_FM_UL.G07 IS '';
COMMENT ON COLUMN BARS.IDENT_FM_UL.G08 IS '';
COMMENT ON COLUMN BARS.IDENT_FM_UL.G09 IS '';
COMMENT ON COLUMN BARS.IDENT_FM_UL.G10 IS '';
COMMENT ON COLUMN BARS.IDENT_FM_UL.G11 IS '';
COMMENT ON COLUMN BARS.IDENT_FM_UL.G12 IS '';



PROMPT *** Create  grants  IDENT_FM_UL ***
grant DELETE,INSERT,SELECT,UPDATE                                            on IDENT_FM_UL     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on IDENT_FM_UL     to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on IDENT_FM_UL     to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/IDENT_FM_UL.sql =========*** End *** =
PROMPT ===================================================================================== 
