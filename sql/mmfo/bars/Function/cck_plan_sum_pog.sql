
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/cck_plan_sum_pog.sql =========*** R
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.CCK_PLAN_SUM_POG /*  ��� ��������� ��� �� �� */
 ( P_ND  IN  NUMBER, P_KV IN number,P_VID IN number,P_OSTX IN NUMBER, P_CC_PAY_S  IN number ) return number
  IS
   --ver 8  16/07/2013

  -- P_ND     - ����� ��������
  -- P_KV     - ������
  -- P_VID    - ��� ������� 4 - �������
  -- P_CC_PAY_S - -- 0 - ������� ����� ��������� ���������� ���  ��������� �����������
                  --     ������� ����� ��� ����� ������� ������
                  -- 1 - ������� ����� ��������� � ������ ��� ���������� ����� ��
                  --     ��������� ���������

  -- ���������� �������� ������ �� ����

  -- CC_PAY_S int:= NVL( GetGlobalOption('CC_PAY_S'),'0');
  -- ������������ �������� �� ��� ��� ������ ������ � ���-�� CC_PAY_S=1 ����� ������������ ��
  -- �� ����� � ��������� � ����� ��������� ������� ��� ���������� ���-��� �� ��������� ���������
  -- ����������
  del_SK4       number:=0   ; -- ������ ���������� ��������� (��� �������������� ������ CCK_PAY_S=1)

  -- ������ ������� cc_lim ������ � �������� ��� ������
  -- ������ � ���
 type t_lim  is record
  (
  ND        NUMBER(10),
  FDAT      DATE,
  LIM2      NUMBER(38,2),
  ACC       INTEGER,
  NOT_9129  INTEGER,
  SUMG      NUMBER(38,2),
  SUMO      NUMBER(38,2),
  OTM       INTEGER,
  KF        VARCHAR2(6 BYTE),
  SUMK      NUMBER (38,2),
  NOT_SN    INTEGER
  );

  rLim t_lim; -- ������ ��� �� ������ ��������� ������
  nSS_ number;

  --  DAT_SN1_ date := gl.bdate-1;
  --  DAT_SK1_ date := gl.bdate-1;
  --  DAT_och date ;
  --  l_ost   int;

begin

     logger.trace ('CCK_PLAN_SUM_POG: Start ND='||to_char(P_ND)||' KV='||to_char(P_KV)||' VID='||to_char(P_VID)||' X_OST='||to_char(P_OSTX)||' CC_PAY_S='||to_char(P_CC_PAY_S));
       dbms_output.put_line ('Start');

  -- ������� �� ��������
 begin
  SELECT Nvl(-SUM(a.ostb+a.ostf),0)/100
    INTO  nSS_
    FROM accounts a, nd_acc n
   WHERE n.nd=P_ND and n.acc=a.acc and a.tip in ('SS ','SP ','SL ')
         and a.kv=980;
 exception when no_data_found then
  dbms_output.put_line ('SS='||nSS_);
  return 0;
  nSS_:=0;
 end;

 logger.trace('CCK_PLAN_SUM_POG: �������� ������� �� �� nSS='||TO_CHAR(nSS_));

 begin
  -- 3)��������� ������
   select      fdat, lim2/100, sumg/100, nvl(sumk/100,0), sumo/100
     into rLim.fdat,rLim.lim2,rLim.SUMg,rLim.SUMk       ,rLim.SUMo
     from cc_lim l
    where l.nd=P_ND and (l.nd,l.fdat)=
          (select nd,min(fdat) from cc_lim
           where nd=P_ND and fdat >= gl.BDATE and sumg>0
           group by nd
          );

   logger.trace ('CCK_PLAN_SUM_POG: ������ ��������� � ������ fdat='||to_char(rLim.fdat,'dd/mm/yyyy')||' SUMo='||rLim.SUMo||' SUMg='||rLim.SUMg||' rLim.SUMk='||rLim.SUMk);

  --  ������� ����� ��� ������� "��������� ������" �������
  --  �� ������������ ��������� ���� �������

  -- ��� ���� ������ ��������� ������ ��� �� �������� -  ����� UPB
  if rLim.fdat>add_months(cck_app.CorrectDate2(980,gl.bd,0),1)   -- or   ( rLim.fdat>last_day(gl.bd))
                            then
     Logger.trace ('CCK_PLAN_SUM_POG: ��������� ������ ��� �� ��������');
     rLim.LIM2:=abs(P_OSTX/100);
     rLim.SUMo:=0;
     rLim.sumg:=0;
     rLim.SUMk:=0;
  end if;


 EXCEPTION  WHEN NO_DATA_FOUND THEN
     rLim.Lim2:=abs(P_OSTX/100);
     rLim.SUMo:=0; rLim.SUMg:=0; rLim.SUMk:=0;
 end;

  -- ������ ������ ��������� ��� �������������� ������
  if P_CC_PAY_S in (1,-1) or P_VID=4 then
   begin

     -- ��������� �� �� �� ��� �����
     SELECT greatest(Nvl(SUM(s.KOS),0)-Nvl(SUM(decode(a.tip,'SP ',s.DOS,0)),0)- Nvl(SUM(decode(a.tip,'SP ',s.KOS,0)),0) ,0)/100
       INTO  Del_SK4
       FROM accounts a, nd_acc n,saldoa s
      WHERE n.nd=P_ND and n.acc=a.acc and a.tip in ('SS ','SP')
            and a.kv=P_KV and s.acc=a.acc
            and s.fdat>(select max(fdat) from cc_lim
                         where nd=P_ND and fdat < gl.BDATE and sumg>0
                       );


  --   Del_SK4:=greatest(l_limit-nSS1_- Del_SK4,0);
  --   Del_SK4:=greatest(nvl(Del_SK4,0),0);  -- ������ ������� � ������ ���������
  --   ���� ��������         �������� - ��� ������
   /*
   if rLim.LIM2+rLim.Sumg-nSS_>0 then
      -- if rLim.LIM2+rLim.Sumg-nSS_<=DEL_SK4 then
       if rLim.LIM2-nSS_>=DEL_SK4-rLim.Sumg then
          DEL_SK4:=rLim.Sumg;
       else
          DEL_SK4:=rLim.Sumg-least(rLim.LIM2-nSS_,DEL_SK4);
       end if;
   else
      DEL_SK4:=0;
   end if;
   */
      --���������� ��� ����� �� ��� ����� ����� = ����� ��� ������� - ������������ ������ �� ���
      -- ������� ��������� ������� ��� ��� ������ ��� ������
     DEL_SK4:=greatest(least(rLim.Sumg,DEL_SK4)-greatest(nSS_-rLim.LIM2,0),0);


     Logger.trace ('CCK_PLAN_SUM_POG: ������ ��������� Del_SK4='||to_char(Del_SK4));
   exception when no_data_found then
     Del_SK4:=0;
     Logger.trace ('CCK_PLAN_SUM_POG: ������ ��������� exception Del_SK4='||to_char(Del_SK4));
   end;
  end if;




  -- ������ �� ���� �������

  --If rLim.fdat is not null then
    If P_VID=4 or P_CC_PAY_S=1 then   -- ��� ������� � ��������� �� ���������� ��� ������
          nSS_:= greatest(nSS_-rLim.LIM2,least( rLim.SUMg-Del_SK4,nSS_),0) ; --��� �������
    else
          nSS_:= greatest(nSS_-rLim.LIM2,0); --� ����������
    end if;
  -- else

  -------------end if;




return nSS_*100;
END CCK_PLAN_SUM_POG ;
/
 show err;
 
PROMPT *** Create  grants  CCK_PLAN_SUM_POG ***
grant EXECUTE                                                                on CCK_PLAN_SUM_POG to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on CCK_PLAN_SUM_POG to RCC_DEAL;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/cck_plan_sum_pog.sql =========*** E
 PROMPT ===================================================================================== 
 