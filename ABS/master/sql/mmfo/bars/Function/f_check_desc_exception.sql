
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_check_desc_exception.sql ========
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_CHECK_DESC_EXCEPTION ( p_ref   oper.ref%type,
                                                        p_kv    oper.kv%type,
                                                        p_nlsa  oper.nlsa%type   default null,
                                                        p_nlsb  oper.nlsb%type   default null
                                                        )
RETURN NUMBER is
   l_tt             oper.tt%type;
   l_okpo_a         varchar (14);
   l_okpo_b         varchar (14);
   l_chk_res        NUMBER (1);
   l_doca           varchar(15);
   l_docb           varchar(15);
   l_exception_flag operw.value%type;
   l_exception_desc operw.value%type;
   l_res_nlsa       NUMBER;
   l_res_nlsb       NUMBER;
-------------------------------------------------------------------------------
/*
LitvinSO 13/10/2015
COBUSUPABS-3825
    � ��������� � ������� �������:
-    PKD �� 2625 �� 2630,2635
-    DPI �� 2620 �� 2630,2635
���������� �������� �� ��� ��� �������� ������� �� ������ � ��� �������� ������� �� �������. ���� � ������ �볺��� ��� ������� (��� 000000000), ���������� �������� �� ��������� ��������� �������� �������.
            �� ������������ ��������:
-    ���� ��������� �� ��������� ����� � ���� � ��� � ������ (��� ��� �������� ��������� ���������), �������� ����������.
-    ���� ��������� �� ��������� ����� - ��� ����� (��� ��� �������� ��������� �� ���������), � ������� ������� ������� �� ��������:
                     - �0� - �������� �� ����������, �������� �����������: ����������
                         ��������� �������� ������� ������� � ����� �������;
                     - �1�, � ������� ����� ������� (�������) �� ��������� -
                               �������� �� ���������� �������� �����������: ����������
                         ��������� �������� ������� ������� � ����� �������;
                     - �1� �� ������� ����� ������� ��������� ������ �������� ���
                       ������ ���������: ���������� �������� �� ��������� ����������
                       ������ ������������� � ��������� ������� ���� �λ -
                               �������� ����������.

LitvinSO Create27/08/2015
������:COBUSUPABS-3735
��� ������� �������� � ��������� ����� ����������� ������� � �� �� ������ �� �������:
-    PKD �� 2625 �� 2620 2630 2635
-    PKR �� 2620 2630 2635 2638 �� 2625
-    PK! �� 2625 �� 2620
-    W43 �� 2630 2638 �� 2625
-    DPI �� 2620 2630 2635 2638 �� 2620 2630 2635
-    DPL �� 2638 �� 2620 2630 2635
����������� �������� �� ��� ��� �������� ������� �� ������ � ��� �������� ������� �� �������. ���� � ������ �볺��� ��� ������� (��� 000000000), ���������� �������� �� ��������� ��������� �������� �������.
        �� ������������ ��������:
-    ���� ��������� �� ��������� ����� � ���� � ��� � ������ (��� ��� �������� ��������� ���������), �������� ����������.
-    ���� ��������� �� ��������� ����� - ��� ����� (��� ��� �������� ��������� �� ���������), � ������� ������� ������� �� ��������:
                     - �0� - �������� �� ����������, �������� �����������: ��������� ��
                       ������� ������� ������� �������������, ��������� ��� � 365
                       �� 16.09.2013�;
                     - �1�, � ������� ����� ������� (�������) �� ��������� -
                               �������� �� ����������;
                     - �1� �� ������� ����� ������� ��������� � �������� �
                               �������� ����������.
*/
function Check_NLS(p_kv    oper.kv%type,
                   p_nlsa  oper.nlsa%type   default null,
                   p_nlsb  oper.nlsb%type   default null)
RETURN NUMBER IS
    begin
        begin
            select c.okpo into l_okpo_a from accounts a, customer c where a.nls = p_nlsa and a.kv = p_kv and a.rnk = c.rnk;
            exception
                        when no_data_found then
                    begin
                        select upper(p.ser)||upper(p.numdoc) into l_doca from accounts a, person p where a.nls = p_nlsa and a.kv = p_kv and a.rnk = p.rnk;
                        exception
                            when no_data_found then
                            bars_error.raise_error('DOC',47,'�� �������� ������ �볺��� �� ������� �');
                    end;
        end;

        if l_okpo_a like '000000000%'  then
                        begin
                            select upper(p.ser)||upper(p.numdoc) into l_doca from accounts a, person p where a.nls = p_nlsa and a.kv = p_kv and a.rnk = p.rnk;
                        exception
                            when no_data_found then
                            bars_error.raise_error('DOC',47,'�� �������� ������ �볺��� �� ������� �');
                        end;
        end if;

        begin
                select c.okpo into l_okpo_b from accounts a, customer c where a.nls = p_nlsb and a.kv = p_kv and a.rnk = c.rnk;
                  exception
                        when no_data_found then
                    begin
                        select upper(p.ser)||upper(p.numdoc) into l_docb from accounts a, person p where a.nls = p_nlsb and a.kv = p_kv and a.rnk = p.rnk;
                    exception
                            when no_data_found then
                            bars_error.raise_error('DOC',47,'�� �������� ������ �볺��� �� ������� �');
                    end;
        end;

        if l_okpo_b like '000000000%' or l_okpo_b is null then
                    begin
                        select upper(p.ser)||upper(p.numdoc) into l_docb from accounts a, person p where a.nls = p_nlsb and a.kv = p_kv and a.rnk = p.rnk;
                    exception
                        when no_data_found then
                        bars_error.raise_error('DOC',47,'�� �������� ������ �볺��� �� ������� �');
                        end;
        end if;

        if (l_okpo_a not like '000000000%') and  (l_okpo_b not like '000000000%') and (l_okpo_a = l_okpo_b)  then

                return 0;
        elsif (l_okpo_a like '000000000%') and  (l_okpo_b like '000000000%') and (l_doca = l_docb) then
                return 0;
        else
                return 1;
        end if;

      end;
function Check_REKV(p_ida    oper.id_a%type,
                    p_idb  oper.id_b%type)
RETURN NUMBER IS
l_ida oper.id_a%type;
l_idb oper.id_b%type;
begin

        if p_ida like '000000000%' or p_idb like '000000000%' then
           return 0;
        end if;

        if p_ida = p_idb  then
            return 0;
        else
            return 1;
        end if;

end;
BEGIN
    begin
            select tt into l_tt from oper where ref = p_ref;
            select id_a, id_b into l_okpo_a, l_okpo_b from oper where ref = p_ref;

         if l_tt = 'PKD' and substr(p_nlsa,1,4) in('2625') and substr(p_nlsb,1,4) in('2630','2635','2620') and p_kv <> 980 then
                begin
                l_chk_res := Check_NLS(p_kv,p_nlsa,p_nlsb);
                l_exception_flag := f_operw (p_ref, 'EXCFL');
                l_exception_desc := f_operw (p_ref, 'EXCTN');
               -- l_res_nlsa       := f_is_resident(P_KV, P_NLSA, P_REF);
               -- l_res_nlsb       := f_is_resident(P_KV, P_NLSB, P_REF);
                end;
        /* ������ COBUSUPABS-3825 �������� �� �������� �� ��� ��� ��� �������� �볺���, ���� �� ���� ���� ���������� �������:
            PKR �� 2630 2635 2638 �� 2625*/
         elsif l_tt = 'PKR' and substr(p_nlsa,1,4) in('2620') and substr(p_nlsb,1,4) in('2625') and p_kv <> 980 then
                begin
                l_chk_res := Check_NLS(p_kv,p_nlsa,p_nlsb);
                l_exception_flag := f_operw (p_ref, 'EXCFL');
                l_exception_desc := f_operw (p_ref, 'EXCTN');
                end;
         elsif l_tt = 'DPI' and substr(p_nlsa,1,4) in('2620','2638') and substr(p_nlsb,1,4) in('2620','2630','2635') and p_kv <> 980 then
                begin
                l_chk_res := Check_NLS(p_kv,p_nlsa,p_nlsb);
                l_exception_flag := f_operw (p_ref, 'EXCFL');
                l_exception_desc := f_operw (p_ref, 'EXCTN');
                end;
         elsif l_tt = 'DPJ' and substr(p_nlsa,1,4) in('2620') and substr(p_nlsb,1,4) in('2620','2630','2635') and p_kv <> 980 then
                begin
                l_chk_res := Check_REKV(l_okpo_a,l_okpo_b);
                l_exception_flag := f_operw (p_ref, 'EXCFL');
                l_exception_desc := f_operw (p_ref, 'EXCTN');
                end;
         elsif l_tt = 'OW4' and substr(p_nlsa,1,4) in('2625') and substr(p_nlsb,1,4) in('2630','2635','2620') and p_kv <> 980 then
                begin
                l_chk_res := Check_NLS(p_kv,p_nlsa,p_nlsb);
                l_exception_flag := f_operw (p_ref, 'EXCFL');
                l_exception_desc := f_operw (p_ref, 'EXCTN');
                end;
         else return 0;
         end if;
     end;
--bars_audit.info ('exc. l_chk_res: '||l_chk_res||' l_exception_desc: '||l_exception_desc||' l_tt: '||l_tt);
    if l_chk_res = 0 then
          return 0;
    elsif l_chk_res = 1 and l_exception_flag = 0 then
          --bars_audit.info ('exc1');
          bars_error.raise_error('DOC',47,'��������� ��������� �������� ������� ������� � ����� �������');
    elsif l_chk_res = 1 and l_exception_flag = 1 and l_exception_desc is null then
          --bars_audit.info ('exc2');
          bars_error.raise_error('DOC',47,'��������� �� ������� ������� ������� �������������, ��������� ��� � 365 �� 16.09.2013�');
    elsif l_chk_res = 1 and l_exception_flag = 1 and (l_tt = 'PKD' or l_tt = 'OW4' or l_tt = 'DPI' or l_tt = 'DPJ')  and substr(p_nlsb,1,4) in('2630','2635') and l_exception_desc is not null and l_exception_desc != '��������� �������� �� ��������� ���������� ������ ������������� � ��������� ������� ���ί ��' then
          --bars_audit.info ('exc3');
          bars_error.raise_error('DOC',47,'��������� ��������� �������� ������� ������� � ����� ������� ���������� ���������');
    elsif l_chk_res = 1 and l_exception_flag = 1 and (l_tt = 'PKD' or l_tt = 'OW4') and substr(p_nlsb,1,4) ='2625' and substr(p_nlsb,1,4) ='2620' and l_exception_desc = '��������� �������� �� ��������� ���������� ������ ������������� � ��������� ������� ���ί ��' then
          --bars_audit.info ('exc4');
          bars_error.raise_error('DOC',47,'��������� ��������� �������� ������� ������� � ����� ������� ���������� ���������');
    elsif l_chk_res = 1 and l_exception_flag = 1 and (l_tt = 'PKD' or l_tt = 'OW4' ) and substr(p_nlsb,1,4) = '2620'  and l_exception_desc is not null and l_exception_desc = '��������� �������� �� ��������� ���������� ������ ������������� � ��������� ������� ���ί ��' then
          --bars_audit.info ('exc5');
          bars_error.raise_error('DOC',47,'��������� ��������� �������� ������� ������� � ����� ������� ���������� ���������');
    elsif l_chk_res = 1 and l_exception_flag = 1 and (l_tt = 'PKR' /*or l_tt = 'DPI'*/ ) and l_exception_desc is not null and l_exception_desc = '��������� �������� �� ��������� ���������� ������ ������������� � ��������� ������� ���ί ��' then
          --bars_audit.info ('exc6');
          bars_error.raise_error('DOC',47,'��������� ��������� �������� ������� ������� � ����� ������� ���������� ���������');
    elsif l_chk_res = 1 and l_exception_flag = 1 and ( l_tt = 'DPI' or l_tt = 'DPJ') and substr(p_nlsb,1,4) = '2620'  and  l_exception_desc is not null and l_exception_desc = '��������� �������� �� ��������� ���������� ������ ������������� � ��������� ������� ���ί ��' then
          --bars_audit.info ('exc5');
          bars_error.raise_error('DOC',47,'��������� ��������� �������� ������� ������� � ����� ������� ���������� ���������');
    elsif l_chk_res = 1 and l_exception_flag = 1 and (l_tt != 'PKD' or l_tt != 'OW4' or l_tt != 'DPI' or l_tt != 'DPJ') and l_exception_desc is not null and l_exception_desc != '��������� �������� �� ��������� ���������� ������ ������������� � ��������� ������� ���ί ��' then
          --bars_audit.info ('exc');
          return 0;
    --else  bars_error.raise_error('DOC',47,'��������� ��������� �������� ������� ������� � ����� ������� ���������� ���������');
    end if;
return 0;

end F_CHECK_DESC_EXCEPTION;
/
 show err;
 
PROMPT *** Create  grants  F_CHECK_DESC_EXCEPTION ***
grant EXECUTE                                                                on F_CHECK_DESC_EXCEPTION to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_check_desc_exception.sql ========
 PROMPT ===================================================================================== 
 