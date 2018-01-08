

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_S245.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_S245 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_S245 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_S245 
   (	S245 VARCHAR2(1), 
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




PROMPT *** ALTER_POLICIES to KL_S245 ***
 exec bpa.alter_policies('KL_S245');


COMMENT ON TABLE BARS.KL_S245 IS '';
COMMENT ON COLUMN BARS.KL_S245.S245 IS '';
COMMENT ON COLUMN BARS.KL_S245.TXT IS '';
COMMENT ON COLUMN BARS.KL_S245.DATA_O IS '';
COMMENT ON COLUMN BARS.KL_S245.DATA_C IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_S245.sql =========*** End *** =====
PROMPT ===================================================================================== 
