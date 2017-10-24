

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_Z300.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_Z300 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_Z300'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_Z300'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_Z300'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_Z300 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_Z300 
   (	Z300 CHAR(3), 
	TXT VARCHAR2(102), 
	D_OPEN DATE, 
	D_CLOSE DATE, 
	A010 CHAR(8)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KL_Z300 ***
 exec bpa.alter_policies('KL_Z300');


COMMENT ON TABLE BARS.KL_Z300 IS '';
COMMENT ON COLUMN BARS.KL_Z300.Z300 IS '';
COMMENT ON COLUMN BARS.KL_Z300.TXT IS '';
COMMENT ON COLUMN BARS.KL_Z300.D_OPEN IS '';
COMMENT ON COLUMN BARS.KL_Z300.D_CLOSE IS '';
COMMENT ON COLUMN BARS.KL_Z300.A010 IS '';



PROMPT *** Create  grants  KL_Z300 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_Z300         to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_Z300         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_Z300.sql =========*** End *** =====
PROMPT ===================================================================================== 
