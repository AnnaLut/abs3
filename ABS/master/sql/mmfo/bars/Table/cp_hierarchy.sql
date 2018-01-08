

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_HIERARCHY.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_HIERARCHY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_HIERARCHY'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CP_HIERARCHY'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CP_HIERARCHY'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CP_HIERARCHY ***
begin 
  execute immediate '
  CREATE TABLE BARS.CP_HIERARCHY 
   (	ID NUMBER(*,0), 
	NAME VARCHAR2(50), 
	DESCRIPTION VARCHAR2(200)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CP_HIERARCHY ***
 exec bpa.alter_policies('CP_HIERARCHY');


COMMENT ON TABLE BARS.CP_HIERARCHY IS 'Ієрархія справедливої вартості цінних паперів';
COMMENT ON COLUMN BARS.CP_HIERARCHY.ID IS 'Ідентифікатор рівня ієрархії';
COMMENT ON COLUMN BARS.CP_HIERARCHY.NAME IS 'Назва рівня ієрархії';
COMMENT ON COLUMN BARS.CP_HIERARCHY.DESCRIPTION IS 'Опис рівня ієрархії';




PROMPT *** Create  constraint XPK_CP_HIERARCHY ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_HIERARCHY ADD CONSTRAINT XPK_CP_HIERARCHY PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006196 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_HIERARCHY MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006197 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_HIERARCHY MODIFY (NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CP_HIERARCHY ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CP_HIERARCHY ON BARS.CP_HIERARCHY (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CP_HIERARCHY ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CP_HIERARCHY    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CP_HIERARCHY    to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_HIERARCHY    to CP_ROLE;
grant FLASHBACK,SELECT                                                       on CP_HIERARCHY    to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_HIERARCHY.sql =========*** End *** 
PROMPT ===================================================================================== 
