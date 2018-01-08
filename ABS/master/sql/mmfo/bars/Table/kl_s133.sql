

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_S133.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_S133 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_S133'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_S133'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_S133'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_S133 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_S133 
   (	S131 VARCHAR2(1), 
	S132 VARCHAR2(1), 
	S133 VARCHAR2(2), 
	TXT VARCHAR2(68), 
	TXT27 VARCHAR2(27), 
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




PROMPT *** ALTER_POLICIES to KL_S133 ***
 exec bpa.alter_policies('KL_S133');


COMMENT ON TABLE BARS.KL_S133 IS '';
COMMENT ON COLUMN BARS.KL_S133.S131 IS '';
COMMENT ON COLUMN BARS.KL_S133.S132 IS '';
COMMENT ON COLUMN BARS.KL_S133.S133 IS '';
COMMENT ON COLUMN BARS.KL_S133.TXT IS '';
COMMENT ON COLUMN BARS.KL_S133.TXT27 IS '';
COMMENT ON COLUMN BARS.KL_S133.DATA_O IS '';
COMMENT ON COLUMN BARS.KL_S133.DATA_C IS '';



PROMPT *** Create  grants  KL_S133 ***
grant SELECT                                                                 on KL_S133         to BARSREADER_ROLE;
grant SELECT                                                                 on KL_S133         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_S133.sql =========*** End *** =====
PROMPT ===================================================================================== 
