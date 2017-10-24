delete from upl_autojobs where job_name='A7_UPLOAD';

insert into upl_autojobs(job_name, descript, is_active)
	values('A7_UPLOAD', 'Вивантаження результатів автотестів', 1);

COMMIT;



prompt Вивантаження #A7
declare
  l_jobname     barsupl.upl_autojob_param_values.job_name%type := 'A7_UPLOAD_';
begin
  for l_kf in (select r.kf, r.code_chr from bars.mv_kf v, barsupl.upl_regions r where v.kf = r.kf)
  loop
    bars.bc.go(l_kf.kf);
    delete from upl_autojobs where job_name = l_jobname||l_kf.code_chr;
    insert into upl_autojobs(job_name, descript, is_active, kf) values(l_jobname||l_kf.code_chr, 'Вивантаження #A7', 1, l_kf.kf);
  end loop;
end;
/

COMMIT;


