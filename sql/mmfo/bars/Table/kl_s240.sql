

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_S240.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_S240 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_S240'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_S240'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_S240'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_S240 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_S240 
   (	S240 VARCHAR2(1), 
	S242 VARCHAR2(1), 
	S245 VARCHAR2(1), 
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




PROMPT *** ALTER_POLICIES to KL_S240 ***
 exec bpa.alter_policies('KL_S240');


COMMENT ON TABLE BARS.KL_S240 IS '';
COMMENT ON COLUMN BARS.KL_S240.S240 IS '';
COMMENT ON COLUMN BARS.KL_S240.S242 IS '';
COMMENT ON COLUMN BARS.KL_S240.S245 IS '';
COMMENT ON COLUMN BARS.KL_S240.TXT IS '';
COMMENT ON COLUMN BARS.KL_S240.DATA_O IS '';
COMMENT ON COLUMN BARS.KL_S240.DATA_C IS '';
COMMENT ON COLUMN BARS.KL_S240.DATA_M IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_S240.sql =========*** End *** =====
PROMPT ===================================================================================== 
