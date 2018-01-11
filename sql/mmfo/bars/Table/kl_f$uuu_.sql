

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_F$UUU_.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_F$UUU_ ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_F$UUU_'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_F$UUU_'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_F$UUU_'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_F$UUU_ ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_F$UUU_ 
   (	NLS VARCHAR2(15), 
	KV NUMBER(*,0), 
	NMS VARCHAR2(38), 
	KOD_ORG VARCHAR2(4), 
	SUM_NG NUMBER(24,0), 
	COMM VARCHAR2(60)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KL_F$UUU_ ***
 exec bpa.alter_policies('KL_F$UUU_');


COMMENT ON TABLE BARS.KL_F$UUU_ IS '';
COMMENT ON COLUMN BARS.KL_F$UUU_.NLS IS '';
COMMENT ON COLUMN BARS.KL_F$UUU_.KV IS '';
COMMENT ON COLUMN BARS.KL_F$UUU_.NMS IS '';
COMMENT ON COLUMN BARS.KL_F$UUU_.KOD_ORG IS '';
COMMENT ON COLUMN BARS.KL_F$UUU_.SUM_NG IS '';
COMMENT ON COLUMN BARS.KL_F$UUU_.COMM IS '';




PROMPT *** Create  constraint SYS_C008559 ***
begin   
 execute immediate '
  ALTER TABLE BARS.KL_F$UUU_ MODIFY (NLS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008560 ***
begin   
 execute immediate '
  ALTER TABLE BARS.KL_F$UUU_ MODIFY (KV NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KL_F$UUU_ ***
grant SELECT                                                                 on KL_F$UUU_       to BARSREADER_ROLE;
grant SELECT                                                                 on KL_F$UUU_       to BARS_DM;
grant SELECT                                                                 on KL_F$UUU_       to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KL_F$UUU_       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_F$UUU_.sql =========*** End *** ===
PROMPT ===================================================================================== 
