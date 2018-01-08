

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_F00_INT_K.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_F00_INT_K ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_F00_INT_K'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_F00_INT_K'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_F00_INT_K'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_F00_INT_K ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_F00_INT_K 
   (	KODF CHAR(2), 
	UUU CHAR(3), 
	AA CHAR(2), 
	A017 CHAR(1), 
	ZZZ VARCHAR2(12), 
	NN CHAR(2), 
	PATH_O VARCHAR2(35), 
	PERIOD CHAR(1), 
	DATF DATE, 
	NOM CHAR(1), 
	PROCC VARCHAR2(5), 
	R CHAR(1), 
	SEMANTIC VARCHAR2(70), 
	KODF_EXT VARCHAR2(2), 
	F_PREF VARCHAR2(1), 
	BRANCH VARCHAR2(30), 
	POLICY_GROUP VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KL_F00_INT_K ***
 exec bpa.alter_policies('KL_F00_INT_K');


COMMENT ON TABLE BARS.KL_F00_INT_K IS '';
COMMENT ON COLUMN BARS.KL_F00_INT_K.KODF IS '';
COMMENT ON COLUMN BARS.KL_F00_INT_K.UUU IS '';
COMMENT ON COLUMN BARS.KL_F00_INT_K.AA IS '';
COMMENT ON COLUMN BARS.KL_F00_INT_K.A017 IS '';
COMMENT ON COLUMN BARS.KL_F00_INT_K.ZZZ IS '';
COMMENT ON COLUMN BARS.KL_F00_INT_K.NN IS '';
COMMENT ON COLUMN BARS.KL_F00_INT_K.PATH_O IS '';
COMMENT ON COLUMN BARS.KL_F00_INT_K.PERIOD IS '';
COMMENT ON COLUMN BARS.KL_F00_INT_K.DATF IS '';
COMMENT ON COLUMN BARS.KL_F00_INT_K.NOM IS '';
COMMENT ON COLUMN BARS.KL_F00_INT_K.PROCC IS '';
COMMENT ON COLUMN BARS.KL_F00_INT_K.R IS '';
COMMENT ON COLUMN BARS.KL_F00_INT_K.SEMANTIC IS '';
COMMENT ON COLUMN BARS.KL_F00_INT_K.KODF_EXT IS '';
COMMENT ON COLUMN BARS.KL_F00_INT_K.F_PREF IS '';
COMMENT ON COLUMN BARS.KL_F00_INT_K.BRANCH IS '';
COMMENT ON COLUMN BARS.KL_F00_INT_K.POLICY_GROUP IS '';




PROMPT *** Create  constraint SYS_C007189 ***
begin   
 execute immediate '
  ALTER TABLE BARS.KL_F00_INT_K MODIFY (KODF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007190 ***
begin   
 execute immediate '
  ALTER TABLE BARS.KL_F00_INT_K MODIFY (PROCC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007191 ***
begin   
 execute immediate '
  ALTER TABLE BARS.KL_F00_INT_K MODIFY (BRANCH NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KL_F00_INT_K ***
grant SELECT                                                                 on KL_F00_INT_K    to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KL_F00_INT_K    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_F00_INT_K.sql =========*** End *** 
PROMPT ===================================================================================== 
