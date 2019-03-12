begin
  bc.home;
--------------------------------------
  update tms_task
    set task_name = 'Нарахування відсотків,комісій (за виключенням пені)  по КП ФО'
    where task_code = 'AVTO%_CCKF';
  commit;
----------------------------------------



end;
/