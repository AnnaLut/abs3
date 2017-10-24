

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/TK1_MANY.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure TK1_MANY ***

  CREATE OR REPLACE PROCEDURE BARS.TK1_MANY 
(p_nd     IN  number,
 p_SS     IN  number, -- ����� �������� ������� � ��������
 p_GPK    IN  int   , -- 3- �������
 DAT_end  IN  date  , -- ���� ���������� ��
 p_RATE   IN  number, -- ������� % ������
 p_basey  IN  int   DEFAULT 0 , --������� ���
 p_irr0   IN  number, -- ���.��.������
 datk_    IN  date  , -- ���� ����� ���
 DATm_    IN  date  , -- 01 ����� ��������� ���
 k_       IN  number, -- ���� (�������� ������)
 OBESP_   IN  number, -- ����������� ��� ��������� � ������ �� ���.���������, ���
                      -- ���������� �� ���� �����������
 --------------------
 p_pv     OUT number,
 p_DOX    OUT number,
 p_BV     OUT number  -- ���.�����
 ) is

/*
  20-11-2012 Sta ��������� ����� ����� � ����.����
  15.11.2012 Sta Lim1. Lim2
  02.11.2012 �����  � ����� SNO   � ������� ��������� �� ��� ��������� ����� (mdate).
             ���� ���� �� ���������, �����  ����� ��������� ������ (��� � �� �������� ����� SN and SPN).C�.T0_many
  02.11.2012 Sta  --CC_LIM  �� ������
  31-10-2012 Sta  -- �������� �������
*/

--  1.�������� PV,BV,Irr �� ������.�� �� ������ ��

  MODE2_ int     ; -- = 1 - ���� �� ����.�����
  TELO_   number := 0 ; -- ���������� �� ����
  S_      number := 0 ; -- ���.������
  DAT_pl1 date   ; -- ������ ��.���� � ��������� �������
--------------------
  l_ost number ; -- ������� ��� �� ����
  l_s1  number ; -- ���.����� 1-�� �������
  l_ss  number ; -- � ��� - ����� ���� \
  l_sn  number ; -- � ��� - ����� ���� /  ���.����� 1-�� �������
  l_fdat  date ;
----------------------------------------
BEGIN
--logger.info('MANY nd=' || p_nd || ' datk_=' || datk_ || ' DATm_=' || DATm_ );
--249-23-41

 -- ������ ���� ���� ������ = ��� �� ���� ������� = �� LIM
 insert into test_many (fdat ,p1_ss,p2_ss,  gpk, ir   ,many,dat,id,nd )
               values  (DATk_,p_SS, p_SS ,p_GPK,p_rate,0   ,datm_, gl.aUid, p_nd);

 -- ���� ���� = ���� ���������
 insert into test_many ( fdat, p1_ss, p1_sn, many,dat,id,nd)
 select fdat, sumg, (sumo-sumg), 0,datm_, gl.aUid, p_nd
 from cc_lim_arc where mdat = datm_ and nd=p_nd and fdat > datk_ and fdat <= dat_end;

 -- ��������� ���� (�� ������ ������)
 begin
   insert into test_many ( fdat ,p1_ss,p1_sn,many,dat,id,nd ) values (DAT_end,0,0,0,datm_, gl.aUid, p_nd);
 exception when dup_val_on_index then null;
 end;

 -- ����� ������ �� ��� (-������(����) + ���������(����). TELO_ = �������
 select sum(nvl(p1_ss,0)) into TELO_ from test_many where dat=datm_ and id=gl.auid and nd=p_nd;

 select min(fdat) into dat_pl1 from  test_many where fdat >= datm_ and many=0 and dat=datm_ and id=gl.auid and nd=p_nd;

 --������� �������� ���, ���� ��� ���������� �� ���� ����������
 insert into test_many (fdat, many, dat, id,nd)
 select FDAT, 1, datm_ ,gl.auid, p_nd
 from (select trunc( add_months(DATk_,num),'MM') FDAT  from conductor
       where NUM > 0  and add_months( DATk_,num) < add_months( DAT_end, 2)
       )
 where fdat not in (select fdat from test_many  where fdat > DATk_ and dat=datm_ and id=gl.auid and nd=p_nd);


 If TELO_ < 0 then
    --���������
    update test_many set p1_ss = nvl(p1_ss,0) - TELO_
     where fdat = datm_ and dat=datm_ and id=gl.auid and nd=p_nd;
    if SQL%rowcount = 0 then
       insert into test_many ( fdat, p1_ss, p1_sn, many, dat, id, nd)
       values (datm_,- TELO_, 0,0, datm_ ,gl.auid, p_nd );
    end if;


 elsIf TELO_ > 0 and p_gpk =3 then
    -- �������� �������
    l_ost := - p_ss;

    -- ��������� ���� ���� � �������� (����.) �������
    select max(fdat) into l_fdat  from cc_lim_arc where mdat = datm_ and fdat < DATm_ and nd=p_nd;
    --  ���.����� 1-�� �������
    begin
       select sumo into l_s1 from cc_lim_arc where mdat = datm_ and nd=p_nd and fdat =l_fdat;
    EXCEPTION  WHEN NO_DATA_FOUND  THEN      l_s1 := 0;
    end;

    -- ����������� ���� ������ � ����������� ���.����� 1-�� �������
    for m in (select *  from test_many  where fdat>=datm_ and many=0 and dat=datm_ and id=gl.auid and nd=p_nd
              order by fdat)
    loop

       l_sn := 0;
       If l_ost > 0 then
          l_sn := ROUND(  calp(l_ost, p_RATE, l_FDAT,m.FDAT-1, nvl(p_basey,2) )  ,0);
       end if;
       l_ss := least( l_ost, greatest(l_s1 - l_sn,0) );
       update test_many set p1_ss = l_ss, p1_sn = l_sn where fdat=m.FDAT and dat=datm_ and id=gl.auid and nd=p_nd;
       l_ost:= l_ost - l_ss;
       l_fdat := m.fdat;
    end loop;

 elsIf TELO_ > 0 then
       -- �������� - �� �������
       -- ����� ����� ��������� ���� (������� ���)
       for m in (select *     from test_many   where p1_ss >0 and fdat >= DATm_    and dat=datm_ and id=gl.auid and nd=p_nd
                 order by fdat desc )
        loop
          If TELO_ > 0  then
             S_ := least(TELO_,m.p1_ss);
             update test_many set p1_ss = nvl(p1_ss,0) - S_
             where fdat=m.FDAT and dat=datm_ and id=gl.auid and nd=p_nd;
             TELO_ := TELO_ - S_ ;
          end if;
       end loop;

 end if;

 -- ���������� �� � ��� �������
 l_ss := 0;
 for k in (select rowid RI, Nvl(p1_ss,0) SS, fdat from test_many where dat=datm_ and id=gl.auid and nd=p_nd order by fdat desc )
 loop
    update test_many set lim2 = l_ss, lim1 = l_ss - k.ss where rowid=k.RI;
    l_ss := l_ss - k.ss;
 end loop;

 If p_gpk <> 3 then
    -- ��� ��� ����������� �������� (����� ��������)
    T0_many ( p_dat=>datm_,
              p_id =>gl.auid,
              p_nd =>p_nd,
              p_31 =>1,
              p_mod =>1 ,
              p_dat_mod => datm_,
              p_basey =>  p_basey
              ) ;
 end if;
-----------------------
  p_pv  := null;
  p_DOX := null;
  p_BV  := null;
-------------------


 p_BV := -p_ss;
 for k in (select a.tip, (s.ostf-s.dos+s.kos) OST, mdate, a.nbs
           from saldoa s, nd_acc n, v_gl a
           where n.nd = p_nd  and n.acc = a.acc and a.tip in ('SN ','SPN','SDI','SPI','SNO')
             and a.acc  = s.acc and s.fdat = (select max(fdat) from saldoa where acc=s.ACC and fdat <=datk_)
             and (s.ostf-s.dos+s.kos) <> 0
           )
 loop
    -- ���������� ���������
    p_BV := p_BV - k.OST;

    if k.tip =    'SPN' and k.nbs like '2__9' then
       -- ������������ ��������   - �� datm_
       update test_many set p1_sn = nvl(p1_sn,0) - k.ost where fdat=DATM_   and dat=datm_ and id=gl.auid and nd=p_nd;
    Elsif k.tip = 'SNO' and k.nbs like '2__8' and k.mdate is not null then
       -- ����������   ��������   - �� mdate
       update test_many set p1_sn = nvl(p1_sn,0) - k.ost where fdat=k.mdate and dat=datm_ and id=gl.auid and nd=p_nd;
       if SQL%rowcount = 0 then
          insert into test_many (fdat,p1_ss,p1_sn,many,dat,id,nd) values (k.mdate,0,-k.ost,0,datm_,gl.auid, p_nd );
       end if;
    end if;
 end loop;
--------------------

-- �������� ����� ������������ ������� ��������� ����� �� (1-�)  ( ��� ����� ����� ����� ���� ���� �� �������)
 update test_many set plan1 =
   round(   ( nvl(p1_ss,0) + nvl(p1_sn,0) ) * (1-k_) , 0)  where dat=datm_ and id=gl.auid and nd=p_nd;

-- ������ ��� ���� !
 If OBESP_ > 0 then
    --����������� ��� ��������� � ������ �� ���.���������, ��� ���������� �� ���� �����������
    -- � ��� �������� ������ �� ����������� �������� �� (1-�) �� ����
    If DAT_end < DATk_ then  l_fdat := datk_ + 180;
    else                     l_fdat := DAT_end +1;
    end if;
    update test_many  set plan1 = nvl(plan1,0) + obesp_  where  fdat =l_fdat and dat=datm_ and id=gl.auid and nd=p_nd;

    if SQL%rowcount = 0 then
       insert into test_many (fdat, p1_ss,p1_sn, many, dat  ,   id,    nd, plan1 )
                    values (l_fdat, 0    ,    0,    0, datm_,gl.auid,p_nd, obesp_) ;
    end if;

 end if;

 If p_irr0 > 0 and p_irr0 <1000 then
    select SUM( plan1 / power(  (1+ p_irr0/100 ), (FDAT- datm_ )/365 )  )
    into p_pv
    from test_many
    where fdat > DATk_ and dat=datm_ and id=gl.auid and nd=p_nd;
--  p_pv := ROUND(  ( 1-nvl(k_,0) ) *  p_pv,0); -- ��� �������� !!
    p_pv := ROUND(    p_pv,0);
 end if;

 update test_many
    set irr = p_irr0,
        dox = p_DOX,
        pv = p_pv ,
        k  = k_
 where fdat = DATk_ and dat=datm_ and id=gl.auid and nd=p_nd;

 RETURN;

end tK1_many;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/TK1_MANY.sql =========*** End *** 
PROMPT ===================================================================================== 
