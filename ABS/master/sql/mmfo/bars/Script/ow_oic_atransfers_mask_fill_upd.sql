BEGIN
   update ow_oic_atransfers_mask
   set nms = '�����.����.���./������.������.'
   where mask = '357055';

   update ow_oic_atransfers_mask
   set nms = '������.����.���/������.������.'
   where mask = '357056';

   commit;
END; 
/ 
