

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/S6_S6_DEPARTAMENT.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to S6_S6_DEPARTAMENT ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table S6_S6_DEPARTAMENT ***
begin 
  execute immediate '
  CREATE TABLE BARS.S6_S6_DEPARTAMENT 
   (	DEPART NUMBER(11,0), 
	HIG_DEPART NUMBER(11,0), 
	NAM_DEPART VARCHAR2(120), 
	BIC NUMBER(11,0), 
	C_KO NUMBER(11,0), 
	K040 VARCHAR2(3), 
	KL_OBU VARCHAR2(20), 
	D_BEGIN DATE, 
	ID_FOLDER NUMBER(11,0), 
	N_PACK NUMBER(11,0), 
	Y_RDB NUMBER(11,0), 
	M_BEGIN NUMBER(11,0), 
	HIG_BIC NUMBER(11,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to S6_S6_DEPARTAMENT ***
 exec bpa.alter_policies('S6_S6_DEPARTAMENT');


COMMENT ON TABLE BARS.S6_S6_DEPARTAMENT IS '';
COMMENT ON COLUMN BARS.S6_S6_DEPARTAMENT.DEPART IS '';
COMMENT ON COLUMN BARS.S6_S6_DEPARTAMENT.HIG_DEPART IS '';
COMMENT ON COLUMN BARS.S6_S6_DEPARTAMENT.NAM_DEPART IS '';
COMMENT ON COLUMN BARS.S6_S6_DEPARTAMENT.BIC IS '';
COMMENT ON COLUMN BARS.S6_S6_DEPARTAMENT.C_KO IS '';
COMMENT ON COLUMN BARS.S6_S6_DEPARTAMENT.K040 IS '';
COMMENT ON COLUMN BARS.S6_S6_DEPARTAMENT.KL_OBU IS '';
COMMENT ON COLUMN BARS.S6_S6_DEPARTAMENT.D_BEGIN IS '';
COMMENT ON COLUMN BARS.S6_S6_DEPARTAMENT.ID_FOLDER IS '';
COMMENT ON COLUMN BARS.S6_S6_DEPARTAMENT.N_PACK IS '';
COMMENT ON COLUMN BARS.S6_S6_DEPARTAMENT.Y_RDB IS '';
COMMENT ON COLUMN BARS.S6_S6_DEPARTAMENT.M_BEGIN IS '';
COMMENT ON COLUMN BARS.S6_S6_DEPARTAMENT.HIG_BIC IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/S6_S6_DEPARTAMENT.sql =========*** End
PROMPT ===================================================================================== 
