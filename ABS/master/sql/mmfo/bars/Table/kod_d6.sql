

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KOD_D6.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KOD_D6 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KOD_D6'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KOD_D6'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KOD_D6'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KOD_D6 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KOD_D6 
   (	RAZD VARCHAR2(2), 
	GR VARCHAR2(3), 
	T020 VARCHAR2(1), 
	R020 VARCHAR2(4), 
	R011 VARCHAR2(16), 
	K071 VARCHAR2(1), 
	K072 VARCHAR2(70), 
	K081 VARCHAR2(10), 
	K051 VARCHAR2(81), 
	K111 VARCHAR2(254), 
	S183 VARCHAR2(15), 
	K030 VARCHAR2(1), 
	D_OPEN DATE, 
	D_CLOSE DATE, 
	D_MODE DATE, 
	PREM VARCHAR2(50)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KOD_D6 ***
 exec bpa.alter_policies('KOD_D6');


COMMENT ON TABLE BARS.KOD_D6 IS '';
COMMENT ON COLUMN BARS.KOD_D6.RAZD IS '';
COMMENT ON COLUMN BARS.KOD_D6.GR IS '';
COMMENT ON COLUMN BARS.KOD_D6.T020 IS '';
COMMENT ON COLUMN BARS.KOD_D6.R020 IS '';
COMMENT ON COLUMN BARS.KOD_D6.R011 IS '';
COMMENT ON COLUMN BARS.KOD_D6.K071 IS '';
COMMENT ON COLUMN BARS.KOD_D6.K072 IS '';
COMMENT ON COLUMN BARS.KOD_D6.K081 IS '';
COMMENT ON COLUMN BARS.KOD_D6.K051 IS '';
COMMENT ON COLUMN BARS.KOD_D6.K111 IS '';
COMMENT ON COLUMN BARS.KOD_D6.S183 IS '';
COMMENT ON COLUMN BARS.KOD_D6.K030 IS '';
COMMENT ON COLUMN BARS.KOD_D6.D_OPEN IS '';
COMMENT ON COLUMN BARS.KOD_D6.D_CLOSE IS '';
COMMENT ON COLUMN BARS.KOD_D6.D_MODE IS '';
COMMENT ON COLUMN BARS.KOD_D6.PREM IS '';





PROMPT *** Create SYNONYM  to KOD_D6 ***

  CREATE OR REPLACE PUBLIC SYNONYM KOD_D6 FOR BARS.KOD_D6;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KOD_D6.sql =========*** End *** ======
PROMPT ===================================================================================== 
