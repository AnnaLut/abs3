PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/bars/script/update_ins_types.sql =========*** Run 
PROMPT ===================================================================================== 

PROMPT *** set object_type = 'GRT' ***

update ins_types set object_type = 'GRT' where id in (0,22);
commit;

PROMPT *** set object_type = 'ANY' ***

update ins_types set object_type = 'ANY' where id in (1,2,3,6,7,8,9,10,14,15,16,17,23);
commit;

PROMPT *** set object_type = 'RNK' ***

update ins_types set object_type = 'RNK' where id in (12,18,19,20,21,24,26);
commit;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/bars/script/update_ins_types.sql =========*** End 
PROMPT ===================================================================================== 
