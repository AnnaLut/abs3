
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_doc_add.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_DOC_ADD 
( id_add_  dpt_agreements.agrmnt_id%type,
  PR_      NUMBER
) RETURN   varchar2
IS
  ---
  -- ������� ��� ���������� ������ ���. ���� (�������� ��)
  ---
  l_str    varchar2(250);
BEGIN

  Case PR_

    when 1 then
      -- ���.��: ����� 䳿 �������� (��������)
      BEGIN
        SELECT decode(nvl(duration,0)     , 0, '',trim (f_sumpr(duration,null,'M'))||' ��.')||
               decode(nvl(duration_days,0), 0, '',trim (f_sumpr(duration_days,null,'M'))||' ��.')
          INTO l_str
          FROM dpt_deposit d,dpt_vidd v , dpt_agreements a
         WHERE d.vidd=v.vidd
           AND d.deposit_id = a.dpt_id
           AND a.agrmnt_id =id_add_;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          l_str := '___';
      END;

    when 2 then
      -- ���.��: ����� 䳿 ��������
      BEGIN
        SELECT decode(nvl(duration,0)     , 0, '',to_char(duration)||' ��.')||
               decode(nvl(duration_days,0), 0, '',to_char(duration_days)||' ��.')
          INTO l_str
          FROM dpt_deposit d,
               dpt_vidd    v,
               dpt_agreements a
         WHERE d.vidd=v.vidd
           AND d.deposit_id = a.dpt_id
           AND a.agrmnt_id  = id_add_;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          l_str := '___';
      END;

    when 3 then
      -- ������ �������� ��������, ����������� ��� ������� dpt_deposit.dat_end - dpt_deposit.dat_begin.(�����)
      BEGIN
         SELECT -- to_date(dat_begin, 'dd.mm.yyyy') d1, to_date(dat_end, 'dd.mm.yyyy') d2,
               TRIM(to_char(trunc(months_between (to_date(d.dat_end, 'dd.mm.yyyy'), to_date(d.dat_begin, 'dd.mm.yyyy')),0)))||'  ��. '||
               -- add_months(to_date(dat_begin, 'dd.mm.yyyy'),trunc(months_between (to_date(dat_end, 'dd.mm.yyyy'), to_date(dat_begin, 'dd.mm.yyyy')),0)) d3,
               TRIM(to_char(to_date(d.dat_end, 'dd.mm.yyyy') -  add_months(to_date(d.dat_begin, 'dd.mm.yyyy'),
               trunc(months_between (to_date(d.dat_end, 'dd.mm.yyyy'), to_date(d.dat_begin, 'dd.mm.yyyy')),0))))||'  ��. '
          INTO l_str
          FROM dpt_deposit d,
               dpt_agreements a
         WHERE d.deposit_id = a.dpt_id
           AND a.agrmnt_id  = id_add_;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          l_str := '___';
      END;

    When 4 Then
      -- ������ �������� ��������, ����������� ��� ������� dpt_deposit.dat_end - dpt_deposit.dat_begin.(��������)
      BEGIN
        SELECT -- to_date(dat_begin, 'dd.mm.yyyy') d1, to_date(dat_end, 'dd.mm.yyyy') d2,
               TRIM(f_sumpr(trunc(months_between (to_date(d.dat_end, 'dd.mm.yyyy'), to_date(d.dat_begin, 'dd.mm.yyyy')),0),null,'M' ))||'  ��. '||
               --add_months(to_date(dat_begin, 'dd.mm.yyyy'),trunc(months_between (to_date(dat_end, 'dd.mm.yyyy'), to_date(dat_begin, 'dd.mm.yyyy')),0)) d3,
               TRIM(f_sumpr(greatest(to_date(d.dat_end, 'dd.mm.yyyy') - add_months(to_date(d.dat_begin, 'dd.mm.yyyy'),
               trunc(months_between (to_date(d.dat_end, 'dd.mm.yyyy'), to_date(d.dat_begin, 'dd.mm.yyyy')),0)),0), null,'M'))||'  ��. '
          INTO l_str
          FROM dpt_deposit d,
               dpt_agreements a
         WHERE d.deposit_id = a.dpt_id
           AND a.agrmnt_id  = id_add_;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          l_str := '___';
      END;

    When 5 Then
      -- ����� ����� �� ���� ������������ ������� ������ ���������� ��
      begin
        select trim(to_char(trunc(months_between(a.date_end, a.date_begin)))) ||' ��. ' ||
               trim(to_char(a.date_end - add_months(a.date_begin, trunc(months_between(a.date_end, a.date_begin))))) ||' ��.'
          into l_str
          from DPT_AGREEMENTS a
         where a.agrmnt_id    = id_add_
           and a.agrmnt_type  = 4
           and a.agrmnt_state = 1;
      exception
        when NO_DATA_FOUND then
          l_str := '___';
      end;

    Else
      l_str := '__';

  End Case;

  return  l_str;

END F_DOC_ADD;
/
 show err;
 
PROMPT *** Create  grants  F_DOC_ADD ***
grant EXECUTE                                                                on F_DOC_ADD       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_DOC_ADD       to START1;
grant EXECUTE                                                                on F_DOC_ADD       to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_doc_add.sql =========*** End *** 
 PROMPT ===================================================================================== 
 