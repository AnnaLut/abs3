

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_Z290.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_Z290 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_Z290'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_Z290'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_Z290'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_Z290 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_Z290 
   (	Z290 CHAR(2), 
	TXT VARCHAR2(80), 
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




PROMPT *** ALTER_POLICIES to KL_Z290 ***
 exec bpa.alter_policies('KL_Z290');


COMMENT ON TABLE BARS.KL_Z290 IS '';
COMMENT ON COLUMN BARS.KL_Z290.Z290 IS '';
COMMENT ON COLUMN BARS.KL_Z290.TXT IS '';
COMMENT ON COLUMN BARS.KL_Z290.D_OPEN IS '';
COMMENT ON COLUMN BARS.KL_Z290.D_CLOSE IS '';
COMMENT ON COLUMN BARS.KL_Z290.D_MODE IS '';



PROMPT *** Create  grants  KL_Z290 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_Z290         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KL_Z290         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_Z290         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_Z290.sql =========*** End *** =====
PROMPT ===================================================================================== 
