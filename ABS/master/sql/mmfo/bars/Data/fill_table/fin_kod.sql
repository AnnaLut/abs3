
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Data/patch_data_FIN_KOD.sql =========*** Run
PROMPT ===================================================================================== 

declare
l_FIN_KOD  FIN_KOD%rowtype;

procedure p_merge(p_FIN_KOD FIN_KOD%rowtype) 
as
Begin
   insert into FIN_KOD
      values p_FIN_KOD; 
 exception when dup_val_on_index then  
   update FIN_KOD
      set row = p_FIN_KOD
    where KOD = p_FIN_KOD.KOD
      and IDF = p_FIN_KOD.IDF
      and FM = p_FIN_KOD.FM;
End;
Begin

 
delete from fin_kod  where idf = 6 and kod like 'PK%' and fm = '0';
delete from fin_kod  where idf in (11,12,13)  and fm = '0';



l_FIN_KOD.NAME :='K10, МK10 – коефіцієнт оборот. позич. кап.за фінрез-ми від звичайної діяльності (EBITDA) ';
l_FIN_KOD.ORD :=10;
l_FIN_KOD.KOD :='K10';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='K12 – показник достатності робочого капіталу';
l_FIN_KOD.ORD :=112;
l_FIN_KOD.KOD :='PK12';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='N';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='K2, МK2 – проміжний коефіцієнт покриття';
l_FIN_KOD.ORD :=2;
l_FIN_KOD.KOD :='K2';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='K3, МK3 – коефіцієнт фінансової незалежно-сті ';
l_FIN_KOD.ORD :=3;
l_FIN_KOD.KOD :='K3';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='K4, МK4 –коефіцієнт покриття необорот-них активів власним капіталом ';
l_FIN_KOD.ORD :=4;
l_FIN_KOD.KOD :='K4';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='K5, МK5 – коефіцієнт рентабель-ності власного капіталу / коефіцієнт оборотності кредиторської за- боргованості ';
l_FIN_KOD.ORD :=5;
l_FIN_KOD.KOD :='K5';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='K6, МK6 –коефіцієнт рентабель-ності продажу за фінрез. від операцій-ної діяльності (EBIT) ';
l_FIN_KOD.ORD :=6;
l_FIN_KOD.KOD :='K6';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='K7, МK7 –коефіцієнт рентабель-ності продажу за фінрез. від звичайної діяльності (EBITDA)';
l_FIN_KOD.ORD :=7;
l_FIN_KOD.KOD :='K7';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='K8, МK8 –коефіцієнт рентабель-ності активів за чистим прибутком';
l_FIN_KOD.ORD :=8;
l_FIN_KOD.KOD :='K8';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='K9, МK9 –коефіцієнт оборотнос-ті оборот-них активів';
l_FIN_KOD.ORD :=9;
l_FIN_KOD.KOD :='K9';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='MK10 – показник оборотності робочого капіталу';
l_FIN_KOD.ORD :=210;
l_FIN_KOD.KOD :='PK10';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='R';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='MK10 – показник оборотності робочого капіталу';
l_FIN_KOD.ORD :=310;
l_FIN_KOD.KOD :='PK10';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='C';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='MK13 – показник чистого прибутку до оподаткування';
l_FIN_KOD.ORD :=313;
l_FIN_KOD.KOD :='PK13';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='C';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='MK13 – показник чистого прибутку до оподаткування';
l_FIN_KOD.ORD :=213;
l_FIN_KOD.KOD :='PK13';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='R';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='MK4 –  показники капіталу';
l_FIN_KOD.ORD :=304;
l_FIN_KOD.KOD :='PK4';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='C';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='MK4 –  показники капіталу';
l_FIN_KOD.ORD :=204;
l_FIN_KOD.KOD :='PK4';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='R';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='MK5 – показники маневреності робочого капіталу';
l_FIN_KOD.ORD :=305;
l_FIN_KOD.KOD :='PK5';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='C';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='MK5 – показники маневреності робочого капіталу';
l_FIN_KOD.ORD :=205;
l_FIN_KOD.KOD :='PK5';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='R';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='MК11 – показник покриття боргу операційним прибутком';
l_FIN_KOD.ORD :=211;
l_FIN_KOD.KOD :='PK11';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='R';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='MК11 – показник покриття боргу операційним прибутком';
l_FIN_KOD.ORD :=311;
l_FIN_KOD.KOD :='PK11';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='C';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Інтегральний показник боржника ';
l_FIN_KOD.ORD :=11;
l_FIN_KOD.KOD :='IPB';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Інші витрати';
l_FIN_KOD.ORD :=13;
l_FIN_KOD.KOD :='AZ13';
l_FIN_KOD.IDF :=11;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Інші довгострокові зобов''язання';
l_FIN_KOD.ORD :=11;
l_FIN_KOD.KOD :='AP11';
l_FIN_KOD.IDF :=13;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Інші доходи';
l_FIN_KOD.ORD :=12;
l_FIN_KOD.KOD :='AZ12';
l_FIN_KOD.IDF :=11;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Інші необоротні активи';
l_FIN_KOD.ORD :=6;
l_FIN_KOD.KOD :='AB6';
l_FIN_KOD.IDF :=12;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Інші оборотні активи';
l_FIN_KOD.ORD :=12;
l_FIN_KOD.KOD :='AB12';
l_FIN_KOD.IDF :=12;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Інші операційні витрати';
l_FIN_KOD.ORD :=7;
l_FIN_KOD.KOD :='AZ7';
l_FIN_KOD.IDF :=11;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Інші операційні доходи';
l_FIN_KOD.ORD :=4;
l_FIN_KOD.KOD :='AZ4';
l_FIN_KOD.IDF :=11;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Інші поточні зобов''язання';
l_FIN_KOD.ORD :=16;
l_FIN_KOD.KOD :='AP16';
l_FIN_KOD.IDF :=13;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Адміністративні витрати';
l_FIN_KOD.ORD :=5;
l_FIN_KOD.KOD :='AZ5';
l_FIN_KOD.IDF :=11;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Активи ';
l_FIN_KOD.ORD :=1;
l_FIN_KOD.KOD :='AB1';
l_FIN_KOD.IDF :=12;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Амортизація';
l_FIN_KOD.ORD :=18;
l_FIN_KOD.KOD :='AZ18';
l_FIN_KOD.IDF :=11;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Відкладені податкові активи';
l_FIN_KOD.ORD :=5;
l_FIN_KOD.KOD :='AB5';
l_FIN_KOD.IDF :=12;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Відкладені податкові зобов''язання';
l_FIN_KOD.ORD :=10;
l_FIN_KOD.KOD :='AP10';
l_FIN_KOD.IDF :=13;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Валовий прибуток / збиток';
l_FIN_KOD.ORD :=3;
l_FIN_KOD.KOD :='AZ3';
l_FIN_KOD.IDF :=11;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Ветка коригування 0 - немає звітності, 1 Клас К нижчий клас групи, 2 - клас К вищи клас групи ';
l_FIN_KOD.ORD :=623;
l_FIN_KOD.KOD :='XXXX';
l_FIN_KOD.IDF :=51;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Виручка від реалізації продукції';
l_FIN_KOD.ORD :=1;
l_FIN_KOD.KOD :='AZ1';
l_FIN_KOD.IDF :=11;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Витрати на збут';
l_FIN_KOD.ORD :=6;
l_FIN_KOD.KOD :='AZ6';
l_FIN_KOD.IDF :=11;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Власний капітал';
l_FIN_KOD.ORD :=6;
l_FIN_KOD.KOD :='AP6';
l_FIN_KOD.IDF :=13;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Грошові кошти';
l_FIN_KOD.ORD :=11;
l_FIN_KOD.KOD :='AB11';
l_FIN_KOD.IDF :=12;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Група виду економічної діяльності';
l_FIN_KOD.ORD :=500;
l_FIN_KOD.KOD :='GVED';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Дата проведення реструктуризації ';
l_FIN_KOD.ORD :=604;
l_FIN_KOD.KOD :='DRES';
l_FIN_KOD.IDF :=51;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Довгострокові зобов''язання';
l_FIN_KOD.ORD :=12;
l_FIN_KOD.KOD :='AP12';
l_FIN_KOD.IDF :=13;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Запаси';
l_FIN_KOD.ORD :=8;
l_FIN_KOD.KOD :='AB8';
l_FIN_KOD.IDF :=12;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Зкорегований клас з врахуванням прострочки';
l_FIN_KOD.ORD :=1;
l_FIN_KOD.KOD :='CLSP';
l_FIN_KOD.IDF :=60;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Зкорегований клас позичальника';
l_FIN_KOD.ORD :=607;
l_FIN_KOD.KOD :='CLS';
l_FIN_KOD.IDF :=56;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Зкорегований клас позичальника';
l_FIN_KOD.ORD :=1;
l_FIN_KOD.KOD :='CLS';
l_FIN_KOD.IDF :=60;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Зкорегований клас позичальника врахуванням групи повязаних контронтрагентів';
l_FIN_KOD.ORD :=613;
l_FIN_KOD.KOD :='CLS2';
l_FIN_KOD.IDF :=56;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Зкорегований клас позичальника врахуванянм групи під спільним контролем';
l_FIN_KOD.ORD :=614;
l_FIN_KOD.KOD :='KKDP';
l_FIN_KOD.IDF :=56;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Зкорегований клас позичальника врахуванянм групи під спільним контролем';
l_FIN_KOD.ORD :=612;
l_FIN_KOD.KOD :='CLS1';
l_FIN_KOD.IDF :=56;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Зкорегований клас позичальника з врахуванням кількості днів прострочки';
l_FIN_KOD.ORD :=607;
l_FIN_KOD.KOD :='CLSP';
l_FIN_KOD.IDF :=56;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Значення інтегрального показника';
l_FIN_KOD.ORD :=501;
l_FIN_KOD.KOD :='PIPB';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Значення коофіцієнта PD (розрахункове)';
l_FIN_KOD.ORD :=611;
l_FIN_KOD.KOD :='PD';
l_FIN_KOD.IDF :=56;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Значення коофіцієнта PD (розрахункове)';
l_FIN_KOD.ORD :=1;
l_FIN_KOD.KOD :='PD8D';
l_FIN_KOD.IDF :=53;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='К1 – показники покриття боргу  ';
l_FIN_KOD.ORD :=101;
l_FIN_KOD.KOD :='PK1';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='N';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='К1, МК1 –коефіцієнт покриття (ліквід-ність третього ступеня)';
l_FIN_KOD.ORD :=1;
l_FIN_KOD.KOD :='K1';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='К10  –показник загальної ліквідності ';
l_FIN_KOD.ORD :=110;
l_FIN_KOD.KOD :='PK10';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='N';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='К10 – показник маневреності робочого капіталу (Частка оборотних активів, непокритих поточними зобов’язан-нями)';
l_FIN_KOD.ORD :=610;
l_FIN_KOD.KOD :='LK10';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='N';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='К11, МК11 – показники покриття боргу чистим доходом (Спроможність обслуговування боргу доходами від основного виду діяльності)';
l_FIN_KOD.ORD :=611;
l_FIN_KOD.KOD :='LK11';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='N';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='К11- показник здатності обслуговування боргу';
l_FIN_KOD.ORD :=111;
l_FIN_KOD.KOD :='PK11';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='N';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='К12 – показник покриття боргу прибутком до амортизації та оподаткування (Спроможність обслуговування боргу прибутком до оподаткування та амортизації)';
l_FIN_KOD.ORD :=612;
l_FIN_KOD.KOD :='LK12';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='N';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='К13 – показник частки неопераційних елементів балансу (Частка активів, яка не має прямого відношення до операційної діяльності підприємства)';
l_FIN_KOD.ORD :=613;
l_FIN_KOD.KOD :='LK13';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='N';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='К13– показник оборотності дебіторської заборгованості';
l_FIN_KOD.ORD :=113;
l_FIN_KOD.KOD :='PK13';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='N';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='К14 – показник оборотності кредиторської заборгованості';
l_FIN_KOD.ORD :=114;
l_FIN_KOD.KOD :='PK14';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='N';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='К14 – показники оборотності поточних активів (Період повного обороту поточних активів)';
l_FIN_KOD.ORD :=614;
l_FIN_KOD.KOD :='LK14';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='N';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='К15 – показник покриття фінансових витрат прибутком до оподаткування та амортизації (Спроможність фінансування неопераційних витрат операційним прибутком до вир';
l_FIN_KOD.ORD :=615;
l_FIN_KOD.KOD :='LK15';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='N';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='К15 – показник частки неопераційних елементів балансу';
l_FIN_KOD.ORD :=115;
l_FIN_KOD.KOD :='PK15';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='N';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='К16 – показник операційного прибутку до відрахування амортизації ';
l_FIN_KOD.ORD :=116;
l_FIN_KOD.KOD :='PK16';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='N';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='К16 – показник рентабельності до оподаткування (Ефективність діяльності підприємства до оподаткування)';
l_FIN_KOD.ORD :=616;
l_FIN_KOD.KOD :='LK16';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='N';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='К17 – показник покриття фінансових витрат валовим (Спроможність фінансування неопераційних витрат валовим прибутком)';
l_FIN_KOD.ORD :=617;
l_FIN_KOD.KOD :='LK17';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='N';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='К18 – показники заборгованості (Частка боргу підприємства до активів)';
l_FIN_KOD.ORD :=618;
l_FIN_KOD.KOD :='LK18';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='N';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='К1– показники капіталу  (Частка капіталу в балансі підприємства)';
l_FIN_KOD.ORD :=601;
l_FIN_KOD.KOD :='LK1';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='N';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='К2  – показники рентабельності активів   ';
l_FIN_KOD.ORD :=102;
l_FIN_KOD.KOD :='PK2';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='N';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='К2 – показники загальної ліквідності (Спроможність підприємства покривати короткостроко-ві зобов’язання за рахунок оборотних активів)';
l_FIN_KOD.ORD :=602;
l_FIN_KOD.KOD :='LK2';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='N';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='К3 – показники покриття боргу прибутком до оподаткування (Спроможність обслуговування боргу прибутком до оподаткування)';
l_FIN_KOD.ORD :=603;
l_FIN_KOD.KOD :='LK3';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='N';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='К3 –показник покриття фінансових витрат за результатами  операційної діяльності';
l_FIN_KOD.ORD :=103;
l_FIN_KOD.KOD :='PK3';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='N';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='К4  –  показники капіталу';
l_FIN_KOD.ORD :=104;
l_FIN_KOD.KOD :='PK4';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='N';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='К4 – показники операційної рентабельності активів ( Ефективність використання активів підприємства в операційній діяльності )';
l_FIN_KOD.ORD :=604;
l_FIN_KOD.KOD :='LK4';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='N';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='К5 – показники маневреності робочого капіталу';
l_FIN_KOD.ORD :=105;
l_FIN_KOD.KOD :='PK5';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='N';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='К5 – показники оборотності запасів ( Період повного обороту запасів )';
l_FIN_KOD.ORD :=605;
l_FIN_KOD.KOD :='LK5';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='N';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='К6 – показники покриття боргу валовим прибутком ( Спроможність обслуговування боргу валовим прибутком )';
l_FIN_KOD.ORD :=606;
l_FIN_KOD.KOD :='LK6';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='N';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='К6 – показники покриття капіталом боргу ';
l_FIN_KOD.ORD :=106;
l_FIN_KOD.KOD :='PK6';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='N';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='К7 – показники покриття чистих фінансових витрат операційним прибутком (Спроможність фінансування чистих неопераційних витрат за результатами операційної д';
l_FIN_KOD.ORD :=607;
l_FIN_KOD.KOD :='LK7';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='N';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='К7 – показники швидкої ліквідності';
l_FIN_KOD.ORD :=107;
l_FIN_KOD.KOD :='PK7';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='N';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='К8 – показники оборотності активів ';
l_FIN_KOD.ORD :=108;
l_FIN_KOD.KOD :='PK8';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='N';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='К8 – показники оборотності кредиторської заборгованості ( Період повного обороту кредиторської заборгованості )';
l_FIN_KOD.ORD :=608;
l_FIN_KOD.KOD :='LK8';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='N';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='К9 – показники оборотності дебіторської заборгованості (Період повного обороту дебіторської заборгованості)';
l_FIN_KOD.ORD :=609;
l_FIN_KOD.KOD :='LK9';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='N';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='К9 –показники оборотності поточних активів ';
l_FIN_KOD.ORD :=109;
l_FIN_KOD.KOD :='PK9';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='N';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Кількість днів прострочки на дату реструктуризації';
l_FIN_KOD.ORD :=606;
l_FIN_KOD.KOD :='PRES';
l_FIN_KOD.IDF :=51;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Кількість реструктуризацій Не вірно вказано';
l_FIN_KOD.ORD :=603;
l_FIN_KOD.KOD :='KRES';
l_FIN_KOD.IDF :=51;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Кількість реструктуризацій Не вірно вказано';
l_FIN_KOD.ORD :=603;
l_FIN_KOD.KOD :='KRES';
l_FIN_KOD.IDF :=71;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Капітал';
l_FIN_KOD.ORD :=8;
l_FIN_KOD.KOD :='AP8';
l_FIN_KOD.IDF :=13;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Клас визначений з інтегрального показника';
l_FIN_KOD.ORD :=503;
l_FIN_KOD.KOD :='CLAS';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Клас на дату реструктуризації';
l_FIN_KOD.ORD :=605;
l_FIN_KOD.KOD :='CRES';
l_FIN_KOD.IDF :=51;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Клас підняти на ';
l_FIN_KOD.ORD :=619;
l_FIN_KOD.KOD :='CLS+';
l_FIN_KOD.IDF :=51;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Код групи повязаних осіб';
l_FIN_KOD.ORD :=610;
l_FIN_KOD.KOD :='NUMG';
l_FIN_KOD.IDF :=51;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Коофіциент PD';
l_FIN_KOD.ORD :=1;
l_FIN_KOD.KOD :='PD';
l_FIN_KOD.IDF :=60;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Кредити та запозичення';
l_FIN_KOD.ORD :=9;
l_FIN_KOD.KOD :='AP9';
l_FIN_KOD.IDF :=13;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='МК1 – показники капіталу  (Частка капіталу в балансі підприємства)';
l_FIN_KOD.ORD :=601;
l_FIN_KOD.KOD :='LK1';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='R';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='МК1 – показники капіталу  (Частка капіталу в балансі підприємства)';
l_FIN_KOD.ORD :=601;
l_FIN_KOD.KOD :='LK1';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='C';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='МК1 – показники покриття боргу  ';
l_FIN_KOD.ORD :=201;
l_FIN_KOD.KOD :='PK1';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='R';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='МК1 – показники покриття боргу  ';
l_FIN_KOD.ORD :=301;
l_FIN_KOD.KOD :='PK1';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='C';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='МК10 – показник оборотності робочого капіталу  (Співвідношен-ня оборотних активів, непокритих поточними зобов’язан-нями, та чистого доходу)';
l_FIN_KOD.ORD :=610;
l_FIN_KOD.KOD :='LK10';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='R';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='МК10 – показник оборотності робочого капіталу  (Співвідношен-ня оборотних активів, непокритих поточними зобов’язан-нями, та чистого доходу)';
l_FIN_KOD.ORD :=610;
l_FIN_KOD.KOD :='LK10';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='C';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='МК11 – показники покриття боргу чистим доходом (Спроможність обслуговування боргу доходами від основного виду діяльності)';
l_FIN_KOD.ORD :=611;
l_FIN_KOD.KOD :='LK11';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='C';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='МК11 – показники покриття боргу чистим доходом (Спроможність обслуговування боргу доходами від основного виду діяльності)';
l_FIN_KOD.ORD :=611;
l_FIN_KOD.KOD :='LK11';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='R';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='МК12 – показник оборотності основних засобів ';
l_FIN_KOD.ORD :=212;
l_FIN_KOD.KOD :='PK12';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='R';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='МК12 – показник оборотності основних засобів ';
l_FIN_KOD.ORD :=312;
l_FIN_KOD.KOD :='PK12';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='C';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='МК12 – показник рентабельності активів до оподаткування (Ефективність використання активів підприємства)';
l_FIN_KOD.ORD :=612;
l_FIN_KOD.KOD :='LK12';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='C';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='МК12 – показник рентабельності активів до оподаткування (Ефективність використання активів підприємства)';
l_FIN_KOD.ORD :=612;
l_FIN_KOD.KOD :='LK12';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='R';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='МК13 – показник покриття фінансових витрат операційним прибутком (Спроможність фінансування неопераційних витрат операційним прибутком)';
l_FIN_KOD.ORD :=613;
l_FIN_KOD.KOD :='LK13';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='C';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='МК13 – показник покриття фінансових витрат операційним прибутком (Спроможність фінансування неопераційних витрат операційним прибутком)';
l_FIN_KOD.ORD :=613;
l_FIN_KOD.KOD :='LK13';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='R';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='МК14 – показники оборотності поточних активів (Період повного обороту поточних активів)';
l_FIN_KOD.ORD :=614;
l_FIN_KOD.KOD :='LK14';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='R';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='МК14 – показники оборотності поточних активів (Період повного обороту поточних активів)';
l_FIN_KOD.ORD :=614;
l_FIN_KOD.KOD :='LK14';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='C';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='МК17 – показник валової рентабельності (Ефективність основної діяльності підприємства)';
l_FIN_KOD.ORD :=617;
l_FIN_KOD.KOD :='LK17';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='C';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='МК17 – показник валової рентабельності (Ефективність основної діяльності підприємства)';
l_FIN_KOD.ORD :=617;
l_FIN_KOD.KOD :='LK17';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='R';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='МК18 – показники заборгованості (Частка боргу підприємства до активів)';
l_FIN_KOD.ORD :=618;
l_FIN_KOD.KOD :='LK18';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='C';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='МК18 – показники заборгованості (Частка боргу підприємства до активів)';
l_FIN_KOD.ORD :=618;
l_FIN_KOD.KOD :='LK18';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='R';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='МК2 – показники загальної ліквідності (Спроможність підприємства покривати короткостроко-ві зобов’язання за рахунок оборотних активів)';
l_FIN_KOD.ORD :=602;
l_FIN_KOD.KOD :='LK2';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='R';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='МК2 – показники загальної ліквідності (Спроможність підприємства покривати короткостроко-ві зобов’язання за рахунок оборотних активів)';
l_FIN_KOD.ORD :=602;
l_FIN_KOD.KOD :='LK2';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='C';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='МК2 – показники рентабельності активів   ';
l_FIN_KOD.ORD :=302;
l_FIN_KOD.KOD :='PK2';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='C';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='МК2 – показники рентабельності активів   ';
l_FIN_KOD.ORD :=202;
l_FIN_KOD.KOD :='PK2';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='R';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='МК3 – показники покриття боргу прибутком до оподаткування (Спроможність обслуговування боргу прибутком до оподаткування)';
l_FIN_KOD.ORD :=603;
l_FIN_KOD.KOD :='LK3';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='R';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='МК3 – показники покриття боргу прибутком до оподаткування (Спроможність обслуговування боргу прибутком до оподаткування)';
l_FIN_KOD.ORD :=603;
l_FIN_KOD.KOD :='LK3';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='C';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='МК3 –показник покриття фінансових витрат за результатами  операційної діяльності';
l_FIN_KOD.ORD :=203;
l_FIN_KOD.KOD :='PK3';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='C';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='МК3 –показник покриття фінансових витрат за результатами  операційної діяльності';
l_FIN_KOD.ORD :=203;
l_FIN_KOD.KOD :='PK3';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='R';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='МК4 – показники операційної рентабельності активів ( Ефективність використання активів підприємства в операційній діяльності )';
l_FIN_KOD.ORD :=604;
l_FIN_KOD.KOD :='LK4';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='R';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='МК4 – показники операційної рентабельності активів ( Ефективність використання активів підприємства в операційній діяльності )';
l_FIN_KOD.ORD :=604;
l_FIN_KOD.KOD :='LK4';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='C';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='МК5 – показники оборотності запасів ( Період повного обороту запасів )';
l_FIN_KOD.ORD :=605;
l_FIN_KOD.KOD :='LK5';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='C';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='МК5 – показники оборотності запасів ( Період повного обороту запасів )';
l_FIN_KOD.ORD :=605;
l_FIN_KOD.KOD :='LK5';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='R';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='МК6 – показники покриття боргу валовим прибутком ( Спроможність обслуговування боргу валовим прибутком )';
l_FIN_KOD.ORD :=606;
l_FIN_KOD.KOD :='LK6';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='R';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='МК6 – показники покриття боргу валовим прибутком ( Спроможність обслуговування боргу валовим прибутком )';
l_FIN_KOD.ORD :=606;
l_FIN_KOD.KOD :='LK6';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='C';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='МК6 – показники покриття капіталом боргу ';
l_FIN_KOD.ORD :=306;
l_FIN_KOD.KOD :='PK6';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='C';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='МК6 – показники покриття капіталом боргу ';
l_FIN_KOD.ORD :=206;
l_FIN_KOD.KOD :='PK6';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='R';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='МК7 – показники покриття чистих фінансових витрат операційним прибутком (Спроможність фінансування чистих неопераційних витрат за результатами операційної д';
l_FIN_KOD.ORD :=607;
l_FIN_KOD.KOD :='LK7';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='R';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='МК7 – показники покриття чистих фінансових витрат операційним прибутком (Спроможність фінансування чистих неопераційних витрат за результатами операційної д';
l_FIN_KOD.ORD :=607;
l_FIN_KOD.KOD :='LK7';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='C';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='МК7 – показники швидкої ліквідності';
l_FIN_KOD.ORD :=207;
l_FIN_KOD.KOD :='PK7';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='R';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='МК7 – показники швидкої ліквідності';
l_FIN_KOD.ORD :=307;
l_FIN_KOD.KOD :='PK7';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='C';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='МК8 – показники оборотності активів ';
l_FIN_KOD.ORD :=208;
l_FIN_KOD.KOD :='PK8';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='R';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='МК8 – показники оборотності активів ';
l_FIN_KOD.ORD :=308;
l_FIN_KOD.KOD :='PK8';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='C';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='МК8 – показники оборотності кредиторської заборгованості ( Період повного обороту кредиторської заборгованості )';
l_FIN_KOD.ORD :=608;
l_FIN_KOD.KOD :='LK8';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='R';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='МК8 – показники оборотності кредиторської заборгованості ( Період повного обороту кредиторської заборгованості )';
l_FIN_KOD.ORD :=608;
l_FIN_KOD.KOD :='LK8';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='C';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='МК9 – показники оборотності дебіторської заборгованості (Період повного обороту дебіторської заборгованості)';
l_FIN_KOD.ORD :=609;
l_FIN_KOD.KOD :='LK9';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='R';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='МК9 – показники оборотності дебіторської заборгованості (Період повного обороту дебіторської заборгованості)';
l_FIN_KOD.ORD :=609;
l_FIN_KOD.KOD :='LK9';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='C';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='МК9 –показники оборотності поточних активів';
l_FIN_KOD.ORD :=309;
l_FIN_KOD.KOD :='PK9';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='C';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='МК9 –показники оборотності поточних активів';
l_FIN_KOD.ORD :=209;
l_FIN_KOD.KOD :='PK9';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='R';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Неконтрольна частка';
l_FIN_KOD.ORD :=7;
l_FIN_KOD.KOD :='AP7';
l_FIN_KOD.IDF :=13;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Нематеріальні активи';
l_FIN_KOD.ORD :=3;
l_FIN_KOD.KOD :='AB3';
l_FIN_KOD.IDF :=12;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Необоротні активи';
l_FIN_KOD.ORD :=7;
l_FIN_KOD.KOD :='AB7';
l_FIN_KOD.IDF :=12;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Нерозподілений прибуток / збиток';
l_FIN_KOD.ORD :=5;
l_FIN_KOD.KOD :='AP5';
l_FIN_KOD.IDF :=13;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Оборотні активи';
l_FIN_KOD.ORD :=13;
l_FIN_KOD.KOD :='AB13';
l_FIN_KOD.IDF :=12;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Операційний прибуток / збиток';
l_FIN_KOD.ORD :=8;
l_FIN_KOD.KOD :='AZ8';
l_FIN_KOD.IDF :=11;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Основні засоби, нерухомість та обладнання ';
l_FIN_KOD.ORD :=2;
l_FIN_KOD.KOD :='AB2';
l_FIN_KOD.IDF :=12;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Пасиви';
l_FIN_KOD.ORD :=1;
l_FIN_KOD.KOD :='AP1';
l_FIN_KOD.IDF :=13;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Податки';
l_FIN_KOD.ORD :=16;
l_FIN_KOD.KOD :='AZ16';
l_FIN_KOD.IDF :=11;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Податкові зобов''язання';
l_FIN_KOD.ORD :=15;
l_FIN_KOD.KOD :='AP15';
l_FIN_KOD.IDF :=13;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Показник - X14 ';
l_FIN_KOD.ORD :=414;
l_FIN_KOD.KOD :='X14';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Показник - X15 ';
l_FIN_KOD.ORD :=415;
l_FIN_KOD.KOD :='X15';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Показник - X16';
l_FIN_KOD.ORD :=416;
l_FIN_KOD.KOD :='X16';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Показник -X1  ';
l_FIN_KOD.ORD :=401;
l_FIN_KOD.KOD :='X1';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Показник -X10 ';
l_FIN_KOD.ORD :=410;
l_FIN_KOD.KOD :='X10';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Показник -X11 ';
l_FIN_KOD.ORD :=411;
l_FIN_KOD.KOD :='X11';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Показник -X12 ';
l_FIN_KOD.ORD :=412;
l_FIN_KOD.KOD :='X12';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Показник -X13';
l_FIN_KOD.ORD :=413;
l_FIN_KOD.KOD :='X13';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Показник -X2  ';
l_FIN_KOD.ORD :=402;
l_FIN_KOD.KOD :='X2';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Показник -X3';
l_FIN_KOD.ORD :=403;
l_FIN_KOD.KOD :='X3';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Показник -X4 ';
l_FIN_KOD.ORD :=404;
l_FIN_KOD.KOD :='X4';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Показник -X5';
l_FIN_KOD.ORD :=405;
l_FIN_KOD.KOD :='X5';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Показник -X6  ';
l_FIN_KOD.ORD :=406;
l_FIN_KOD.KOD :='X6';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Показник -X7';
l_FIN_KOD.ORD :=407;
l_FIN_KOD.KOD :='X7';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Показник -X8  ';
l_FIN_KOD.ORD :=408;
l_FIN_KOD.KOD :='X8';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Показник -X9  ';
l_FIN_KOD.ORD :=409;
l_FIN_KOD.KOD :='X9';
l_FIN_KOD.IDF :=6;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Поточні зобов''язання';
l_FIN_KOD.ORD :=17;
l_FIN_KOD.KOD :='AP17';
l_FIN_KOD.IDF :=13;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Поточні кредити та запозичення';
l_FIN_KOD.ORD :=13;
l_FIN_KOD.KOD :='AP13';
l_FIN_KOD.IDF :=13;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Поточні податкові активи';
l_FIN_KOD.ORD :=10;
l_FIN_KOD.KOD :='AB10';
l_FIN_KOD.IDF :=12;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Поточна дебіторська заборгованість';
l_FIN_KOD.ORD :=9;
l_FIN_KOD.KOD :='AB9';
l_FIN_KOD.IDF :=12;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Прибуток / збиток до оподаткування';
l_FIN_KOD.ORD :=15;
l_FIN_KOD.KOD :='AZ15';
l_FIN_KOD.IDF :=11;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Рішення колегіального органу data (Клас К вищий за клас групи)';
l_FIN_KOD.ORD :=621;
l_FIN_KOD.KOD :='RKD2';
l_FIN_KOD.IDF :=51;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Рішення колегіального органу data (Клас К нижчий за клас групи)';
l_FIN_KOD.ORD :=618;
l_FIN_KOD.KOD :='RKD1';
l_FIN_KOD.IDF :=51;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Рішення колегіального органу data (відсутня звітність)';
l_FIN_KOD.ORD :=616;
l_FIN_KOD.KOD :='RKD0';
l_FIN_KOD.IDF :=51;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Рішення колегіального органу data (ознак визнання дефолту)';
l_FIN_KOD.ORD :=621;
l_FIN_KOD.KOD :='VDD1';
l_FIN_KOD.IDF :=74;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Рішення колегіального органу data (ознак визнання дефолту)';
l_FIN_KOD.ORD :=621;
l_FIN_KOD.KOD :='ZDD1';
l_FIN_KOD.IDF :=75;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Рішення колегіального органу data (ознак визнання дефолту)';
l_FIN_KOD.ORD :=621;
l_FIN_KOD.KOD :='ZDD1';
l_FIN_KOD.IDF :=57;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Рішення колегіального органу data (ознак визнання дефолту)';
l_FIN_KOD.ORD :=621;
l_FIN_KOD.KOD :='VDD1';
l_FIN_KOD.IDF :=56;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Рішення колегіального органу № (Клас К вищий за клас групи)';
l_FIN_KOD.ORD :=620;
l_FIN_KOD.KOD :='RKN2';
l_FIN_KOD.IDF :=51;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Рішення колегіального органу № (Клас К нижчий за клас групи)';
l_FIN_KOD.ORD :=617;
l_FIN_KOD.KOD :='RKN1';
l_FIN_KOD.IDF :=51;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Рішення колегіального органу № (відсутня звітність)';
l_FIN_KOD.ORD :=615;
l_FIN_KOD.KOD :='RKN0';
l_FIN_KOD.IDF :=51;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Рішення колегіального органу № (ознак визнання дефолту)';
l_FIN_KOD.ORD :=620;
l_FIN_KOD.KOD :='VDN1';
l_FIN_KOD.IDF :=74;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Рішення колегіального органу № (ознак визнання дефолту)';
l_FIN_KOD.ORD :=620;
l_FIN_KOD.KOD :='VDN1';
l_FIN_KOD.IDF :=56;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Рішення колегіального органу № (ознак визнання дефолту)';
l_FIN_KOD.ORD :=620;
l_FIN_KOD.KOD :='ZDN1';
l_FIN_KOD.IDF :=75;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Рішення колегіального органу № (ознак визнання дефолту)';
l_FIN_KOD.ORD :=620;
l_FIN_KOD.KOD :='ZDN1';
l_FIN_KOD.IDF :=57;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Резерв накопичених курсових різниць';
l_FIN_KOD.ORD :=4;
l_FIN_KOD.KOD :='AP4';
l_FIN_KOD.IDF :=13;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Результат від участі в капіталі';
l_FIN_KOD.ORD :=11;
l_FIN_KOD.KOD :='AZ11';
l_FIN_KOD.IDF :=11;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Собівартість реалізованої продукції';
l_FIN_KOD.ORD :=2;
l_FIN_KOD.KOD :='AZ2';
l_FIN_KOD.IDF :=11;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Статутний капітал';
l_FIN_KOD.ORD :=2;
l_FIN_KOD.KOD :='AP2';
l_FIN_KOD.IDF :=13;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Сформований банком резерв під зменшення корисності, %';
l_FIN_KOD.ORD :=609;
l_FIN_KOD.KOD :='SRKA';
l_FIN_KOD.IDF :=52;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Торгова та інша дебіторська заборгованість';
l_FIN_KOD.ORD :=4;
l_FIN_KOD.KOD :='AB4';
l_FIN_KOD.IDF :=12;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Торгова та інша кредиторська заборгованість';
l_FIN_KOD.ORD :=14;
l_FIN_KOD.KOD :='AP14';
l_FIN_KOD.IDF :=13;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Фінансові витрати';
l_FIN_KOD.ORD :=10;
l_FIN_KOD.KOD :='AZ10';
l_FIN_KOD.IDF :=11;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Фінансові доходи';
l_FIN_KOD.ORD :=9;
l_FIN_KOD.KOD :='AZ9';
l_FIN_KOD.IDF :=11;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Фонд переоцінки';
l_FIN_KOD.ORD :=3;
l_FIN_KOD.KOD :='AP3';
l_FIN_KOD.IDF :=13;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Чиста кредитна заборгованість до значення EBITDA';
l_FIN_KOD.ORD :=602;
l_FIN_KOD.KOD :='KZDE';
l_FIN_KOD.IDF :=52;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Чиста кредитна заборгованість до чистої виручки від реалізації';
l_FIN_KOD.ORD :=601;
l_FIN_KOD.KOD :='KZDV';
l_FIN_KOD.IDF :=52;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Чистий прибуток / збиток';
l_FIN_KOD.ORD :=17;
l_FIN_KOD.KOD :='AZ17';
l_FIN_KOD.IDF :=11; 
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Чистий прибуток / збиток від курсових різниць';
l_FIN_KOD.ORD :=14;
l_FIN_KOD.KOD :='AZ14';
l_FIN_KOD.IDF :=11;
l_FIN_KOD.FM :='F';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='кількість днів прострочки';
l_FIN_KOD.ORD :=1;
l_FIN_KOD.KOD :='KKDP';
l_FIN_KOD.IDF :=60;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);


l_FIN_KOD.NAME :='Дата фінансової реструктуризації data (ознак приппинення дефолту)';
l_FIN_KOD.ORD :=622;
l_FIN_KOD.KOD :='DZD6';
l_FIN_KOD.IDF :=55;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD); 
 
 
l_FIN_KOD.NAME :='Рішення колегіального органу data (ознак припинення дефолту)';
l_FIN_KOD.ORD :=620;
l_FIN_KOD.KOD :='DZD7';
l_FIN_KOD.IDF :=55;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);
 
 l_FIN_KOD.NAME :='Рішення колегіального органу № (ознак припинення дефолту)';
l_FIN_KOD.ORD :=620;
l_FIN_KOD.KOD :='NZD7';
l_FIN_KOD.IDF :=55;
l_FIN_KOD.FM :='0';

 p_merge( l_FIN_KOD);
commit;
END;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Data/patch_data_FIN_KOD.sql =========*** End
PROMPT ===================================================================================== 
