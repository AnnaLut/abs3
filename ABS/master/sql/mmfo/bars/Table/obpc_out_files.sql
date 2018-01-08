

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OBPC_OUT_FILES.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OBPC_OUT_FILES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OBPC_OUT_FILES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''OBPC_OUT_FILES'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''OBPC_OUT_FILES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OBPC_OUT_FILES ***
begin 
  execute immediate '
  CREATE TABLE BARS.OBPC_OUT_FILES 
   (	FILE_CHAR CHAR(1), 
	ACC_TYPE CHAR(3)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OBPC_OUT_FILES ***
 exec bpa.alter_policies('OBPC_OUT_FILES');


COMMENT ON TABLE BARS.OBPC_OUT_FILES IS 'Справочник формирования файлов процессинга';
COMMENT ON COLUMN BARS.OBPC_OUT_FILES.FILE_CHAR IS 'Тип файла';
COMMENT ON COLUMN BARS.OBPC_OUT_FILES.ACC_TYPE IS 'Тип отбираемого~счета';




PROMPT *** Create  constraint PK_OBPCOUTFILES ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_OUT_FILES ADD CONSTRAINT PK_OBPCOUTFILES PRIMARY KEY (ACC_TYPE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OBPCOUTFILES_TIPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_OUT_FILES ADD CONSTRAINT FK_OBPCOUTFILES_TIPS FOREIGN KEY (ACC_TYPE)
	  REFERENCES BARS.TIPS (TIP) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OBPCOUTFILES_FILECHAR ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_OUT_FILES MODIFY (FILE_CHAR CONSTRAINT CC_OBPCOUTFILES_FILECHAR NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OBPCOUTFILES_ACCTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_OUT_FILES MODIFY (ACC_TYPE CONSTRAINT CC_OBPCOUTFILES_ACCTYPE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OBPCOUTFILES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OBPCOUTFILES ON BARS.OBPC_OUT_FILES (ACC_TYPE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OBPC_OUT_FILES ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OBPC_OUT_FILES  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OBPC_OUT_FILES  to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on OBPC_OUT_FILES  to OBPC;
grant DELETE,INSERT,SELECT,UPDATE                                            on OBPC_OUT_FILES  to OBPC_OUT_FILES;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OBPC_OUT_FILES  to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on OBPC_OUT_FILES  to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OBPC_OUT_FILES.sql =========*** End **
PROMPT ===================================================================================== 
