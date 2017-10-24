

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_FC9.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure NBUR_P_FC9 ***

  CREATE OR REPLACE PROCEDURE BARS.NBUR_P_FC9 (p_kod_filii        varchar2,
                                             p_report_date      date,
                                             p_form_id          number,
                                             p_scheme           varchar2 default 'C',
                                             p_balance_type     varchar2 default 'S',
                                             p_file_code        varchar2 default '#C9')
is
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : ��������� ������������ #C9 ��� �������� �����
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
%
% VERSION     :  v.16.013  21.04.2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
/*
   ��������� ��������� DD NNN

  DD    -   ���� �������� ��������:
    10 - ��� ������
    20 - ���� ������
    31 - ��� ������ �������� �����/���������������� ����� ���� ������� �����/��� �����
    35 - ��� ������������
    40 - ��� ���� ����������� ������
    41 � ��� ����������� �������� �� ��������� ��������� (�� 21.03.2016)
    62 - ��� �����, � ��� ���� ���������� ������
    99 - ������� ��� ��������

   NNN    -    ������� ���������� ����� �������� (����� ����������� �������� ������) � ����� ������� ���.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
    l_nbuc          varchar2(20);
    l_type          number;
    l_datez         date            := p_report_date + 1;
    l_file_code     varchar2(2)     := substr(p_file_code, 2, 2);
    l_file_id       number;
    l_fmt           varchar2(20)    :='999990D0000';
    l_gr_sum_840    number          := 100000; -- �������� ����
    l_kurs_840      number          := F_NBUR_RET_KURS (840, p_report_date);
    l_sum_kom       number          := gl.p_icurval(840, 100000, p_report_date);
    l_ourOKPO       varchar2(20)    := LPAD (F_Get_Params ('OKPO', NULL), 8, '0');
    l_max_nnn       number          := 0;
    l_koef          number          := 0;
BEGIN
  
  logger.info ('NBUR_P_FC9 begin for date = '||to_char(p_report_date, 'dd.mm.yyyy'));

  -- ����������� ��������� ���������� (��� ������� ��� ��� ��� �������������)
  nbur_files.P_PROC_SET(p_kod_filii, p_file_code, p_scheme, l_datez, 0, l_file_code, l_nbuc, l_type);

  l_file_id := 16757;
  
  if p_report_date < to_date('05042017','ddmmyyyy') then
     l_koef := 0.65;
  else
     l_koef := 0.50;
  end if;

  BEGIN
    
    INSERT
      INTO nbur_detail_protocols (report_date,
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
    SELECT d.report_date,
           d.kf,
           p_file_code,
           l_nbuc nbuc,
           substr(d.colname,2,2)||lpad(d.nnn, 3, '0') field_code,
           d.value field_value,
           'Part 1' description,
           d.acc_id,
           d.acc_num,
           d.kv,
           null maturity_date,
           d.cust_id,
           d.ref,
           NULL nd,
           branch
     from (select a.*,
                  dense_rank() over (order by tp, cust_id, ref, kv) nnn
            from ( with temp_sel as (
                   select *
                     from ( select *
                              from ( select /*+ ordered */
                                            t.report_date, t.kf, t.ref, t.kv,
                                            c.cust_id, t.acc_id_cr acc_id, t.acc_num_cr acc_num, 
                                            lpad((dense_rank() over (order by c.cust_id, t.ref)), 3, '0') nnn,
                                            lpad(t.kv, 3, '0') P10,
                                            TO_CHAR (ROUND (t.bal, 0)) P20,
                                            case 
                                              when t.kf = '300465' and
                                                 ( t.acc_num_db like '1500%' or
                                                   t.acc_num_db like '1600%') and
                                                   t.acc_num_cr in ('29091000580557','29092000040557',
                                                                    '29095000081557','29091927',
                                                                    '2909003101','29095000046547',
                                                                    '292460205','292490204','29096000541557',
                                                                    '37394501547','37391006','373990351') or
                                                   c.CUST_CODE = l_ourOKPO and 
                                                   decode(o.dk, 1, O.ID_B, o.ID_A) = l_ourOKPO
                                              then '006'
                                              when decode(o.dk, 1, O.ID_B, o.ID_A) <> l_ourOKPO
                                              then replace(replace(decode(o.dk, 1, O.ID_B, o.ID_A), '0000000000', '0'), '000000000', '0')
                                              when c.k030 = '1' and length(trim(c.cust_code))<=8
                                              then lpad(trim(c.cust_code), 8,'0')
                                              when c.k030 = '1' and
                                                   lpad(trim(c.cust_code), 10,'0') in ('99999','999999999','00000','000000000','0000000000')
                                              then ''
                                              when c.k030 = '1' and length(trim(c.cust_code)) > 8
                                              then lpad(trim(c.cust_code), 10,'0')
                                              when c.k030 = '2'
                                              then '0'
                                              else '0'
                                            end as P31,
                                            c.K030 as P35,
                                            case
                                              when trim(p.d1#C9) is not null
                                              then trim(p.d1#C9)
                                              else
                                                case
                                                  when t.kf = '300465' and
                                                      ((t.acc_num_db like '1500%' or
                                                        t.acc_num_db like '1600%') and
                                                        t.acc_num_cr in ('29091000580557','29092000040557','29095000081557',
                                                                '29091927','2909003101','29095000046547',
                                                                '292460205','292490204','29096000541557',
                                                                '373900354','373910357','373910360','373920363',
                                                                '373930353','373940356','373950359',
                                                                '373950362','37395358','373960352','37397906547',
                                                                '373980361','37398355','373990351','373990364',
                                                                '37391006' ))
                                                  then '29'
                                                  when t.kf = '300465' and
                                                     ( t.acc_num_db like '1500%' or t.acc_num_db like '1600%' ) and
                                                       t.acc_num_cr in ('37394501547')
                                                  then '09'
                                                  when t.KF = '300465' and
                                                       t.ACC_NUM_DB like '1500%' and
                                                  -- ( t.ACC_NUM_CR like '3739%' or t.ACC_NUM_CR like '2924%' ) and
                                                       n.T_SYSTEM Is Not Null -- �������� ������� ����� �� � ����������� ������ ��������� 13.01.2017
                                                  then '29'
                                                  else
                                                    case
                                                      when trim(lower(o.nazn)) like '%�_�����%' or
                                                           trim(lower(o.nazn)) like '%������_����%�������%' or
                                                           t.acc_num_db like '2909%' and t.acc_num_cr like '2603%'
                                                      then '01'
                                                      when trim(lower(o.nazn)) like '%�������%' or
                                                           trim(lower(o.nazn)) like '%���������%'
                                                      then '28'
                                                      when trim(lower(o.nazn)) like '%prepayment%' or
                                                           trim(lower(o.nazn)) like '%����%' or
                                                           trim(lower(o.nazn)) like '%���_������%�������%' or
                                                           trim(lower(o.nazn)) like '%�������%' and t.acc_num_cr like '2620%' or
                                                           t.acc_num_db like '2909%' and t.acc_num_cr like '2620%'
                                                      then '30'
                                                      else '09'
                                                    end
                                                end
                                            end as P40,
                                            nvl((case 
--                                                  when trim(p.kod_g) is not null
--                                                  then lpad(trim(p.kod_g), 3, '0')
                                                  when trim(p.d6#70) is null
                                                  then f_nbur_get_kod_g(t.ref)
                                                  else lpad(substr(trim(p.d6#70), 1, 3), 3, '0')
                                             end), '000') P62,
                                            nvl(trim(p.dd#70), substr(o.nazn, 1, 70)) P99,
                                            gl.p_ncurval(840, t.bal_uah, t.report_date) sum_840,
                                            c.k030, o.branch
                                       from NBUR_DM_TRANSACTIONS t
                                       join NBUR_REF_SEL_TRANS r
                                         on ( t.acc_num_db like r.acc_num_db||'%' and
                                              t.acc_num_cr like r.acc_num_cr||'%' and
                                              t.kf = nvl(r.mfo, t.kf) )
                                       left outer
                                       join NBUR_DM_ADL_DOC_RPT_DTL p
                                         on ( p.report_date = p_report_date and
                                              p.kf          = p_kod_filii   and
                                              p.ref         = t.ref         )
                                       join OPER o
                                         on ( o.ref = t.ref )
                                       join NBUR_DM_CUSTOMERS c
                                         on ( c.report_date = p_report_date and
                                              c.kf          = p_kod_filii   and
                                              c.cust_id     = t.cust_id_cr  )
                                       left outer
                                       join OTCN_TRANSIT_NLS n
                                         on ( n.NLS = t.ACC_NUM_CR )
                                      where t.report_date = p_report_date
                                        and t.kf = p_kod_filii 
                                        and t.kv <> 980 
                                        and r.file_id = l_file_id 
                                        and ( lower(trim(o.nazn)) not like '����%'
                                              or
                                              lower(trim(o.nazn)) like '����%' and t.R020_DB = '1500' and t.R020_CR IN ('1819', '3540') )
                                        and t.ref not in (select ref from NBUR_TMP_DEL_70 where kodf = l_file_code and datf = p_report_date)
                                        and not (T.R020_DB = '2603' and T.R020_CR = '2600')
                                        and not (T.R020_DB = '1600' and T.R020_CR = '1600')
                                        and o.tt <> '���'
                                        and NOT ( t.R020_DB IN ('1500','1600') and 
                                                  t.R020_CR = '2909'           AND
                                                  t.ACC_NUM_CR NOT IN ('29096000541557','29095000046547','29095000081557'
                                                                      ,'29091000580557','2909003101',    '29092000040557'
                                                                      ,'29091927') 
                                                )
                                        and not (t.R020_DB = '3739' and t.R020_CR = '2909' and T.OB22_CR = '66') 
                                        and not (t.R020_DB = '1600' and t.ACC_NUM_CR = '18199')
                                        and (not (r.acc_num_db in ('1500', '1502', '1600') and
                                  r.acc_num_cr = '3800')
                             or
                             r.acc_num_db in ('1500', '1502', '1600') and
                             r.acc_num_cr = '3800' and
                             (o.dk = 0 and (o.nlsa like '60%' or o.nlsa like '610%' or o.nlsa like '611%')
                              or
                              o.dk = 1 and (o.nlsb like '60%' or o.nlsb like '610%' or o.nlsb like '611%')
                             ) and
                            gl.p_icurval (o.kv, o.s, p_report_date) > l_sum_kom  -- why gl.p_icurval ?? - o.SQ
                            )
                       )
                    where (substr(acc_num, 1, 2) not in ('15','16') OR
                           substr(acc_num, 1, 2) in ('15','16') and k030 = '2') and
                           nvl(p62, '000') not in ('804','UKR')
                    )
                    UNPIVOT (VALUE FOR colname IN  (p10, p20, p31, p35, p40, p62, p99))
                    )
                select report_date, kf, ref, cust_id, acc_id, acc_num, kv, branch, colname,
                      (case when colname = 'P20'
                            then to_char(round(value))
                            else value
                       end) value, 1 tp
                from temp_sel
                where sum_840 > l_gr_sum_840
               ) a
                ) d;
    EXCEPTION
       WHEN OTHERS
       THEN
          logger.info (
                'NBUR_P_FC9 error: '
             || SQLERRM
             || ' for date = '
             || TO_CHAR (p_report_date, 'dd.mm.yyyy'));
    END;

    -- ������ � ����� ��� ����������� �����
    select nvl(max(to_number(substr(field_code, 3, 3))), 0) 
    into l_max_nnn
    from nbur_detail_protocols
    WHERE     report_date = p_report_date
          AND report_code = p_file_code
          AND kf = p_kod_filii;
          
    --  ����������� ������
    BEGIN
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
        SELECT d.report_date,
               d.kf,
               p_file_code,
               l_nbuc nbuc,
               substr(d.colname,2,2)||lpad(d.nnn + l_max_nnn, 3, '0') field_code,
               d.value field_value,
               'Part 2' description,
               null acc_id,
               null acc_num,
               d.kv,
               null maturity_date,
               null cust_id,
               null ref,
               NULL nd,
               null branch
         from (select *
           from (
             select report_date, kf, kv,
                    lpad((dense_rank() over (order by kv)), 3, '0') nnn,
                    p10, to_char(p20) p20, p31, p35, p40, p62, p99
             from (select o.report_date, o.kf, o.kv, 
                          LPAD (o.kv, 3, '0') p10,
                          sum(NVL(round(z.s2 / l_koef, 0), 0)) p20,
                            '0'         p31,
                            '1'         p35,
                            '36'        p40,
                            '804'       p62,
                            '���� �� ������ ����"�������� �������' p99
                     from NBUR_DM_TRANSACTIONS o
                        left outer join  zayavka z
                        on (o.ref = refoper and
                            z.dk = 2 and 
                            z.obz = 1)
                     where o.report_date = p_report_date
                       and o.R020_CR = '2603' 
                       and o.kv <> 980
                    group by o.report_date, o.kf, o.kv, 
                          LPAD (o.kv, 3, '0'))
             where p20<>0)
          UNPIVOT (VALUE FOR colname IN  (p10, p20, p31, p35, p40, p62, p99))) d;   
    EXCEPTION
       WHEN OTHERS
       THEN
          logger.info (
                'NBUR_P_FC9 error: '
             || SQLERRM
             || ' for date = '
             || TO_CHAR (p_report_date, 'dd.mm.yyyy'));
    END;                
                
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
              (case when field_code like '20%' then 
                to_char(round(field_value/100, 0)) else field_value end)
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
            

    logger.info ('NBUR_P_FC9 end for date = '||to_char(p_report_date, 'dd.mm.yyyy'));

END;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_FC9.sql =========*** End **
PROMPT ===================================================================================== 
