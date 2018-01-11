

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_K014.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_K014 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_K014'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_K014'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_K014'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_K014 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_K014 
   (	K014 VARCHAR2(1), 
	Z220 VARCHAR2(1), 
	TXT VARCHAR2(100), 
	D_OPEN DATE, 
	D_CLOSE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KL_K014 ***
 exec bpa.alter_policies('KL_K014');


COMMENT ON TABLE BARS.KL_K014 IS '';
COMMENT ON COLUMN BARS.KL_K014.K014 IS '';
COMMENT ON COLUMN BARS.KL_K014.Z220 IS '';
COMMENT ON COLUMN BARS.KL_K014.TXT IS '';
COMMENT ON COLUMN BARS.KL_K014.D_OPEN IS '';
COMMENT ON COLUMN BARS.KL_K014.D_CLOSE IS '';



PROMPT *** Create  grants  KL_K014 ***
grant SELECT                                                                 on KL_K014         to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_K014         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KL_K014         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_K014         to START1;
grant SELECT                                                                 on KL_K014         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_K014.sql =========*** End *** =====
PROMPT ===================================================================================== 
