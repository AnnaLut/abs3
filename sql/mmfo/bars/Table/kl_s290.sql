

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_S290.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_S290 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_S290'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_S290'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_S290'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_S290 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_S290 
   (	S290 CHAR(1), 
	TXT VARCHAR2(40), 
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




PROMPT *** ALTER_POLICIES to KL_S290 ***
 exec bpa.alter_policies('KL_S290');


COMMENT ON TABLE BARS.KL_S290 IS '';
COMMENT ON COLUMN BARS.KL_S290.S290 IS '';
COMMENT ON COLUMN BARS.KL_S290.TXT IS '';
COMMENT ON COLUMN BARS.KL_S290.DATA_O IS '';
COMMENT ON COLUMN BARS.KL_S290.DATA_C IS '';
COMMENT ON COLUMN BARS.KL_S290.DATA_M IS '';



PROMPT *** Create  grants  KL_S290 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_S290         to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_S290         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_S290.sql =========*** End *** =====
PROMPT ===================================================================================== 
