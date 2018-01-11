

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/S6_DEPARTAMENT.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to S6_DEPARTAMENT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''S6_DEPARTAMENT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''S6_DEPARTAMENT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''S6_DEPARTAMENT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table S6_DEPARTAMENT ***
begin 
  execute immediate '
  CREATE TABLE BARS.S6_DEPARTAMENT 
   (	DEPART NUMBER(5,0), 
	HIG_DEPART NUMBER(5,0), 
	NAM_DEPART VARCHAR2(120), 
	BIC NUMBER(10,0), 
	C_KO NUMBER(3,0), 
	K040 CHAR(3), 
	KL_OBU VARCHAR2(20), 
	D_BEGIN DATE, 
	ID_FOLDER NUMBER(10,0), 
	N_PACK NUMBER(5,0), 
	Y_RDB NUMBER(3,0), 
	M_BEGIN NUMBER(3,0), 
	HIG_BIC NUMBER(10,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to S6_DEPARTAMENT ***
 exec bpa.alter_policies('S6_DEPARTAMENT');


COMMENT ON TABLE BARS.S6_DEPARTAMENT IS '';
COMMENT ON COLUMN BARS.S6_DEPARTAMENT.DEPART IS '';
COMMENT ON COLUMN BARS.S6_DEPARTAMENT.HIG_DEPART IS '';
COMMENT ON COLUMN BARS.S6_DEPARTAMENT.NAM_DEPART IS '';
COMMENT ON COLUMN BARS.S6_DEPARTAMENT.BIC IS '';
COMMENT ON COLUMN BARS.S6_DEPARTAMENT.C_KO IS '';
COMMENT ON COLUMN BARS.S6_DEPARTAMENT.K040 IS '';
COMMENT ON COLUMN BARS.S6_DEPARTAMENT.KL_OBU IS '';
COMMENT ON COLUMN BARS.S6_DEPARTAMENT.D_BEGIN IS '';
COMMENT ON COLUMN BARS.S6_DEPARTAMENT.ID_FOLDER IS '';
COMMENT ON COLUMN BARS.S6_DEPARTAMENT.N_PACK IS '';
COMMENT ON COLUMN BARS.S6_DEPARTAMENT.Y_RDB IS '';
COMMENT ON COLUMN BARS.S6_DEPARTAMENT.M_BEGIN IS '';
COMMENT ON COLUMN BARS.S6_DEPARTAMENT.HIG_BIC IS '';




PROMPT *** Create  constraint SYS_C009259 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_DEPARTAMENT MODIFY (DEPART NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009260 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_DEPARTAMENT MODIFY (BIC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009261 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_DEPARTAMENT MODIFY (C_KO NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  S6_DEPARTAMENT ***
grant SELECT                                                                 on S6_DEPARTAMENT  to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on S6_DEPARTAMENT  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on S6_DEPARTAMENT  to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on S6_DEPARTAMENT  to START1;
grant SELECT                                                                 on S6_DEPARTAMENT  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/S6_DEPARTAMENT.sql =========*** End **
PROMPT ===================================================================================== 
