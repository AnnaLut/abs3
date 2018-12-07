update OW_TRANSNLSMASK t
   set TAB_NAME = 'W4_ACC',
       MASK = replace(MASK, '%', '')
 where TAB_NAME is null or TAB_NAME = 'W4_ACC';

commit;
/