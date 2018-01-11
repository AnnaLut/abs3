

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SV_TICK.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SV_TICK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SV_TICK'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SV_TICK'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SV_TICK'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SV_TICK ***
begin 
  execute immediate '
  CREATE TABLE BARS.SV_TICK 
   (	TICK_NAME VARCHAR2(12), 
	ID_ROW NUMBER(10,0), 
	ERR_REK VARCHAR2(20), 
	ERR_KOD VARCHAR2(4)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SV_TICK ***
 exec bpa.alter_policies('SV_TICK');


COMMENT ON TABLE BARS.SV_TICK IS 'Квитанції P7*';
COMMENT ON COLUMN BARS.SV_TICK.TICK_NAME IS 'Імя файлу';
COMMENT ON COLUMN BARS.SV_TICK.ID_ROW IS 'Рядок';
COMMENT ON COLUMN BARS.SV_TICK.ERR_REK IS 'Назва помилкового реквізиту/структури';
COMMENT ON COLUMN BARS.SV_TICK.ERR_KOD IS 'Код помилки за реквізитом';




PROMPT *** Create  constraint PK_SVTICK_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.SV_TICK ADD CONSTRAINT PK_SVTICK_ID PRIMARY KEY (TICK_NAME, ID_ROW)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SVTICK_TICKNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SV_TICK MODIFY (TICK_NAME CONSTRAINT CC_SVTICK_TICKNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SVTICK_IDROW_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SV_TICK MODIFY (ID_ROW CONSTRAINT CC_SVTICK_IDROW_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SVTICK_ID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SVTICK_ID ON BARS.SV_TICK (TICK_NAME, ID_ROW) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SV_TICK ***
grant SELECT                                                                 on SV_TICK         to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SV_TICK         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SV_TICK         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on SV_TICK         to RPBN002;
grant SELECT                                                                 on SV_TICK         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SV_TICK.sql =========*** End *** =====
PROMPT ===================================================================================== 
