

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/STO_STATUS.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to STO_STATUS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STO_STATUS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''STO_STATUS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table STO_STATUS ***
begin 
  execute immediate '
  CREATE TABLE BARS.STO_STATUS 
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




PROMPT *** ALTER_POLICIES to STO_STATUS ***
 exec bpa.alter_policies('STO_STATUS');


COMMENT ON TABLE BARS.STO_STATUS IS 'Статус регулярного платежу в бек-офісі';
COMMENT ON COLUMN BARS.STO_STATUS.ID IS 'Ідентифікатор статусу';
COMMENT ON COLUMN BARS.STO_STATUS.NAME IS 'Зміст статусу';




PROMPT *** Create  constraint CHK_STO_STATUS ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_STATUS ADD CONSTRAINT CHK_STO_STATUS CHECK (ID IN (-1, 0, 1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010055 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_STATUS MODIFY (NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010054 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_STATUS MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0011589 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_STATUS ADD PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_STO_STATUS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_STO_STATUS ON BARS.STO_STATUS (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  STO_STATUS ***
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on STO_STATUS      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on STO_STATUS      to BARS_DM;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on STO_STATUS      to STO;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/STO_STATUS.sql =========*** End *** ==
PROMPT ===================================================================================== 
