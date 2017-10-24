begin

   for k in (select kf from MV_KF) loop
       bc.subst_mfo(k.kf);

        Insert into BARS.CUST_PTKC
           (RNK, OKPO, NMK, COMM)
         Values
           ('999999999', '35442539', 'ТОВ ''Фінансова компанія Контрактовий дім''', 
            'дог. N 8 від 22.02.2012 1 рік з пролонгацією інкасація терміналів самообслуговування');

        Insert into BARS.CUST_PTKC
           (RNK, OKPO, NMK, COMM)
         Values
           ('999999999', '36425142', 'ТОВ ''Глобал Мані''', 
            'дог. N 64 від 08.07.2013 1 рік з пролонгацією інкасація та доставка готівкових коштів');

        Insert into BARS.CUST_PTKC
           (RNK, OKPO, NMK, COMM)
         Values
           ('999999999', '34046074', 'ТОВ ''Айбокс''', 
            'дог. N 104 від 27.06.2014 1 рік з пролонгацією інкасація терміналів самообслуговування');

        Insert into BARS.CUST_PTKC
           (RNK, OKPO, NMK, COMM)
         Values
           ('999999999', '38324133', 'ТОВ ''Пост Фінанс''', 
            'дог. N 110 від 26.09.2014 1 рік з пролонгацією інкасація та доставка готівкових коштів');

        Insert into BARS.CUST_PTKC
           (RNK, OKPO, NMK, COMM)
         Values
           ('999999999', '35075436', 'ТОВ ''ІНАНСОВА КОМПАНІЯ ФЕНІКС''', 
            'дог. N 147 від 02.06.2015 1 рік з пролонгацією інкасація терміналів самообслуговування');

        Insert into BARS.CUST_PTKC
           (RNK, OKPO, NMK, COMM)
         Values
           ('999999999', '36426020', 'ТОВ ''ФІНАНСОВА КОМАНІЯ ОМП-2013''', 
            'дог. N 148 від 04.06.2015 1 рік з пролонгацією інкасація терміналів самообслуговування');

        Insert into BARS.CUST_PTKC
           (RNK, OKPO, NMK, COMM)
         Values
           ('999999999', '39859339', 'ТОВ ''СВІФТ ГАРАНТ''', 
            'дог. N 230 від 30.05.2016 1 рік з пролонгацією інкасація терміналів самообслуговування');

        Insert into BARS.CUST_PTKC
           (RNK, OKPO, NMK, COMM)
         Values
           ('999999999', '40243180', 'ТОВ «ЕЛЕКТРУМ ПЕЙМЕНТ СІСТЕМ»', 
            'дог. N 231 від 10.05.2016 1 рік з пролонгацією інкасація готівкових коштів');

        Insert into BARS.CUST_PTKC
           (RNK, OKPO, NMK, COMM)
         Values
           ('999999999', '39776771', 'ТОВ «ФІНАНСОВА КОМПАНІЯ «КРЕДИТОР ХХI»', 
            'дог. N 253 від 19.10.2016 1 рік з пролонгацією інкасація готівкових коштів');

        Insert into BARS.CUST_PTKC
           (RNK, OKPO, NMK, COMM)
         Values
           ('999999999', '39299501', 'ТОВ ''ТРІОЛАН.МАНІ''', 
            'дог. N 288 від 27.02.2017 1 рік з пролонгацією інкасація терміналів самообслуговування');

        Insert into BARS.CUST_PTKC
           (RNK, OKPO, NMK, COMM)
         Values
           ('999999999', '39405417', 'ТОВ «Фінансова компанія «ТАНДЕМ-ФІНАНС»', 
            'дог. N 290 від 15.03.2017 1 рік з пролонгацією інкасація терміналів самообслуговування');

        Insert into BARS.CUST_PTKC
           (RNK, OKPO, NMK, COMM)
         Values
           ('999999999', '36060724', 'ТОВ ''ФК АБСОЛЮТ ФІНАНС''', 
            'дог. N 211/25-11 від 18.06.2014 1 рік з пролонгацією Інкасація та повернення вал. цінновстей');

        Insert into BARS.CUST_PTKC
           (RNK, OKPO, NMK, COMM)
         Values
           ('999999999', '39601463', 'ТОВ ''НСП''', 
            'дог. N 1478 від 03.06.2016 1 рік з пролонгацією інкасація готівкових коштів');
       
       for k in ( select unique c.rnk, p.okpo
                  from customer c, CUST_PTKC p
                  where c.rnk in (select rnk
                                  from accounts 
                                  where nls like '2909%' 
                                    and kv = 980 
                                    and ob22 = '43') 
                    and c.okpo = p.okpo
                ) 

           loop
      
              update CUST_PTKC set rnk = k.rnk 
              where okpo = k.okpo;
          
           end loop;
        commit;   
   end loop;

end;
/           
          
exec bc.home;
 
