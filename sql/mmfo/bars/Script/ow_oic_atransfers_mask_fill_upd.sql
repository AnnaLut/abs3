BEGIN
   update ow_oic_atransfers_mask
   set nms = 'Нарах.фікс.ком./еквайр.обслуг.'
   where mask = '357055';

   update ow_oic_atransfers_mask
   set nms = 'Простр.фікс.ком/еквайр.обслуг.'
   where mask = '357056';

   commit;
END; 
/ 
