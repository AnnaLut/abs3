

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_S210.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_S210 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_S210 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_S210 
   (	S210 VARCHAR2(1), 
	TXT VARCHAR2(54), 
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




PROMPT *** ALTER_POLICIES to KL_S210 ***
 exec bpa.alter_policies('KL_S210');


COMMENT ON TABLE BARS.KL_S210 IS '';
COMMENT ON COLUMN BARS.KL_S210.S210 IS '';
COMMENT ON COLUMN BARS.KL_S210.TXT IS '';
COMMENT ON COLUMN BARS.KL_S210.DATA_O IS '';
COMMENT ON COLUMN BARS.KL_S210.DATA_C IS '';
COMMENT ON COLUMN BARS.KL_S210.DATA_M IS '';



PROMPT *** Create  grants  KL_S210 ***
grant SELECT                                                                 on KL_S210         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_S210.sql =========*** End *** =====
PROMPT ===================================================================================== 
