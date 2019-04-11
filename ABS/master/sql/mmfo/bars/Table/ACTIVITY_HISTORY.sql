PROMPT ===================================================================================== 
PROMPT *** Run *** ======== Scripts /Sql/BARS/Table/ACTIVITY_HISTORY.sql ======= *** Run *** 
PROMPT ===================================================================================== 

BEGIN 
   execute immediate  
      'begin  
          bpa.alter_policy_info(''ACTIVITY_HISTORY'', ''CENTER'' , null, null, null, null);
          bpa.alter_policy_info(''ACTIVITY_HISTORY'', ''FILIAL'' , null, null, null, null);
          bpa.alter_policy_info(''ACTIVITY_HISTORY'', ''WHOLE'' , null, null, null, null);
          null;
       end; 
      '; 
END; 
/

PROMPT *** Create  table ACTIVITY_HISTORY ***
begin 
   execute immediate '
   CREATE TABLE ACTIVITY_HISTORY  
   (
      id                NUMBER(38)     not null,
      activity_id       NUMBER(38)     not null,
      activity_state_id NUMBER(5)      not null,
      sys_time          DATE                   ,
      user_id           NUMBER(38)             ,
      comment_text      VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
   PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
   NOCOMPRESS LOGGING
   TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

PROMPT *** ALTER_POLICIES to ACTIVITY_HISTORY ***
exec bpa.alter_policies('ACTIVITY_HISTORY');

COMMENT ON TABLE  BARS.ACTIVITY_HISTORY                       IS 'Кроки по процесу. Історія';
COMMENT ON COLUMN BARS.ACTIVITY_HISTORY.ID                IS 'Ідентифікатор запису';
COMMENT ON COLUMN BARS.ACTIVITY_HISTORY.activity_state_id IS 'Ідентифікатор стану кроку по процесу';
COMMENT ON COLUMN BARS.ACTIVITY_HISTORY.sys_time          IS 'Дата та час внесення змін';
COMMENT ON COLUMN BARS.ACTIVITY_HISTORY.user_id           IS 'Користувач';
COMMENT ON COLUMN BARS.ACTIVITY_HISTORY.comment_text      IS 'Коментарі';

PROMPT *** Create index IDX_ACTIVITY_HISTORY ***
begin   
   execute immediate '
   create index IDX_ACTIVITY_HISTORY on ACTIVITY_HISTORY (ACTIVITY_ID)
   PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
   TABLESPACE BRSMDLI ';
exception when others then
   if sqlcode=-955 then null; else raise; end if;
end;
/

PROMPT *** Create  grants  ACTIVITY_HISTORY ***
grant SELECT, INSERT, UPDATE, DELETE on ACTIVITY_HISTORY to BARS_ACCESS_DEFROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** ======== Scripts /Sql/BARS/Table/ACTIVITY_HISTORY.sql ======= *** End ***
PROMPT ===================================================================================== 
