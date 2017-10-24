

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/CC_CLOSE.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure CC_CLOSE ***

  CREATE OR REPLACE PROCEDURE BARS.CC_CLOSE (custtype_ int,dat_ date) is   err_    varchar2(1024);
  --���������-�������� � ����-��������
begin
 for k in (select nd,cc_id from cc_deal where sos>=10 and sos<15 and wdate<dat_ and
             ( (custtype_=2 and vidd in (1,2,3)) or (custtype_=3 and vidd in (11,12,13)) or (custtype_=0 and vidd in (1,2,3,11,12,13)))
          )
 loop
   cck.cc_close(k.nd,err_); -- � ��������� cck.cc_close ������� ��������������� ������� �� "����������"
   if trim(err_) is null then  INSERT INTO cc_sob (ND,FDAT,ISP,TXT,otm) values (k.ND,gl.bDATE,gl.aUID,'������� ������.' ,6);  end if;
 end loop;

 -- ���� ������ CCK ��� �� ����������, �� ��� ��������
 for k in (select a.acc
           from accounts a, nd_acc n, nd_txt t
           where a.tip like '%SG%' and a.dazs is not null and a.acc = n.acc
             AND N.ND = T.ND AND T.TAG =  'MGR_T')
 LOOP update accounts set dazs = null where acc = k.acc; end loop;

end;
/
show err;

PROMPT *** Create  grants  CC_CLOSE ***
grant EXECUTE                                                                on CC_CLOSE        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on CC_CLOSE        to RCC_DEAL;
grant EXECUTE                                                                on CC_CLOSE        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/CC_CLOSE.sql =========*** End *** 
PROMPT ===================================================================================== 
