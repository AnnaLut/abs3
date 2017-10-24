

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/MODIFY_FIO.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure MODIFY_FIO ***

  CREATE OR REPLACE PROCEDURE BARS.MODIFY_FIO (p_str in varchar2, p_str_out out varchar2, cust number default 0 )
/*
17.02.2017 ������ ����� ` �� ', �������� ������ ` ��� ���������
09.02.2017 ������ �������� cust  - 0 - ���������� �1, 1 - �� ���������� �1
09,02,2017 ������ ���� �������� ��� ������ [1,!,?]  
08.02.2017 ������ "����" ��������� ������� ϲ�
           ������ ����� ���. �������� ����� �� chr(39)
           �������� ����� ��� ������� �109-�������� ������ �����Ͳ��� (���� ����� ��� � ����� ������� �� �����)
           ������ ��������  �� � � ������ ������ � (��� ������) � ����� ���� �� ���� �����
02,02,2017 ��������� ����������� ����� ϲ� ����� ������ � COBUSUPABS-5248 (http://jira.unity-bars.com.ua:11000/browse/COBUSUPABS-5248)         

*/
is
l_nmk varchar2(70);
begin

l_nmk:=p_str;

l_nmk:=REGEXP_REPLACE(l_nmk, '( ){2,}', ' '); --�������� ������� ������
l_nmk:=trim(l_nmk); ---������� ������ � ���� �����

--insert into TMP_CUST_UPD (rnk,nmk,nmk_new) values (k.rnk,l_nmk,null); --�������� ���������� �� ���
--commit;

--1----------------
case when cust=0 then 
                    begin
                        if REGEXP_LIKE(l_nmk,'^[[:alpha:]]{1}[^[:alpha:]]{2,}') --�������� �� ������ �109-�������� ������ �����Ͳ���, ��� ���� 
                                                                    --�� ���� ����� ��� �� ���� �����
                            then
                        --     DBMS_OUTPUT.PUT_LINE('������ ����� �������� ����: '||l_nmk);
                             l_nmk:= regexp_replace(l_nmk, '^[[:alpha:]]{1}[^[:alpha:]]{2,}', '', 1, 1, 'i');
                        --     DBMS_OUTPUT.PUT_LINE('������ ����� �������� �����: '||l_nmk);
                        end if;
                   end;
     else null;
end case;               
--2-------------------
if REGEXP_LIKE(l_nmk,'\.+') --�������� �� � l_nmk � ������
    then
--    DBMS_OUTPUT.PUT_LINE('������ ����� �������� ����: '||l_nmk);
    l_nmk:= translate(l_nmk,'.',' '); --������� . �� '�����'  
--    DBMS_OUTPUT.PUT_LINE('������ ����� �������� �����: '||l_nmk);  
end if;
------ ��������� ��� 08,02,2017 ����
----select dump ('�') from dual ---Typ=96 Len=1: 133 
if REGEXP_LIKE(l_nmk,'[�]') --�������� �� � � ������ ������ � (��� ������)
 then
-- DBMS_OUTPUT.PUT_LINE('������� " ����: '||l_nmk);
 l_nmk:= translate(l_nmk,'�',' '); --������� �� ���� �����
-- DBMS_OUTPUT.PUT_LINE('������� " �����: '||l_nmk);
 end if ;
----------------------------------------
--5-----------------------------------
case when cust=1 then 
                  begin
                       if REGEXP_LIKE(l_nmk,'[^[:alpha:]]{3,}$') then null; --���� ���������� �������� � ���� �� SN_LN, �-� SN_MN ���������� �� ���� �� ���� ������1��� :23012003, ���� LIKE - ������ �� ������ �� ����� �������
                          else                                             -- ������������ �� � ���� ��� (�� ���� ���� ����� 0. �������� �� 0+�����) � ����� ������� �� �����, ��� �� �������� ���� ���� �. (� � ������)
                            if REGEXP_LIKE(l_nmk,'0+') --�������� �� � � ������ ������ 0
                                    then
                            --        DBMS_OUTPUT.PUT_LINE('������� 0 �� O ����: '||l_nmk);
                                    l_nmk:= translate(l_nmk,'0','�'); --������� 0 �� O (������ �� ��� �� ����� �������� "�")
                            --        DBMS_OUTPUT.PUT_LINE('������� 0 �� O �����: '||l_nmk);
                            end if;
                        end if;
                  end;
     else null;
end case;                    
--------------------------------------
--3----------------------------------
if REGEXP_LIKE(l_nmk,'[^[:alpha:]]+$') ---�������� �� � ���� ������ �� �����
        then
--        DBMS_OUTPUT.PUT_LINE('��������� ��� �� ���� � ���� �� ����� ����� ����: '||l_nmk);
        l_nmk:= REGEXP_REPLACE(l_nmk, '[^[:alpha:]]+$', '', 1, 1, 'i'); -- ��������� ��� �� ���� � ����
--        DBMS_OUTPUT.PUT_LINE('��������� ��� �� ���� � ���� �� ����� ����� �����: '||l_nmk);  
end if;

------5 --------------------------
if REGEXP_LIKE(l_nmk,'0+') --�������� �� � � ������ ������ 0
    then
--DBMS_OUTPUT.PUT_LINE('������� 0 �� O ����: '||l_nmk);
l_nmk:= translate(l_nmk,'0','�'); --������� 0 �� O (������ �� ��� �� ����� �������� "�")
--DBMS_OUTPUT.PUT_LINE('������� 0 �� O �����: '||l_nmk);
end if;
--6----------------------------------
--6)    ������� �*� ��� �/� ��� � ��, �� ������������ � �������� �����, �� ��������;
if REGEXP_LIKE(l_nmk,'[*]+')   --�������� �� � � ������ ������ *
 then
-- DBMS_OUTPUT.PUT_LINE('������� * ����: '||l_nmk);
 l_nmk:= translate(l_nmk,'*',chr(39));
-- DBMS_OUTPUT.PUT_LINE('������� * �����: '||l_nmk);
 end if ;
if REGEXP_LIKE(l_nmk,'[/]+')  --�������� �� � � ������ ������ /
 then
-- DBMS_OUTPUT.PUT_LINE('������� / ����: '||l_nmk);
 l_nmk:= translate(l_nmk,'/',chr(39));
-- DBMS_OUTPUT.PUT_LINE('������� / �����: '||l_nmk);
 end if ;
 --select dump ('�') from dual --Typ=96 Len=1: 148 ���. ������� �������
if REGEXP_LIKE(l_nmk,'[�]+') --�������� �� � � ������ ������ "
 then
-- DBMS_OUTPUT.PUT_LINE('������� " ����: '||l_nmk);
 l_nmk:= translate(l_nmk,'�',chr(39));
-- DBMS_OUTPUT.PUT_LINE('������� " �����: '||l_nmk);
 end if ;
-- select dump ('"') from dual --Typ=96 Len=1: 34 ���. ������� �������
if REGEXP_LIKE(l_nmk,'["]+') --�������� �� � � ������ ������ "
 then
-- DBMS_OUTPUT.PUT_LINE('������� " ����: '||l_nmk);
 l_nmk:= translate(l_nmk,'"',chr(39));
-- DBMS_OUTPUT.PUT_LINE('������� " �����: '||l_nmk);
 end if ;
 
if REGEXP_LIKE(l_nmk,'[`]+') --�������� �� � � ������ ������ `
 then
-- DBMS_OUTPUT.PUT_LINE('������� " ����: '||l_nmk);
 l_nmk:= translate(l_nmk,'`',chr(39));
-- DBMS_OUTPUT.PUT_LINE('������� " �����: '||l_nmk);
 end if ;
--------------------------------------
--7-----------------------------------
--7)    ������ ������� ����� ����������� ������� �� ����� ����������� �������:
if REGEXP_LIKE(l_nmk,'[IETOPAHKXCBM]+') --- ��� UPPER
then
  l_nmk:= translate(l_nmk,'IETOPAHKXCBM','������������');
--  DBMS_OUTPUT.PUT_LINE('IETOPAHKXCBM: '||l_nmk);
end if;
--��������� 01,02,2017 ���� �� ������������ Ĳ� 
--if REGEXP_LIKE(l_nmk,'[ietopahkxcbm]+') --- ��� LOWER ���� ����� ����� ��������
--then
--  l_nmk:= translate(l_nmk,'ietopahkxcbm','������������');
--  DBMS_OUTPUT.PUT_LINE('ietopahkxcbm: '||l_nmk);
--end if;
/*****************�.4 ******************************************************
4)    ������ �� ��������: 1 ��� "!" ��� "?" ��:
-    ����� �������� "�", ���� ���� ������ ���� ���������� �����, ��� �� ������� �����;
-    ����� �������� "�", ���� ���� ������ ���� ������� �����
*/
if  regexp_LIKE(l_nmk, '[1!?]+') then
 begin
  --for i in 1..regexp_count(l_nmk,'[1,!,?]+') --�-�� �������� ������� --��������� l_nmk
  while regexp_LIKE(l_nmk, '[1!?]+') --���� ����� ������ 1,!,?
    loop
--      dbms_output.put_line('�.4 ����� ��� ��������� 1,!,? ������ ϲ�: '||l_nmk);
      ---------------------��� 1---------------
      if regexp_instr(l_nmk,'1') <>0 -- � ����-��� ��������� 1(�������) � ������
         then
           if regexp_instr(l_nmk,'1') =1  --���� �� ��������� ����� (�� ������ �������. ������ ���������� � �������)
              then 
                l_nmk:=regexp_replace(l_nmk, '^.{1}', '�'); --������� ����-���� ������, ���� ����� ������ �� � 
             else
            --���� ��������� �� �����
            --'�','�','�','�','�','�','�','�','�','�'
               if substr(l_nmk,regexp_instr(l_nmk,'1')-1,1) in ('�','�','�','�','�','�','�','�','�','�','�','�','�','�','�','�','�','�','�','�') --���� ��������� �������
                 then 
                   begin
                      --���� ��������� �������, ���������� �� �SCII ���. ���� ����� ������ ������ �� ������, ���� ��, �� �� ��������
                     case 
                         when ASCII(substr(l_nmk,regexp_instr(l_nmk,'1')-1,1)) in (192,197,170,200,178,175,206,211,222,223) 
                           then l_nmk:=regexp_replace(l_nmk,'[1]', '�', 1, 1, 'i');
                                else l_nmk:=regexp_replace(l_nmk,'[1]', '�', 1, 1, 'i'); --������ ����� ��������� "1" �� � ��������
                     end case;
                     end;
                 else 
                   begin
                   case
                      --���� ��������� ����� ������ ��� ����� (' ') ������ ����� ��������� �� ������ �
                      when ASCII(substr(l_nmk,regexp_instr(l_nmk,'1')-1,1)) in (193,194,195,165,196,198,51,201,202,203,204,205,207,208,209,210,212,88,214,215,216,217,32)
                         then l_nmk:=regexp_replace(l_nmk,'[1]', '�', 1, 1, 'i');
                           else l_nmk:=regexp_replace(l_nmk,'[1]', '�', 1, 1, 'i'); --������ ����� ��������� "1" �� �  (��������) --replace('���1��1','.{||regexp_instr('1���1��1','1')||}','�' )   --- ���� ���������� ������ ���������� - �������� �� "�"
                    end case; 
                   end;
               end if;
             end if;
      end if;
      -----------------------��� ! ---
  if regexp_instr(l_nmk,'!') <>0 -- � ����-��� ��������� !(����� ������) � ������
         then 
           if regexp_instr(l_nmk,'!') =1  --���� �� ��������� ����� (�� ������ �������. ������ ���������� � �������)
              then 
                l_nmk:=regexp_replace(l_nmk, '^.{1}', '�'); --������� ����-���� ������, ���� ����� ������ �� � 
             else
            --���� ��������� �� �����
            --'�','�','�','�','�','�','�','�','�','�'
               if substr(l_nmk,regexp_instr(l_nmk,'!')-1,1) in ('�','�','�','�','�','�','�','�','�','�','�','�','�','�','�','�','�','�','�','�') --���� ��������� �������
                 then 
                   begin
                      --���� ��������� �������, ���������� �� �SCII ���. ���� ����� ������ ������ �� ������, ���� ��, �� �� ��������
                     case 
                         when ASCII(substr(l_nmk,regexp_instr(l_nmk,'!')-1,1)) in (192,197,170,200,178,175,206,211,222,223) 
                           then l_nmk:=regexp_replace(l_nmk,'[!]', '�', 1, 1, 'i');
                                else l_nmk:=regexp_replace(l_nmk,'[!]', '�', 1, 1, 'i'); --������ ����� ��������� "!" �� � ��������
                     end case;
                     end;
                 else 
                   begin
                   case
                      --���� ��������� ����� ������ ��� ����� (' ')
                      when ASCII(substr(l_nmk,regexp_instr(l_nmk,'!')-1,1)) in (193,194,195,165,196,198,51,201,202,203,204,205,207,208,209,210,212,88,214,215,216,217,32)
                         then l_nmk:=regexp_replace(l_nmk,'[!]', '�', 1, 1, 'i');
                           else l_nmk:=regexp_replace(l_nmk,'[!]', '�', 1, 1, 'i');
                    end case; --������ ����� ��������� "!" �� �  (��������) --replace('���1��1','.{||regexp_instr('1���1��1','1')||}','�' )   --- ���� ���������� ������ ���������� - �������� �� "�"
                   end;
               end if;
             end if;
      end if;

      ---------------------------��� ?--------
   if regexp_instr(l_nmk,'\?') <>0 -- � ����-��� ��������� ? � ������
         then 
           if regexp_instr(l_nmk,'\?') =1  --���� �� ��������� ����� (�� ������ �������. ������ ���������� � �������)
              then 
                l_nmk:=regexp_replace(l_nmk, '^.{1}', '�'); --������� ����-���� ������, ���� ����� ������ �� � 
             else
            --���� ��������� �� �����
            --'�','�','�','�','�','�','�','�','�','�'
               if substr(l_nmk,regexp_instr(l_nmk,'\?')-1,1) in ('�','�','�','�','�','�','�','�','�','�','�','�','�','�','�','�','�','�','�','�') --���� ��������� �������
                 then 
                   begin
                      --���� ��������� �������, ���������� �� �SCII ���. ���� ����� ������ ������ �� ������, ���� ��, �� �� ��������
                     case 
                         when ASCII(substr(l_nmk,regexp_instr(l_nmk,'\?')-1,1)) in (192,197,170,200,178,175,206,211,222,223) 
                           then l_nmk:=regexp_replace(l_nmk,'[?]', '�', 1, 1, 'i');
                                else l_nmk:=regexp_replace(l_nmk,'[?]', '�', 1, 1, 'i'); --������ ����� ��������� "?" �� � ��������
                     end case;
                     end;
                 else 
                   begin
                   case
                      --���� ��������� ����� ������ ��� ����� (' ')
                      when ASCII(substr(l_nmk,regexp_instr(l_nmk,'\?')-1,1)) in (193,194,195,165,196,198,51,201,202,203,204,205,207,208,209,210,212,88,214,215,216,217,32)
                         then l_nmk:=regexp_replace(l_nmk,'[?]', '�', 1, 1, 'i');
                           else l_nmk:=regexp_replace(l_nmk,'[?]', '�', 1, 1, 'i');
                    end case; --������ ����� ��������� "?" �� �  (��������) --replace('���1��1','.{||regexp_instr('1���1��1','1')||}','�' )   --- ���� ���������� ������ ���������� - �������� �� "�"
                   end;
               end if;
             end if;
      end if;
--------------------------------
    end loop;
 end;
end if;
-- dbms_output.put_line('�.4 ����� ��� ��������� 1,!,? ������� ϲ�: '||l_nmk);
/***********************************************************************/
---------------------------------------------------------
if REGEXP_LIKE(l_nmk,'[0-9]+') --- �������� �� ������� ������ �����
then
--  DBMS_OUTPUT.PUT_LINE('����� ��� ����, �� �������� �� "_" ����: '||l_nmk);
  l_nmk:= REGEXP_REPLACE(l_nmk, '[0-9]+', '_'); -- ����� ��� ����, �� �������� �� "_" (�����������)
--  DBMS_OUTPUT.PUT_LINE('����� ��� ����, �� �������� �� "_" �����: '||l_nmk);
end if;
--DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------');

/**************************************��������� Ĳ� 01,02,2017****************************************************************/
--�������� ��� ������� ϲ� ������ ������ ������, �� ����� ��������� � ������ �����������, �-�: ���� ������� ..(�� ������) �� ������.
l_nmk:=REGEXP_REPLACE(l_nmk, '( ){2,}', ' '); --�������� ������� ������
l_nmk:=trim(l_nmk); ---������� ������ � ���� �����


--� �������� ������ ������� �� �� ����� � ϲ�, ������ ����� '(��������)(����� �� ����� ����) �� "_" (����� �����������), �� ������� � �������� "����� ��� ����, �� �������� �� --"_"
--��������:
--select REGEXP_REPLACE('"!,#,$,%,&,(,),*,wqe+,,,-,.,/,:,;,<,=,>,?,@,[,\,],^,`,{,|,},~asd\!,#$\!,#$%&()/*+.-[-\!,$%&()/*+.:;=<>@?\[{}#~\^\|`', '[-\!,$%&()/*+.:;=<>@?\[{}#~\^\|`"]+', '') from dual;
--select REGEXP_REPLACE('wqe]a]]]]s]d', ']', '') from dual; 
 
-- ������ � ������ �� ������� �� ����� (������ ��������� �� ��������), �� ���� �������� ���� ���� ������� ����<�������� �������� ������������ � �� ������
--������� - (����) (08.02.2017)
if REGEXP_LIKE(l_nmk, '[\�!,$%&()/*+.:;=<>@?\[{}#~\^\|"]+') or REGEXP_LIKE(l_nmk, ']')
then  
    l_nmk:=REGEXP_REPLACE(l_nmk, '[\�!,$%&()/*+.:;=<>@?\[{}#~\^\|"]+', ' ');
    l_nmk:=REGEXP_REPLACE(l_nmk, ']', ' '); --���������� ] �� ����� ������� ��������� ] ������� � ������� ������ (��� ��������� ������ ������)
end if;

----------------------------------------
--�������� ��� ������� ϲ� ������ ������ ������, �� ����� ��������� � ������ �����������, �-�: ���� ������� �� �� ������.
l_nmk:=REGEXP_REPLACE(l_nmk, '( ){2,}', ' '); --�������� ������� ������
l_nmk:=trim(l_nmk); ---������� ������ � ���� �����
/*---------------------------------------------------------------------------*/
p_str_out:=l_nmk;

end;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/MODIFY_FIO.sql =========*** End **
PROMPT ===================================================================================== 
