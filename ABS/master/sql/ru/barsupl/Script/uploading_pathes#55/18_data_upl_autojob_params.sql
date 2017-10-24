prompt Вивантаження #A7

declare
  l_jobname0    barsupl.upl_autojob_param_values.job_name%type := 'A7_UPLOAD';
  l_jobname     barsupl.upl_autojob_param_values.job_name%type;
  l_parvalue    barsupl.upl_autojob_param_values.value%type;
begin
  for l_kf in (select r.kf, r.code_chr from bars.mv_kf v, barsupl.upl_regions r where v.kf = r.kf)
  loop
    bars.bc.go(l_kf.kf);

    if barsupl.bars_upload_utl.is_mmfo > 1 then
	   l_jobname := l_jobname0||'_'||l_kf.code_chr;
	else
	   l_jobname := l_jobname0;
	end if;
 	delete from UPL_AUTOJOB_PARAM_VALUES where job_name = l_jobname;

	select value into l_parvalue from barsupl.upl_autojob_param_values where (job_name = 'DAILY_UPLOAD_'||l_kf.code_chr or job_name = 'DAILY_UPLOAD') and param = 'COPY_TO_DIR';
	insert into upl_autojob_param_values   (job_name, param, value) Values   (l_jobname, 'COPY_TO_DIR', l_parvalue);

	select value into l_parvalue from barsupl.upl_autojob_param_values where (job_name = 'DAILY_UPLOAD_'||l_kf.code_chr or job_name = 'DAILY_UPLOAD') and param = 'NETUSE';
	insert into upl_autojob_param_values   (job_name, param, value) Values   (l_jobname, 'NETUSE', l_parvalue);

	Insert into UPL_AUTOJOB_PARAM_VALUES   (JOB_NAME, PARAM, VALUE) Values   (l_jobname, 'BANKDAYS_BEFORE', '1');
	Insert into UPL_AUTOJOB_PARAM_VALUES   (JOB_NAME, PARAM, VALUE) Values   (l_jobname, 'GROUPID', '18');
	Insert into UPL_AUTOJOB_PARAM_VALUES   (JOB_NAME, PARAM, VALUE) Values   (l_jobname, 'HOLIDAY_CHECK_STATUS', '0');
	Insert into UPL_AUTOJOB_PARAM_VALUES   (JOB_NAME, PARAM, VALUE) Values   (l_jobname, 'HOLIDAY_UPLOAD', '0');
	Insert into UPL_AUTOJOB_PARAM_VALUES   (JOB_NAME, PARAM, VALUE) Values   (l_jobname, 'USE_ARCH', '1');
	Insert into UPL_AUTOJOB_PARAM_VALUES   (JOB_NAME, PARAM, VALUE) Values   (l_jobname, 'USE_COPY', '1');
	Insert into UPL_AUTOJOB_PARAM_VALUES   (JOB_NAME, PARAM, VALUE) Values   (l_jobname, 'USE_FTP', '0');
	Insert into UPL_AUTOJOB_PARAM_VALUES   (JOB_NAME, PARAM, VALUE) Values   (l_jobname, 'WHEN_DAYLIST', 'MON,TUE,WED,THU,FRI,SAT,SUN');
	Insert into UPL_AUTOJOB_PARAM_VALUES   (JOB_NAME, PARAM, VALUE) Values   (l_jobname, 'WHEN_HOUR', '21');
	Insert into UPL_AUTOJOB_PARAM_VALUES   (JOB_NAME, PARAM, VALUE) Values   (l_jobname, 'WHEN_MINUTE', '0');

/*
    if barsupl.bars_upload_utl.is_mmfo > 1 then
        -- ************* MMFO *************
		delete from UPL_AUTOJOB_PARAM_VALUES where job_name = l_jobname||l_kf.code_chr;

		select value into l_parvalue from barsupl.upl_autojob_param_values where kf = l_kf.kf and job_name = 'DAILY_UPLOAD_'||l_kf.code_chr and param = 'COPY_TO_DIR';
		insert into upl_autojob_param_values   (job_name, param, value, kf) Values   (l_jobname||'_'||l_kf.code_chr, 'COPY_TO_DIR', l_parvalue, l_kf.kf);

		select value into l_parvalue from barsupl.upl_autojob_param_values where kf = l_kf.kf and job_name = 'DAILY_UPLOAD_'||l_kf.code_chr and param = 'NETUSE';
		insert into upl_autojob_param_values   (job_name, param, value, kf) Values   (l_jobname||'_'||l_kf.code_chr, 'NETUSE', l_parvalue, l_kf.kf);

		Insert into UPL_AUTOJOB_PARAM_VALUES   (JOB_NAME, PARAM, VALUE, kf) Values   (l_jobname||'_'||l_kf.code_chr, 'BANKDAYS_BEFORE', '1', l_kf.kf);
		Insert into UPL_AUTOJOB_PARAM_VALUES   (JOB_NAME, PARAM, VALUE, kf) Values   (l_jobname||'_'||l_kf.code_chr, 'GROUPID', '18', l_kf.kf);
		Insert into UPL_AUTOJOB_PARAM_VALUES   (JOB_NAME, PARAM, VALUE, kf) Values   (l_jobname||'_'||l_kf.code_chr, 'HOLIDAY_CHECK_STATUS', '0', l_kf.kf);
		Insert into UPL_AUTOJOB_PARAM_VALUES   (JOB_NAME, PARAM, VALUE, kf) Values   (l_jobname||'_'||l_kf.code_chr, 'HOLIDAY_UPLOAD', '0', l_kf.kf);
		Insert into UPL_AUTOJOB_PARAM_VALUES   (JOB_NAME, PARAM, VALUE, kf) Values   (l_jobname||'_'||l_kf.code_chr, 'USE_ARCH', '1', l_kf.kf);
		Insert into UPL_AUTOJOB_PARAM_VALUES   (JOB_NAME, PARAM, VALUE, kf) Values   (l_jobname||'_'||l_kf.code_chr, 'USE_COPY', '1', l_kf.kf);
		Insert into UPL_AUTOJOB_PARAM_VALUES   (JOB_NAME, PARAM, VALUE, kf) Values   (l_jobname||'_'||l_kf.code_chr, 'USE_FTP', '0', l_kf.kf);
		Insert into UPL_AUTOJOB_PARAM_VALUES   (JOB_NAME, PARAM, VALUE, kf) Values   (l_jobname||'_'||l_kf.code_chr, 'WHEN_DAYLIST', 'MON,TUE,WED,THU,FRI,SAT,SUN', l_kf.kf);
		Insert into UPL_AUTOJOB_PARAM_VALUES   (JOB_NAME, PARAM, VALUE, kf) Values   (l_jobname||'_'||l_kf.code_chr, 'WHEN_HOUR', '21', l_kf.kf);
		Insert into UPL_AUTOJOB_PARAM_VALUES   (JOB_NAME, PARAM, VALUE, kf) Values   (l_jobname||'_'||l_kf.code_chr, 'WHEN_MINUTE', '0', l_kf.kf);
	else
	    -- ************* RU *************
 		delete from UPL_AUTOJOB_PARAM_VALUES where job_name = l_jobname;

		select value into l_parvalue from barsupl.upl_autojob_param_values where job_name = 'DAILY_UPLOAD' and param = 'COPY_TO_DIR';
		insert into upl_autojob_param_values   (job_name, param, value) Values   (l_jobname, 'COPY_TO_DIR', l_parvalue);

		select value into l_parvalue from barsupl.upl_autojob_param_values where job_name = 'DAILY_UPLOAD' and param = 'NETUSE';
		insert into upl_autojob_param_values   (job_name, param, value) Values   (l_jobname, 'NETUSE', l_parvalue);

		Insert into UPL_AUTOJOB_PARAM_VALUES   (JOB_NAME, PARAM, VALUE) Values   (l_jobname, 'BANKDAYS_BEFORE', '1');
		Insert into UPL_AUTOJOB_PARAM_VALUES   (JOB_NAME, PARAM, VALUE) Values   (l_jobname, 'GROUPID', '18');
		Insert into UPL_AUTOJOB_PARAM_VALUES   (JOB_NAME, PARAM, VALUE) Values   (l_jobname, 'HOLIDAY_CHECK_STATUS', '0');
		Insert into UPL_AUTOJOB_PARAM_VALUES   (JOB_NAME, PARAM, VALUE) Values   (l_jobname, 'HOLIDAY_UPLOAD', '0');
		Insert into UPL_AUTOJOB_PARAM_VALUES   (JOB_NAME, PARAM, VALUE) Values   (l_jobname, 'USE_ARCH', '1');
		Insert into UPL_AUTOJOB_PARAM_VALUES   (JOB_NAME, PARAM, VALUE) Values   (l_jobname, 'USE_COPY', '1');
		Insert into UPL_AUTOJOB_PARAM_VALUES   (JOB_NAME, PARAM, VALUE) Values   (l_jobname, 'USE_FTP', '0');
		Insert into UPL_AUTOJOB_PARAM_VALUES   (JOB_NAME, PARAM, VALUE) Values   (l_jobname, 'WHEN_DAYLIST', 'MON,TUE,WED,THU,FRI,SAT,SUN');
		Insert into UPL_AUTOJOB_PARAM_VALUES   (JOB_NAME, PARAM, VALUE) Values   (l_jobname, 'WHEN_HOUR', '21');
		Insert into UPL_AUTOJOB_PARAM_VALUES   (JOB_NAME, PARAM, VALUE) Values   (l_jobname, 'WHEN_MINUTE', '0');
	end if;
*/

  end loop;
end;
/


COMMIT;