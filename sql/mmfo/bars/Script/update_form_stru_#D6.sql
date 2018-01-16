-- с 01.01.2018 новая структура файла LDBBBBZLLУУ9ЦRQQVVVMMMN 
--                             вместо LDBBBBZLLУ9ЦRQQVVVMMMN 

-- параметр K072 будет формироваться 2-х значным вместо однозначного

exec bc.home;  

delete from form_stru where kodf = 'D6';


Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D6', 1, '1-сума,~2-%% ставка)', 'substr(kodp,1,1)', '1', 
    'C', 12);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D6', 2, 'Тип залишку~чи обороту~(1-ДтЗ,2-КтЗ,6-ДтО)', 'substr(kodp,2,1)', '1', 
    'C', 11);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D6', 3, 'Бал.~рах.', 'substr(kodp,3,4)', '1', 
    'C', 1);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D6', 4, 'Параметр~R011', 'substr(kodp,7,1)', '1', 
    'C', 3);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D6', 5, 'Роздiл виду~економiчної~дiяльностi~(K111)', 'substr(kodp,8,2)', '1', 
    'C', 4);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D6', 6, 'Код сектору~економiки~(K072)', 'substr(kodp,10,2)', '1', 
    'C', 5);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D6', 7, 'Код~''9''', 'substr(kodp,12,1)', '1', 
    'C', 6);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D6', 8, 'Початковий~строк~погашення~(S183)', 'substr(kodp,13,1)', '1', 
    'C', 7);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D6', 9, 'Резиден~тнiсть~(K030)', 'substr(kodp,14,1)', '1', 
    'C', 8);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D6', 10, 'Орг.-правова~форма~господар.~(K051)', 'substr(kodp,15,2)', '1', 
    'C', 9);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D6', 11, 'Код~валюти~(R030)', 'substr(kodp,17,3)', '1', 
    'C', 2);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D6', 12, 'Код~країни~(K040)', 'substr(kodp,20,3)', '1', 
    'C', 10);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D6', 13, 'Сегмент N~(2-залишок~3-середній зал~4-проц.витрати)', 'substr(kodp,23,1)', '1', 
    'C', 13);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017)
 Values
   ('D6', 14, 'Код областi~безбаланс.вiд.', 'substr(nbuc,1,12)', '0', 
    'C');
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017)
 Values
   ('D6', 15, 'Значення~показника', 'znap', '0', 
    'C');


commit;
