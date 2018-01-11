

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_S190.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_S190 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_S190'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_S190'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_S190'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_S190 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_S190 
   (	S190 VARCHAR2(1), 
	TXT VARCHAR2(48), 
	DATA_O DATE, 
	DATA_C DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KL_S190 ***
 exec bpa.alter_policies('KL_S190');


COMMENT ON TABLE BARS.KL_S190 IS '';
COMMENT ON COLUMN BARS.KL_S190.S190 IS '';
COMMENT ON COLUMN BARS.KL_S190.TXT IS '';
COMMENT ON COLUMN BARS.KL_S190.DATA_O IS '';
COMMENT ON COLUMN BARS.KL_S190.DATA_C IS '';



PROMPT *** Create  grants  KL_S190 ***
grant SELECT                                                                 on KL_S190         to UPLD;



PROMPT *** Create SYNONYM  to KL_S190 ***

  CREATE OR REPLACE PUBLIC SYNONYM KL_S190 FOR BARS.KL_S190;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_S190.sql =========*** End *** =====
PROMPT ===================================================================================== 
