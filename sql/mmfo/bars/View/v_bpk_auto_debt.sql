create or replace force view v_bpk_auto_debt as
select o.ref, o.tt, pdat,  nextvisagrp, sos, if.fn, if.dat
  from xml_impfiles if, xml_impdocs ic, oper o 
 where  
       config = 'imp_7_0'                         -- ��������� ������ - �������� �������� 
   and imptype = 'cw'                             -- ��� ������� XLS
   and if.dat > gl.bd - 1                         -- ������� ������ ����������� ���������
   and o.tt in ('2PD','RKP','G4W','F4W','3PD')    -- ������ �������� �� ����������� �������� 
   and o.nextvisagrp <> '1E'                      -- �� ����� ��������� �� �� ������ 30� ���� ��. ��� ��� ���� ����� ��������� ��� ���������� �� ��
   and ic.ref = o.ref                             
   and o.sos <> 5                                 -- �������� ��� �� �������
   and if.fn = ic.fn
   and if.dat = ic.dat
   and if.kf = ic.kf
   and ic.ref is not null
   order by ref desc;



comment on table v_bpk_auto_debt is '��������� ��� ���������� ��������� ��� ���������� �� ����������� �������� ���';
