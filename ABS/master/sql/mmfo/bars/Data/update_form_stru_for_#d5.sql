-- 05/07/2017 
-- новая структура файлу на 01.07.2017
-- вместо части показателя Код~''9'' 
-- будет формироваться параметр K140 (код розміру суб'єкта господарювання)

exec bc.home;

update BARS.FORM_STRU set name = 'Код розміру~суб''єкта господарювання'
where kodf='D5' and natr = 7;

commit;

update BARS.NBUR_REF_FORM_STRU set Segment_name = 'Код розміру~суб''єкта господарювання'
where file_id=16853 and segment_number = 7;

commit;

