

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_F$UUU.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_F$UUU ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_F$UUU'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_F$UUU'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''KL_F$UUU'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_F$UUU ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_F$UUU 
   (	NLS VARCHAR2(15), 
	KV NUMBER(*,0), 
	NMS VARCHAR2(38), 
	KOD_ORG VARCHAR2(4), 
	SUM_NG NUMBER(24,0), 
	COMM VARCHAR2(60), 
	N_SORT NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KL_F$UUU ***
 exec bpa.alter_policies('KL_F$UUU');


COMMENT ON TABLE BARS.KL_F$UUU IS 'Довiдник осбових рахункiв для DBF файлу $UUUDDMM ОщадБанку';
COMMENT ON COLUMN BARS.KL_F$UUU.NLS IS 'Особовий рахунок';
COMMENT ON COLUMN BARS.KL_F$UUU.KV IS 'Код валюти';
COMMENT ON COLUMN BARS.KL_F$UUU.NMS IS 'Назва рахунку';
COMMENT ON COLUMN BARS.KL_F$UUU.KOD_ORG IS 'Код органiзацii';
COMMENT ON COLUMN BARS.KL_F$UUU.SUM_NG IS 'Сума оборотiв з початку року';
COMMENT ON COLUMN BARS.KL_F$UUU.COMM IS 'Коментар';
COMMENT ON COLUMN BARS.KL_F$UUU.N_SORT IS '';




PROMPT *** Create  constraint XPK_KL_F$UUU ***
begin   
 execute immediate '
  ALTER TABLE BARS.KL_F$UUU ADD CONSTRAINT XPK_KL_F$UUU PRIMARY KEY (NLS, KV)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009202 ***
begin   
 execute immediate '
  ALTER TABLE BARS.KL_F$UUU MODIFY (NLS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009203 ***
begin   
 execute immediate '
  ALTER TABLE BARS.KL_F$UUU MODIFY (KV NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_KL_F$UUU ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_KL_F$UUU ON BARS.KL_F$UUU (NLS, KV) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KL_F$UUU ***
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on KL_F$UUU        to ABS_ADMIN;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on KL_F$UUU        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KL_F$UUU        to BARS_DM;
grant SELECT                                                                 on KL_F$UUU        to RPBN002;
grant SELECT                                                                 on KL_F$UUU        to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KL_F$UUU        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_F$UUU.sql =========*** End *** ====
PROMPT ===================================================================================== 
