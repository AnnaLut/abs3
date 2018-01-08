

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_S184.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_S184 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_S184'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_S184'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_S184'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_S184 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_S184 
   (	S184 VARCHAR2(1), 
	S181 VARCHAR2(1), 
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




PROMPT *** ALTER_POLICIES to KL_S184 ***
 exec bpa.alter_policies('KL_S184');


COMMENT ON TABLE BARS.KL_S184 IS '';
COMMENT ON COLUMN BARS.KL_S184.S184 IS '';
COMMENT ON COLUMN BARS.KL_S184.S181 IS '';
COMMENT ON COLUMN BARS.KL_S184.TXT IS '';
COMMENT ON COLUMN BARS.KL_S184.DATA_O IS '';
COMMENT ON COLUMN BARS.KL_S184.DATA_C IS '';
COMMENT ON COLUMN BARS.KL_S184.DATA_M IS '';



PROMPT *** Create  grants  KL_S184 ***
grant SELECT                                                                 on KL_S184         to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_S184.sql =========*** End *** =====
PROMPT ===================================================================================== 
