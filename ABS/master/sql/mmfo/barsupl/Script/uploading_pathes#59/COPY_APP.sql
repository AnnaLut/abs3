/* Установка нового параметра COPY_APP для ММФО */

declare
  l_copy_app_value BARSUPL.UPL_AUTOJOB_PARAMS.DEFVAL%TYPE;
  l_kf             varchar2(6);
begin
   --l_kf       := '300465';
   dbms_output.put_line('Set param COPY_APP for AUTOJOB..');
   for lc_kf in (select kf from bars.mv_kf where kf = l_kf or l_kf = '' or l_kf is null)
   loop
      l_kf := lc_kf.kf;
      bars.bc.go(l_kf);
      if  bars_upload.get_param('ORACLE_OS') = 'WIN'  then
          l_copy_app_value := 'xcopy.exe';
      else
          l_copy_app_value := '#!/bin/bash[10]cp';
      end if;

      begin
        Insert into BARSUPL.UPL_AUTOJOB_PARAMS (param, defval, descript)
         Values ('COPY_APP', l_copy_app_value, 'OS комманда копирования файлов');
      exception
        when DUP_VAL_ON_INDEX
          then null;
        when others
          then raise;
      end;
      --dbms_output.put_line('1 = ' || sql%rowcount);

      Insert into BARSUPL.UPL_AUTOJOB_PARAM_VALUES (job_name, param, value)
      select distinct p1.JOB_NAME, 'COPY_APP' as PARAM, l_copy_app_value as VALUE
        from barsupl.UPL_AUTOJOB_PARAM_VALUES p1
             left join barsupl.UPL_AUTOJOB_PARAM_VALUES p2 on (p2.param = 'COPY_APP' and p1.JOB_NAME = p2.JOB_NAME)
       where p1.param = 'USE_COPY'
         and p2.JOB_NAME is null;
      --dbms_output.put_line('2 = ' || l_kf || ' = ' || sql%rowcount);
      commit;
   end loop;
   --commit;
   bars.bc.go('/');
end;
/
