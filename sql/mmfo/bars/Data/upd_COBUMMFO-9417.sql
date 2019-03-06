exec bc.home;

update nbur_ref_files
set  file_priority = 0
where file_code like '%12%';
commit;