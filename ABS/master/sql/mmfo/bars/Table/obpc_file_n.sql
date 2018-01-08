

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OBPC_FILE_N.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OBPC_FILE_N ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OBPC_FILE_N'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''OBPC_FILE_N'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OBPC_FILE_N'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OBPC_FILE_N ***
begin 
  execute immediate '
  CREATE TABLE BARS.OBPC_FILE_N 
   (	FILE_N NUMBER(38,0), 
	FILE_DATE DATE, 
	FILE_CHAR CHAR(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OBPC_FILE_N ***
 exec bpa.alter_policies('OBPC_FILE_N');


COMMENT ON TABLE BARS.OBPC_FILE_N IS 'Информация о последнем сформированном файле';
COMMENT ON COLUMN BARS.OBPC_FILE_N.FILE_N IS 'Номер последнего сформированного файла';
COMMENT ON COLUMN BARS.OBPC_FILE_N.FILE_DATE IS 'Дата формирования последнего файла';
COMMENT ON COLUMN BARS.OBPC_FILE_N.FILE_CHAR IS '';




PROMPT *** Create  constraint PK_OBPCFILEN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_FILE_N ADD CONSTRAINT PK_OBPCFILEN PRIMARY KEY (FILE_CHAR)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OBPCFILEN_FILECHAR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_FILE_N MODIFY (FILE_CHAR CONSTRAINT CC_OBPCFILEN_FILECHAR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OBPCFILEN ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OBPCFILEN ON BARS.OBPC_FILE_N (FILE_CHAR) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OBPC_FILE_N ***
grant DELETE,INSERT,SELECT,UPDATE                                            on OBPC_FILE_N     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OBPC_FILE_N     to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on OBPC_FILE_N     to OBPC;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OBPC_FILE_N     to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OBPC_FILE_N.sql =========*** End *** =
PROMPT ===================================================================================== 
