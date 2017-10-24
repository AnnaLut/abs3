
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_get_empty_attr.sql =========*** R
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_GET_EMPTY_ATTR (p_rnk number) return varchar2
is
  l_msg    varchar2(2000) := null;
  l_cust   customer%rowtype;
  l_person person%rowtype;
  l_adr    customer_address%rowtype;
  procedure add_msg (i_str varchar2)
  is
  begin
     l_msg := case when l_msg is null then i_str
                   else l_msg || chr(10) || i_str
              end;
  end;
  procedure check_attr (i_value varchar2, i_name varchar2) is
  begin
     if i_value is null then add_msg(i_name); end if;
  end;
  procedure check_attr (i_value number, i_name varchar2) is
  begin
     if i_value is null then add_msg(i_name); end if;
  end;
  procedure check_attr (i_value date, i_name varchar2) is
  begin
     if i_value is null then add_msg(i_name); end if;
  end;
begin

  begin
     select c.* into l_cust
       from customer c
      where c.rnk = p_rnk;
     -- ����. �������
     check_attr(l_cust.country, '�����');
     check_attr(l_cust.nmk, '������������ �볺��� (���.)');
     check_attr(l_cust.nmkv, '������������ (���.)');
     check_attr(l_cust.okpo, '���������������� ���');
     check_attr(l_cust.adm, '���. ����� ���������');
     check_attr(l_cust.rgtax, '�����. ����� � ϲ');
     check_attr(l_cust.datet, '���� �����. � ϲ');
     check_attr(l_cust.datea, '���� �����. � ���.');
     -- �����
     begin
        select * into l_adr from customer_address where rnk = p_rnk and type_id = 1;
        check_attr(l_adr.locality, '��������� ����� (��������)');
        check_attr(l_adr.street, '���., �����., �-�. (��������)');
        check_attr(l_adr.home, '� ���., �/� (��������)');
     exception when no_data_found then null;
     end;
     check_attr( kl.get_customerw(p_rnk, 'K013 '), '��� ���� �볺��� (K013)');
     -- ����. ��
     if l_cust.custtype = 3 then
        check_attr(trim(l_cust.ise), '����. ������ �������� (�070)');
        check_attr(trim(l_cust.fs), '����� �������� (�080)');
        check_attr(trim(l_cust.ved), '��� ��. ��������(�110)');
        check_attr(trim(l_cust.k050), '����� �������������� (�050)');
        begin
           select * into l_person from person where rnk = p_rnk;
           check_attr(l_person.passp , '��� ���������');
           check_attr(l_person.ser, '����');
           check_attr(l_person.numdoc, '����� ���.');
           check_attr(l_person.organ, '��� �������');
           check_attr(l_person.pdate, '���� �������');
           check_attr(l_person.bday, '���� ����������');
           check_attr(l_person.sex, '�����');
           check_attr(l_person.teld, '���. ���.');
        exception when no_data_found then null;
        end;
        check_attr(kl.get_customerw(p_rnk, 'MPNO '), '���. ���.');
        check_attr(kl.get_customerw(p_rnk, 'GR   '), '������������');
        check_attr(kl.get_customerw(p_rnk, 'DATZ '), '���� ���������� ���������� ������');
        check_attr(kl.get_customerw(p_rnk, 'IDDPR'), '���� ��������� i������i���i�/��������� ����������');
        check_attr(kl.get_customerw(p_rnk, 'ID_YN'), '������������� �볺��� ���������');
        check_attr(kl.get_customerw(p_rnk, 'O_REP'), '������ ��������� �볺���');
        check_attr(kl.get_customerw(p_rnk, 'IDPIB'), 'ϲ� �� ���. ����������, ����������. �� �����-��� � �������� �볺���');
        check_attr(kl.get_customerw(p_rnk, 'DJER '), '�������������� ������ ���������� ����i�');
        check_attr(kl.get_customerw(p_rnk, 'CIGPO') ,'������ ��������� �����');
     -- ��-��������
     elsif mod(l_cust.codcagent, 2) = 1 then
        check_attr(trim(l_cust.ise), '����. ������ �������� (�070)');
        check_attr(trim(l_cust.fs), '����� �������� (�080)');
        check_attr(trim(l_cust.ved), '��� ��. ��������(�110)');
        check_attr(trim(l_cust.k050), '����� �������������� (�050)');
        check_attr(kl.get_customerw(p_rnk, 'UUCG '), '����� ������� ������ �� ����������� ��, �� ���������');
        check_attr(kl.get_customerw(p_rnk, 'UUDV '), '������ �������� ��������');
     end if;
  exception when no_data_found then null;
  end;
  return l_msg;
end f_get_empty_attr;
/
 show err;
 
PROMPT *** Create  grants  F_GET_EMPTY_ATTR ***
grant EXECUTE                                                                on F_GET_EMPTY_ATTR to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_get_empty_attr.sql =========*** E
 PROMPT ===================================================================================== 
 