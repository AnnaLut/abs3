

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_S370.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_S370 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_S370'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_S370'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_S370'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_S370 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_S370 
   (	S370 CHAR(1), 
	TXT VARCHAR2(48), 
	DATA_O DATE, 
	DATA_C DATE, 
	DATA_M DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KL_S370 ***
 exec bpa.alter_policies('KL_S370');


COMMENT ON TABLE BARS.KL_S370 IS '';
COMMENT ON COLUMN BARS.KL_S370.S370 IS '';
COMMENT ON COLUMN BARS.KL_S370.TXT IS '';
COMMENT ON COLUMN BARS.KL_S370.DATA_O IS '';
COMMENT ON COLUMN BARS.KL_S370.DATA_C IS '';
COMMENT ON COLUMN BARS.KL_S370.DATA_M IS '';



PROMPT *** Create  grants  KL_S370 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_S370         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KL_S370         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_S370         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_S370.sql =========*** End *** =====
PROMPT ===================================================================================== 
