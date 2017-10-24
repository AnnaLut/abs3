

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KOD_OP.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KOD_OP ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KOD_OP ***
begin 
  execute immediate '
  CREATE TABLE BARS.KOD_OP 
   (	RAZDEL NUMBER(1,0), 
	GRUPPA NUMBER(3,0), 
	VID_OP NUMBER(3,0), 
	KOD_OP NUMBER(4,0), 
	NAIM_OP VARCHAR2(40), 
	DB_S NUMBER(14,0), 
	KR_S NUMBER(14,0), 
	VID NUMBER(2,0), 
	I_VA NUMBER(3,0), 
	NK_A VARCHAR2(38), 
	NK_B VARCHAR2(38), 
	NP VARCHAR2(160), 
	NM NUMBER(2,0), 
	S_OP NUMBER(14,0), 
	FLAG VARCHAR2(2), 
	KOL_SCH NUMBER(10,0), 
	OB41 VARCHAR2(4), 
	OB41K VARCHAR2(4)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KOD_OP ***
 exec bpa.alter_policies('KOD_OP');


COMMENT ON TABLE BARS.KOD_OP IS '';
COMMENT ON COLUMN BARS.KOD_OP.I_VA IS '';
COMMENT ON COLUMN BARS.KOD_OP.NK_A IS '';
COMMENT ON COLUMN BARS.KOD_OP.NK_B IS '';
COMMENT ON COLUMN BARS.KOD_OP.NP IS '';
COMMENT ON COLUMN BARS.KOD_OP.NM IS '';
COMMENT ON COLUMN BARS.KOD_OP.S_OP IS '';
COMMENT ON COLUMN BARS.KOD_OP.FLAG IS '';
COMMENT ON COLUMN BARS.KOD_OP.KOL_SCH IS '';
COMMENT ON COLUMN BARS.KOD_OP.OB41 IS '';
COMMENT ON COLUMN BARS.KOD_OP.OB41K IS '';
COMMENT ON COLUMN BARS.KOD_OP.RAZDEL IS '';
COMMENT ON COLUMN BARS.KOD_OP.GRUPPA IS '';
COMMENT ON COLUMN BARS.KOD_OP.VID_OP IS '';
COMMENT ON COLUMN BARS.KOD_OP.KOD_OP IS '';
COMMENT ON COLUMN BARS.KOD_OP.NAIM_OP IS '';
COMMENT ON COLUMN BARS.KOD_OP.DB_S IS '';
COMMENT ON COLUMN BARS.KOD_OP.KR_S IS '';
COMMENT ON COLUMN BARS.KOD_OP.VID IS '';



PROMPT *** Create  grants  KOD_OP ***
grant SELECT                                                                 on KOD_OP          to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KOD_OP          to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KOD_OP.sql =========*** End *** ======
PROMPT ===================================================================================== 
