

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_EBKC_PRIVATE_ENT_REL.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_EBKC_PRIVATE_ENT_REL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_EBKC_PRIVATE_ENT_REL ("KF", "RNK", "REL_RNK", "NAME", "K014", "K040", "REGIONCODE", "K110", "K051", "K070", "OKPO", "ISOKPOEXCLUSION", "TELEPHONE", "EMAIL", "K080", "ADDRESS", "DOCTYPE", "DOCSER", "DOCNUMBER", "DOCISSUEDATE", "DOCORGAN", "ACTUALDATE", "EDDRID", "BIRTHDAY", "BIRTHPLACE", "SEX", "NOTES", "RELSIGN") AS 
  select c.kf,                                                  --��� �� (��� ���)
       case
         when ( EBK_PARAMS.IS_CUT_RNK = 1 )
         then trunc(c.RNK/100)
         else c.RNK
       end as RNK,                                                  -- �����. �
       decode(r.rel_intext, 1, r.rel_rnk, to_number(null))
         as rel_rnk,                                       --��� �������� �����
       r.name,                                   --����� ��� ϲ� �������� �����
       r.custtype as k014,                                  --��� �볺��� (�014)
       to_char(r.country) as k040,                       --����� �볺��� (�040)
       r.region as regionCode,                          --��� ������
       r.ved   as k110,                               --��� ��. ��������(�110)
       r.sed   as k051,                            --����� �������������� (�051)
       r.ise   as k070,                          --����. ������ �������� (�070)
       r.okpo,                                      --�����. ��� / ��� �� ������
       (SELECT cw.VALUE FROM customerw cw
        WHERE cw.tag = 'EOKPO' AND r.rel_rnk = cw.rnk)
        as isOkpoExclusion,                 --������ ���������� �����. ���
       r.tel  as telephone,                                            --�������
       r.email,                                                         --e-mail
       r.fs   as k080,                                  --����� �������� (K080)
       r.adr  as address,                                               --������
       r.doc_type   as docType,                                  --��� ���������
       r.doc_serial as docSer,                                 --���� ���������
       r.doc_number as docNumber,                              --����� ���������
       r.doc_date   as docIssueDate,                     --���� ������ ���������
       r.doc_issuer as docOrgan,                        --̳��� ������ ���������
       (select actual_date from person p1 where p1.rnk=r.rel_rnk)
         as actualDate,                                            --ĳ����� ��
       (select eddr_id from person p1 where p1.rnk=r.rel_rnk)
         as eddrId,                              --��������� ����� ������ ����
       r.birthday,                                             --���� ����������
       r.birthplace,                                          --̳��� ����������
       r.sex,                                                            --�����
       '' as notes,                                        --�������� (�������)
       r.rel_id as relSign                                 --������ ����������
 from CUSTOMER c
    , PERSON   p
    , V_CUSTOMER_REL r
where c.custtype = 3
  and c.sed = '91'
  and c.rnk = r.rnk
  and c.rnk = p.rnk;

PROMPT *** Create  grants  V_EBKC_PRIVATE_ENT_REL ***
grant SELECT                                                                 on V_EBKC_PRIVATE_ENT_REL to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_EBKC_PRIVATE_ENT_REL.sql =========***
PROMPT ===================================================================================== 
