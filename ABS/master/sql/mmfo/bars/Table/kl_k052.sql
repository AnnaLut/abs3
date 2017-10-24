

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_K052.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_K052 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_K052'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_K052'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_K052'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_K052 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_K052 
   (	K050 CHAR(3), 
	K052 CHAR(1), 
	TXT VARCHAR2(96), 
	D_OPEN DATE, 
	D_CLOSE DATE, 
	D_MODE DATE, 
	K052_OLD CHAR(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KL_K052 ***
 exec bpa.alter_policies('KL_K052');


COMMENT ON TABLE BARS.KL_K052 IS '';
COMMENT ON COLUMN BARS.KL_K052.K050 IS '';
COMMENT ON COLUMN BARS.KL_K052.K052 IS '';
COMMENT ON COLUMN BARS.KL_K052.TXT IS '';
COMMENT ON COLUMN BARS.KL_K052.D_OPEN IS '';
COMMENT ON COLUMN BARS.KL_K052.D_CLOSE IS '';
COMMENT ON COLUMN BARS.KL_K052.D_MODE IS '';
COMMENT ON COLUMN BARS.KL_K052.K052_OLD IS '';



PROMPT *** Create  grants  KL_K052 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_K052         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KL_K052         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_K052         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_K052.sql =========*** End *** =====
PROMPT ===================================================================================== 
