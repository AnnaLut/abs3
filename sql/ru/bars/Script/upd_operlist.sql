update operlist ol
   set ol.funcname = '/barsroot/cdo/corplight/accounts/index/'
 where ol.funcname = '/barsroot/corplight/accounts/index/';
 
update operlist ol
   set ol.funcname = '/barsroot/cdo/common/users/index/?clmode=base',
       ol.name     = 'ϳ��������� �� ���'
 where ol.funcname = '/barsroot/corplight/users/index/?clmode=base';
 
update operlist ol
   set ol.funcname = '/barsroot/cdo/common/users/index/?clmode=visa',
       ol.name     = 'ϳ����������� ���������� �� ���'
 where ol.funcname = '/barsroot/corplight/users/index/?clmode=visa';
 
commit;
