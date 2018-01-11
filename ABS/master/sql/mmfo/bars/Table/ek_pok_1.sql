

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EK_POK_1.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EK_POK_1 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''EK_POK_1'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''EK_POK_1'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''EK_POK_1'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EK_POK_1 ***
begin 
  execute immediate '
  CREATE TABLE BARS.EK_POK_1 
   (	A010 VARCHAR2(2), 
	KOD_EKPOK VARCHAR2(48), 
	TXT VARCHAR2(96), 
	PRM1 VARCHAR2(10), 
	PRM2 VARCHAR2(163), 
	PRM21 VARCHAR2(65), 
	PRM3 VARCHAR2(24), 
	PRM4 VARCHAR2(254), 
	PRM41 VARCHAR2(55), 
	PRM5 VARCHAR2(96), 
	TYP VARCHAR2(1), 
	WIDTH NUMBER(3,0), 
	DEC NUMBER(1,0), 
	FORMA VARCHAR2(24), 
	DATA_O DATE, 
	TELEFON VARCHAR2(9), 
	DEPARTAM VARCHAR2(24), 
	FIO VARCHAR2(18), 
	PRIZNAK VARCHAR2(1), 
	REM VARCHAR2(3), 
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




PROMPT *** ALTER_POLICIES to EK_POK_1 ***
 exec bpa.alter_policies('EK_POK_1');


COMMENT ON TABLE BARS.EK_POK_1 IS '';
COMMENT ON COLUMN BARS.EK_POK_1.A010 IS '';
COMMENT ON COLUMN BARS.EK_POK_1.KOD_EKPOK IS '';
COMMENT ON COLUMN BARS.EK_POK_1.TXT IS '';
COMMENT ON COLUMN BARS.EK_POK_1.PRM1 IS '';
COMMENT ON COLUMN BARS.EK_POK_1.PRM2 IS '';
COMMENT ON COLUMN BARS.EK_POK_1.PRM21 IS '';
COMMENT ON COLUMN BARS.EK_POK_1.PRM3 IS '';
COMMENT ON COLUMN BARS.EK_POK_1.PRM4 IS '';
COMMENT ON COLUMN BARS.EK_POK_1.PRM41 IS '';
COMMENT ON COLUMN BARS.EK_POK_1.PRM5 IS '';
COMMENT ON COLUMN BARS.EK_POK_1.TYP IS '';
COMMENT ON COLUMN BARS.EK_POK_1.WIDTH IS '';
COMMENT ON COLUMN BARS.EK_POK_1.DEC IS '';
COMMENT ON COLUMN BARS.EK_POK_1.FORMA IS '';
COMMENT ON COLUMN BARS.EK_POK_1.DATA_O IS '';
COMMENT ON COLUMN BARS.EK_POK_1.TELEFON IS '';
COMMENT ON COLUMN BARS.EK_POK_1.DEPARTAM IS '';
COMMENT ON COLUMN BARS.EK_POK_1.FIO IS '';
COMMENT ON COLUMN BARS.EK_POK_1.PRIZNAK IS '';
COMMENT ON COLUMN BARS.EK_POK_1.REM IS '';
COMMENT ON COLUMN BARS.EK_POK_1.DATA_C IS '';
COMMENT ON COLUMN BARS.EK_POK_1.DATA_M IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EK_POK_1.sql =========*** End *** ====
PROMPT ===================================================================================== 
