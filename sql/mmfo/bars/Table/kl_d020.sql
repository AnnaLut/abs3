

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_D020.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_D020 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_D020'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_D020'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_D020'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_D020 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_D020 
   (	PREM VARCHAR2(3), 
	R020 VARCHAR2(4), 
	D020 VARCHAR2(2), 
	T020 VARCHAR2(1), 
	TXT VARCHAR2(250), 
	A010 VARCHAR2(2), 
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




PROMPT *** ALTER_POLICIES to KL_D020 ***
 exec bpa.alter_policies('KL_D020');


COMMENT ON TABLE BARS.KL_D020 IS '';
COMMENT ON COLUMN BARS.KL_D020.PREM IS '';
COMMENT ON COLUMN BARS.KL_D020.R020 IS '';
COMMENT ON COLUMN BARS.KL_D020.D020 IS '';
COMMENT ON COLUMN BARS.KL_D020.T020 IS '';
COMMENT ON COLUMN BARS.KL_D020.TXT IS '';
COMMENT ON COLUMN BARS.KL_D020.A010 IS '';
COMMENT ON COLUMN BARS.KL_D020.D_OPEN IS '';
COMMENT ON COLUMN BARS.KL_D020.D_CLOSE IS '';
COMMENT ON COLUMN BARS.KL_D020.D_MODE IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_D020.sql =========*** End *** =====
PROMPT ===================================================================================== 
