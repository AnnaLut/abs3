

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_R013K.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_R013K ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_R013K'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_R013K'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_R013K'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_R013K ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_R013K 
   (	PREM CHAR(3), 
	R020 CHAR(4), 
	R020R013 CHAR(4), 
	R013 CHAR(1), 
	TXT VARCHAR2(144), 
	A010 CHAR(2), 
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




PROMPT *** ALTER_POLICIES to KL_R013K ***
 exec bpa.alter_policies('KL_R013K');


COMMENT ON TABLE BARS.KL_R013K IS '';
COMMENT ON COLUMN BARS.KL_R013K.PREM IS '';
COMMENT ON COLUMN BARS.KL_R013K.R020 IS '';
COMMENT ON COLUMN BARS.KL_R013K.R020R013 IS '';
COMMENT ON COLUMN BARS.KL_R013K.R013 IS '';
COMMENT ON COLUMN BARS.KL_R013K.TXT IS '';
COMMENT ON COLUMN BARS.KL_R013K.A010 IS '';
COMMENT ON COLUMN BARS.KL_R013K.D_OPEN IS '';
COMMENT ON COLUMN BARS.KL_R013K.D_CLOSE IS '';
COMMENT ON COLUMN BARS.KL_R013K.D_MODE IS '';



PROMPT *** Create  grants  KL_R013K ***
grant SELECT                                                                 on KL_R013K        to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_R013K        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KL_R013K        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_R013K        to START1;
grant SELECT                                                                 on KL_R013K        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_R013K.sql =========*** End *** ====
PROMPT ===================================================================================== 
