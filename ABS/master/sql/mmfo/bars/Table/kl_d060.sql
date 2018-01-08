

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_D060.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_D060 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_D060'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_D060'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_D060'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_D060 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_D060 
   (	D060 VARCHAR2(2), 
	D060K030 VARCHAR2(1), 
	TXT VARCHAR2(60), 
	PO_NAME VARCHAR2(40), 
	PO_KOD VARCHAR2(3), 
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




PROMPT *** ALTER_POLICIES to KL_D060 ***
 exec bpa.alter_policies('KL_D060');


COMMENT ON TABLE BARS.KL_D060 IS '';
COMMENT ON COLUMN BARS.KL_D060.D060 IS '';
COMMENT ON COLUMN BARS.KL_D060.D060K030 IS '';
COMMENT ON COLUMN BARS.KL_D060.TXT IS '';
COMMENT ON COLUMN BARS.KL_D060.PO_NAME IS '';
COMMENT ON COLUMN BARS.KL_D060.PO_KOD IS '';
COMMENT ON COLUMN BARS.KL_D060.D_OPEN IS '';
COMMENT ON COLUMN BARS.KL_D060.D_CLOSE IS '';
COMMENT ON COLUMN BARS.KL_D060.D_MODE IS '';





PROMPT *** Create SYNONYM  to KL_D060 ***

  CREATE OR REPLACE PUBLIC SYNONYM KL_D060 FOR BARS.KL_D060;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_D060.sql =========*** End *** =====
PROMPT ===================================================================================== 
