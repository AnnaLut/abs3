

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_Z275.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_Z275 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_Z275'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_Z275'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_Z275'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_Z275 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_Z275 
   (	Z275 CHAR(1), 
	TXT VARCHAR2(27)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KL_Z275 ***
 exec bpa.alter_policies('KL_Z275');


COMMENT ON TABLE BARS.KL_Z275 IS '';
COMMENT ON COLUMN BARS.KL_Z275.Z275 IS '';
COMMENT ON COLUMN BARS.KL_Z275.TXT IS '';



PROMPT *** Create  grants  KL_Z275 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_Z275         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KL_Z275         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_Z275         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_Z275.sql =========*** End *** =====
PROMPT ===================================================================================== 
