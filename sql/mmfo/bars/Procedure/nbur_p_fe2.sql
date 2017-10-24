

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_FE2.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure NBUR_P_FE2 ***

  CREATE OR REPLACE PROCEDURE BARS.NBUR_P_FE2 (p_kod_filii        varchar2,
                                             p_report_date      date,
                                             p_form_id          number,
                                             p_scheme           varchar2 default 'C',
                                             p_balance_type     varchar2 default 'S',
                                             p_file_code        varchar2 default '#E2')
is
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : ��������� ������������ #E2 ��� �������� �����
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
%
% VERSION       v.16.013  04.04.2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_          char(30)  := 'v.16.013  04.04.2017';
/*
   ��������� ��������� DD NNN

  DD    -   ���� �������� ��������:
    10 - ��� ������
    20 - ���� ������
    31 - ��� ������ �������� �����/i������i���i���� ����� ���� ������� �����/��� �����
    62 - ��� ������������;
    40 - ���� ��������;
    41 - ��� �������� �������� �� ��������� ��������� (�� 21.03.2016)
    64 - ��� �����, � ��� ���������� �������� ������;
    65 - ��� �����, ����� ���������� �������� ������;
    66 - ����� �����, ����� ���������� �������� ������;
    61 - ³������ ��� ��������

   NNN    -    ������� ���������� ����� �������� � ����� ������� ���.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
    l_nbuc          varchar2(20);
    l_type          number;
    l_datez         date := p_report_date + 1;
    l_file_code     varchar2(2) := substr(p_file_code, 2, 2);
    l_file_id       number;
    l_fmt           varchar2(20):='999990D0000';
    l_gr_sum_840    number         := 100000 ; -- �������� ����
    l_kurs_840      number := F_NBUR_RET_KURS (840, p_report_date);
    l_ourGLB        varchar2(20);
    l_last_nnn      number := 0;
    l_ourOKPO       varchar2(20) := LPAD (F_Get_Params ('OKPO', NULL), 8, '0');

BEGIN
    logger.info ('NBUR_P_FE2 begin for date = '||to_char(p_report_date, 'dd.mm.yyyy'));

    execute immediate 'truncate table NBUR_TMP_TRANS_1';

    -- ����������� ��������� ���������� (��� ������� ��� ��� ��� �������������)
    nbur_files.P_PROC_SET(p_kod_filii, p_file_code, p_scheme, l_datez, 0, l_file_code, l_nbuc, l_type);

    l_file_id := 16950;

    begin
        select max(decode(glb, 0, '0', lpad(to_char(glb), 3, '0')))
        into l_ourGLB
        from rcukru
        where mfo = p_kod_filii;
    exception
        when no_data_found then
            l_ourGLB := null;
    end;

    -- ��������� �����
    insert into NBUR_TMP_TRANS_1 (REPORT_DATE, KF, REF, TT, RNK, ACC, NLS, KV,
        P10, P20, P31, P40, P62, REFD,
        D1#E2, D6#E2, D7#E2, D8#E2, DA#E2, KOD_G, NB, NAZN)
    select REPORT_DATE, KF, REF, TT, CUST_ID, ACC_ID, ACC_NUM, KV,
        P10, P20, P31, D1#E2 P40, P62, REFD,
        D1#E2, D6#E2, D7#E2, D8#E2, DA#E2, KOD_G, NB, NAZN
    from (select /*+ ordered */  unique t.report_date, t.kf, t.ref, t.tt,
            c.cust_id, t.acc_id_db acc_id, t.acc_num_db acc_num, t.kv,
            lpad((dense_rank() over (order by t.ref)), 3, '0') nnn,
            lpad(t.kv, 3, '0') P10,
            TO_CHAR (ROUND (t.bal /  (F_Ret_Dig(t.kv, t.report_date) * 100), 0)) P20,
            (case when 
                    t.kf = '300465' and
                    t.acc_num_cr like '1500%' and
                    (t.acc_num_db in ('29091000580557',
                                     '29092000040557',
                                     '29095000081557',
                                     '29095000046547',
                                     '29091927',
                                     '2909003101',
                                     '292460205',
                                     '292490204') OR
                     substr(t.acc_num_db,1,4) = '1502') 
                        or
                     C.CUST_CODE = l_ourOKPO and
                     not (substr(t.acc_num_db,1,4) = '1919' and substr(t.acc_num_cr,1,4) = '1500') and
                     not (o.nlsa like '1600%' and o.nlsb like '1500%') and
                     decode(o.dk, 1, O.ID_A, o.ID_B) = l_ourOKPO 
                        or
                     o.nlsa like '3548%' and o.nlsb like '1500%' 
                        or
                     (trim(c.CUST_CODE) = l_ourOKPO or c.cust_type = '1' and c.k040 = '804') and
                     not(substr(t.acc_num_db,1,4) = '1919' and substr(t.acc_num_cr,1,4) = '1500' and t.tt <> 'NOS') and
                     decode(o.dk, 1, O.ID_A, o.ID_B) = l_ourOKPO
                then l_ourGLB
                when substr(t.acc_num_db,1,4) = '1919' and substr(t.acc_num_cr,1,4) = '1500' and t.tt <> 'NOS' or
                     o.nlsa like '1600%' and o.nlsb like '1500%'
                then '0'
                when decode(o.dk, 1, O.ID_A, o.ID_B) <> l_ourOKPO 
                then replace(replace(decode(o.dk, 1, O.ID_A, o.ID_B), '0000000000', '0'), '000000000', '0')
                else
                    (case when c.k030 = '2' or C.K040 <> '804'
                            then lpad(trim(c.cust_code), 10, '0')
                          when c.k030 = '1' and length(trim(c.cust_code))<=8 and trim(c.cust_code)<>l_ourOKPO
                            then lpad(trim(c.cust_code), 8,'0')
                          when c.k030 = '1' and
                               lpad(trim(c.cust_code), 10,'0') in
                                ('99999','999999999','00000','000000000','0000000000')
                            then '0'
                          when c.k030 = '1' and length(trim(c.cust_code)) > 8 and trim(c.cust_code)<>l_ourOKPO
                            then lpad(trim(c.cust_code), 10,'0')
                          else
                            l_ourGLB
                    end)
            end) P31,
            (case when t.kf = '300465' then
                 (case when t.acc_num_cr like '1500%' and
                            t.acc_num_db in ('29091000580557',
                                             '29092000040557',
                                             '29095000081557',
                                             '29095000046547',
                                             '29091927',
                                             '2909003101',
                                             '292460205',
                                             '292490204')
                           then '37'
                        when t.acc_num_cr like '1500%' and
                             t.acc_num_db in ('37394501547')
                            then '31'
                        when t.acc_num_db like '1600%' and
                             t.acc_num_cr like '1500%'
                        then
                           '31'
                      else
                           (case when trim(p.d1#e2) is not null
                                 then trim(p.d1#e2)
                                 else '00'
                           end)
                 end)
            else
                (case when trim(p.d1#e2) is not null
                      then trim(p.d1#e2)
                      when trim(p.d1#70) is null and
                           trim(p.d1#e2) is null and
                           trim(o.nazn) is not null
                      then
                         (case when instr(lower(o.nazn),'����') > 0 or
                                    instr(lower(o.nazn),'������') > 0 or
                                    instr(lower(o.nazn),'���_������ �������') > 0 or
                                    instr(lower(o.nazn),'�������') > 0 and t.acc_num_db like '2620%'
                             then '38'
                             else '00'
                         end)
                      else
                        (case when trim(p.d1#e2) is not null
                            then nvl(substr(trim(p.d1#e2), 1, 2), '00')
                            else nvl(substr(trim(p.d1#70), 1, 2), '00')
                         end)
                end)
            end) D1#E2,
            nvl((case when substr(trim(p.KOD_G),1,1) in ('O','P','�','�')
                    then SUBSTR (trim(p.KOD_G), 2, 3)
                    else SUBSTR (trim(p.KOD_G), 1, 3)
                 end),
                 substr(nvl(p.D6#70, p.D6#E2),1,3)) D6#E2,
            substr(trim(nvl(p.D9#70, p.D7#E2)),1,10) D7#E2,
            substr(trim(nvl(p.DA#70, p.D8#E2)),1,70) D8#E2,
            substr(nvl(trim(z.value), trim(p.DD#70)),1,70) DA#E2,
            (case when c.k040 <> '804' and
                       not (o.nlsa like '3548%' and o.nlsb like '1500%')
                         or
                       substr(t.acc_num_db,1,4) = '1919' and substr(t.acc_num_cr,1,4) = '1500' and t.tt <> 'NOS'
                  then '2' 
                  when o.nlsa like '3548%' and o.nlsb like '1500%' 
                  then '1'
                  else c.k030 
            end) P62,
            --(case when c.k040 <> '804' then '0' else to_char(2 - to_number(c.k030)) end) P62,
            to_number(trim(f_dop(t.ref, 'NOS_R'))) refd,
            (case when nvl(b.kodc,'000') <> '000' then b.kodc
                  else SUBSTR (trim(p.KOD_G), 1, 3)
            end) kod_g,
            substr(trim(u.nb), 1, 70) nb,
            substr(o.nazn,1,70) nazn
        from NBUR_DM_TRANSACTIONS t
        join NBUR_REF_SEL_TRANS r
        on (t.acc_num_db like r.acc_num_db||'%' and
            t.acc_num_cr like r.acc_num_cr||'%')
        left outer join NBUR_DM_ADL_DOC_RPT_DTL p
        on (t.report_date = p.report_date and
            t.kf = p.kf and
            t.ref = p.ref)
        join NBUR_DM_CUSTOMERS c
        on (t.report_date = c.report_date and
            t.kf = c.kf and
            t.cust_id_db = c.cust_id)
        left outer join rcukru u
        on (trim(c.cust_type) = trim(u.ikod))
        join oper o
        on (t.ref = o.ref)
        left outer join operw z
        on (t.ref = z.ref and z.tag = 'DA#E2')
       left outer join bopcount b
        on (b.iso_countr = SUBSTR (trim(p.KOD_N), 1, 3))
        where t.report_date = p_report_date and
            t.kf = p_kod_filii and
            t.kv not in (959, 961, 962, 964, 980) and
            r.file_id = l_file_id and
            gl.p_ncurval(840, t.bal_uah, t.report_date) > l_gr_sum_840 and 
            t.ref not in (select ref from NBUR_TMP_DEL_70 where kodf = l_file_code and datf = p_report_date) and
            not (o.nlsa like '1500%' and o.nlsb like '1500%' or
                 o.nlsa like '1919%' and o.nlsb like '1600%' and lower(o.nazn) like '%������%' or
                 o.nlsa like '19198%' and o.nlsb like '1600%' or
                 o.nlsa like '1600%' and o.nlsb like '1500%'  and c.k040 = '804' or
                 t.acc_num_db like '1600%' and c.k040 = '804' or
                 o.kf = '300465' and o.mfoa <> o.mfob or
                 t.kf = '300465' and t.r020_db in ('2600', '2620') and t.r020_cr in ('1919','2909','3739') and t.ref <> 88702330401 or
                 o.nlsa like '1500%' and o.nlsb like '7100%' and
                 o.dk=0 and round(t.bal_uah / l_kurs_840, 0) < 100000
            )
      );

   -- ���������� ���������� ��������� (������� 1)
   INSERT INTO nbur_detail_protocols (report_date,
                                      kf,
                                      report_code,
                                      nbuc,
                                      field_code,
                                      field_value,
                                      description,
                                      acc_id,
                                      acc_num,
                                      kv,
                                      maturity_date,
                                      cust_id,
                                      REF,
                                      nd,
                                      branch)
    SELECT report_date,
           kf,
           p_file_code,
           l_nbuc nbuc,
           substr(colname,2,2)||nnn field_code,
           value field_value,
           'Part 1 ' description,
           acc,
           nls,
           kv,
           null maturity_date,
           rnk,
           ref,
           NULL nd,
           null branch
    FROM (select z.report_date,
               z.kf,
               z.ref,
               z.rnk,
               z.acc,
               z.nls,
               z.kv,
               z.p10,
               z.p20,
               z.p31,
               z.p40,
               nvl(lpad(nvl(nvl(trim(translate(z.kod_g, '0123456789OP��', '0123456789')),
                                substr(trim (z.D6#E2), 1, 70)),
                            f_get_swift_country(z.ref)), 3, '0'),
                   '��� ���i�� � ��� ���������� ������' ) p64,
               nvl(nvl(substr(trim (z.D7#E2), 1, 10),
                   f_get_swift_bank_code(z.ref)),
                   rpad(nvl(nvl(trim (z.D7#E2), z.kod_g), '0000000000'), 10, '0')) p65,
               nvl(nvl(nvl(z.nb, substr(trim (z.D8#E2), 1, 70)), f_get_swift_bank_name(z.ref)),
                   '����� �����' ) p66,
              (case when p_kod_filii = '300465' then (case when DA#E2 is not null then DA#E2 else z.nazn end)
                    when z.d1#E2 = '20' then '������ � ������'
                    when z.d1#E2 = '21' then '������ ������, ����, ������'
                    when z.d1#E2 = '23' then '��������� �볺���� ������� �� ����������� (�� �����)'
                    when z.d1#E2 = '24' then '��������� ������ ������� �� �����-�����������'
                    when z.d1#E2 = '26' then '������� ������� �����������'
                    when z.d1#E2 = '27' then '��������� �������� � �����������'
                    when z.d1#E2 = '28' then '�����������'
                    when z.d1#E2 = '29' then '����������'
                    when z.d1#E2 = '30' then '���������� ��������'
                    when z.d1#E2 = '31' then '������������� � ����� �����'
                    when z.d1#E2 = '32' then '������ �� ����������'
                    when z.d1#E2 = '33' then '������������ ���������, ����������'
                    when z.d1#E2 = '34' then '��������� �볺���� �������, ���������� �� �����'
                    when z.d1#E2 = '35' then '��������� ������ ������� �� ����������� (�� �����)'
                    when z.d1#E2 = '36' then '���������� �� ����������� (�� ��������� ����������)'
                    when z.d1#E2 = '37' then '���������� �� ��������� ���������'
                    when z.d1#E2 = '38' then '������� ��������'
                    when z.d1#E2 = '39' then '�����'
                    when z.d1#E2 = '40' then '��������� ��������������'
                    when z.d1#E2 = '41' then '�������'
                    when z.d1#E2 = '42' then '�������� ������������'
                    when z.d1#E2 = '43' then '������ �� �������� ��������'
                    when z.d1#E2 = '44' then '�� ���������� � ����� ���������� ������'
                    else nvl(z.d61#E2, z.nazn)
                 end) p61,
              z.p62,
              lpad((dense_rank() over (order by z.rnk, z.ref)), 3, '0') nnn
        from (select a.report_date,
                a.kf, a.ref, a.tt, a.rnk, a.acc, a.nls, a.kv,
                a.p10, a.p20, a.p31, a.p40, a.refd,
                (case when t.id_oper is not null then to_char(20+t.id_oper) else a.D1#E2 end) D1#E2,
                nvl(t.bankcountry, nvl(a.D6#E2, a.kod_g)) D6#E2,
                rpad(nvl(trim(a.D7#E2), trim(t.bank_code)), 10, '0') D7#E2,
                nvl(t.benefbank, a.D8#E2) D8#E2,
                (case when r.kol_61 > 3
                      then '������ ��'||to_char(r.kol_61)||'-�� ���'
                      when r.kol_61 = 1
                      then k.DC#E2||lpad(r.DC#E2_max, 6,'0')
                      else r.DC1#E2
                 end) D61#E2,
                a.nb, substr(a.nazn, 1, 70) nazn,
                a.p62, a.kod_g, a.DA#E2
            from NBUR_TMP_TRANS_1 a
            left outer join (select ref, pid,
                                    min(pid) id_min,
                                    max(id) id,
                                    count(*) cnt
                             from contract_p
                             group by ref, pid) p
            on (a.ref = p.ref)
            left outer join top_contracts t
            on (p.pid = t.pid)
            left outer join (select t.pid, t.id,
                                   max(trim(t.name)) DC#E2_max,
                                   count(*) kol_61,
                                   LISTAGG(lpad(trim(c.cnum_cst),9,'#')||'/'||
                                           substr(c.cnum_year,-1)||'/'||
                                           trim(t.name)||' '||
                                           to_char(t.datedoc,'ddmmyyyy'),
                                            ',')
                                   WITHIN GROUP (ORDER BY t.pid, t.id, t.name) DC1#E2
                            from tamozhdoc t, customs_decl c
                              where trim(c.cnum_num)=trim(t.name)
                            group by t.pid, t.id) r
            on (p.pid = r.pid and
                p.id = r.id)
            left outer join (select t.pid, t.id, trim(t.name) name,
                                    trim(c.f_okpo) okpo,
                                    to_char(t.datedoc,'ddmmyyyy') D4#E2,
                                    lpad(trim(c.cnum_cst),9,'#')||'/'||
                                    substr(c.cnum_year,-1)||'/' DC#E2
                              from tamozhdoc t, customs_decl c
                              where trim(c.cnum_num)=trim(t.name)) k
            on (r.pid = k.pid and
                r.id = k.id and
                r.DC#E2_max = k.name and
                k.okpo = a.p31)
            where nvl(nvl(a.d6#E2, a.kod_g), 'ZZZ') not in ('804','UKR')
                and not ((a.nls like '1919%' or
                          a.nls like '3739%' ) and
                          a.tt = 'NOS')  )  z)
        UNPIVOT (VALUE FOR colname IN (p10, p20, p31, p40, p61, P62, p64, p65, p66));

   select to_number(ltrim(max(substr(field_code, 3, 3)), '0'))
   into l_last_nnn
   from nbur_detail_protocols
   where report_date = p_report_date and
         kf = p_kod_filii and
         report_code = p_file_code;

   -- ���������� ���������� ��������� (������� 2)
   -- �������� �������
   INSERT INTO nbur_detail_protocols (report_date,
                                      kf,
                                      report_code,
                                      nbuc,
                                      field_code,
                                      field_value,
                                      description,
                                      acc_id,
                                      acc_num,
                                      kv,
                                      maturity_date,
                                      cust_id,
                                      REF,
                                      nd,
                                      branch)
    SELECT report_date,
           kf,
           p_file_code,
           l_nbuc nbuc,
           substr(colname,2,2)||nnn field_code,
           value field_value,
           'Part 2' description,
           acc,
           nls,
           kv,
           null maturity_date,
           rnk,
           ref,
           refd nd,
           null branch
    FROM (select z.report_date,
               z.kf,
               z.ref,
               z.rnk,
               z.acc,
               z.nls,
               z.kv,
               z.p10,
               z.p20,
               z.p31,
               z.p40,
               nvl(lpad(nvl(nvl(trim(translate(z.kod_g, '0123456789OP��', '0123456789')),
                                substr(trim (z.D6#E2), 1, 70)),
                            f_get_swift_country(z.ref)), 3, '0'),
                   '��� ���i�� � ��� ���������� ������' ) p64,
               nvl(nvl(substr(trim (z.D7#E2), 1, 10),
                   f_get_swift_bank_code(z.ref)),
                   rpad(nvl(trim (z.D7#E2), z.kod_g), 10, '0')) p65,
               nvl(nvl(nvl(z.nb, substr(trim (z.D8#E2), 1, 70)), f_get_swift_bank_name(z.ref)),
                   '����� �����' ) p66,
              (case when p_kod_filii = '300465' then (case when DA#E2 is not null then DA#E2 else z.nazn end)
                    when z.d1#E2 = '20' then '������ � ������'
                    when z.d1#E2 = '21' then '������ ������, ����, ������'
                    when z.d1#E2 = '23' then '��������� �볺���� ������� �� ����������� (�� �����)'
                    when z.d1#E2 = '24' then '��������� ������ ������� �� �����-�����������'
                    when z.d1#E2 = '26' then '������� ������� �����������'
                    when z.d1#E2 = '27' then '��������� �������� � �����������'
                    when z.d1#E2 = '28' then '�����������'
                    when z.d1#E2 = '29' then '����������'
                    when z.d1#E2 = '30' then '���������� ��������'
                    when z.d1#E2 = '31' then '������������� � ����� �����'
                    when z.d1#E2 = '32' then '������ �� ����������'
                    when z.d1#E2 = '33' then '������������ ���������, ����������'
                    when z.d1#E2 = '34' then '��������� �볺���� �������, ���������� �� �����'
                    when z.d1#E2 = '35' then '��������� ������ ������� �� ����������� (�� �����)'
                    when z.d1#E2 = '36' then '���������� �� ����������� (�� ��������� ����������)'
                    when z.d1#E2 = '37' then '���������� �� ��������� ���������'
                    when z.d1#E2 = '38' then '������� ��������'
                    when z.d1#E2 = '39' then '�����'
                    when z.d1#E2 = '40' then '��������� ��������������'
                    when z.d1#E2 = '41' then '�������'
                    when z.d1#E2 = '42' then '�������� ������������'
                    when z.d1#E2 = '43' then '������ �� �������� ��������'
                    when z.d1#E2 = '44' then '�� ���������� � ����� ���������� ������'
                    else z.nazn
                 end) p61,
              z.p62, z.refd,
              lpad((dense_rank() over (order by z.rnk, z.ref)) + l_last_nnn, 3, '0') nnn
        from (select a.report_date,
                    a.kf,
                    a.ref,
                    a.tt,
                    c.cust_id rnk,
                    t1.ACC_ID_DB acc,
                    t1.ACC_NUM_DB nls,
                    a.kv,
                    a.p10,
                    a.p20,
                    a.P31,
                    nvl(decode(f.kva, 980, '30', '28'), a.p40) p40,
                    a.P62,
                    a.D6#E2,
                    a.D7#E2,
                    a.D8#E2,
                    a.KOD_G,
                    a.NB,
                    substr(a.NAZN, 1, 70) nazn,
                    nvl(decode(f.kva, 980, '30', '28'), a.p40) d1#E2,
                    t1.ref refd, a.DA#E2
                from NBUR_TMP_TRANS_1 a
                left outer join oper x
                on (x.vdat between p_report_date - 7 and p_report_date
                    and x.nlsb = a.nls
                    and x.kv = a.kv
                    and x.refl = a.ref)
                left outer join NBUR_DM_TRANSACTIONS t1
                on (x.ref = t1.ref and
                    t1.report_date = a.report_date and
                    t1.kf = a.kf)
                left outer join fx_deal f
                on (f.refb=x.ref)
                left outer join NBUR_DM_CUSTOMERS c
                on (c.report_date = p_report_date and
                    c.kf = p_kod_filii and
                    f.rnk = c.cust_id)
                where nvl(nvl(a.d6#E2, a.kod_g), 'ZZZ') not in ('804','UKR')
                      and ((a.nls like '1919%' or
                            a.nls like '3739%' ) and
                            a.tt = 'NOS')
                      and nvl(t1.tt, '***') like 'FX%'
                      and decode(f.kva, 980, '30', '28')<>'30') z)
   UNPIVOT (VALUE FOR colname IN (p10, p20, p31, p40, p61, P62, p64, p65, p66));

   select to_number(ltrim(max(substr(field_code, 3, 3)), '0'))
   into l_last_nnn
   from nbur_detail_protocols
   where report_date = p_report_date and
         kf = p_kod_filii and
         report_code = p_file_code;

   -- ���������� ���������� ��������� (������� 3)
   INSERT INTO nbur_detail_protocols (report_date,
                                      kf,
                                      report_code,
                                      nbuc,
                                      field_code,
                                      field_value,
                                      description,
                                      acc_id,
                                      acc_num,
                                      kv,
                                      maturity_date,
                                      cust_id,
                                      REF,
                                      nd,
                                      branch)
    SELECT report_date,
           kf,
           p_file_code,
           l_nbuc nbuc,
           substr(colname,2,2)||nnn field_code,
           value field_value,
           'Part 3' description,
           acc,
           nls,
           kv,
           null maturity_date,
           rnk,
           ref,
           refd nd,
           null branch
    FROM (select z.report_date,
               z.kf,
               z.ref,
               z.rnk,
               z.acc,
               z.nls,
               z.kv,
               z.p10,
               z.p20,
               z.p31,
               z.p40,
               nvl(lpad(nvl(nvl(trim(translate(z.kod_g, '0123456789OP��', '0123456789')),
                                substr(trim (z.D6#E2), 1, 70)),
                            f_get_swift_country(z.ref)), 3, '0'),
                   '��� ���i�� � ��� ���������� ������' ) p64,
               nvl(nvl(substr(trim (z.D7#E2), 1, 10),
                   f_get_swift_bank_code(z.ref)),
                   rpad(nvl(trim (z.D7#E2), z.kod_g), 10, '0')) p65,
               nvl(nvl(nvl(z.nb, substr(trim (z.D8#E2), 1, 70)), f_get_swift_bank_name(z.ref)),
                   '����� �����' ) p66,
              (case when p_kod_filii = '300465' then (case when DA#E2 is not null then DA#E2 else z.nazn end)
                    when z.d1#E2 = '20' then '������ � ������'
                    when z.d1#E2 = '21' then '������ ������, ����, ������'
                    when z.d1#E2 = '23' then '��������� �볺���� ������� �� ����������� (�� �����)'
                    when z.d1#E2 = '24' then '��������� ������ ������� �� �����-�����������'
                    when z.d1#E2 = '26' then '������� ������� �����������'
                    when z.d1#E2 = '27' then '��������� �������� � �����������'
                    when z.d1#E2 = '28' then '�����������'
                    when z.d1#E2 = '29' then '����������'
                    when z.d1#E2 = '30' then '���������� ��������'
                    when z.d1#E2 = '31' then '������������� � ����� �����'
                    when z.d1#E2 = '32' then '������ �� ����������'
                    when z.d1#E2 = '33' then '������������ ���������, ����������'
                    when z.d1#E2 = '34' then '��������� �볺���� �������, ���������� �� �����'
                    when z.d1#E2 = '35' then '��������� ������ ������� �� ����������� (�� �����)'
                    when z.d1#E2 = '36' then '���������� �� ����������� (�� ��������� ����������)'
                    when z.d1#E2 = '37' then '���������� �� ��������� ���������'
                    when z.d1#E2 = '38' then '������� ��������'
                    when z.d1#E2 = '39' then '�����'
                    when z.d1#E2 = '40' then '��������� ��������������'
                    when z.d1#E2 = '41' then '�������'
                    when z.d1#E2 = '42' then '�������� ������������'
                    when z.d1#E2 = '43' then '������ �� �������� ��������'
                    when z.d1#E2 = '44' then '�� ���������� � ����� ���������� ������'
                    else z.nazn
                 end) p61,
              z.p62,
              lpad((dense_rank() over (order by z.rnk, z.ref)) + l_last_nnn, 3, '0') nnn,
              z.refd
        from (select a.report_date,
                    a.kf,
                    a.ref,
                    a.tt,
                    nvl(c.cust_id, a.rnk) rnk,
                    nvl(t1.ACC_ID_DB, a.acc) acc,
                    nvl(t1.ACC_NUM_DB, a.nls) nls,
                    nvl(b.kv, a.kv) kv,
                    a.p10,
                    a.p20,
                    a.P31,
                    nvl(a.p40, decode(f.kva, 980, '30', '28')) p40,
                    a.p62,
                    nvl(t.bankcountry, nvl(a.D6#E2, a.kod_g)) D6#E2,
                    rpad(nvl(trim(D7#E2), trim(t.bank_code)), 10, '0') D7#E2,
                    nvl(t.benefbank, a.D8#E2) D8#E2,
                    (case when r.kol_61 > 3
                          then '������ ��'||to_char(r.kol_61)||'-�� ���'
                          when r.kol_61 = 1
                          then k.DC#E2||lpad(r.DC#E2_max, 6,'0')
                          else r.DC1#E2
                     end) D61#E2,
                    a.KOD_G,
                    a.NB,
                    a.NAZN,
                    nvl(a.p40, decode(f.kva, 980, '30', '28')) d1#E2,
                    x.ref refd, a.DA#E2
                from NBUR_TMP_TRANS_1 a
                left outer join oper x
                on (x.vdat between p_report_date - 7 and p_report_date
                    and x.nlsb = a.nls
                    and x.kv = a.kv
                    and x.refl = a.ref)
                left outer join NBUR_DM_TRANSACTIONS t1
                on (x.ref = t1.ref and
                    t1.report_date = a.report_date and
                    t1.kf = a.kf)
                left outer join (select ref, pid,
                                        min(pid) id_min,
                                        max(id) id,
                                        count(*) cnt
                                 from contract_p
                                 group by ref, pid) p
                on (a.ref = p.ref)
                left outer join top_contracts t
                on (p.pid = t.pid)
                left outer join (select t.pid, t.id,
                                       max(trim(t.name)) DC#E2_max,
                                       count(*) kol_61,
                                       LISTAGG(lpad(trim(c.cnum_cst),9,'#')||'/'||
                                               substr(c.cnum_year,-1)||'/'||
                                               trim(t.name)||' '||
                                               to_char(t.datedoc,'ddmmyyyy'),
                                                ',')
                                       WITHIN GROUP (ORDER BY t.pid, t.id, t.name) DC1#E2
                                from tamozhdoc t, customs_decl c
                                  where trim(c.cnum_num)=trim(t.name)
                                group by t.pid, t.id) r
                on (p.pid = r.pid and
                    p.id = r.id)
                left outer join (select t.pid, t.id, trim(t.name) name,
                                        trim(c.f_okpo) okpo,
                                        to_char(t.datedoc,'ddmmyyyy') D4#E2,
                                        lpad(trim(c.cnum_cst),9,'#')||'/'||
                                        substr(c.cnum_year,-1)||'/' DC#E2
                                  from tamozhdoc t, customs_decl c
                                  where trim(c.cnum_num)=trim(t.name)) k
                on (r.pid = k.pid and
                    r.id = k.id and
                    r.DC#E2_max = k.name and
                    k.okpo = a.p31)
                left outer join fx_deal f
                on (f.refb=x.ref)
                left outer join NBUR_DM_ACCOUNTS b
                on (b.report_date = p_report_date and
                    b.kf = p_kod_filii and
                    b.acc_id = t1.ACC_ID_DB)
                left outer join NBUR_DM_CUSTOMERS c
                on (c.report_date = p_report_date and
                    c.kf = p_kod_filii and
                    c.cust_id = b.cust_id)
                where nvl(nvl(a.d6#E2, a.kod_g), 'ZZZ') not in ('804','UKR')
                      and ((a.nls like '1919%' or
                            a.nls like '3739%' ) and
                            a.tt = 'NOS')
                      and nvl(t1.tt, '***') not like 'FX%') z)
    UNPIVOT (VALUE FOR colname IN (p10, p20, p31, p40, p61, P62, p64, p65, p66));

    -- ������������ ����������� �����  �  nbur_agg_protocols
    INSERT INTO nbur_agg_protocols (report_date,
                                    kf,
                                    report_code,
                                    nbuc,
                                    field_code,
                                    field_value)
       SELECT report_date,
              kf,
              report_code,
              nbuc,
              field_code,
              field_value
         FROM nbur_detail_protocols
      WHERE     report_date = p_report_date
            AND report_code = p_file_code
            AND kf = p_kod_filii;
      
      -- ������� ����� ��� ������� ���������� �����������
      DELETE FROM OTCN_TRACE_70 WHERE kodf = l_file_code and datf = p_report_date and kf = p_kod_filii;

      insert into OTCN_TRACE_70(KODF, DATF, USERID, NLS, KV, ODATE, KODP, ZNAP, NBUC, ISP, RNK, ACC, REF, COMM, ND, MDATE, TOBO)
      select l_file_code, p_report_date, USER_ID, ACC_NUM, KV, p_report_date, FIELD_CODE, FIELD_VALUE, NBUC, null ISP, 
             CUST_ID, ACC_ID, REF, DESCRIPTION, ND, MATURITY_DATE, BRANCH
      FROM nbur_detail_protocols
      WHERE     report_date = p_report_date
            AND report_code = p_file_code
            AND kf = p_kod_filii;
            
    logger.info ('NBUR_P_FE2 end for date = '||to_char(p_report_date, 'dd.mm.yyyy'));

END;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_FE2.sql =========*** End **
PROMPT ===================================================================================== 
