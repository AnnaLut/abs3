

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_S032.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_S032 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_S032'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_S032'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_S032'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_S032 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_S032 
   (	S032 CHAR(1), 
	TXT VARCHAR2(68), 
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




PROMPT *** ALTER_POLICIES to KL_S032 ***
 exec bpa.alter_policies('KL_S032');


COMMENT ON TABLE BARS.KL_S032 IS '';
COMMENT ON COLUMN BARS.KL_S032.S032 IS '';
COMMENT ON COLUMN BARS.KL_S032.TXT IS '';
COMMENT ON COLUMN BARS.KL_S032.D_OPEN IS '';
COMMENT ON COLUMN BARS.KL_S032.D_CLOSE IS '';
COMMENT ON COLUMN BARS.KL_S032.D_MODE IS '';



PROMPT *** Create  grants  KL_S032 ***
grant SELECT                                                                 on KL_S032         to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_S032         to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_S032         to START1;
grant SELECT                                                                 on KL_S032         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_S032.sql =========*** End *** =====
PROMPT ===================================================================================== 
