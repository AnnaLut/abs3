

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_K045.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_K045 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_K045'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_K045'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_K045'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_K045 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_K045 
   (	K045  VARCHAR2(1), 
	TXT   VARCHAR2(32), 
	D_OPEN   DATE, 
	D_CLOSE  DATE, 
	D_MODE   DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


PROMPT *** ALTER_POLICIES to KL_K045 ***
 exec bpa.alter_policies('KL_K045');


COMMENT ON TABLE  BARS.KL_K045 IS 'Код території здійснення операції';
COMMENT ON COLUMN BARS.KL_K045.K045 IS 'Код території';
COMMENT ON COLUMN BARS.KL_K045.TXT IS 'Розшифровка коду території';
COMMENT ON COLUMN BARS.KL_K045.D_OPEN IS '';
COMMENT ON COLUMN BARS.KL_K045.D_CLOSE IS '';
COMMENT ON COLUMN BARS.KL_K045.D_MODE IS '';



PROMPT *** Create  grants  KL_K045 ***
grant SELECT                                   on KL_K045         to BARSREADER_ROLE;
grant SELECT                                   on KL_K045         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_K045.sql =========*** End *** =====
PROMPT ===================================================================================== 
