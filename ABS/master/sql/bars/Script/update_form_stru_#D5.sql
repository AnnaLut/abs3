-- с 01.01.2018 новая структура файла LDBBBBZLLУУOЦRQQЧVVVMMMTГГNI 
--                             вместо LDBBBBZLLУOЦRQQЧVVVMMMTГГNI 

-- параметр K072 будет формироваться 2-х значным вместо однозначного

exec bc.home;  

delete from form_stru where kodf = 'D5';

Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D5', 1, '1-сума~2-%% ставка', 'substr(kodp,1,1)', '1', 
    'C', 15);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D5', 2, 'Тип залишку~чи обороту~(1-ДтЗ,2-КтЗ,6-КтО)', 'substr(kodp,2,1)', '1', 
    'C', 14);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D5', 3, 'Бал.~рах.', 'substr(kodp,3,4)', '1', 
    'C', 1);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D5', 4, 'Параметр~R011', 'substr(kodp,7,1)', '1', 
    'C', 3);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D5', 5, 'Код виду~економiчної~дiяльностi~(K111)', 'substr(kodp,8,2)', '1', 
    'C', 4);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D5', 6, 'Код сектора~економiки~(K072)', 'substr(kodp,10,2)', '1', 
    'C', 5);

Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D5', 7, 'Код розміру~суб''єкта госп-ня (K140)', 'substr(kodp,12,1)', '1', 
    'C', 6);

Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D5', 8, 'Початковий~строк~погашення~(S183)', 'substr(kodp,13,1)', '1', 
    'C', 7);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D5', 9, 'Резиден~тнiсть~(K030)', 'substr(kodp,14,1)', '1', 
    'C', 8);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D5', 10, 'Орг.-правова~форма~господар.~(K051)', 'substr(kodp,15,2)', '1', 
    'C', 9);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D5', 11, 'Узагальнений~вид забеспеч.~(S032)', 'substr(kodp,17,1)', '1', 
    'C', 10);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D5', 12, 'Код~валюти~(R030)', 'substr(kodp,18,3)', '1', 
    'C', 2);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D5', 13, 'Код~країни~(K040)', 'substr(kodp,21,3)', '1', 
    'C', 11);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D5', 14, 'Клас~боржника~(S080)', 'substr(kodp,24,1)', '1', 
    'C', 12);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D5', 15, 'Код цiлi~споживання~(S260)', 'substr(kodp,25,2)', '1', 
    'C', 13);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D5', 16, 'Сегмент N~(2-залишок~3-середній зал~4-проц.доходи)', 'substr(kodp,27,1)', '1', 
    'C', 16);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017, CODE_SORT)
 Values
   ('D5', 17, 'Код строку~прострочення боргу~S190', 'substr(kodp,28,1)', '1', 
    'C', 17);
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017)
 Values
   ('D5', 18, 'Код областi~безбаланс.вiд', 'substr(nbuc,1,12)', '0', 
    'C');
Insert into BARS.FORM_STRU
   (KODF, NATR, NAME, VAL, ISCODE, A017)
 Values
   ('D5', 19, 'Значення~показника', 'znap', '0', 
    'C');

commit;
