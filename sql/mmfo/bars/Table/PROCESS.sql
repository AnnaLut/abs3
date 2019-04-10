PROMPT ===================================================================================== 
PROMPT *** Run *** ============= Scripts /Sql/BARS/Table/PROCESS.sql =========== *** Run *** 
PROMPT ===================================================================================== 

BEGIN 
   execute immediate  
      'begin  
          bpa.alter_policy_info(''PROCESS'', ''CENTER'' , null, null, null, null);
          bpa.alter_policy_info(''PROCESS'', ''FILIAL'' , null, null, null, null);
          bpa.alter_policy_info(''PROCESS'', ''WHOLE'' , null, null, null, null);
          null;
       end; 
      '; 
END; 
/

PROMPT *** Create  table PROCESS ***
begin 
   execute immediate '
   CREATE TABLE PROCESS  
   (
      ID              NUMBER(38)     NOT NULL,
      PROCESS_TYPE_ID NUMBER(38)     NOT NULL,
      PROCESS_NAME    VARCHAR2(4000) NOT NULL,
      PROCESS_DATA    CLOB                   ,
      OBJECT_ID       NUMBER(38)             ,
      STATE_ID        NUMBER(5)      NOT NULL
   ) SEGMENT CREATION IMMEDIATE 
   PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
   NOCOMPRESS LOGGING
   TABLESPACE BRSMDLD ';
exception when others then       
   if sqlcode=-955 then null; else raise; end if; 
end; 
/

PROMPT *** ALTER_POLICIES to PROCESS ***
exec bpa.alter_policies('PROCESS');

COMMENT ON TABLE  BARS.PROCESS                 IS 'Процеси';
COMMENT ON COLUMN BARS.PROCESS.ID              IS 'Ідентифікатор процесу';
COMMENT ON COLUMN BARS.PROCESS.PROCESS_TYPE_ID IS 'Ідентифікатор типу процесу';
COMMENT ON COLUMN BARS.PROCESS.PROCESS_NAME    IS 'Найменування процесу';
COMMENT ON COLUMN BARS.PROCESS.PROCESS_DATA    IS 'Дані процесу';
COMMENT ON COLUMN BARS.PROCESS.OBJECT_ID       IS 'Ідентифікатор об''єкту';
COMMENT ON COLUMN BARS.PROCESS.STATE_ID        IS 'Ідентифікатор стану процесу';

PROMPT *** Create  constraint PK_PROCESS ***
begin   
   execute immediate '
   ALTER TABLE BARS.PROCESS ADD CONSTRAINT PK_PROCESS PRIMARY KEY (ID)
   USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
   TABLESPACE BRSMDLI ENABLE';
exception when others then
   if sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264
      or sqlcode=-2275 or sqlcode=-1442 then 
      null; 
   else 
      raise; 
   end if;
end;
/

PROMPT *** Create index IDX_PROCESS_PROC_TYPE ***
begin   
   execute immediate '
   CREATE INDEX BARS.IDX_PROCESS_PROC_TYPE ON BARS.PROCESS (PROCESS_TYPE_ID) 
   PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
   TABLESPACE BRSMDLI ';
exception when others then
   if sqlcode=-955 then null; else raise; end if;
end;
/

PROMPT *** Create index IDX_PROCESS_OBJECT ***
begin   
   execute immediate '
   CREATE INDEX BARS.IDX_PROCESS_OBJECT ON BARS.PROCESS (OBJECT_ID) 
   PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
   TABLESPACE BRSMDLI ';
exception when others then
   if sqlcode=-955 then null; else raise; end if;
end;
/

PROMPT *** Create  grants  PROCESS ***
grant SELECT, INSERT, UPDATE, DELETE on PROCESS to BARS_ACCESS_DEFROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** ============= Scripts /Sql/BARS/Table/PROCESS.sql =========== *** End ***
PROMPT ===================================================================================== 
