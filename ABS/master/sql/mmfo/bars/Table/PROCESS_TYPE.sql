PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PROCESS_TYPE.sql ========= *** Run *** 
PROMPT ===================================================================================== 

BEGIN 
   execute immediate  
      'begin  
          bpa.alter_policy_info(''PROCESS_TYPE'', ''CENTER'' , null, null, null, null);
          bpa.alter_policy_info(''PROCESS_TYPE'', ''FILIAL'' , null, null, null, null);
          bpa.alter_policy_info(''PROCESS_TYPE'', ''WHOLE'' , null, null, null, null);
          null;
       end; 
      '; 
END; 
/

PROMPT *** Create  table PROCESS_TYPE ***
begin 
   execute immediate '
   CREATE TABLE PROCESS_TYPE  
   (
      ID           NUMBER(38)    NOT NULL,
      MODULE_CODE  VARCHAR2(50)  NOT NULL,
      PROCESS_CODE VARCHAR2(50)  NOT NULL,
      PROCESS_NAME VARCHAR2(300) NOT NULL,
      CAN_CREATE   VARCHAR2(100)         ,
      CAN_RUN      VARCHAR2(100)         ,
      CAN_REVERT   VARCHAR2(100)         ,
      CAN_REMOVE   VARCHAR2(100)         ,
      ON_CREATE    VARCHAR2(100)         ,
      ON_RUN       VARCHAR2(100)         ,
      ON_REVERT    VARCHAR2(100)         ,
      ON_REMOVE    VARCHAR2(100)         ,
      IS_ACTIVE    CHAR(1)       NOT NULL
   ) SEGMENT CREATION IMMEDIATE 
   PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
   NOCOMPRESS LOGGING
   TABLESPACE BRSMDLD ';
exception when others then       
   if sqlcode=-955 then null; else raise; end if; 
end; 
/

PROMPT *** ALTER_POLICIES to PROCESS_TYPE ***
exec bpa.alter_policies('PROCESS_TYPE');

COMMENT ON TABLE  BARS.PROCESS_TYPE              IS 'Типи процесів';
COMMENT ON COLUMN BARS.PROCESS_TYPE.ID           IS 'Ідентифікатор типу процесу';
COMMENT ON COLUMN BARS.PROCESS_TYPE.MODULE_CODE  IS 'Код модуля';
COMMENT ON COLUMN BARS.PROCESS_TYPE.PROCESS_CODE IS 'Код типу процесу';
COMMENT ON COLUMN BARS.PROCESS_TYPE.PROCESS_NAME IS 'Найменування типу процесу';
COMMENT ON COLUMN BARS.PROCESS_TYPE.CAN_CREATE   IS 'Процедура перевірки прав на створення процесу';
COMMENT ON COLUMN BARS.PROCESS_TYPE.CAN_RUN      IS 'Процедура перевірки прав на запуск процесу';
COMMENT ON COLUMN BARS.PROCESS_TYPE.CAN_REVERT   IS 'Процедура перевірки правна повернення процесу';
COMMENT ON COLUMN BARS.PROCESS_TYPE.CAN_REMOVE   IS 'Процедура перевірки прав на видалення процесу';
COMMENT ON COLUMN BARS.PROCESS_TYPE.ON_CREATE    IS 'Процедура створення процесу';
COMMENT ON COLUMN BARS.PROCESS_TYPE.ON_RUN       IS 'Процедура запуску процесу';
COMMENT ON COLUMN BARS.PROCESS_TYPE.ON_REVERT    IS 'Процедура повернення процесу';
COMMENT ON COLUMN BARS.PROCESS_TYPE.ON_REMOVE    IS 'Процедура видалення процесу';
COMMENT ON COLUMN BARS.PROCESS_TYPE.IS_ACTIVE    IS 'Ознака активності процесу'; 

PROMPT *** Create  constraint PK_PROCESS_TYPE ***
begin   
   execute immediate '
   ALTER TABLE BARS.PROCESS_TYPE ADD CONSTRAINT PK_PROCESS_TYPE PRIMARY KEY (ID)
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

PROMPT *** Create constraint CC_PROCESS_TYPE_IS_ACTIVE ***
begin   
   execute immediate '
   ALTER TABLE BARS.PROCESS_TYPE ADD CONSTRAINT CC_PROCESS_TYPE_IS_ACTIVE CHECK (IS_ACTIVE IN (''N'', ''Y'')) DEFERRABLE INITIALLY DEFERRED ENABLE';
exception when others then
   if sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264
      or sqlcode=-2275 or sqlcode=-1442 then 
      null; 
   else 
      raise; 
   end if;
end;
/

PROMPT *** Create unique index UIX_PROCESS_TYPE_CODE ***
begin   
   execute immediate '
   CREATE UNIQUE INDEX BARS.UIX_PROCESS_TYPE_CODE ON BARS.PROCESS_TYPE (MODULE_CODE, PROCESS_CODE) 
   PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
   TABLESPACE BRSMDLI ';
exception when others then
   if sqlcode=-955 then null; else raise; end if;
end;
/

PROMPT *** Create  grants  PROCESS_TYPE ***
grant SELECT, INSERT, UPDATE, DELETE on PROCESS_TYPE to BARS_ACCESS_DEFROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PROCESS_TYPE.sql ========= *** End ***
PROMPT ===================================================================================== 
