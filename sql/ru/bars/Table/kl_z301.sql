

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_Z301.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_Z301 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_Z301'', ''FILIAL'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_Z301 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_Z301 
   (	Z301 CHAR(3), 
	TXT VARCHAR2(102), 
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




PROMPT *** ALTER_POLICIES to KL_Z301 ***
 exec bpa.alter_policies('KL_Z301');


COMMENT ON TABLE BARS.KL_Z301 IS '';
COMMENT ON COLUMN BARS.KL_Z301.Z301 IS '';
COMMENT ON COLUMN BARS.KL_Z301.TXT IS '';
COMMENT ON COLUMN BARS.KL_Z301.D_OPEN IS '';
COMMENT ON COLUMN BARS.KL_Z301.D_CLOSE IS '';



PROMPT *** Create  grants  KL_Z301 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_Z301         to KL_Z301;
grant SELECT                                                                 on KL_Z301         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_Z301.sql =========*** End *** =====
PROMPT ===================================================================================== 
