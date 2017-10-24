

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_Z200.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_Z200 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_Z200'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_Z200'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_Z200'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_Z200 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_Z200 
   (	Z200 CHAR(2), 
	Z201 CHAR(2), 
	TXT VARCHAR2(108), 
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




PROMPT *** ALTER_POLICIES to KL_Z200 ***
 exec bpa.alter_policies('KL_Z200');


COMMENT ON TABLE BARS.KL_Z200 IS '';
COMMENT ON COLUMN BARS.KL_Z200.Z200 IS '';
COMMENT ON COLUMN BARS.KL_Z200.Z201 IS '';
COMMENT ON COLUMN BARS.KL_Z200.TXT IS '';
COMMENT ON COLUMN BARS.KL_Z200.D_OPEN IS '';
COMMENT ON COLUMN BARS.KL_Z200.D_CLOSE IS '';
COMMENT ON COLUMN BARS.KL_Z200.D_MODE IS '';



PROMPT *** Create  grants  KL_Z200 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_Z200         to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_Z200         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_Z200.sql =========*** End *** =====
PROMPT ===================================================================================== 
