

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_Z140.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_Z140 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_Z140 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_Z140 
   (	Z140 VARCHAR2(1), 
	TXT VARCHAR2(81), 
	D_OPEN DATE, 
	D_CLOSE DATE, 
	D_MODE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KL_Z140 ***
 exec bpa.alter_policies('KL_Z140');


COMMENT ON TABLE BARS.KL_Z140 IS '';
COMMENT ON COLUMN BARS.KL_Z140.Z140 IS '';
COMMENT ON COLUMN BARS.KL_Z140.TXT IS '';
COMMENT ON COLUMN BARS.KL_Z140.D_OPEN IS '';
COMMENT ON COLUMN BARS.KL_Z140.D_CLOSE IS '';
COMMENT ON COLUMN BARS.KL_Z140.D_MODE IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_Z140.sql =========*** End *** =====
PROMPT ===================================================================================== 
