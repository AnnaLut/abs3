PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Data/patch_data_OW_INST_STATUS_DICT.sql ====
PROMPT ===================================================================================== 

declare
l_OW_INST_STATUS_DICT  OW_INST_STATUS_DICT%rowtype;

procedure p_merge(p_OW_INST_STATUS_DICT OW_INST_STATUS_DICT%rowtype) 
as
Begin
   insert into OW_INST_STATUS_DICT
      values p_OW_INST_STATUS_DICT; 
 exception when dup_val_on_index then  
   update OW_INST_STATUS_DICT t
      set row = p_OW_INST_STATUS_DICT
    where t.ST_ID = p_OW_INST_STATUS_DICT.ST_ID;
End;
Begin

l_OW_INST_STATUS_DICT.ST_ID :=1;
l_OW_INST_STATUS_DICT.ST_SID :='WAITING';
l_OW_INST_STATUS_DICT.ST_NAME :='Очікує виставлення до сплати';

 p_merge( l_OW_INST_STATUS_DICT);


l_OW_INST_STATUS_DICT.ST_ID :=2;
l_OW_INST_STATUS_DICT.ST_SID :='OPEN';
l_OW_INST_STATUS_DICT.ST_NAME :='Виставлено до оплати';

 p_merge( l_OW_INST_STATUS_DICT);


l_OW_INST_STATUS_DICT.ST_ID :=3;
l_OW_INST_STATUS_DICT.ST_SID :='PAID';
l_OW_INST_STATUS_DICT.ST_NAME :='Сплачено';

 p_merge( l_OW_INST_STATUS_DICT);


l_OW_INST_STATUS_DICT.ST_ID :=4;
l_OW_INST_STATUS_DICT.ST_SID :='PAIDPART';
l_OW_INST_STATUS_DICT.ST_NAME :='Сплачено частково';

 p_merge( l_OW_INST_STATUS_DICT);


l_OW_INST_STATUS_DICT.ST_ID :=5;
l_OW_INST_STATUS_DICT.ST_SID :='OVD';
l_OW_INST_STATUS_DICT.ST_NAME :='Прострочено';

 p_merge( l_OW_INST_STATUS_DICT);


l_OW_INST_STATUS_DICT.ST_ID :=6;
l_OW_INST_STATUS_DICT.ST_SID :='CLOSED';
l_OW_INST_STATUS_DICT.ST_NAME :='Відмінено';

 p_merge( l_OW_INST_STATUS_DICT);


l_OW_INST_STATUS_DICT.ST_ID :=7;
l_OW_INST_STATUS_DICT.ST_SID :='REVISED';
l_OW_INST_STATUS_DICT.ST_NAME :='Реструктуризовано';

 p_merge( l_OW_INST_STATUS_DICT);


commit;
END;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Data/patch_data_OW_INST_STATUS_DICT.sql ====
PROMPT ===================================================================================== 