PROMPT =====================================================================================                     
PROMPT *** Run *** ========== Scripts /Sql/bars/data/fin_question_55.sql =========*** Run **            
PROMPT =====================================================================================                     
                                                                                                                 
declare                                                                                                          

    procedure add_question ( p_name       fin_question.name%type,                            
                             p_ord        fin_question.ord%type,                             
                             p_kod        fin_question.kod%type,                             
                             p_idf        fin_question.idf%type,                             
                             p_descript   fin_question.descript%type default null,           
                             p_pob        fin_question.pob%type default 0                    
                                                                                             
                        )                                                                    
    as                                                                                       
    l_ques  fin_question%rowtype;                                                            
    begin                                                                                    
                                                                                          
       l_ques.name       :=   p_name     ;                                                   
       l_ques.ord        :=   p_ord      ;                                                   
       l_ques.kod        :=   p_kod      ;                                                   
       l_ques.idf        :=   p_idf      ;                                                   
       l_ques.pob        :=   p_pob      ;                                                   
       l_ques.descript   :=   p_descript ;                                                   

     insert into fin_question                            
          values l_ques;                                 
    exception when dup_val_on_index then                 
      update fin_question                                
        set  row  = l_ques                               
      where  kod  = l_ques.kod and                       
             idf  = l_ques.idf ;                         
end;                                                 

    procedure add_question_rep ( p_kod        fin_question_reply.kod%type,          
                                 p_name       fin_question_reply.name%type,         
                                 p_ord        fin_question_reply.ord%type,          
                                 p_val        fin_question_reply.val%type,          
                                 p_idf        fin_question_reply.idf%type,          
                                 p_repl_s     fin_question_reply.repl_s%type,       
                                 p_namep      fin_question_reply.namep%type         
                        )                                                           
    as                                                                              
    l_ques  fin_question_reply%rowtype;                                             
    begin                                                                           

      l_ques.name       :=   p_name     ;                       
      l_ques.ord        :=   p_ord      ;                       
      l_ques.kod        :=   p_kod      ;                       
      l_ques.idf        :=   p_idf      ;                       
      l_ques.val        :=   p_val      ;                       
      l_ques.repl_s     :=   p_repl_s   ;                       
      l_ques.namep      :=   p_namep    ;                       

      insert into fin_question_reply                         
           values l_ques;                                    
     exception when dup_val_on_index then                    
       update fin_question_reply                             
         set  row  = l_ques                                  
       where  kod  = l_ques.kod and                          
              ord  = l_ques.ord and                          
              idf  = l_ques.idf ;                            
end;                                                        
                                                             
                                                             
Begin                                                        

 dbms_output.put_line('PROMPT *** IDF=55 KOD>>ZD1 *** Контрагент поновив регулярні платежі');
 add_question('Контрагент поновив регулярні платежі', 1, 'ZD1', 55, 'Контрагент поновив регулярні платежі, тобто
впродовж щонайменше 180 календарних днів
поспіль від дня запровадження банком заходів,
спрямованих на відновлення його здатності
обслуговувати борг, забезпечує щомісячне або
впродовж 365 днів – щоквартальне погашення
основного боргу, або процентів у сумі, не меншій
ніж сума нарахованих процентів за ставкою,
визначеною в договорі, за відповідний період (місяць, квартал)', 0);
    add_question_rep('ZD1', 'Ні', 1, 0, 55, null, '');
    add_question_rep('ZD1', 'Так', 2, 1, 55, null, '');

 dbms_output.put_line('PROMPT *** IDF=55 KOD>>ZD4 *** З моменту усунення події/подій, на підставі якої/яких було визнано дефолт боржника, минуло щонайменше 180 днів');
 add_question('З моменту усунення події/подій, на підставі якої/яких було визнано дефолт боржника, минуло щонайменше 180 днів', 2, 'ZD4', 55, '', 0);
    add_question_rep('ZD4', 'Ні', 1, 0, 55, null, '');
    add_question_rep('ZD4', 'Так', 2, 1, 55, null, '');

 dbms_output.put_line('PROMPT *** IDF=55 KOD>>ZD2 *** Жодне з зобов’язань Контрагента на дату ухвалення рішення про припинення визнання дефолту не є простроченим більше ніж на 30 календарних днів');
 add_question('Жодне з зобов’язань Контрагента на дату ухвалення рішення про припинення визнання дефолту не є простроченим більше ніж на 30 календарних днів', 3, 'ZD2', 55, 'Жодне з зобов’язань Контрагента на дату ухвалення рішення про припинення визнання дефолту боржника/контрагента не є простроченим більше ніж на 30 календарних днів', 0);
    add_question_rep('ZD2', 'Ні', 1, 0, 55, null, '');
    add_question_rep('ZD2', 'Так', 2, 1, 55, null, '');

 dbms_output.put_line('PROMPT *** IDF=55 KOD>>ZD3 *** Банк має документально підтверджене обґрунтоване судження, що Контрагент, попри наявні фінансові труднощі, спроможний обслуговувати борг');
 add_question('Банк має документально підтверджене обґрунтоване судження, що Контрагент, попри наявні фінансові труднощі, спроможний обслуговувати борг', 4, 'ZD3', 55, '', 0);
    add_question_rep('ZD3', 'Ні', 1, 0, 55, null, '');
    add_question_rep('ZD3', 'Так', 2, 1, 55, null, '');

 dbms_output.put_line('PROMPT *** IDF=55 KOD>>ZD5 *** Ознаки подійдефолту або визнання дефолу');
 add_question('Ознаки подійдефолту або визнання дефолу', 5, 'ZD5', 55, '', 0);
    add_question_rep('ZD5', 'Ні', 1, 0, 55, null, '');
    add_question_rep('ZD5', 'Так', 2, 1, 55, null, '');

 dbms_output.put_line('PROMPT *** IDF=55 KOD>>ZD6 *** Відбулась фінансова реструктуризація');
 add_question('Відбулась фінансова реструктуризація', 6, 'ZD6', 55, '', 0);
    add_question_rep('ZD6', 'Ні', 1, 0, 55, null, '');
    add_question_rep('ZD6', 'Так', 2, 1, 55, null, '');

 dbms_output.put_line('PROMPT *** IDF=55 KOD>>ZD7 *** Зняти дефолт?');
 add_question('Зняти дефолт?', 7, 'ZD7', 55, '', 0);
    add_question_rep('ZD7', 'Ні', 1, 0, 55, null, '');
    add_question_rep('ZD7', 'Так', 2, 1, 55, null, '');
	
dbms_output.put_line('PROMPT *** IDF=55 KOD>>ZD8 *** Запроваджено процедуру фінансової реструктуризації?');
 add_question('Запроваджено процедуру фінансової реструктуризації?', 8, 'ZD8', 55, '', 0);
    add_question_rep('ZD8', '1', 1, 0, 55, null, '5');
    add_question_rep('ZD8', '2', 2, 1, 55, null, '6');
end;                                        
/                                           
                                            
commit;                                     
