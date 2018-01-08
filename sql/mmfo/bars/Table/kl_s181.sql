

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_S181.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_S181 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_S181'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_S181'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_S181'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_S181 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_S181 
   (	S181 VARCHAR2(1), 
	TXT VARCHAR2(128)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KL_S181 ***
 exec bpa.alter_policies('KL_S181');


COMMENT ON TABLE BARS.KL_S181 IS '';
COMMENT ON COLUMN BARS.KL_S181.S181 IS '';
COMMENT ON COLUMN BARS.KL_S181.TXT IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_S181.sql =========*** End *** =====
PROMPT ===================================================================================== 
