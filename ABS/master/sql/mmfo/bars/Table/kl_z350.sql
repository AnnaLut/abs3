

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_Z350.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_Z350 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_Z350'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_Z350'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_Z350'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_Z350 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_Z350 
   (	Z350 VARCHAR2(1), 
	TXT VARCHAR2(32), 
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




PROMPT *** ALTER_POLICIES to KL_Z350 ***
 exec bpa.alter_policies('KL_Z350');


COMMENT ON TABLE  BARS.KL_Z350 IS 'Емітент електронного платіжного засобу';
COMMENT ON COLUMN BARS.KL_Z350.Z350 IS 'Код емітента';
COMMENT ON COLUMN BARS.KL_Z350.TXT IS 'Назва емітента';
COMMENT ON COLUMN BARS.KL_Z350.D_OPEN IS '';
COMMENT ON COLUMN BARS.KL_Z350.D_CLOSE IS '';
COMMENT ON COLUMN BARS.KL_Z350.D_MODE IS '';



PROMPT *** Create  grants  KL_Z350 ***
grant SELECT                                   on KL_Z350         to BARSREADER_ROLE;
grant SELECT                                   on KL_Z350         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_Z350.sql =========*** End *** =====
PROMPT ===================================================================================== 
