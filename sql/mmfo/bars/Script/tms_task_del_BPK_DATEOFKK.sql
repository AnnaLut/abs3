
    alter table TMS_TASK_RUN
      drop constraint FK_TMS_TASK_RUN_REF_TASK;

    alter table TMS_TASK_RUN
      add constraint FK_TMS_TASK_RUN_REF_TASK foreign key (TASK_ID)
      references TMS_TASK (ID) on delete cascade
      novalidate;
  
      delete from tms_task where task_code ='BPK_DATEOFKK';
