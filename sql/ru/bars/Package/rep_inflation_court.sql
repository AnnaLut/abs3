 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/rep_inflation_court.sql =========***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE rep_inflation_court AS

    -- ���������� ������� �� ����� �� ���� �� ������ ������  V_INFLATION_SALDOA
function fost(p_acc integer, p_date date) return number ;

-- ������ ������� F_IND_INFL_ex ���������� ������� �.�. ������  ������ ������� ���������� ��� ���� ��������, � �� ����� * �� ����
FUNCTION �_IND_INFL ( p_DAT0 date ,  p_DATi date ) RETURN number;

 -- ���������� ����������� ����� �� �������
 -- P_ACC - ��� ������� ����������
 -- P_DAT_BEGIN - ���� � ��� ����������� ����������
 -- P_DAT_END -  ���� ������ � ���

  PROCEDURE inflation_acc(P_ACC IN NUMBER, P_DAT_BEGIN IN DATE ,P_DAT_END IN DATE);


 -- ���������� ����� ��������� inflation_acc
 PROCEDURE inflation_nls(P_NLS IN VARCHAR2,P_KV IN  NUMBER, P_DAT_BEGIN IN DATE,P_DAT_END IN DATE);


 --������ �� ��������
  PROCEDURE inflation_nd(P_ND IN NUMBER, P_DAT_BEGIN IN DATE,P_DAT_END IN DATE, P_TYP_KOD IN NUMBER DEFAULT 1);
END rep_inflation_court;
/
CREATE OR REPLACE PACKAGE BODY rep_inflation_court AS
/******************************************************************************
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        21.05.2014      dav+nov        1. Created this package body.
   2.0        10.10.2014      dav+nov        �������� ������ ��� ��� � ������ �������� ����� ������������� V_INFLATION_SALDOA
                                             ������� ��������� ���������/�������� ������� ������������ saldoa   (saldoa �� ��������!!! )
   2.1        26.11.2014                     - ���������� ���������� ����� ������ ��������� �� ������� ���������� �����
                                             - ���������� ��� �� ������ �����
  2.2                                        add function fost
******************************************************************************/


--
function fost(p_acc integer, p_date date) return number
    -- ���������� ������� �� ����� �� ���� �� ������ ������  V_INFLATION_SALDOA
    --
    -- ���� ����� ���� �����, ���������� ���� �����������
    --
is
    l_ostc   number;
begin
    -- ������� ������� ������� � ���� ���������� �������� (ostf - �������������)
  SELECT s.ostf+s.dos-s.kos INTO l_ostc from V_INFLATION_SALDOA s
   WHERE s.acc=p_acc
    AND (s.acc,s.FDAT) =
        (select acc,max(fdat) from V_INFLATION_SALDOA
         where acc=p_acc and fdat<=p_date group by acc) ;

      return l_ostc;
   exception when no_data_found then
    return 0;

end fost;

-- ������ ������� F_IND_INFL_ex ���������� ������� �.�. ������  ������ ������� ���������� ��� ���� ��������, � �� ����� * �� ����
FUNCTION �_IND_INFL
( p_DAT0 date , -- ���� ��������� ����������� �����
  p_DATi date   -- �������� ���� ��� ��������� ��������� "�������������" �����
) RETURN number IS

  l_DAT0  date;
  l_DATi  date;
  i_      int ;
  l_Si  number;
  l_ir  number;

begin

  l_DAT0 := round (      p_DAT0                                    , 'MM' ) ;
  l_DATi := round ( nvl (p_DATi, nvl(gl.BDATE , trunc(sysdate) ) ) , 'MM' ) ;

  -- -- ��� ���-��� �� ����������� ��� ���������� ��������� 01.01.2014 � ���������� 31.01.2014
  if trunc(p_DAT0,'MM')<trunc(nvl (p_DATi, nvl(gl.BDATE , trunc(sysdate) ) ),'MM') then
     i_    := months_between  (l_DATi, l_DAT0);
  else
    i_    := 0;
  end if;

  l_Si  := 1;

  If I_ <= 0 then return l_Si; end if;
  ------------------------------------
  for k in (select add_months(l_DAT0,c.num-1) FDAT  from conductor c where c.num <= i_ order by c.num )
  loop
     begin
       select IR into l_Ir from IND_INFL where IDAT = k.FDAT;
     exception when no_data_found then l_IR := 100 ;
     end;
     l_Si :=  l_Si * l_IR/100;
  end loop;

  RETURN l_Si ;

end �_IND_INFL;



  PROCEDURE inflation_acc(P_ACC IN NUMBER, P_DAT_BEGIN IN DATE ,P_DAT_END IN DATE) IS
    l_ost number;
    l_dat_end date;
    l_kos number;
     str_inf tmp_inflation_court%rowtype;
     l_k number;

     l_count number:=0;
     l_err number;

  BEGIN
  -- �������� ���� ������� ���� �������� � ��� ��� ���� ������������� �� ���� ������������� ���������� �� ���� ������ � ��� ��� �� ���� ��������� ������ �������������

  -- �������� ��������� ������� �� �����

  if P_DAT_BEGIN is null then
     RAISE_APPLICATION_ERROR (-20999,'�� ������� ���� ������� ������ P_DAT_BEGIN');
  end if;


  delete from  tmp_inflation_court where acc=P_ACC;
  -- ������������ ��� ������� �� ���� P_DAT_END ����������
  --,����� ��� ��������� ��������
   l_dat_end:=P_DAT_END; -- ���� ��������� (��������� ����������)
   -- V_INFLATION_SALDOA -    ������ �������������  ������������ ����� ���������� "saldoa" ��� ������� ���� �����
   --                         � ���������� ��� � � ��� (�� ���� � �������) � ������� �� saldoa ������� �������� �������� �� 100



select count(*)  into l_count
                from V_INFLATION_SALDOA s
                where acc=P_ACC and fdat>=P_DAT_BEGIN and fdat<=nvl(to_date(P_DAT_END,'dd.mm.yy'),trunc(sysdate)) ;

                      dbms_output.put_line ('l_count='||l_count);
   --------------------------------------------- DOS------------------------------------------------------------------------------------------------
   -- ���� �� �������� �� ����������
   for i in (select rownum rn, fdat,ostf,dos from
               (select   s.ostf*100 ostf,
                         s.fdat,
                         s.dos*100  dos
                from V_INFLATION_SALDOA s
                where acc=P_ACC and fdat>=P_DAT_BEGIN and fdat<=nvl(to_date(P_DAT_END,'dd.mm.yy'),trunc(sysdate))
                order by fdat
               )
            )
   loop
            -- dbms_output.put_line ('ACC= '||to_char(P_ACC)||' '||to_char(i.fdat,'dd/mm/yyyy'));
      -- ������� ������� ������ �� ����������
      -- ����������� ����� ���������   ���� ���������� P_DAT_END �������� ���� ���������
      -- DAT_BEG_K ��������� �� ��������� ���� , � �� �� ������ �� ����������.
     if i.rn=1  then
         -- ��������� ������ ������  ������ � ���� ������ ������� ������
         -- ��� ������� ����� ������ ���������� �� �� ���� ������������� ���������� � ������� �� ���� ���� ���.
        l_ost:=abs(rep_inflation_court.fost(P_ACC,P_DAT_BEGIN))*100;
        if l_ost>0 then
           insert into tmp_inflation_court (ND , ACC   , FDAT_BEG    , DAT_BEG_K                        ,  FDAT_END,           DAT_END_K  , S_nom , S    , S_K, K, COMM)
                                    values (null,P_ACC , P_DAT_BEGIN , round(dat_next_u(P_DAT_BEGIN,-1),'MM'), to_date(l_dat_end,'dd.mm.yy'), round(l_dat_end,'MM'), l_ost , l_ost, null, 1, null);
        end if;
     end if;

     if i.dos>0 and P_DAT_BEGIN<i.fdat then
        insert into tmp_inflation_court (ND , ACC   , FDAT_BEG, DAT_BEG_K                        ,  FDAT_END,           DAT_END_K  , S_nom , S    , S_K , K, COMM)
                                 values (null,P_ACC , i.fdat  , round(dat_next_u(i.fdat,-1),'MM'), to_date(l_dat_end,'dd.mm.yy'), round(l_dat_end,'MM'), i.dos ,i.dos , null, 1, null);
     end if;


   end loop;
   commit;

--RAISE_APPLICATION_ERROR(-20111,'dddd');

 --------------------------------------------- KOS ------------------------------------------------------------------------------------------------
 -- ���� �� ���������    (P_DAT_BEGIN ����� ��������� ��� ���� ��� ���������� DOS)
   for i in (select ACC, FDAT, OSTF*100 OSTF, DOS*100 DOS, KOS*100 KOS
              from V_INFLATION_SALDOA
             where acc=P_ACC and fdat>P_DAT_BEGIN and fdat<=nvl(to_date(P_DAT_END,'dd.mm.yy'),trunc(sysdate))   and kos>0
             order by fdat
            )
   loop
    l_kos:=i.kos; -- ����� ���������� ��������
    l_count:=0;
        -- ���� ������ ���  ������ ��� ������� ��� ���������� ��� ��������
        while l_kos>0
        loop
                  l_count:=l_count+1;                     if l_count>500 then      RAISE_APPLICATION_ERROR (-20999,'������ ���� !!!'); end if; -- ������ �� ������� ����� �� ������  ������

          -- ���� ������ � ������� ���� ��� �� ���������� ����� ����� (� ������� fdat_end- ���� ���������� ������� ���� ����������� �� ���� ������� �������� � ����� DOS)
          select * into str_inf from tmp_inflation_court where acc=P_ACC and  fdat_end=l_dat_end and fdat_beg=(select min(fdat_beg) from tmp_inflation_court where acc=P_ACC and FDAT_END=l_dat_end);
          DBMS_OUTPUT.PUT_LINE('KOS ACC= '||to_char(P_ACC)||' '||to_char(i.fdat,'dd/mm/yyyy')||' S='||str_inf.s||'  l_kos='||l_kos);
          --logger.info ('ACC= '||to_char(P_ACC)||' '||to_char(i.fdat,'dd/mm/yyyy')||' S='||str_inf.s);
         -- ���� ������� ������ ��� ����� ���������� ������ ����������� ���� ��������� ������� + ��������� ����� KOS-a
         if l_kos>=str_inf.s then
           update tmp_inflation_court set FDAT_END=i.fdat, DAT_END_K=round(  i.fdat,'MM')  where acc=P_ACC  and fdat_beg=str_inf.fdat_beg  and FDAT_END=l_dat_end returning count(acc) into l_err;

                      if l_err >1 then  rollback; RAISE_APPLICATION_ERROR (-20999,'Update ������� ��������� ������ ACC= '||to_char(P_ACC)||' '||l_err||' '||to_char(i.fdat,'dd/mm/yyyy')); end if;

           l_kos:=l_kos-str_inf.s;
         else --commit;
         -- ���� ����� ��������� �� �������
         -- �� ������� ������ ������� ������� �����-��� ����� ('��� ������ ��������� ��������������)
           update tmp_inflation_court set S=str_inf.s-l_kos  where acc=P_ACC and fdat_beg=str_inf.fdat_beg and FDAT_END=l_dat_end returning count(acc) into l_err;
                            if l_err >1 then  RAISE_APPLICATION_ERROR (-20999,'ACC= '||to_char(P_ACC)||' '||l_err||' '||to_char(i.fdat,'dd/mm/yyyy')); end if;
           -- ������� ����� �����  (���������� ������ ���������� � ���� ��������� ������)
           insert into tmp_inflation_court (ND, ACC   , FDAT_beg       ,  DAT_BEG_K       , FDAT_END,        DAT_END_K ,        S_nom   ,    S   ,   S_K,       K,           COMM)
                                              values (null,P_ACC, str_inf.fdat_beg, str_inf.dat_beg_k, i.fdat         ,round(  i.fdat,'MM'), str_inf.s_nom, l_kos, l_kos,  1 , str_inf.comm );
           l_kos:=0;
         end if;
        end loop;
    end loop;

    update tmp_inflation_court
       set k=round(�_IND_INFL(  dat_next_u(FDAT_beg,-1), FDAT_END ),3)-- ��������� ��� ���� � 1 ������ ����� �������
     where acc=P_ACC and fdat_beg>=P_DAT_BEGIN and fdat_beg<=nvl(to_date(P_DAT_END,'dd.mm.yy'),trunc(sysdate));

    update tmp_inflation_court
       set S_K=S*k,
           S3=round((fdat_end-fdat_beg+1)*S*3/ (100*365),4)
     where acc=P_ACC and fdat_beg>=P_DAT_BEGIN and fdat_beg<=nvl(to_date(P_DAT_END,'dd.mm.yy'),trunc(sysdate));

    commit;
  END;



--  ����������� ������� �� �����
 PROCEDURE inflation_nls(P_NLS IN VARCHAR2,P_KV IN  NUMBER,  P_DAT_BEGIN IN DATE,P_DAT_END IN DATE) is
 l_acc number;
 begin


  select acc into l_acc from accounts where nls=P_NLS and kv=nvl(P_KV,980);
   inflation_acc(l_acc,to_date(P_DAT_BEGIN,'dd/mm/yyyy'),to_date(P_DAT_END,'dd/mm/yyyy'));


 end;

  -- ����������� ������� �� ��������  (�� ���� ������ ��������)
  PROCEDURE inflation_nd(P_ND IN  NUMBER,  P_DAT_BEGIN IN DATE,P_DAT_END IN DATE, P_TYP_KOD IN NUMBER DEFAULT 1) is
 l_acc number;
 date_prior date;
 l_on number:=0;
 begin

  if P_TYP_KOD is null or P_TYP_KOD not in (0,1,2) then
     RAISE_APPLICATION_ERROR (-20999,'��� �������� ������ �� ���� TYP='||nvl(to_char(P_TYP_KOD),'null')||' (������� ���� 1-������ 2-��� 0-���)');
  end if;
   -- ��������� ���-�� ��� (���) �����
  if  P_TYP_KOD=0    then select count(acc) into l_on from accounts where acc=P_ND;
  elsif P_TYP_KOD=1  then select count(nd)  into l_on from cc_deal  where nd=P_ND;
  elsif P_TYP_KOD=2  then select count(nd)  into l_on from w4_acc   where nd=P_ND;
  end if;

  if l_on<1 then
     RAISE_APPLICATION_ERROR (-20999, (case when P_TYP_KOD=1 then '��������� ������' when P_TYP_KOD=2 then '������ ���' else '������� ��� = ' end)||to_char(P_ND)||' �� �������.');
  end if ;

    -- ��� ������� ����� �� �� ����� ������� ���� ����� �������
     if P_TYP_KOD in (1,2) then
        update  tmp_inflation_court set nd=null where nd=P_ND and typ_kod=P_TYP_KOD;
     end if;


       -- �������� ����� �� ������� ���������� ���������� ������
    for nd in (select a.acc, to_number(substr(cck_app.get_nd_txt(n.nd,'FLAGS'),2,1)) flg, d.sdate, a.tip
                     from  cc_deal d,nd_acc n, accounts a
                   where  d.nd=n.nd and n.acc=a.acc and a.tip in ('SP ','SPN' ) and n.nd=P_ND and P_TYP_KOD=1
               union all
               select a.acc, 99 flg,d.dat_begin sdate, 'SP '
                 from  w4_acc d, accounts a
               where  d.nd=P_ND and d.acc_2207=a.acc and P_TYP_KOD=2
               union all
               select a.acc, 99 flg,d.dat_begin sdate, 'SPN'
                 from  w4_acc d, accounts a
                where  d.nd=P_ND and d.acc_2209=a.acc and P_TYP_KOD=2
                union all
               select a.acc, 0 flg, a.daos sdate, (case when a.nbs like '2__7' then 'SP ' else 'SPN' end) tip
                 from  accounts a
                where  a.acc=P_ND and P_TYP_KOD=0
              )
     loop
      date_prior:=null;
        -- ���������� ������
       inflation_acc(nd.acc,to_date(P_DAT_BEGIN,'dd/mm/yyyy'),to_date(P_DAT_END,'dd/mm/yyyy'));

       -- ����������� ��� ��������
       update tmp_inflation_court set nd=P_ND, typ_kod=P_TYP_KOD where acc=nd.acc;
       commit;
       -- ����������� ���� ���������� � ����������� �� ���� ���������� (����� ����/�����)

        if nd.flg=0 and nd.tip='SPN' then -- ����
          for k in (select distinct  fdat_beg  from tmp_inflation_court where acc=nd.acc order by fdat_beg)
          loop
          -- �� ������� ����
              if date_prior is null then
                 date_prior:=greatest(add_months(dat_next_u (k.fdat_beg,-2),-1), nd.sdate);
              end if;

               update tmp_inflation_court set dat_irr=to_char(date_prior,'dd/mm/yyyy')||' - ' ||to_char(dat_next_u (k.fdat_beg,-2),'dd/mm/yyyy') where acc=nd.acc and fdat_beg=k.fdat_beg;
                date_prior:=dat_next_u (k.fdat_beg,-2)+1 ;
          end loop;
         elsif   nd.flg=99 and nd.tip='SPN'   then -- ������� ����� ����� �� ��� (�� �� 25 ������, �  �� � ����� ������) ���� ������� �������� � 25 ����� �� ������
          for k in (select distinct fdat_beg from tmp_inflation_court where acc=nd.acc order by fdat_beg)
          loop

                   -- �� ������� �����
              if date_prior is null then
                 date_prior:=greatest(add_months(dat_next_u (k.fdat_beg,-1),-2), nd.sdate);
              end if;
                            --    RAISE_APPLICATION_ERROR (-20999,date_prior);
               update tmp_inflation_court set dat_irr=to_char(date_prior,'dd/mm/yyyy')||' - ' ||to_char(  add_months(dat_next_u (k.fdat_beg,-1),-1)    ,'dd/mm/yyyy')  where acc=nd.acc and fdat_beg=k.fdat_beg;
               --update tmp_inflation_court c set c.dat_irr=200  where c.acc=nd.acc and c.fdat_beg=k.fdat_beg;
               dbms_output.put_line (to_char(date_prior,'dd/mm/yyyy')||' - ' ||to_char(  add_months(dat_next_u (k.fdat_beg,-1),-1)    ,'dd/mm/yyyy'));
                date_prior:=add_months(dat_next_u (k.fdat_beg,-1),-1);
          end loop;
         elsif   nd.tip='SPN'   then -- �����
          for k in (select distinct fdat_beg from tmp_inflation_court where acc=nd.acc order by fdat_beg)
          loop
          -- �� ������� �����
              if date_prior is null then
                 date_prior:=greatest(last_day(add_months(dat_next_u (k.fdat_beg,-1),-2)), nd.sdate);
              end if;
                            --    RAISE_APPLICATION_ERROR (-20999,date_prior);
               update tmp_inflation_court set dat_irr=to_char(date_prior,'dd/mm/yyyy')||' - ' ||to_char(  last_day(add_months(dat_next_u (k.fdat_beg,-1),-1))    ,'dd/mm/yyyy')  where acc=nd.acc and fdat_beg=k.fdat_beg;
               --update tmp_inflation_court c set c.dat_irr=200  where c.acc=nd.acc and c.fdat_beg=k.fdat_beg;
               dbms_output.put_line (to_char(date_prior,'dd/mm/yyyy')||' - ' ||to_char(  last_day(add_months(dat_next_u (k.fdat_beg,-1),-1))    ,'dd/mm/yyyy'));
                date_prior:=last_day(add_months(dat_next_u (k.fdat_beg,-1),-1));
          end loop;
         else
           update tmp_inflation_court set dat_irr=to_char(dat_next_u (fdat_beg,-1)  ,'MON. YYYY', 'NLS_DATE_LANGUAGE = UKRAINIAN')  where acc=nd.acc;
         end if;
		 
     end loop;
  commit;
 end;

END rep_inflation_court;
/
 show err;
 
PROMPT *** Create  grants  REP_INFLATION_COURT ***
grant EXECUTE                                                                on REP_INFLATION_COURT to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on REP_INFLATION_COURT to RCC_DEAL;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/rep_inflation_court.sql =========***
 PROMPT ===================================================================================== 
 