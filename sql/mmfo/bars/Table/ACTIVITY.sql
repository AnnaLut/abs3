PROMPT ===================================================================================== 
PROMPT *** Run *** ============ Scripts /Sql/BARS/Table/ACTIVITY.sql =========== *** Run *** 
PROMPT ===================================================================================== 

BEGIN 
   execute immediate  
   'begin  
       bpa.alter_policy_info(''ACTIVITY'', ''CENTER'' , null, null, null, null);
       bpa.alter_policy_info(''ACTIVITY'', ''FILIAL'' , null, null, null, null);
       bpa.alter_policy_info(''ACTIVITY'', ''WHOLE'' , null, null, null, null);
       null;
    end; 
   '; 
END; 
/

PROMPT *** Create  table ACTIVITY ***
begin 
   execute immediate '
   CREATE TABLE ACTIVITY  
   (
      ID               NUMBER(38)     NOT NULL,
      ACTIVITY_TYPE_ID NUMBER(38)     NOT NULL,
      OBJECT_ID        NUMBER(38)             ,
      ACTIVITY_NAME    VARCHAR2(4000)         ,
      PROCESS_ID       NUMBER(38)             ,
      ACTIVITY_DATA    CLOB                   ,
      STATE_ID         NUMBER(5)      NOT NULL
   ) SEGMENT CREATION IMMEDIATE 
   PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
   NOCOMPRESS LOGGING
   TABLESPACE BRSMDLD ';
exception when others then       
   if sqlcode=-955 then null; else raise; end if; 
end; 
/

PROMPT *** ALTER_POLICIES to ACTIVITY ***
exec bpa.alter_policies('ACTIVITY');

COMMENT ON TABLE  BARS.ACTIVITY                  IS 'Кроки по процесу';
COMMENT ON COLUMN BARS.ACTIVITY.ID               IS 'Ідентифікатор кроку по процесу';
COMMENT ON COLUMN BARS.ACTIVITY.ACTIVITY_TYPE_ID IS 'Ідентифікатор типу кроку';
COMMENT ON COLUMN BARS.ACTIVITY.OBJECT_ID        IS 'Ідентифікатор об''єкту';
COMMENT ON COLUMN BARS.ACTIVITY.ACTIVITY_NAME    IS 'Найменування кроку по процесу';
COMMENT ON COLUMN BARS.ACTIVITY.PROCESS_ID       IS 'Ідентифікатор процесу';
COMMENT ON COLUMN BARS.ACTIVITY.ACTIVITY_DATA    IS 'Дані кроку по процесу';
COMMENT ON COLUMN BARS.ACTIVITY.STATE_ID         IS 'Ідентифікатор стану кроку по процесу';

PROMPT *** Create  constraint PK_ACTIVITY ***
begin   
   execute immediate '
   ALTER TABLE BARS.ACTIVITY ADD CONSTRAINT PK_ACTIVITY PRIMARY KEY (ID)
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

PROMPT *** Create index IDX_ACTIVITY_TYPE ***
begin   
   execute immediate '
   CREATE INDEX BARS.IDX_ACTIVITY_TYPE ON BARS.ACTIVITY (ACTIVITY_TYPE_ID) 
   PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
   TABLESPACE BRSMDLI ';
exception when others then
   if sqlcode=-955 then null; else raise; end if;
end;
/

PROMPT *** Create index IDX_ACTIVITY_OBJECT ***
begin   
   execute immediate '
   CREATE INDEX BARS.IDX_ACTIVITY_OBJECT ON BARS.ACTIVITY (OBJECT_ID) 
   PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
   TABLESPACE BRSMDLI ';
exception when others then
   if sqlcode=-955 then null; else raise; end if;
end;
/

PROMPT *** Create index IDX_ACTIVITY_PROCESS ***
begin   
   execute immediate '
   CREATE INDEX BARS.IDX_ACTIVITY_PROCESS ON BARS.ACTIVITY (PROCESS_ID) 
   PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
   TABLESPACE BRSMDLI ';
exception when others then
   if sqlcode=-955 then null; else raise; end if;
end;
/

PROMPT *** Create  grants  ACTIVITY ***
grant SELECT, INSERT, UPDATE, DELETE on ACTIVITY to  BARS_ACCESS_DEFROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** ============ Scripts /Sql/BARS/Table/ACTIVITY.sql =========== *** End ***
PROMPT ===================================================================================== 
