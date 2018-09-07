update operlist ol
   set ol.funcname = '/barsroot/cdo/corplight/accounts/index/'
 where ol.funcname = '/barsroot/corplight/accounts/index/';
 
update operlist ol
   set ol.funcname = '/barsroot/cdo/common/users/index/?clmode=base',
       ol.name     = 'Підключення до СДО'
 where ol.funcname = '/barsroot/corplight/users/index/?clmode=base';
 
update operlist ol
   set ol.funcname = '/barsroot/cdo/common/users/index/?clmode=visa',
       ol.name     = 'Підтвердження підключення до СДО'
 where ol.funcname = '/barsroot/corplight/users/index/?clmode=visa';
 
commit;
