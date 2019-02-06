CREATE OR REPLACE function BARS.F_zay_eqv_check (
       p_zay_id   zayavka.id%type          default null,
 --      p_days number default null, --������� ��� �������� , ���� NULL - ��
                                  -- �� ������� ����
       p_mode varchar2 default null --'M' - �������� �����, 'D' - �������� ����
)
return number
is
/*
06,02,2019 - v.5 ������ ��������
30.01.2019 - v.4
15.01.2019  - ������� �������� �� �� ���������� ��� �� ����������� ������
������ �� �������� �������. � ������� ���� �������� (-�����) ��� ����
�������� (+ �����)
� ������ � ������ � ������� ������������ (�������� ������� � 07.02.2019�.
������ ������ ���� ������ � ������ ���������, ��������� ��� � 5
���� ������������ ��������� ��� ������ ������� �� ���������� �������
��������� ������� �������� � �������� ����� , ���- ��������� �5)
35.	������ ������������� ����������:
�������� � ������� ���������� ������ ��� ������� �������� �� ����������
����� �볺���� (�������� ������, ��������� ������, �������� ������-���������)
,�� ����������� ��������� �����, �������� �������� ��� � ����� ����� �� ������
�볺���. ����������� ����������� �� ������, ���������� ����� � ����������
������� ���������� ������, ������������ ������������ ������
�� ���� ���������� ��������.
*/
       l_okpo number;
       l_SER_PASP VARCHAR2(10);
       l_NOM_PASP VARCHAR2(20);
    --   l_tgr number(1);
       ss_eq  number; --���� �������� �� ���� �� ���(�� ����� - �� � ����. ��������)
       sin_eq number; --��������� ������� ������
       --l_request zayavka%rowtype;
       l_sos     zayavka.sos%type;
       l_viza    zayavka.viza%type;
       l_id number;
       l_rnk number;
       l_kv2 varchar2(3);
       l_s2 number;
       l_kf varchar2(6);
       l_days number(2);
       l_prv number (1);--������� ������
       l_custtype customer.custtype%type;
       l_ch_date_m date;
       l_ch_date_d date;
begin
/***********v 1.0
sin_eq:=  gl.p_icurval (p_kv, p_suma, trunc(SYSDATE)); --���������

 begin
    select okpo into l_okpo from customer c where c.rnk= p_rnk ;
 exception
  when no_data_found then
    bc.go(p_mfo);
    select okpo into l_okpo from customer c where c.rnk= p_rnk ;
    bc.go('300465');
 end ;


--��������� ���� ��� ���������� ������ �� ���� �� ����
select nvl(sum(summa),0) into ss_eq from zay_val_control
    where okpo in (select okpo from customer c
                    where c.rnk= p_rnk and c.DATE_OFF is null)
    and zay_date=p_date;

--��������� ��������� � ����������� �����������
--��������� ����� �� �� ������� � 149 999,99 ���. �
--��������� �� ��������� ������ ����� �� ��������� �����,
--������������ ������������ ������ ������ �� ���� ��������� ��������.

    result:=F_get_CURR_LIM_DAY1-(sin_eq + ss_eq);

    return result;
    *****************************/

    /*********v 2.0
    ���� �������� �� ZAY21, ����� ������ ��� ��������
    �������� ID , �� ����� ��������� ��� �� ������  */

  -----------------��� �� ������� ������
  select *
  into
         l_id
        ,l_rnk
        ,l_kv2
        ,l_s2
        ,l_kf
  from   (select *
          from   (select id, rnk, kv2, s2, kf
                  from   zayavka
                  union all
                  select id, rnk, kv2, s2, mfo
                  from   zayavka_ru)
          where  id = p_zay_id

          );
    ---------------------------------------
    --��������� ���� �볺��� �� ������� ������
    begin
      select c.okpo, p.ser, p.numdoc, c.custtype
      into   l_okpo, l_SER_PASP, l_NOM_PASP, l_custtype
      from   customer c
             left   join person p   on     p.rnk = c.rnk
      where  c.rnk = l_rnk
             and date_off is null;
    exception
      when no_data_found then
        bc.go(l_kf);
        select okpo, p.ser, p.numdoc,c.custtype
        into   l_okpo, l_SER_PASP, l_NOM_PASP, l_custtype
        from   customer c
               left   join person p on  p.rnk = c.rnk
        where  c.rnk = l_rnk
               and date_off is null;
        bc.go('300465');
    end;
    ------------------------------
    ----��������� ������� ������
    sin_eq:=  gl.p_icurval (l_kv2,l_s2, trunc(SYSDATE));
    ------------------------------
    -----------------������� ������ , ���� �� - �� ������� ����� 1
    if l_custtype=2 then l_prv:=1;
      else
      select prv into l_prv  from tabval where kv=l_kv2;
    end if;
    ---------------------------------------
    --����� ��������
    --�������� �� �����(�� �������� (0,1)) + �������� �� ����(�� ���������(1,2))
    if    p_mode = 'M' then        
    -- �������� �� ������� �� ���� � ������
   select coalesce(sum(z.summa), 0)
    into   ss_eq
    from 
    (
    --���� �� �����(�� �������� (0,1))
    select Z.SUMMA
    from   zay_val_control z
          inner  join tabval tv on tv.kv = z.kv2 and tv.prv = l_prv
    where  z.okpo || z.SER_PASP || z.NOM_PASP =
           l_okpo || l_SER_PASP || l_NOM_PASP
           and z.sos = 0
           and z.viza = 1
           and z.zay_date >= trunc(sysdate) - 30
     
    union all
      -- ���� �� ����(�� ���������(1,2))
    select z.summa
    from   zay_val_control z
          inner  join tabval tv on tv.kv = z.kv2 and tv.prv = l_prv
    where  z.okpo || z.SER_PASP || z.NOM_PASP =
           l_okpo || l_SER_PASP || l_NOM_PASP
           and z.sos = 1
           and z.viza = 2
           and z.zay_date_v =trunc(sysdate)
     ) z      
           ; 
      
    elsif p_mode = 'D' then --�������� �� ���� (�� ���������(1,2))
    -- �������� �� ������� �� ���� � ������
     select coalesce(sum(z.summa), 0)
    into   ss_eq
    from   zay_val_control z
          inner  join tabval tv on tv.kv = z.kv2 and tv.prv = l_prv
    where  z.okpo || z.SER_PASP || z.NOM_PASP =
           l_okpo || l_SER_PASP || l_NOM_PASP
           and z.sos = 1
           and z.viza = 2
           and z.zay_date_v =trunc(sysdate)
           ;
   end if;

    ----------------------------
    
    --���������=������ �� ��������� ����� ����� , �� ����� ������
    
    return F_get_CURR_LIM_DAY1/*149 999 99*/-(sin_eq + ss_eq); -- �������(-), ������� (+) ��������

end;
/