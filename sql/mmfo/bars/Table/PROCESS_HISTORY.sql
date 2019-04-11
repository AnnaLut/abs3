PROMPT ===================================================================================== 
PROMPT *** Run *** ========= Scripts /Sql/BARS/Table/PROCESS_HISTORY.sql ======= *** Run *** 
PROMPT ===================================================================================== 

BEGIN 
   execute immediate  
      'begin  
          bpa.alter_policy_info(''PROCESS_HISTORY'', ''CENTER'' , null, null, null, null);
          bpa.alter_policy_info(''PROCESS_HISTORY'', ''FILIAL'' , null, null, null, null);
          bpa.alter_policy_info(''PROCESS_HISTORY'', ''WHOLE'' , null, null, null, null);
          null;
       end; 
      '; 
END; 
/

PROMPT *** Create  table PROCESS_HISTORY ***
begin 
   execute immediate '
   CREATE TABLE PROCESS_HISTORY  
   (
      ID               NUMBER(38)          NOT NULL,
      PROCESS_ID       NUMBER(38)          NOT NULL,
      PROCESS_STATE_ID NUMBER(38)          NOT NULL,
      SYS_TIME         DATE                        ,
      USER_ID          NUMBER(38)                  ,
      COMMENT_TEXT     VARCHAR2(4000 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
   PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
   NOCOMPRESS LOGGING
   TABLESPACE BRSMDLD ';
exception when others then       
   if sqlcode=-955 then null; else raise; end if; 
end; 
/

PROMPT *** ALTER_POLICIES to PROCESS_HISTORY ***
exec bpa.alter_policies('PROCESS_HISTORY');

COMMENT ON TABLE  BARS.PROCESS_HISTORY                  IS 'Історія зміни статусу процесу';
COMMENT ON COLUMN BARS.PROCESS_HISTORY.ID               IS 'Ідентифікатор';
COMMENT ON COLUMN BARS.PROCESS_HISTORY.PROCESS_ID       IS 'Ідентифікатор процесу';
COMMENT ON COLUMN BARS.PROCESS_HISTORY.PROCESS_STATE_ID IS 'Ідентифікатор стану процесу';
COMMENT ON COLUMN BARS.PROCESS_HISTORY.SYS_TIME         IS 'Дата та час внесення змін';
COMMENT ON COLUMN BARS.PROCESS_HISTORY.USER_ID          IS 'Користувач';
COMMENT ON COLUMN BARS.PROCESS_HISTORY.COMMENT_TEXT     IS 'Коментарі';

PROMPT *** Create index IDX_PROCESS_HISTORY ***
begin   
   execute immediate '
   create index IDX_PROCESS_HISTORY on PROCESS_HISTORY (PROCESS_ID)
   PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
   TABLESPACE BRSMDLI ';
exception when others then
   if sqlcode=-955 then null; else raise; end if;
end;
/

PROMPT *** Create  grants  PROCESS_HISTORY ***
grant SELECT, INSERT, UPDATE, DELETE on PROCESS_HISTORY to BARS_ACCESS_DEFROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** ========= Scripts /Sql/BARS/Table/PROCESS_HISTORY.sql ======= *** End ***
PROMPT ===================================================================================== 
