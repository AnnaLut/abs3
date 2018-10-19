
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Data/patch_data_KL_K190.sql =========*** Run
PROMPT ===================================================================================== 

declare
l_KL_K190  KL_K190%rowtype;

procedure p_merge(p_KL_K190 KL_K190%rowtype) 
as
Begin
   insert into KL_K190
      values p_KL_K190; 
 exception when dup_val_on_index then  
   update KL_K190
      set row = p_KL_K190
;
End;
Begin

l_KL_K190.K190 :='#';
l_KL_K190.RATING :='';
l_KL_K190.DESCR :='Розріз відсутній';
l_KL_K190.DT_OPEN :=to_date('01.01.2018','DD.MM.YYYY');
l_KL_K190.DT_CLOSE :=to_date('','DD.MM.YYYY HH24:MI:SS');

 p_merge( l_KL_K190);


l_KL_K190.K190 :='FA01';
l_KL_K190.RATING :='AAA';
l_KL_K190.DESCR :='Вищий інвестиційний клас (Fitch IBCA).';
l_KL_K190.DT_OPEN :=to_date('01.01.2018','DD.MM.YYYY');
l_KL_K190.DT_CLOSE :=to_date('','DD.MM.YYYY HH24:MI:SS');

 p_merge( l_KL_K190);


l_KL_K190.K190 :='FA02';
l_KL_K190.RATING :='AA+';
l_KL_K190.DESCR :='Високий інвестиційний клас (Fitch IBCA).';
l_KL_K190.DT_OPEN :=to_date('01.01.2018','DD.MM.YYYY');
l_KL_K190.DT_CLOSE :=to_date('','DD.MM.YYYY HH24:MI:SS');

 p_merge( l_KL_K190);


l_KL_K190.K190 :='FA03';
l_KL_K190.RATING :='AA';
l_KL_K190.DESCR :='Високий інвестиційний клас (Fitch IBCA).';
l_KL_K190.DT_OPEN :=to_date('01.01.2018','DD.MM.YYYY');
l_KL_K190.DT_CLOSE :=to_date('','DD.MM.YYYY HH24:MI:SS');

 p_merge( l_KL_K190);


l_KL_K190.K190 :='FA04';
l_KL_K190.RATING :='AA-';
l_KL_K190.DESCR :='Високий інвестиційний клас (Fitch IBCA).';
l_KL_K190.DT_OPEN :=to_date('01.01.2018','DD.MM.YYYY');
l_KL_K190.DT_CLOSE :=to_date('','DD.MM.YYYY HH24:MI:SS');

 p_merge( l_KL_K190);


l_KL_K190.K190 :='FA05';
l_KL_K190.RATING :='A+';
l_KL_K190.DESCR :='Підвищений інвестиційний клас (Fitch IBCA).';
l_KL_K190.DT_OPEN :=to_date('01.01.2018','DD.MM.YYYY');
l_KL_K190.DT_CLOSE :=to_date('','DD.MM.YYYY HH24:MI:SS');

 p_merge( l_KL_K190);


l_KL_K190.K190 :='FA06';
l_KL_K190.RATING :='A';
l_KL_K190.DESCR :='Підвищений інвестиційний клас (Fitch IBCA).';
l_KL_K190.DT_OPEN :=to_date('01.01.2018','DD.MM.YYYY');
l_KL_K190.DT_CLOSE :=to_date('','DD.MM.YYYY HH24:MI:SS');

 p_merge( l_KL_K190);


l_KL_K190.K190 :='FA07';
l_KL_K190.RATING :='A-';
l_KL_K190.DESCR :='Підвищений інвестиційний клас (Fitch IBCA).';
l_KL_K190.DT_OPEN :=to_date('01.01.2018','DD.MM.YYYY');
l_KL_K190.DT_CLOSE :=to_date('','DD.MM.YYYY HH24:MI:SS');

 p_merge( l_KL_K190);


l_KL_K190.K190 :='FB01';
l_KL_K190.RATING :='BBB+';
l_KL_K190.DESCR :='Нижчий інвестиційний клас (Fitch IBCA).';
l_KL_K190.DT_OPEN :=to_date('01.01.2018','DD.MM.YYYY');
l_KL_K190.DT_CLOSE :=to_date('','DD.MM.YYYY HH24:MI:SS');

 p_merge( l_KL_K190);


l_KL_K190.K190 :='FB02';
l_KL_K190.RATING :='BBB';
l_KL_K190.DESCR :='Нижчий інвестиційний клас (Fitch IBCA).';
l_KL_K190.DT_OPEN :=to_date('01.01.2018','DD.MM.YYYY');
l_KL_K190.DT_CLOSE :=to_date('','DD.MM.YYYY HH24:MI:SS');

 p_merge( l_KL_K190);


l_KL_K190.K190 :='FB03';
l_KL_K190.RATING :='BBB-';
l_KL_K190.DESCR :='Нижчий інвестиційний клас (Fitch IBCA).';
l_KL_K190.DT_OPEN :=to_date('01.01.2018','DD.MM.YYYY');
l_KL_K190.DT_CLOSE :=to_date('','DD.MM.YYYY HH24:MI:SS');

 p_merge( l_KL_K190);


l_KL_K190.K190 :='FB04';
l_KL_K190.RATING :='BB+';
l_KL_K190.DESCR :='Не інвестиційний клас. Спекулятивний (Fitch IBCA).';
l_KL_K190.DT_OPEN :=to_date('01.01.2018','DD.MM.YYYY');
l_KL_K190.DT_CLOSE :=to_date('','DD.MM.YYYY HH24:MI:SS');

 p_merge( l_KL_K190);


l_KL_K190.K190 :='FB05';
l_KL_K190.RATING :='BB';
l_KL_K190.DESCR :='Не інвестиційний клас. Спекулятивний (Fitch IBCA).';
l_KL_K190.DT_OPEN :=to_date('01.01.2018','DD.MM.YYYY');
l_KL_K190.DT_CLOSE :=to_date('','DD.MM.YYYY HH24:MI:SS');

 p_merge( l_KL_K190);


l_KL_K190.K190 :='FB06';
l_KL_K190.RATING :='BB-';
l_KL_K190.DESCR :='Не інвестиційний клас. Спекулятивний (Fitch IBCA).';
l_KL_K190.DT_OPEN :=to_date('01.01.2018','DD.MM.YYYY');
l_KL_K190.DT_CLOSE :=to_date('','DD.MM.YYYY HH24:MI:SS');

 p_merge( l_KL_K190);


l_KL_K190.K190 :='FB07';
l_KL_K190.RATING :='B+';
l_KL_K190.DESCR :='Високо спекулятивний клас (Fitch IBCA).';
l_KL_K190.DT_OPEN :=to_date('01.01.2018','DD.MM.YYYY');
l_KL_K190.DT_CLOSE :=to_date('','DD.MM.YYYY HH24:MI:SS');

 p_merge( l_KL_K190);


l_KL_K190.K190 :='FB08';
l_KL_K190.RATING :='B';
l_KL_K190.DESCR :='Високо спекулятивний клас (Fitch IBCA).';
l_KL_K190.DT_OPEN :=to_date('01.01.2018','DD.MM.YYYY');
l_KL_K190.DT_CLOSE :=to_date('','DD.MM.YYYY HH24:MI:SS');

 p_merge( l_KL_K190);


l_KL_K190.K190 :='FB09';
l_KL_K190.RATING :='B-';
l_KL_K190.DESCR :='Високо спекулятивний клас (Fitch IBCA).';
l_KL_K190.DT_OPEN :=to_date('01.01.2018','DD.MM.YYYY');
l_KL_K190.DT_CLOSE :=to_date('','DD.MM.YYYY HH24:MI:SS');

 p_merge( l_KL_K190);


l_KL_K190.K190 :='FC01';
l_KL_K190.RATING :='CCC';
l_KL_K190.DESCR :='Клас істотного ризику (Fitch IBCA).';
l_KL_K190.DT_OPEN :=to_date('01.01.2018','DD.MM.YYYY');
l_KL_K190.DT_CLOSE :=to_date('','DD.MM.YYYY HH24:MI:SS');

 p_merge( l_KL_K190);


l_KL_K190.K190 :='FD01';
l_KL_K190.RATING :='DDD';
l_KL_K190.DESCR :='Дефолт. Банкрутство (Fitch IBCA).';
l_KL_K190.DT_OPEN :=to_date('01.01.2018','DD.MM.YYYY');
l_KL_K190.DT_CLOSE :=to_date('','DD.MM.YYYY HH24:MI:SS');

 p_merge( l_KL_K190);


l_KL_K190.K190 :='FD02';
l_KL_K190.RATING :='DD';
l_KL_K190.DESCR :='Дефолт. Банкрутство (Fitch IBCA).';
l_KL_K190.DT_OPEN :=to_date('01.01.2018','DD.MM.YYYY');
l_KL_K190.DT_CLOSE :=to_date('','DD.MM.YYYY HH24:MI:SS');

 p_merge( l_KL_K190);


l_KL_K190.K190 :='FD03';
l_KL_K190.RATING :='D';
l_KL_K190.DESCR :='Дефолт. Банкрутство (Fitch IBCA).';
l_KL_K190.DT_OPEN :=to_date('01.01.2018','DD.MM.YYYY');
l_KL_K190.DT_CLOSE :=to_date('','DD.MM.YYYY HH24:MI:SS');

 p_merge( l_KL_K190);


l_KL_K190.K190 :='MA01';
l_KL_K190.RATING :='Aaa';
l_KL_K190.DESCR :='Вищий інвестиційний клас (Moody''s).';
l_KL_K190.DT_OPEN :=to_date('01.01.2018','DD.MM.YYYY');
l_KL_K190.DT_CLOSE :=to_date('','DD.MM.YYYY HH24:MI:SS');

 p_merge( l_KL_K190);


l_KL_K190.K190 :='MA02';
l_KL_K190.RATING :='Aa1';
l_KL_K190.DESCR :='Високий інвестиційний клас (Moody''s).';
l_KL_K190.DT_OPEN :=to_date('01.01.2018','DD.MM.YYYY');
l_KL_K190.DT_CLOSE :=to_date('','DD.MM.YYYY HH24:MI:SS');

 p_merge( l_KL_K190);


l_KL_K190.K190 :='MA03';
l_KL_K190.RATING :='Aa2';
l_KL_K190.DESCR :='Високий інвестиційний клас (Moody''s).';
l_KL_K190.DT_OPEN :=to_date('01.01.2018','DD.MM.YYYY');
l_KL_K190.DT_CLOSE :=to_date('','DD.MM.YYYY HH24:MI:SS');

 p_merge( l_KL_K190);


l_KL_K190.K190 :='MA04';
l_KL_K190.RATING :='Aa3';
l_KL_K190.DESCR :='Високий інвестиційний клас (Moody''s).';
l_KL_K190.DT_OPEN :=to_date('01.01.2018','DD.MM.YYYY');
l_KL_K190.DT_CLOSE :=to_date('','DD.MM.YYYY HH24:MI:SS');

 p_merge( l_KL_K190);


l_KL_K190.K190 :='MA05';
l_KL_K190.RATING :='A1';
l_KL_K190.DESCR :='Підвищений інвестиційний клас(Moody''s).';
l_KL_K190.DT_OPEN :=to_date('01.01.2018','DD.MM.YYYY');
l_KL_K190.DT_CLOSE :=to_date('','DD.MM.YYYY HH24:MI:SS');

 p_merge( l_KL_K190);


l_KL_K190.K190 :='MA06';
l_KL_K190.RATING :='A2';
l_KL_K190.DESCR :='Підвищений інвестиційний клас (Moody''s).';
l_KL_K190.DT_OPEN :=to_date('01.01.2018','DD.MM.YYYY');
l_KL_K190.DT_CLOSE :=to_date('','DD.MM.YYYY HH24:MI:SS');

 p_merge( l_KL_K190);


l_KL_K190.K190 :='MA07';
l_KL_K190.RATING :='A3';
l_KL_K190.DESCR :='Підвищений інвестиційний клас (Moody''s).';
l_KL_K190.DT_OPEN :=to_date('01.01.2018','DD.MM.YYYY');
l_KL_K190.DT_CLOSE :=to_date('','DD.MM.YYYY HH24:MI:SS');

 p_merge( l_KL_K190);


l_KL_K190.K190 :='MB01';
l_KL_K190.RATING :='Baa1';
l_KL_K190.DESCR :='Нижчий інвестиційний клас (Moody''s).';
l_KL_K190.DT_OPEN :=to_date('01.01.2018','DD.MM.YYYY');
l_KL_K190.DT_CLOSE :=to_date('','DD.MM.YYYY HH24:MI:SS');

 p_merge( l_KL_K190);


l_KL_K190.K190 :='MB02';
l_KL_K190.RATING :='Baa2';
l_KL_K190.DESCR :='Нижчий інвестиційний клас (Moody''s).';
l_KL_K190.DT_OPEN :=to_date('01.01.2018','DD.MM.YYYY');
l_KL_K190.DT_CLOSE :=to_date('','DD.MM.YYYY HH24:MI:SS');

 p_merge( l_KL_K190);


l_KL_K190.K190 :='MB03';
l_KL_K190.RATING :='Baa3';
l_KL_K190.DESCR :='Нижчий інвестиційний клас (Moody''s).';
l_KL_K190.DT_OPEN :=to_date('01.01.2018','DD.MM.YYYY');
l_KL_K190.DT_CLOSE :=to_date('','DD.MM.YYYY HH24:MI:SS');

 p_merge( l_KL_K190);


l_KL_K190.K190 :='MB04';
l_KL_K190.RATING :='Ba1';
l_KL_K190.DESCR :='Не інвестиційний клас. Спекулятивний (Moody''s).';
l_KL_K190.DT_OPEN :=to_date('01.01.2018','DD.MM.YYYY');
l_KL_K190.DT_CLOSE :=to_date('','DD.MM.YYYY HH24:MI:SS');

 p_merge( l_KL_K190);


l_KL_K190.K190 :='MB05';
l_KL_K190.RATING :='Ba2';
l_KL_K190.DESCR :='Не інвестиційний клас. Спекулятивний (Moody''s).';
l_KL_K190.DT_OPEN :=to_date('01.01.2018','DD.MM.YYYY');
l_KL_K190.DT_CLOSE :=to_date('','DD.MM.YYYY HH24:MI:SS');

 p_merge( l_KL_K190);


l_KL_K190.K190 :='MB06';
l_KL_K190.RATING :='Ba3';
l_KL_K190.DESCR :='Не інвестиційний клас. Спекулятивний (Moody''s).';
l_KL_K190.DT_OPEN :=to_date('01.01.2018','DD.MM.YYYY');
l_KL_K190.DT_CLOSE :=to_date('','DD.MM.YYYY HH24:MI:SS');

 p_merge( l_KL_K190);


l_KL_K190.K190 :='MB07';
l_KL_K190.RATING :='B1';
l_KL_K190.DESCR :='Високо спекулятивний клас (Moody''s).';
l_KL_K190.DT_OPEN :=to_date('01.01.2018','DD.MM.YYYY');
l_KL_K190.DT_CLOSE :=to_date('','DD.MM.YYYY HH24:MI:SS');

 p_merge( l_KL_K190);


l_KL_K190.K190 :='MB08';
l_KL_K190.RATING :='B2';
l_KL_K190.DESCR :='Високо спекулятивний клас (Moody''s).';
l_KL_K190.DT_OPEN :=to_date('01.01.2018','DD.MM.YYYY');
l_KL_K190.DT_CLOSE :=to_date('','DD.MM.YYYY HH24:MI:SS');

 p_merge( l_KL_K190);


l_KL_K190.K190 :='MB09';
l_KL_K190.RATING :='B3';
l_KL_K190.DESCR :='Високо спекулятивний клас (Moody''s).';
l_KL_K190.DT_OPEN :=to_date('01.01.2018','DD.MM.YYYY');
l_KL_K190.DT_CLOSE :=to_date('','DD.MM.YYYY HH24:MI:SS');

 p_merge( l_KL_K190);


l_KL_K190.K190 :='MC01';
l_KL_K190.RATING :='Caa1';
l_KL_K190.DESCR :='Клас істотного ризику (Moody''s).';
l_KL_K190.DT_OPEN :=to_date('01.01.2018','DD.MM.YYYY');
l_KL_K190.DT_CLOSE :=to_date('','DD.MM.YYYY HH24:MI:SS');

 p_merge( l_KL_K190);


l_KL_K190.K190 :='MC02';
l_KL_K190.RATING :='Caa2';
l_KL_K190.DESCR :='Екстремально спекулятивний клас (Moody''s).';
l_KL_K190.DT_OPEN :=to_date('01.01.2018','DD.MM.YYYY');
l_KL_K190.DT_CLOSE :=to_date('','DD.MM.YYYY HH24:MI:SS');

 p_merge( l_KL_K190);


l_KL_K190.K190 :='MC03';
l_KL_K190.RATING :='Caa3';
l_KL_K190.DESCR :='Клас дефолту з малою  вірогідністю зростання (Moody''s).';
l_KL_K190.DT_OPEN :=to_date('01.01.2018','DD.MM.YYYY');
l_KL_K190.DT_CLOSE :=to_date('','DD.MM.YYYY HH24:MI:SS');

 p_merge( l_KL_K190);


l_KL_K190.K190 :='MC04';
l_KL_K190.RATING :='Ca';
l_KL_K190.DESCR :='Клас дефолту з малою  вірогідністю зростання (Moody''s).';
l_KL_K190.DT_OPEN :=to_date('01.01.2018','DD.MM.YYYY');
l_KL_K190.DT_CLOSE :=to_date('','DD.MM.YYYY HH24:MI:SS');

 p_merge( l_KL_K190);


l_KL_K190.K190 :='MC05';
l_KL_K190.RATING :='C';
l_KL_K190.DESCR :='Дефолт. Банкрутство (Moody''s).';
l_KL_K190.DT_OPEN :=to_date('01.01.2018','DD.MM.YYYY');
l_KL_K190.DT_CLOSE :=to_date('','DD.MM.YYYY HH24:MI:SS');

 p_merge( l_KL_K190);


l_KL_K190.K190 :='MC06';
l_KL_K190.RATING :='/';
l_KL_K190.DESCR :='Дефолт. Банкрутство (Moody''s).';
l_KL_K190.DT_OPEN :=to_date('01.01.2018','DD.MM.YYYY');
l_KL_K190.DT_CLOSE :=to_date('','DD.MM.YYYY HH24:MI:SS');

 p_merge( l_KL_K190);


l_KL_K190.K190 :='SA01';
l_KL_K190.RATING :='AAA';
l_KL_K190.DESCR :='Вищий інвестиційний клас (Standart & Poor''s).';
l_KL_K190.DT_OPEN :=to_date('01.01.2018','DD.MM.YYYY');
l_KL_K190.DT_CLOSE :=to_date('','DD.MM.YYYY HH24:MI:SS');

 p_merge( l_KL_K190);


l_KL_K190.K190 :='SA02';
l_KL_K190.RATING :='AA+';
l_KL_K190.DESCR :='Високий інвестиційний клас (Standart & Poor''s).';
l_KL_K190.DT_OPEN :=to_date('01.01.2018','DD.MM.YYYY');
l_KL_K190.DT_CLOSE :=to_date('','DD.MM.YYYY HH24:MI:SS');

 p_merge( l_KL_K190);


l_KL_K190.K190 :='SA03';
l_KL_K190.RATING :='AA';
l_KL_K190.DESCR :='Високий інвестиційний клас (Standart & Poor''s).';
l_KL_K190.DT_OPEN :=to_date('01.01.2018','DD.MM.YYYY');
l_KL_K190.DT_CLOSE :=to_date('','DD.MM.YYYY HH24:MI:SS');

 p_merge( l_KL_K190);


l_KL_K190.K190 :='SA04';
l_KL_K190.RATING :='AA-';
l_KL_K190.DESCR :='Високий інвестиційний клас (Standart & Poor''s).';
l_KL_K190.DT_OPEN :=to_date('01.01.2018','DD.MM.YYYY');
l_KL_K190.DT_CLOSE :=to_date('','DD.MM.YYYY HH24:MI:SS');

 p_merge( l_KL_K190);


l_KL_K190.K190 :='SA05';
l_KL_K190.RATING :='A+';
l_KL_K190.DESCR :='Підвищений інвестиційний клас (Standart & Poor''s).';
l_KL_K190.DT_OPEN :=to_date('01.01.2018','DD.MM.YYYY');
l_KL_K190.DT_CLOSE :=to_date('','DD.MM.YYYY HH24:MI:SS');

 p_merge( l_KL_K190);


l_KL_K190.K190 :='SA06';
l_KL_K190.RATING :='A';
l_KL_K190.DESCR :='Підвищений інвестиційний клас (Standart & Poor''s).';
l_KL_K190.DT_OPEN :=to_date('01.01.2018','DD.MM.YYYY');
l_KL_K190.DT_CLOSE :=to_date('','DD.MM.YYYY HH24:MI:SS');

 p_merge( l_KL_K190);


l_KL_K190.K190 :='SA07';
l_KL_K190.RATING :='A-';
l_KL_K190.DESCR :='Підвищений інвестиційний клас (Standart & Poor''s).';
l_KL_K190.DT_OPEN :=to_date('01.01.2018','DD.MM.YYYY');
l_KL_K190.DT_CLOSE :=to_date('','DD.MM.YYYY HH24:MI:SS');

 p_merge( l_KL_K190);


l_KL_K190.K190 :='SB01';
l_KL_K190.RATING :='BBB+';
l_KL_K190.DESCR :='Нижчий інвестиційний клас (Standart & Poor''s).';
l_KL_K190.DT_OPEN :=to_date('01.01.2018','DD.MM.YYYY');
l_KL_K190.DT_CLOSE :=to_date('','DD.MM.YYYY HH24:MI:SS');

 p_merge( l_KL_K190);


l_KL_K190.K190 :='SB02';
l_KL_K190.RATING :='BBB';
l_KL_K190.DESCR :='Нижчий інвестиційний клас (Standart & Poor''s).';
l_KL_K190.DT_OPEN :=to_date('01.01.2018','DD.MM.YYYY');
l_KL_K190.DT_CLOSE :=to_date('','DD.MM.YYYY HH24:MI:SS');

 p_merge( l_KL_K190);


l_KL_K190.K190 :='SB03';
l_KL_K190.RATING :='BBB-';
l_KL_K190.DESCR :='Нижчий інвестиційний клас (Standart & Poor''s).';
l_KL_K190.DT_OPEN :=to_date('01.01.2018','DD.MM.YYYY');
l_KL_K190.DT_CLOSE :=to_date('','DD.MM.YYYY HH24:MI:SS');

 p_merge( l_KL_K190);


l_KL_K190.K190 :='SB04';
l_KL_K190.RATING :='BB+';
l_KL_K190.DESCR :='Не інвестиційний клас. Спекулятивний (Standart & Poor''s).';
l_KL_K190.DT_OPEN :=to_date('01.01.2018','DD.MM.YYYY');
l_KL_K190.DT_CLOSE :=to_date('','DD.MM.YYYY HH24:MI:SS');

 p_merge( l_KL_K190);


l_KL_K190.K190 :='SB05';
l_KL_K190.RATING :='BB';
l_KL_K190.DESCR :='Не інвестиційний клас. Спекулятивний (Standart & Poor''s).';
l_KL_K190.DT_OPEN :=to_date('01.01.2018','DD.MM.YYYY');
l_KL_K190.DT_CLOSE :=to_date('','DD.MM.YYYY HH24:MI:SS');

 p_merge( l_KL_K190);


l_KL_K190.K190 :='SB06';
l_KL_K190.RATING :='BB-';
l_KL_K190.DESCR :='Не інвестиційний клас. Спекулятивний (Standart & Poor''s).';
l_KL_K190.DT_OPEN :=to_date('01.01.2018','DD.MM.YYYY');
l_KL_K190.DT_CLOSE :=to_date('','DD.MM.YYYY HH24:MI:SS');

 p_merge( l_KL_K190);


l_KL_K190.K190 :='SB07';
l_KL_K190.RATING :='B+';
l_KL_K190.DESCR :='Високо спекулятивний клас (Standart & Poor''s).';
l_KL_K190.DT_OPEN :=to_date('01.01.2018','DD.MM.YYYY');
l_KL_K190.DT_CLOSE :=to_date('','DD.MM.YYYY HH24:MI:SS');

 p_merge( l_KL_K190);


l_KL_K190.K190 :='SB08';
l_KL_K190.RATING :='B';
l_KL_K190.DESCR :='Високо спекулятивний клас (Standart & Poor''s).';
l_KL_K190.DT_OPEN :=to_date('01.01.2018','DD.MM.YYYY');
l_KL_K190.DT_CLOSE :=to_date('','DD.MM.YYYY HH24:MI:SS');

 p_merge( l_KL_K190);


l_KL_K190.K190 :='SB09';
l_KL_K190.RATING :='B-';
l_KL_K190.DESCR :='Високо спекулятивний клас (Standart & Poor''s).';
l_KL_K190.DT_OPEN :=to_date('01.01.2018','DD.MM.YYYY');
l_KL_K190.DT_CLOSE :=to_date('','DD.MM.YYYY HH24:MI:SS');

 p_merge( l_KL_K190);


l_KL_K190.K190 :='SC01';
l_KL_K190.RATING :='CCC+';
l_KL_K190.DESCR :='Клас істотного ризику (Standart & Poor''s).';
l_KL_K190.DT_OPEN :=to_date('01.01.2018','DD.MM.YYYY');
l_KL_K190.DT_CLOSE :=to_date('','DD.MM.YYYY HH24:MI:SS');

 p_merge( l_KL_K190);


l_KL_K190.K190 :='SC02';
l_KL_K190.RATING :='CCC';
l_KL_K190.DESCR :='Екстремально спекулятивний клас (Standart & Poor''s).';
l_KL_K190.DT_OPEN :=to_date('01.01.2018','DD.MM.YYYY');
l_KL_K190.DT_CLOSE :=to_date('','DD.MM.YYYY HH24:MI:SS');

 p_merge( l_KL_K190);


l_KL_K190.K190 :='SC03';
l_KL_K190.RATING :='ССС-';
l_KL_K190.DESCR :='Клас дефолту з малою  вірогідністю зростання (Standart & Poor''s).';
l_KL_K190.DT_OPEN :=to_date('01.01.2018','DD.MM.YYYY');
l_KL_K190.DT_CLOSE :=to_date('','DD.MM.YYYY HH24:MI:SS');

 p_merge( l_KL_K190);


l_KL_K190.K190 :='SC04';
l_KL_K190.RATING :='СС';
l_KL_K190.DESCR :='Клас дефолту з малою  вірогідністю зростання (Standart & Poor''s).';
l_KL_K190.DT_OPEN :=to_date('01.01.2018','DD.MM.YYYY');
l_KL_K190.DT_CLOSE :=to_date('','DD.MM.YYYY HH24:MI:SS');

 p_merge( l_KL_K190);


l_KL_K190.K190 :='SC05';
l_KL_K190.RATING :='C';
l_KL_K190.DESCR :='Клас дефолту з малою  вірогідністю зростання (Standart & Poor''s).';
l_KL_K190.DT_OPEN :=to_date('01.01.2018','DD.MM.YYYY');
l_KL_K190.DT_CLOSE :=to_date('','DD.MM.YYYY HH24:MI:SS');

 p_merge( l_KL_K190);


l_KL_K190.K190 :='SD01';
l_KL_K190.RATING :='D';
l_KL_K190.DESCR :='Дефолт. Банкрутство (Standart & Poor''s).';
l_KL_K190.DT_OPEN :=to_date('01.01.2018','DD.MM.YYYY');
l_KL_K190.DT_CLOSE :=to_date('','DD.MM.YYYY HH24:MI:SS');

 p_merge( l_KL_K190);


commit;
END;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Data/patch_data_KL_K190.sql =========*** End
PROMPT ===================================================================================== 
