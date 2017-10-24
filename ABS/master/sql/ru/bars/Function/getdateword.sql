
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/getdateword.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.GETDATEWORD 
    ( i_dt in date, i_mode in number , i_dt_from date default null
    )
    RETURN VARCHAR2
    is
    l_str varchar2(100);
    l_str_month varchar2(100);
    l_str_year varchar2(100);
    l_str_decade varchar2(100);
    l_str_century varchar2(100);

    l_day number;
    l_month number;
    l_year number;
    l_century number;

    begin
    --l_str :=to_char(i_dt,'DD/MM/YYYY');
    if (i_mode in (1,2)) then
    select substr(to_char(i_dt, 'DD/MM/YYYY'),1,2), substr(to_char(i_dt, 'DD/MM/YYYY'),4,2),substr(to_char(i_dt, 'DD/MM/YYYY'),7,2) ,substr(to_char(i_dt, 'DD/MM/YYYY'),9,2)
    into l_day,l_month, l_century ,l_year
     from dual;
    else
    if (i_mode <>3) or (i_dt_from is null) then return l_str; end if;
    select trunc(mod(MONTHS_BETWEEN(i_dt, i_dt_from),1)*31),  trunc(mod(MONTHS_BETWEEN(i_dt, i_dt_from),12)), trunc(MONTHS_BETWEEN(i_dt, i_dt_from)/12)
    into l_day,l_month,l_year
    from dual;
    if i_dt_from>i_dt then l_str := '������ ����� ���������: "���� �" ����� �� "���� ��" '; return l_str;  end if;
    if l_year>99 then l_str := '������ ����� ���������: ������ �� ������ ����� 100 ����'; return l_str;  end if;
    end if;



    case
    when (l_day=1) then
     if (i_mode = 1) then l_str :='�������'; else if (i_mode = 2) then  l_str :='�����'; else l_str :='���� ����'; end if ; end if ;
    when (l_day=2) then
     if (i_mode = 1) then l_str :='�������'; else if (i_mode = 2) then l_str :='�����'; else l_str :='��� ��'; end if ; end if ;
    when (l_day=3) then
     if (i_mode = 1) then l_str :='��������'; else if (i_mode = 2) then l_str :='�����';  else l_str :='��� ��'; end if ; end if ;
    when (l_day=4) then
     if (i_mode = 1) then l_str :='����������'; else if (i_mode = 2) then l_str :='��������';  else l_str :='������ ��'; end if ; end if ;
    when (l_day=5) then
     if (i_mode = 1) then l_str :='�''�����'; else if (i_mode = 2) then l_str :='�''���';  else l_str :='�''��� ���'; end if ; end if ;
    when (l_day=6) then
     if (i_mode = 1) then l_str :='�������'; else if (i_mode = 2) then l_str :='�����';  else l_str :='����� ���'; end if ; end if ;
    when (l_day=7) then
     if (i_mode = 1) then l_str :='�������'; else if (i_mode = 2) then l_str :='�����';  else l_str :='�� ���'; end if ; end if ;
    when (l_day=8) then
     if (i_mode = 1) then l_str :='��������'; else if (i_mode = 2) then l_str :='������';   else l_str :='��� ���'; end if ; end if ;
    when (l_day=9) then
     if (i_mode = 1) then l_str :='���''�����'; else if (i_mode = 2) then l_str :='���''���';  else l_str :='���''��� ���'; end if ; end if ;
    when (l_day=10) then
     if (i_mode = 1) then l_str :='��������'; else if (i_mode = 2) then l_str :='������'; else l_str :='������ ���'; end if ; end if ;
    when (l_day=11) then
     if (i_mode = 1) then l_str :='������������'; else if (i_mode = 2) then l_str :='����������';  else l_str :='���������� ���'; end if ; end if ;
    when (l_day=12) then
     if (i_mode = 1) then l_str :='������������'; else if (i_mode = 2) then l_str :='����������';  else l_str :='���������� ���'; end if ; end if ;
    when (l_day=13) then
     if (i_mode = 1) then l_str :='������������'; else if (i_mode = 2) then l_str :='����������';  else l_str :='���������� ���'; end if ; end if ;
    when (l_day=14) then
     if (i_mode = 1) then l_str :='��������������'; else if (i_mode = 2) then l_str :='������������'; else l_str :='������������ ���'; end if ; end if ;
    when (l_day=15) then
     if (i_mode = 1) then l_str :='�''�����������'; else if (i_mode = 2) then l_str :='�''���������';  else l_str :='�''��������� ���'; end if ; end if ;
    when (l_day=16) then
     if (i_mode = 1) then l_str :='س�����������'; else if (i_mode = 2) then l_str :='س���������';  else l_str :='����������� ���'; end if ; end if ;
    when (l_day=17) then
     if (i_mode = 1) then l_str :='ѳ����������'; else if (i_mode = 2) then l_str :='ѳ��������';  else l_str :='��������� ���'; end if ; end if ;
    when (l_day=18) then
     if (i_mode = 1) then l_str :='³�����������'; else if (i_mode = 2) then l_str :='³���������';  else l_str :='���������� ���'; end if ;end if ;
    when (l_day=19) then
     if (i_mode = 1) then l_str :='���''�����������'; else if (i_mode = 2) then l_str :='���''���������';  else l_str :='���''��������� ���'; end if ;end if ;
    when (l_day=20) then
     if (i_mode = 1) then l_str :='����������'; else if (i_mode = 2) then l_str :='��������';  else l_str :='�������� ���'; end if ; end if ;
    when (l_day=21) then
     if (i_mode = 1) then l_str :='�������� �������'; else if (i_mode = 2) then l_str :='�������� �����';  else l_str :='�������� ���� ����'; end if ;end if ;
    when (l_day=22) then
     if (i_mode = 1) then l_str :='�������� �������'; else if (i_mode = 2) then l_str :='�������� �����';   else l_str :='�������� ��� ��'; end if ; end if ;
     when (l_day=23) then
     if (i_mode = 1) then l_str :='�������� ��������'; else if (i_mode = 2) then l_str :='�������� �����';  else l_str :='�������� ��� ��'; end if ; end if ;
    when (l_day=24) then
     if (i_mode = 1) then l_str :='�������� ����������'; else if (i_mode = 2) then l_str :='�������� ��������';  else l_str :='�������� ������ ��'; end if ; end if ;
    when (l_day=25) then
     if (i_mode = 1) then l_str :='�������� �''�����'; else if (i_mode = 2) then l_str :='�������� �''���';  else l_str :='�������� �''��� ���'; end if ; end if ;
    when (l_day=26) then
     if (i_mode = 1) then l_str :='�������� �������'; else if (i_mode = 2) then l_str :='�������� �����';  else l_str :='�������� ����� ���'; end if ; end if ;
    when (l_day=27) then
     if (i_mode = 1) then l_str :='�������� �������'; else if (i_mode = 2) then l_str :='�������� �����';  else l_str :='�������� �� ���'; end if ; end if ;
    when (l_day=28) then
     if (i_mode = 1) then l_str :='�������� ��������'; else if (i_mode = 2) then l_str :='�������� ������';  else l_str :='�������� ��� ���'; end if ; end if ;
    when (l_day=29) then
     if (i_mode = 1) then l_str :='�������� ���''�����'; else if (i_mode = 2) then l_str :='�������� ���''���';  else l_str :='�������� ���''��� ���'; end if ; end if ;
    when (l_day=30) then
     if (i_mode = 1) then l_str :='����������'; else if (i_mode = 2) then l_str :='��������';  else l_str :='�������� ���'; end if ; end if ;
    when (l_day=31) then
     if (i_mode = 1) then l_str :='�������� �������'; else if (i_mode = 2) then l_str :='�������� �����';  else l_str :='�������� ���� ����'; end if ; end if ;
    else  l_str :='';
    end case;

    case
    when (l_month=1) then
     if (i_mode in (1,2)) then l_str_month :='����'; else  l_str_month :='���� �����'; end if ;
    when (l_month=2) then
     if (i_mode in (1,2)) then l_str_month :='������'; else  l_str_month :='��� �����'; end if ;
    when (l_month=3) then
     if (i_mode in (1,2)) then l_str_month :='�������'; else  l_str_month :='��� �����'; end if ;
    when (l_month=4) then
     if (i_mode in (1,2)) then l_str_month :='�����'; else  l_str_month :='������ �����'; end if ;
    when (l_month=5) then
     if (i_mode in (1,2)) then l_str_month :='������'; else  l_str_month :='�''��� ������'; end if ;
    when (l_month=6) then
     if (i_mode in (1,2)) then l_str_month :='������'; else  l_str_month :='����� ������'; end if ;
    when (l_month=7) then
     if (i_mode in (1,2)) then l_str_month :='�����'; else  l_str_month :='�� ������'; end if ;
    when (l_month=8) then
     if (i_mode in (1,2)) then l_str_month :='������'; else  l_str_month :='��� ������'; end if ;
    when (l_month=9) then
     if (i_mode in (1,2)) then l_str_month :='�������'; else  l_str_month :='���''��� ������'; end if ;
    when (l_month=10) then
     if (i_mode in (1,2)) then l_str_month :='������'; else  l_str_month :='������ ������'; end if ;
    when (l_month=11) then
     if (i_mode in (1,2)) then l_str_month :='���������'; else  l_str_month :='���������� ������'; end if ;
    when (l_month=12) then
     if (i_mode in (1,2)) then l_str_month :='������'; else  l_str_month :='���������� ������'; end if ;
    else l_str_month :='';
    end case;

     if (i_mode in (1,2)) then l_str := l_str|| ' ' || l_str_month; else  l_str := l_str_month|| ' ' || l_str ; end if ;

     if (i_mode in (1,2)) then
     case
     when (l_century=19) then
     l_str_century := '���� ������ ���''�����';
     when (l_century=20) then
     l_str_century := '�� ������';
     when (l_century=21) then
     l_str_century := '�� ������ ���';
     end case;
     end if;

    case
    when ((l_year >20) and (l_year <30)) then  l_str_decade := '��������'; l_year := substr(l_year,2);
    when ((l_year >30) and (l_year <40)) then  l_str_decade := '��������'; l_year := substr(l_year,2);
    when ((l_year >40) and (l_year <50)) then  l_str_decade := '�����'; l_year := substr(l_year,2);
    when ((l_year >50) and (l_year <60)) then  l_str_decade := '�''�������'; l_year := substr(l_year,2);
    when ((l_year >60) and (l_year <70)) then  l_str_decade := '���������'; l_year := substr(l_year,2);
    when ((l_year >70) and (l_year <80)) then  l_str_decade := '�������'; l_year := substr(l_year,2);
    when ((l_year >80) and (l_year <90)) then  l_str_decade := '��������'; l_year := substr(l_year,2);
    when ((l_year >90) and (l_year <100)) then l_str_decade := '���''������'; l_year := substr(l_year,2);
    when (l_year =0 ) then l_str_century := '������������'; l_year := substr(l_year,2);
    when (l_year =20) then l_str_decade := '����������'; l_year := substr(l_year,2);
    when (l_year =30) then l_str_decade := '����������'; l_year := substr(l_year,2);
    when (l_year =40) then l_str_decade := '����������'; l_year := substr(l_year,2);
    when (l_year =50) then l_str_decade := '�''�����������'; l_year := substr(l_year,2);
    when (l_year =60) then l_str_decade := '�������������'; l_year := substr(l_year,2);
    when (l_year =70) then l_str_decade := '������������'; l_year := substr(l_year,2);
    when (l_year =80) then l_str_decade := '��������������'; l_year := substr(l_year,2);
    when (l_year =90) then l_str_decade := '���''��������'; l_year := substr(l_year,2);

    else l_str_decade :='';
    end case;


     case
     when (l_year=1) then
     if (i_mode in ( 1,2))  then l_str_year :='�������'; else l_str_year :='���� ��'; end if ;
    when (l_year=2) then
     if (i_mode in ( 1,2)) then l_str_year :='�������';  else l_str_year :='��� ����'; end if ;
    when (l_year=3) then
     if (i_mode in ( 1,2)) then l_str_year :='��������';   else l_str_year :='��� ����'; end if ;
    when (l_year=4) then
     if (i_mode in ( 1,2)) then l_str_year :='����������';   else l_str_year :='������ ����'; end if ;
    when (l_year=5) then
     if (i_mode in ( 1,2)) then l_str_year :='�''�����'; else l_str_year :='�''��� ����'; end if ;
    when (l_year=6) then
     if (i_mode in ( 1,2)) then l_str_year :='�������';  else l_str_year :='����� ����'; end if ;
    when (l_year=7) then
     if (i_mode in ( 1,2)) then l_str_year :='�������';  else l_str_year :='�� ����'; end if ;
    when (l_year=8) then
     if (i_mode in ( 1,2)) then l_str_year :='��������';  else l_str_year :='��� ����'; end if ;
    when (l_year=9) then
     if (i_mode in ( 1,2)) then l_str_year :='���''�����';  else l_str_year :='���''��� ����'; end if ;
    when (l_year=10) then
     if (i_mode in ( 1,2)) then l_str_year :='��������';  else l_str_year :='������ ����'; end if ;
    when (l_year=11) then
     if (i_mode in ( 1,2)) then l_str_year :='������������';  else l_str_year :='���������� ����'; end if ;
    when (l_year=12) then
     if (i_mode in ( 1,2)) then l_str_year :='������������';   else l_str_year :='���������� ����'; end if ;
    when (l_year=13) then
     if (i_mode in ( 1,2)) then l_str_year :='������������';   else l_str_year :='���������� ����'; end if ;
    when (l_year=14) then
     if (i_mode in ( 1,2)) then l_str_year :='��������������';  else l_str_year :='������������ ����'; end if ;
    when (l_year=15) then
     if (i_mode in ( 1,2)) then l_str_year :='�''�����������';   else l_str_year :='�''��������� ����'; end if ;
    when (l_year=16) then
     if (i_mode in ( 1,2)) then l_str_year :='�������������';   else l_str_year :='����������� ����'; end if ;
    when (l_year=17) then
     if (i_mode in ( 1,2)) then l_str_year :='�����������';  else l_str_year :='��������� ����'; end if ;
    when (l_year=18) then
     if (i_mode in ( 1,2)) then l_str_year :='������������';   else l_str_year :='���������� ����'; end if ;
    when (l_year=19) then
     if (i_mode in ( 1,2)) then l_str_year :='���''�����������';   else l_str_year :='���''��������� ����'; end if ;
    else l_str_year := '';
     end case;

     if (i_mode in ( 1,2)) then l_str_year := l_str_decade || ' ' || l_str_year|| ' ����'; end if;

     if (i_mode in ( 1,2)) then
     l_str := l_str || ' ' || l_str_century || ' ' ||l_str_year;
     else
     l_str := l_str_year  || ' ' ||  l_str;
     end if;


    select replace(l_str,'  ', ' ') into l_str from dual;
    return l_str;
        END;
/
 show err;
 
PROMPT *** Create  grants  GETDATEWORD ***
grant EXECUTE                                                                on GETDATEWORD     to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on GETDATEWORD     to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/getdateword.sql =========*** End **
 PROMPT ===================================================================================== 
 