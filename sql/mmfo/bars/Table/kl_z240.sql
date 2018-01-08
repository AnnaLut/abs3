

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_Z240.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_Z240 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_Z240'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_Z240'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_Z240'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_Z240 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_Z240 
   (	PREM CHAR(3), 
	Z240 CHAR(2), 
	T020 CHAR(1), 
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




PROMPT *** ALTER_POLICIES to KL_Z240 ***
 exec bpa.alter_policies('KL_Z240');


COMMENT ON TABLE BARS.KL_Z240 IS '';
COMMENT ON COLUMN BARS.KL_Z240.PREM IS '';
COMMENT ON COLUMN BARS.KL_Z240.Z240 IS '';
COMMENT ON COLUMN BARS.KL_Z240.T020 IS '';
COMMENT ON COLUMN BARS.KL_Z240.TXT IS '';
COMMENT ON COLUMN BARS.KL_Z240.A010 IS '';
COMMENT ON COLUMN BARS.KL_Z240.D_OPEN IS '';
COMMENT ON COLUMN BARS.KL_Z240.D_CLOSE IS '';
COMMENT ON COLUMN BARS.KL_Z240.D_MODE IS '';



PROMPT *** Create  grants  KL_Z240 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_Z240         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KL_Z240         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_Z240         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_Z240.sql =========*** End *** =====
PROMPT ===================================================================================== 
