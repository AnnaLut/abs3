

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_D100.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_D100 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_D100'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_D100'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_D100'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_D100 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_D100 
   (	D100 VARCHAR2(2), 
	TXT VARCHAR2(128), 
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




PROMPT *** ALTER_POLICIES to KL_D100 ***
 exec bpa.alter_policies('KL_D100');


COMMENT ON TABLE BARS.KL_D100 IS '';
COMMENT ON COLUMN BARS.KL_D100.D100 IS '';
COMMENT ON COLUMN BARS.KL_D100.TXT IS '';
COMMENT ON COLUMN BARS.KL_D100.D_OPEN IS '';
COMMENT ON COLUMN BARS.KL_D100.D_CLOSE IS '';
COMMENT ON COLUMN BARS.KL_D100.D_MODE IS '';



PROMPT *** Create  grants  KL_D100 ***
grant SELECT                                                                 on KL_D100         to BARSREADER_ROLE;
grant SELECT                                                                 on KL_D100         to UPLD;



PROMPT *** Create SYNONYM  to KL_D100 ***

  CREATE OR REPLACE PUBLIC SYNONYM KL_D100 FOR BARS.KL_D100;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_D100.sql =========*** End *** =====
PROMPT ===================================================================================== 
