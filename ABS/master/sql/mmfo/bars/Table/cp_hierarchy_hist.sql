

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_HIERARCHY_HIST.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_HIERARCHY_HIST ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_HIERARCHY_HIST'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CP_HIERARCHY_HIST'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CP_HIERARCHY_HIST'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CP_HIERARCHY_HIST ***
begin 
  execute immediate '
  CREATE TABLE BARS.CP_HIERARCHY_HIST 
   (	CP_ID NUMBER(*,0), 
	FDAT DATE, 
	HIERARCHY_ID NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CP_HIERARCHY_HIST ***
 exec bpa.alter_policies('CP_HIERARCHY_HIST');


COMMENT ON TABLE BARS.CP_HIERARCHY_HIST IS 'Історія змін ієрархії справедливої вартості цінних паперів';
COMMENT ON COLUMN BARS.CP_HIERARCHY_HIST.CP_ID IS 'Ідентифікатор CP';
COMMENT ON COLUMN BARS.CP_HIERARCHY_HIST.FDAT IS 'Дата зміни рівня';
COMMENT ON COLUMN BARS.CP_HIERARCHY_HIST.HIERARCHY_ID IS 'ID рівня ієрархії';




PROMPT *** Create  constraint XPK_CP_HIERARCHY_HIST ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_HIERARCHY_HIST ADD CONSTRAINT XPK_CP_HIERARCHY_HIST PRIMARY KEY (CP_ID, FDAT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007458 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_HIERARCHY_HIST MODIFY (CP_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007459 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_HIERARCHY_HIST MODIFY (FDAT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CP_HIERARCHY_HIST ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CP_HIERARCHY_HIST ON BARS.CP_HIERARCHY_HIST (CP_ID, FDAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CP_HIERARCHY_HIST ***
grant SELECT                                                                 on CP_HIERARCHY_HIST to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CP_HIERARCHY_HIST to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CP_HIERARCHY_HIST to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_HIERARCHY_HIST to CP_ROLE;
grant SELECT                                                                 on CP_HIERARCHY_HIST to UPLD;
grant FLASHBACK,SELECT                                                       on CP_HIERARCHY_HIST to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_HIERARCHY_HIST.sql =========*** End
PROMPT ===================================================================================== 
