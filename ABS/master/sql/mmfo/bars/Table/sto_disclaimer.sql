

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/STO_DISCLAIMER.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to STO_DISCLAIMER ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STO_DISCLAIMER'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''STO_DISCLAIMER'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table STO_DISCLAIMER ***
begin 
  execute immediate '
  CREATE TABLE BARS.STO_DISCLAIMER 
   (	ID NUMBER(*,0), 
	NAME VARCHAR2(50)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to STO_DISCLAIMER ***
 exec bpa.alter_policies('STO_DISCLAIMER');


COMMENT ON TABLE BARS.STO_DISCLAIMER IS 'Причини відмови в бек-офісі';
COMMENT ON COLUMN BARS.STO_DISCLAIMER.ID IS 'Ідентифікатор відмови';
COMMENT ON COLUMN BARS.STO_DISCLAIMER.NAME IS 'Зміст ідмови';




PROMPT *** Create  constraint SYS_C0010052 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_DISCLAIMER MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010908 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_DISCLAIMER ADD PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CHK_STO_DISCLAIMER ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_DISCLAIMER ADD CONSTRAINT CHK_STO_DISCLAIMER CHECK (ID >= 0) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010053 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_DISCLAIMER MODIFY (NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_STO_DISCLAIMER ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_STO_DISCLAIMER ON BARS.STO_DISCLAIMER (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  STO_DISCLAIMER ***
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on STO_DISCLAIMER  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on STO_DISCLAIMER  to BARS_DM;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on STO_DISCLAIMER  to STO;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/STO_DISCLAIMER.sql =========*** End **
PROMPT ===================================================================================== 
