-- на 27.12.2017 (за 26.12.2017) меняется структура файла #C5 
-- в структуру показателя добалены части показателя
-- параметр R011, параметр S245, параметр K077
-- удапяется параметр R012 

exec suda;

delete from form_stru where kodf = 'C5';


Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('C5', 1, '1-Дт~2-Кт', 'substr(kodp,1,1)', '1', 
    'G', 1);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('C5', 2, 'Бал.~рах.', 'substr(kodp,2,4)', '1', 
    'G', 2);

--нова частина коду
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('C5', 3, 'Параметр~R011', 'substr(kodp,6,1)', '1', 
    'G', 3);

Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('C5', 4, 'Параметр~R013', 'substr(kodp,7,1)', '1', 
    'G', 4);

Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('C5', 5, 'Код~валюти', 'substr(kodp,8,3)', '1', 
    'G', 5);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('C5', 6, 'Розподіл~активів~(S580)', 'substr(kodp,11,1)', '1', 
    'G', 6);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('C5', 7, 'Код~індексації~(R017)', 'substr(kodp,12,1)', '1', 
    'G', 7);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('C5', 8, 'Валюта~індексації', 'substr(kodp,13,3)', '1', 
    'G', 8);

--нова частина коду
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('C5', 9, 'Код~кінцевого строку~(S245)', 'substr(kodp,16,1)', '1', 
    'G', 9);
--нова частина коду
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('C5', 10, 'Код~агрегованого сектору~(K077)', 'substr(kodp,17,1)', '1', 
    'G', 10);

Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, A017)
 Values
   ('C5', 11, 'Значення~показника', 'znap', 'G');

commit;

