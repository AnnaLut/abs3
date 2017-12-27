-- на 27.12.2017 меняется структура файла #3A 
-- вместо параметра R013 должен формироваться параметр R011

exec suda;

update form_stru set name='Параметр~R011'
where kodf = '3A' and natr = 4;

commit;

