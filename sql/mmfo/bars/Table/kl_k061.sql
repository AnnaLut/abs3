

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_K061.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_K061 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_K061 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_K061 
   (	K061 VARCHAR2(1), 
	TXT VARCHAR2(48), 
	D_OPEN DATE, 
	D_CLOSE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KL_K061 ***
 exec bpa.alter_policies('KL_K061');


COMMENT ON TABLE BARS.KL_K061 IS '';
COMMENT ON COLUMN BARS.KL_K061.K061 IS '';
COMMENT ON COLUMN BARS.KL_K061.TXT IS '';
COMMENT ON COLUMN BARS.KL_K061.D_OPEN IS '';
COMMENT ON COLUMN BARS.KL_K061.D_CLOSE IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_K061.sql =========*** End *** =====
PROMPT ===================================================================================== 
