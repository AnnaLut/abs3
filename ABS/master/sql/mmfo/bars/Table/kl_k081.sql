

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_K081.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_K081 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_K081'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_K081'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_K081'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_K081 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_K081 
   (	K081 CHAR(1), 
	K082 CHAR(1), 
	TXT VARCHAR2(96), 
	TXT27 VARCHAR2(54), 
	D_OPEN DATE, 
	D_CLOSE DATE, 
	D_MODE DATE, 
	K030 CHAR(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KL_K081 ***
 exec bpa.alter_policies('KL_K081');


COMMENT ON TABLE BARS.KL_K081 IS '';
COMMENT ON COLUMN BARS.KL_K081.K081 IS '';
COMMENT ON COLUMN BARS.KL_K081.K082 IS '';
COMMENT ON COLUMN BARS.KL_K081.TXT IS '';
COMMENT ON COLUMN BARS.KL_K081.TXT27 IS '';
COMMENT ON COLUMN BARS.KL_K081.D_OPEN IS '';
COMMENT ON COLUMN BARS.KL_K081.D_CLOSE IS '';
COMMENT ON COLUMN BARS.KL_K081.D_MODE IS '';
COMMENT ON COLUMN BARS.KL_K081.K030 IS '';



PROMPT *** Create  grants  KL_K081 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_K081         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KL_K081         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_K081         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_K081.sql =========*** End *** =====
PROMPT ===================================================================================== 
