

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_Z271.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_Z271 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_Z271'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_Z271'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_Z271'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_Z271 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_Z271 
   (	Z271 CHAR(1), 
	TXT VARCHAR2(27)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KL_Z271 ***
 exec bpa.alter_policies('KL_Z271');


COMMENT ON TABLE BARS.KL_Z271 IS '';
COMMENT ON COLUMN BARS.KL_Z271.Z271 IS '';
COMMENT ON COLUMN BARS.KL_Z271.TXT IS '';



PROMPT *** Create  grants  KL_Z271 ***
grant SELECT                                                                 on KL_Z271         to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_Z271         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KL_Z271         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_Z271         to START1;
grant SELECT                                                                 on KL_Z271         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_Z271.sql =========*** End *** =====
PROMPT ===================================================================================== 
