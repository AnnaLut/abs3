
-----     ������ COBUSUPABS-7172

set lines 1000
set trimspool on
set serveroutput on size 1000000


prompt ���������� �������� PR1
-------------------------------
----   PR1:   9714 �� ��, 9910 �� ��

update TTS set NLSA=null, NLSB=null where TT='PR1';

begin
  insert into ps_tts(nbs, tt, dk)
  values ('9714', 'PR1', 0 );
exception when others then 
  null;
end;
/
begin
  insert into ps_tts(nbs, tt, dk)
  values ('9910', 'PR1', 1 );
exception when others then 
  null;
end;
/

prompt ���������� �������� PR3
-------------------------------
----   PR3:   9711 �� ��

update TTS set  NLSB=null where TT='PR3';

begin
  insert into ps_tts(nbs, tt, dk )
  values ('9711', 'PR3', 1 );
exception when others then 
  null;
end;
/


prompt ���������� �������� 053
-------------------------------

UPDATE tts SET NAME='������ ������ �� ������ ��.(�����.����.� ������� ��� �������.���,���)',
               NAZN='������ ������ �� ������ �볺��� (�������� �������� � ������� ��� ������������� ���, ���)'
   where TT='053';

----   ��������� 2924/33 �� ��
begin
  insert into ps_tts(nbs, tt, dk, ob22)
  values ('2924', '053', 0, '33');
exception when others then 
  null;
end;
/


commit;
