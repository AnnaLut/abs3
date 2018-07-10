begin
    Insert into BARSUPL.UPL_AUTOJOB_PARAM_VALUES (JOB_NAME, PARAM, VALUE)
    select j.job_name, 'UPL_METHOD', case when upper(j.job_name) like 'VIF%' then 'BUFF' else 'CLOB' end
      from BARSUPL.UPL_AUTOJOBS j
      left join BARSUPL.UPL_AUTOJOB_PARAM_VALUES v on (j.job_name = v.job_name and v.PARAM = 'UPL_METHOD')
     where v.job_name is null;
end;
/

COMMIT;
