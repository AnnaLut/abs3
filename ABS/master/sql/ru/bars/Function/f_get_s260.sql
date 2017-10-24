
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_get_s260.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_GET_S260 (f_nd number, f_acc number, f_s260 varchar2,
    rnk_ number default null, nbs_ VARCHAR2 default null, default_ number default 1) return varchar2
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
-- versions 07/11/2012 (05/11/2012 )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
-- 08/06/2012 ������� ������ ����� ����������� (������ �� 03/03/2012 ����������� �� � ����)
--            � �������� ������ ����� �� ���� (� ��������������� ����� � ��������� ���)
-- 03/03/2012 ��� �� ������� ������������� S260r_ ='08' � ����� ���������� �� N ���. �� ND_TXT
--            � ��� ���������� � ND_TXT �� SPECPARAM
-- 29/02/2012 ������ ���� 06 (i���) ����� ����������� ����� ��� 08 (i��� ...)
--            ��������� � ��-�� KL_S260
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
is
    s260_k varchar2(10);
    k051_   VARCHAR2(2);
    custtype_   number;
    s260r_  varchar2(10);
begin
    if f_nd is not null then
        begin
          SELECT max((substr(trim(t.txt),1,2)))
          into s260_k
          FROM nd_txt t
          WHERE t.nd = f_nd
            and t.tag='S260';

           s260r_ := nvl(trim(s260_k), nvl(f_s260,'00'));
        end;
     else
         BEGIN
              SELECT max(NVL(substr(trim(t.txt),1,2), nvl(f_s260,'00')))
              INTO  s260_k
              FROM nd_acc n, nd_txt t
              WHERE n.acc=f_acc
                and n.nd=t.nd
                and t.tag='S260';

              s260r_ := nvl(trim(s260_k), nvl(f_s260,'00'));
         END;
    end if;

    if default_ = 0 then
       if nvl(trim(s260r_), '00') = '00' and f_s260 <> '00' then
          s260r_ := f_s260;
       end if;

       return nvl(trim(s260r_), '00');
    else

       if substr(nbs_, 4, 1) in ('8', '9') and s260r_ = '00'
       then
          BEGIN
            select max(NVL(p.s260, '00'))
               into s260r_
            from nd_acc n, nd_acc n1, accounts a, specparam p
            where n.acc = f_acc
              and n.nd = n1.nd
              and a.acc = n1.acc
              and n1.acc <> f_acc
              and trim(a.tip) = 'SS'
              and a.acc = p.acc(+);
          EXCEPTION WHEN NO_DATA_FOUND THEN
             BEGIN
                select max(NVL(p.s260, '00'))
                   into s260r_
                from nd_acc n, nd_acc n1, accounts a, specparam p
                where n.acc = f_acc
                  and n.nd = n1.nd
                  and a.acc = n1.acc
                  and n1.acc <> f_acc
                  and trim(a.tip) = 'SP'
                  and a.acc = p.acc(+);
             EXCEPTION WHEN NO_DATA_FOUND THEN
                null;
             END;
          END;
       end if;

       if s260r_ = '00' then
          s260r_ := '08';
       end if;

       return nvl(trim(s260r_), '00');
    end if;
end f_get_s260;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_get_s260.sql =========*** End ***
 PROMPT ===================================================================================== 
 