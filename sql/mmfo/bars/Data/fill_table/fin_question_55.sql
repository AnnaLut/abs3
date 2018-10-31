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

 dbms_output.put_line('PROMPT *** IDF=55 KOD>>ZD1 *** ���������� ������� �������� ������');
 add_question('���������� ������� �������� ������', 1, 'ZD1', 55, '���������� ������� �������� ������, �����
�������� ���������� 180 ����������� ���
������ �� ��� ������������� ������ ������,
����������� �� ���������� ���� ��������
������������� ����, ��������� �������� ���
�������� 365 ��� � ������������ ���������
��������� �����, ��� �������� � ���, �� ������
�� ���� ����������� �������� �� �������,
���������� � �������, �� ��������� ����� (�����, �������)', 0);
    add_question_rep('ZD1', 'ͳ', 1, 0, 55, null, '');
    add_question_rep('ZD1', '���', 2, 1, 55, null, '');

 dbms_output.put_line('PROMPT *** IDF=55 KOD>>ZD4 *** � ������� �������� ��䳿/����, �� ������ ���/���� ���� ������� ������ ��������, ������ ���������� 180 ���');
 add_question('� ������� �������� ��䳿/����, �� ������ ���/���� ���� ������� ������ ��������, ������ ���������� 180 ���', 2, 'ZD4', 55, '', 0);
    add_question_rep('ZD4', 'ͳ', 1, 0, 55, null, '');
    add_question_rep('ZD4', '���', 2, 1, 55, null, '');

 dbms_output.put_line('PROMPT *** IDF=55 KOD>>ZD2 *** ����� � ���������� ����������� �� ���� ��������� ������ ��� ���������� �������� ������� �� � ������������ ����� �� �� 30 ����������� ���');
 add_question('����� � ���������� ����������� �� ���� ��������� ������ ��� ���������� �������� ������� �� � ������������ ����� �� �� 30 ����������� ���', 3, 'ZD2', 55, '����� � ���������� ����������� �� ���� ��������� ������ ��� ���������� �������� ������� ��������/����������� �� � ������������ ����� �� �� 30 ����������� ���', 0);
    add_question_rep('ZD2', 'ͳ', 1, 0, 55, null, '');
    add_question_rep('ZD2', '���', 2, 1, 55, null, '');

 dbms_output.put_line('PROMPT *** IDF=55 KOD>>ZD3 *** ���� �� ������������� ����������� ����������� ��������, �� ����������, ����� ����� �������� ��������, ���������� ������������� ����');
 add_question('���� �� ������������� ����������� ����������� ��������, �� ����������, ����� ����� �������� ��������, ���������� ������������� ����', 4, 'ZD3', 55, '', 0);
    add_question_rep('ZD3', 'ͳ', 1, 0, 55, null, '');
    add_question_rep('ZD3', '���', 2, 1, 55, null, '');

 dbms_output.put_line('PROMPT *** IDF=55 KOD>>ZD5 *** ������ ����������� ��� �������� ������');
 add_question('������ ����������� ��� �������� ������', 5, 'ZD5', 55, '', 0);
    add_question_rep('ZD5', 'ͳ', 1, 0, 55, null, '');
    add_question_rep('ZD5', '���', 2, 1, 55, null, '');

 dbms_output.put_line('PROMPT *** IDF=55 KOD>>ZD6 *** ³������� ��������� ����������������');
 add_question('³������� ��������� ����������������', 6, 'ZD6', 55, '', 0);
    add_question_rep('ZD6', 'ͳ', 1, 0, 55, null, '');
    add_question_rep('ZD6', '���', 2, 1, 55, null, '');

 dbms_output.put_line('PROMPT *** IDF=55 KOD>>ZD7 *** ����� ������?');
 add_question('����� ������?', 7, 'ZD7', 55, '', 0);
    add_question_rep('ZD7', 'ͳ', 1, 0, 55, null, '');
    add_question_rep('ZD7', '���', 2, 1, 55, null, '');
	
dbms_output.put_line('PROMPT *** IDF=55 KOD>>ZD8 *** ������������ ��������� ��������� ����������������?');
 add_question('������������ ��������� ��������� ����������������?', 8, 'ZD8', 55, '', 0);
    add_question_rep('ZD8', '1', 1, 0, 55, null, '5');
    add_question_rep('ZD8', '2', 2, 1, 55, null, '6');
end;                                        
/                                           
                                            
commit;                                     
