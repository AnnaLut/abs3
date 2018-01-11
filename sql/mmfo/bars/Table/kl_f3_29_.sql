

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_F3_29_.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_F3_29_ ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_F3_29_'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_F3_29_'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_F3_29_'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_F3_29_ ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_F3_29_ 
   (	KF CHAR(2), 
	R020 CHAR(4), 
	R050 CHAR(2), 
	R012 CHAR(1), 
	DDD CHAR(3), 
	TXT VARCHAR2(60), 
	S240 CHAR(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KL_F3_29_ ***
 exec bpa.alter_policies('KL_F3_29_');


COMMENT ON TABLE BARS.KL_F3_29_ IS '';
COMMENT ON COLUMN BARS.KL_F3_29_.KF IS '';
COMMENT ON COLUMN BARS.KL_F3_29_.R020 IS '';
COMMENT ON COLUMN BARS.KL_F3_29_.R050 IS '';
COMMENT ON COLUMN BARS.KL_F3_29_.R012 IS '';
COMMENT ON COLUMN BARS.KL_F3_29_.DDD IS '';
COMMENT ON COLUMN BARS.KL_F3_29_.TXT IS '';
COMMENT ON COLUMN BARS.KL_F3_29_.S240 IS '';



PROMPT *** Create  grants  KL_F3_29_ ***
grant SELECT                                                                 on KL_F3_29_       to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_F3_29_       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KL_F3_29_       to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_F3_29_       to START1;
grant SELECT                                                                 on KL_F3_29_       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_F3_29_.sql =========*** End *** ===
PROMPT ===================================================================================== 
