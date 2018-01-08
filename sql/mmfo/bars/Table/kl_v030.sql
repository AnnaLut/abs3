

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_V030.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_V030 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_V030'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_V030'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_V030'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_V030 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_V030 
   (	D_VAL DATE, 
	R030 CHAR(3), 
	A3 CHAR(3), 
	NOMIN NUMBER(*,0), 
	Z_KURS NUMBER(10,4)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KL_V030 ***
 exec bpa.alter_policies('KL_V030');


COMMENT ON TABLE BARS.KL_V030 IS '';
COMMENT ON COLUMN BARS.KL_V030.D_VAL IS '';
COMMENT ON COLUMN BARS.KL_V030.R030 IS '';
COMMENT ON COLUMN BARS.KL_V030.A3 IS '';
COMMENT ON COLUMN BARS.KL_V030.NOMIN IS '';
COMMENT ON COLUMN BARS.KL_V030.Z_KURS IS '';



PROMPT *** Create  grants  KL_V030 ***
grant SELECT                                                                 on KL_V030         to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_V030         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KL_V030         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_V030         to START1;
grant SELECT                                                                 on KL_V030         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_V030.sql =========*** End *** =====
PROMPT ===================================================================================== 
