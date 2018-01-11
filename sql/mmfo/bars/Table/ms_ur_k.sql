

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/MS_UR_K.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to MS_UR_K ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''MS_UR_K'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''MS_UR_K'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''MS_UR_K'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table MS_UR_K ***
begin 
  execute immediate '
  CREATE TABLE BARS.MS_UR_K 
   (	ID NUMBER, 
	NAME VARCHAR2(35)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to MS_UR_K ***
 exec bpa.alter_policies('MS_UR_K');


COMMENT ON TABLE BARS.MS_UR_K IS 'Справ.уровней принятия решения';
COMMENT ON COLUMN BARS.MS_UR_K.ID IS 'Код';
COMMENT ON COLUMN BARS.MS_UR_K.NAME IS 'Наименование';




PROMPT *** Create  constraint XPK_MS_UR_K ***
begin   
 execute immediate '
  ALTER TABLE BARS.MS_UR_K ADD CONSTRAINT XPK_MS_UR_K PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007897 ***
begin   
 execute immediate '
  ALTER TABLE BARS.MS_UR_K MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_MS_UR_K ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_MS_UR_K ON BARS.MS_UR_K (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  MS_UR_K ***
grant SELECT                                                                 on MS_UR_K         to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on MS_UR_K         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on MS_UR_K         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on MS_UR_K         to CC_AIM;
grant DELETE,INSERT,SELECT,UPDATE                                            on MS_UR_K         to RCC_DEAL;
grant SELECT                                                                 on MS_UR_K         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on MS_UR_K         to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on MS_UR_K         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/MS_UR_K.sql =========*** End *** =====
PROMPT ===================================================================================== 
