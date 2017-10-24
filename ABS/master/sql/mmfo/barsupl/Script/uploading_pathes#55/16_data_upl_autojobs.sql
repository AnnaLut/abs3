prompt Вивантаження #A7
declare
  l_jobname0    barsupl.upl_autojob_param_values.job_name%type := 'A7_UPLOAD';
  l_jobname     barsupl.upl_autojob_param_values.job_name%type;
begin
  for l_kf in (select r.kf, r.code_chr from bars.mv_kf v, barsupl.upl_regions r where v.kf = r.kf)
  loop
    bars.bc.go(l_kf.kf);

    if barsupl.bars_upload_utl.is_mmfo > 1 then
	   l_jobname := l_jobname0||'_'||l_kf.code_chr;
	else
	   l_jobname := l_jobname0;
	end if;
    delete from upl_autojobs where job_name = l_jobname;
    insert into upl_autojobs(job_name, descript, is_active) values(l_jobname, 'Вивантаження #A7', 1);
/*
	-- ************* MMFO *************
       --insert into upl_autojobs(job_name, descript, is_active, kf) values(l_jobname||'_'||l_kf.code_chr, 'Вивантаження #A7', 1, l_kf.kf);
	   insert into upl_autojobs(job_name, descript, is_active) values(l_jobname||'_'||l_kf.code_chr, 'Вивантаження #A7', 1);
	else
	   -- ************* RU *************
       insert into upl_autojobs(job_name, descript, is_active) values(l_jobname, 'Вивантаження #A7', 1);
	end if;
*/

  end loop;
end;
/

--COMMIT;


