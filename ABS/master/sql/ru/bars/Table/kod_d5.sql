

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KOD_D5.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KOD_D5 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KOD_D5'', ''FILIAL'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KOD_D5 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KOD_D5 
   (	RAZD CHAR(2), 
	GR CHAR(3), 
	T020 CHAR(1), 
	R020 CHAR(4), 
	R011 VARCHAR2(16), 
	K071 CHAR(1), 
	K072 VARCHAR2(20), 
	K081 CHAR(10), 
	K051 VARCHAR2(81), 
	K111 VARCHAR2(250), 
	S183 VARCHAR2(14), 
	S260 VARCHAR2(30), 
	K030 CHAR(1), 
	D_OPEN DATE, 
	D_CLOSE DATE, 
	D_MODE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KOD_D5 ***
 exec bpa.alter_policies('KOD_D5');


COMMENT ON TABLE BARS.KOD_D5 IS '';
COMMENT ON COLUMN BARS.KOD_D5.RAZD IS '';
COMMENT ON COLUMN BARS.KOD_D5.GR IS '';
COMMENT ON COLUMN BARS.KOD_D5.T020 IS '';
COMMENT ON COLUMN BARS.KOD_D5.R020 IS '';
COMMENT ON COLUMN BARS.KOD_D5.R011 IS '';
COMMENT ON COLUMN BARS.KOD_D5.K071 IS '';
COMMENT ON COLUMN BARS.KOD_D5.K072 IS '';
COMMENT ON COLUMN BARS.KOD_D5.K081 IS '';
COMMENT ON COLUMN BARS.KOD_D5.K051 IS '';
COMMENT ON COLUMN BARS.KOD_D5.K111 IS '';
COMMENT ON COLUMN BARS.KOD_D5.S183 IS '';
COMMENT ON COLUMN BARS.KOD_D5.S260 IS '';
COMMENT ON COLUMN BARS.KOD_D5.K030 IS '';
COMMENT ON COLUMN BARS.KOD_D5.D_OPEN IS '';
COMMENT ON COLUMN BARS.KOD_D5.D_CLOSE IS '';
COMMENT ON COLUMN BARS.KOD_D5.D_MODE IS '';



PROMPT *** Create  grants  KOD_D5 ***
grant SELECT                                                                 on KOD_D5          to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KOD_D5          to KOD_D5;
grant SELECT                                                                 on KOD_D5          to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KOD_D5.sql =========*** End *** ======
PROMPT ===================================================================================== 
