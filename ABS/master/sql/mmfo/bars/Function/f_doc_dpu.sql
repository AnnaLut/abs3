
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_doc_dpu.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_DOC_DPU (dpu_ dpu_deal.dpu_id%type , PR_ NUMBER, NUM_ NUMBER DEFAULT NULL ) RETURN VARCHAR2
IS
STR_    VARCHAR2(250);
---������� ��� ���������� ������ ��������(�������� ��.�)
BEGIN
STR_:='__';
--PR_=1 - ������ �������� ��������, ����������� ��� ������� dpt_deposit.dat_end-dpt_deposit.dat_begin.(NUM_=1- �����,NUM_=2- ��������)
--PR_=2 - ̳�������� ����� ��������� ����� ���� ������ �������� "�������"(NUM_=1- �����,NUM_=2- ��������)
------- 3�.  - 10�.
------- 6�.  - 30�.
------- 9�.  - 60�.
------- 15�. - 100�.
--PR=3 - ������� �����������
--PR=4 - ³�������� ������ ������ ��� ������ "���������������"
 IF PR_ = 1  AND NUM_ = 1 THEN
-- PR_ = 1 ������ �������� ��������, ����������� ��� ������� dpt_deposit.dat_end-dpt_deposit.dat_begin.(NUM_=1- �����,NUM_=2- ��������)
  BEGIN 
  SELECT -- to_date(dat_begin, 'dd.mm.yyyy') d1, to_date(dat_end, 'dd.mm.yyyy') d2,
         decode(nvl(months_between (to_date(dat_end, 'dd.mm.yyyy'), to_date(dat_begin, 'dd.mm.yyyy')),0), 0,'',
                    to_char(trunc(months_between (to_date(dat_end, 'dd.mm.yyyy'), to_date(dat_begin, 'dd.mm.yyyy')),0))||' ��. ' )||
         -- add_months(to_date(dat_begin, 'dd.mm.yyyy'),trunc(months_between (to_date(dat_end, 'dd.mm.yyyy'), to_date(dat_begin, 'dd.mm.yyyy')),0)) d3,
         decode(nvl(to_date(dat_end,'dd.mm.yyyy')-add_months(to_date(dat_begin, 'dd.mm.yyyy'),
                    trunc(months_between(to_date(dat_end, 'dd.mm.yyyy'),to_date(dat_begin, 'dd.mm.yyyy')),0)),0),0,'',
                to_char(to_date(dat_end, 'dd.mm.yyyy')-add_months(to_date(dat_begin, 'dd.mm.yyyy'),
                trunc(months_between (to_date(dat_end, 'dd.mm.yyyy'), to_date(dat_begin, 'dd.mm.yyyy')),0) )||' ��. '))
     INTO STR_
     FROM dpu_deal 
    WHERE dpu_id=dpu_;
    EXCEPTION WHEN NO_DATA_FOUND THEN STR_:='__';
  END;    
 ELSIF PR_ = 1  AND NUM_ = 2 THEN
  BEGIN 
   SELECT-- to_date(dat_begin, 'dd.mm.yyyy') d1, to_date(dat_end, 'dd.mm.yyyy') d2,
         decode(nvl(months_between (to_date(dat_end, 'dd.mm.yyyy'), to_date(dat_begin, 'dd.mm.yyyy')),0), 0,'',
                f_sumpr(to_char(trunc(months_between (to_date(dat_end, 'dd.mm.yyyy'), to_date(dat_begin, 'dd.mm.yyyy')),0)), null,'M')||' ��. ' )||
         -- add_months(to_date(dat_begin, 'dd.mm.yyyy'),trunc(months_between (to_date(dat_end, 'dd.mm.yyyy'), to_date(dat_begin, 'dd.mm.yyyy')),0)) d3,
         decode(nvl(to_date(dat_end,'dd.mm.yyyy')-add_months(to_date(dat_begin, 'dd.mm.yyyy'),
                    trunc(months_between(to_date(dat_end, 'dd.mm.yyyy'),to_date(dat_begin, 'dd.mm.yyyy')),0)),0),0,'',
                f_sumpr(to_char(to_date(dat_end, 'dd.mm.yyyy')-add_months(to_date(dat_begin, 'dd.mm.yyyy'),
                trunc(months_between (to_date(dat_end, 'dd.mm.yyyy'), to_date(dat_begin, 'dd.mm.yyyy')),0) )), null,'M')||' ��. ')
     INTO STR_
     FROM dpu_deal 
    WHERE dpu_id=dpu_;
    EXCEPTION WHEN NO_DATA_FOUND THEN STR_:='__';
  END;    
 ELSIF PR_ = 2  AND NUM_ = 1 THEN
 --PR_=2 - ������ ���������� �������� "�������"(NUM_=1- �����,NUM_=2- ��������)
  BEGIN 
   SELECT to_char(decode( months_between (to_date(dat_end, 'dd.mm.yyyy'), to_date(dat_begin, 'dd.mm.yyyy')),
                    3, 10, 
                    6, 30,
                    9, 60,
                    15, 100, 0 ))
     INTO STR_                     
     FROM dpu_deal 
    WHERE dpu_id= dpu_;
    EXCEPTION WHEN NO_DATA_FOUND THEN STR_:='__';
  END;    
 ELSIF PR_ = 2  AND NUM_ = 2 THEN
   BEGIN 
   SELECT f_sumpr(to_char(decode( months_between (to_date(dat_end, 'dd.mm.yyyy'), to_date(dat_begin, 'dd.mm.yyyy')),
                    3, 10, 
                    6, 30,
                    9, 60,
                    15, 100, 0 )), null,'M')
     INTO STR_                     
     FROM dpu_deal 
    WHERE dpu_id= dpu_;
    EXCEPTION WHEN NO_DATA_FOUND THEN STR_:='__';
  END;
  ELSIF PR_ = 3 THEN
   BEGIN 
    SELECT DECODE (comproc,1,'����������� �� ���� �������� �������� �� ���� �.1.1. ������� 
                              �� ���� �������� �������� ����� �� ����� �������� � ����� ��� ����������� 
                              �������� �� ��������� �����;',
                           0,'�� ���� �������� �� �����������, �� �� ����� ___ �������� ��� ���������� 
                              ����� ��������������� �� �������� ������� �볺��� ���������� � � 4.1.4 ����� ��������.' ,
                           '' )
     INTO STR_                     
     FROM dpu_deal 
    WHERE dpu_id= dpu_;
    EXCEPTION WHEN NO_DATA_FOUND THEN STR_:='__';
  END;
  ELSIF PR_ = 4  AND NUM_ = 1 THEN
  BEGIN 
   SELECT trim(to_char(IIF_N(12,months_between(to_date(d.dat_end,'dd.mm.yyyy'),
                                          to_date(d.dat_begin, 'dd.mm.yyyy')),
                           to_char(v.proc*0.9),
                           to_char(v.proc*0.5),
                           to_char(v.proc*0.5))))
     INTO STR_                     
     FROM dpt_u v,dpu_deal d
    WHERE d.dpu_id= dpu_ AND d.dpu_id=v.dpu_id;
  END;
  ELSIF PR_ = 4  AND NUM_ = 2 THEN
  BEGIN 
   SELECT trim(f_sumpr(IIF_N(12,months_between(to_date(d.dat_end,'dd.mm.yyyy'),
                                          to_date(d.dat_begin, 'dd.mm.yyyy')),
                           to_char(v.proc*0.9),
                           to_char(v.proc*0.5),
                           to_char(v.proc*0.5))
                  , null,'M'))
     INTO STR_                     
     FROM dpt_u v,dpu_deal d
    WHERE d.dpu_id= dpu_ AND d.dpu_id=v.dpu_id;
  END;  
  END IF; 
   
  RETURN  STR_;
END; 
 
/
 show err;
 
PROMPT *** Create  grants  F_DOC_DPU ***
grant EXECUTE                                                                on F_DOC_DPU       to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_doc_dpu.sql =========*** End *** 
 PROMPT ===================================================================================== 
 