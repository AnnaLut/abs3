CREATE OR REPLACE function BARS.f_kf_nn(p_dat01 date,p_kf varchar2) RETURN varchar2 is

/* ������ 1.0 20-06-2018
   ����� ��� �� -- > MMFO � 2018 ����
*/


 l_nn varchar2(2) := '';

begin
   begin
      select id into l_nn
      from (select '337568' kf,'����'     NM, to_date('01-07-2018','dd-mm-yyyy') fdat, '19' id  from dual union all
            select '352457' kf,'������'   NM, to_date('01-03-2018','dd-mm-yyyy') fdat, '22' id  from dual union all
            select '328845' kf,'�����'    NM, to_date('01-07-2018','dd-mm-yyyy') fdat, '16' id  from dual union all
            select '325796' kf,'����'    NM, to_date('01-06-2018','dd-mm-yyyy') fdat, '14' id  from dual union all
            select '311647' kf,'�������'  NM, to_date('01-05-2018','dd-mm-yyyy') fdat, '07' id  from dual union all
            select '302076' kf,'³�����'  NM, to_date('01-05-2018','dd-mm-yyyy') fdat, '03' id  from dual union all
            select '353553' kf,'������' NM, to_date('01-03-2018','dd-mm-yyyy') fdat, '26' id  from dual)
      where p_dat01 < fdat and kf=p_kf;
   exception when NO_DATA_FOUND THEN l_nn := '';
   end;
   return l_nn;
end;
/

