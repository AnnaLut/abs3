

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KOD_14.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KOD_14 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KOD_14'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KOD_14'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KOD_14'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KOD_14 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KOD_14 
   (	RAZD CHAR(2), 
	GR CHAR(3), 
	R020 CHAR(4), 
	R011 CHAR(1), 
	K071 CHAR(1), 
	K081 CHAR(1), 
	K051 CHAR(2), 
	K111 CHAR(2), 
	K030 CHAR(1), 
	D_OPEN DATE, 
	D_CLOSE DATE, 
	PR_MOG CHAR(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KOD_14 ***
 exec bpa.alter_policies('KOD_14');


COMMENT ON TABLE BARS.KOD_14 IS 'Классификатор НБУ';
COMMENT ON COLUMN BARS.KOD_14.RAZD IS '';
COMMENT ON COLUMN BARS.KOD_14.GR IS '';
COMMENT ON COLUMN BARS.KOD_14.R020 IS '';
COMMENT ON COLUMN BARS.KOD_14.R011 IS '';
COMMENT ON COLUMN BARS.KOD_14.K071 IS '';
COMMENT ON COLUMN BARS.KOD_14.K081 IS '';
COMMENT ON COLUMN BARS.KOD_14.K051 IS '';
COMMENT ON COLUMN BARS.KOD_14.K111 IS '';
COMMENT ON COLUMN BARS.KOD_14.K030 IS '';
COMMENT ON COLUMN BARS.KOD_14.D_OPEN IS '';
COMMENT ON COLUMN BARS.KOD_14.D_CLOSE IS '';
COMMENT ON COLUMN BARS.KOD_14.PR_MOG IS '';



PROMPT *** Create  grants  KOD_14 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KOD_14          to ABS_ADMIN;
grant SELECT                                                                 on KOD_14          to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KOD_14          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KOD_14          to BARS_DM;
grant SELECT                                                                 on KOD_14          to CUST001;
grant SELECT                                                                 on KOD_14          to START1;
grant SELECT                                                                 on KOD_14          to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KOD_14          to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KOD_14.sql =========*** End *** ======
PROMPT ===================================================================================== 
