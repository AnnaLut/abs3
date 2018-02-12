
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_ret_type_r013.sql =========*** Ru
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_RET_TYPE_R013 (p_fdat in date,      -- ����� ����
                                           p_nbs  in varchar2,  -- ���������� �������
                                           p_r013 in varchar2   -- �������� R013
                                          ) return number
is
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
             �������� ������� ��� ��������� #C5,#A7

 ������� ��� �������� ��������� p_r013 ��� ����������� p_nbs

   l_ret =1 -��� ������� ����������� �������, �� ��������� �� 30 ���
            -��� ��� ����� �������
   l_ret =2 -��� ������� ����������� �������, �� ��������� ����� 30 ���

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/

    l_ret   NUMBER;
begin
    select (case when lower(txt) like '%��������%30%��%' then 1
              when lower(txt) like '%�����%30%��%' then 2
              else 1
            end)
    into l_ret
    from kl_r013
    where trim(prem) = '��' and
          r020 = p_nbs and
          r013 = p_r013 and
          d_open <p_fdat and
          (d_close IS NULL OR d_close >= p_fdat);

    return l_ret;
exception
    when no_data_found then
         return 1;
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_ret_type_r013.sql =========*** En
 PROMPT ===================================================================================== 
 