

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_Z120.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_Z120 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_Z120'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_Z120'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_Z120'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_Z120 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_Z120 
   (	Z120 CHAR(1), 
	TXT VARCHAR2(65), 
	TXT30 VARCHAR2(30), 
	D_OPEN DATE, 
	D_CLOSE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KL_Z120 ***
 exec bpa.alter_policies('KL_Z120');


COMMENT ON TABLE BARS.KL_Z120 IS '';
COMMENT ON COLUMN BARS.KL_Z120.Z120 IS '';
COMMENT ON COLUMN BARS.KL_Z120.TXT IS '';
COMMENT ON COLUMN BARS.KL_Z120.TXT30 IS '';
COMMENT ON COLUMN BARS.KL_Z120.D_OPEN IS '';
COMMENT ON COLUMN BARS.KL_Z120.D_CLOSE IS '';



PROMPT *** Create  grants  KL_Z120 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_Z120         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KL_Z120         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_Z120         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_Z120.sql =========*** End *** =====
PROMPT ===================================================================================== 
