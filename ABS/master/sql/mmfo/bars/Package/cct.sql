
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/cct.sql =========*** Run *** =======
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.CCT IS

/******************************************************************************
   NAME:       CCT
   PURPOSE:  ����� ��� ������ � �������� �� ��������� ������
******************************************************************************/

 G_HEADER_VERSION  CONSTANT VARCHAR2(64)  := 'version 13 03/03/2014';

--------------------------------------------------------------------
-- chk_term : �������� ����� ������ �� ������ ��������
--------------------------------------------------------------------
 procedure chk_term
 (p_npp    cc_trans.npp%TYPE   ,
  p_acc    cc_trans.ACC%TYPE   ,
  P_d_plan cc_trans.d_plan%type);

--------------------------------------------------------------------
-- chk_nbs : �����i��� ������ ������ � ���������� ��������.
--------------------------------------------------------------------
 procedure chk_nbs
 (p_npp    cc_trans.npp%TYPE   ,
  p_acc    cc_trans.ACC%TYPE   ,
  P_FDAT   cc_trans.FDAT%type  ,
  P_d_plan cc_trans.d_plan%type);

--------------------------------------------------------------------
-- Del_TRANSH : ����i��� ��������� ������
--------------------------------------------------------------------
 procedure Del_TRANSH  (p_npp    cc_trans.npp%TYPE );

--------------------------------------------------------------------
-- Upd_TRANSH : ����i��� ������ ������
--------------------------------------------------------------------
 procedure Upd_TRANSH
  (p_npp   cc_trans.npp%TYPE ,
   p_SV    cc_trans.sv%TYPE  ,
   p_Sz    cc_trans.sz%TYPE  ,
   p_comm  cc_trans.comm%TYPE
   );

--------------------------------------------------------------------
-- tranSh1 : ������ � ������� �������
--------------------------------------------------------------------
 procedure tranSh1
 (p_nbs   accounts.nbs%type  ,
  p_acc   OPLDOK.ACC%TYPE    ,
  P_S     OPLDOK.S%TYPE      ,
  P_FDAT  OPLDOK.FDAT%type   ,
  P_ref   OPLDOK.ref%type    ,
  P_ost   accounts.ostc%type ,
  P_tip   accounts.tip%type  ,
  p_mdate accounts.mdate%type,
  p_accc  accounts.accc%type );

--------------------------------------------------------------------
-- UPD_SZ ����������� �������i ���� ��������
--------------------------------------------------------------------
  procedure UPD_SZ  ( p_NPP     IN  cc_trans.NPP%type,
                      p_SZ_OLD  IN  cc_trans.SZ%type ,
                      p_SZ_NEW  IN  cc_trans.SZ%type
                      );


--------------------------------------------------------------------
-- UPD_POG ��������� � ������������ �������
--------------------------------------------------------------------
  procedure UPD_POG ( p_NPP     IN  cc_trans.NPP%type    ,
                      p_D_PLAN  IN  cc_trans.D_PLAN%type ,
                      p_SV1     IN  cc_trans.SV%type     ,
                      p_D_PLAN1 IN  cc_trans.D_PLAN%type ,
                      p_SZ1     IN  cc_trans.SZ%type,
                      p_COMM    IN  cc_trans.COMM%type
                      );


--------------------------------------------------------------------
--Otm1_UPD : ���������� ���������� �� ������� ���������  1-��  ������
--------------------------------------------------------------------
  procedure Otm1_UPD (p_NPP    IN  cc_trans.NPP%type    ,
                      p_SZ     IN  cc_trans.SZ%type     ,
                      p_REFP   IN  cc_trans.REFP%type   ,
                      p_D_FAKT IN  cc_trans.D_FAKT%type ) ;



--------------------------------------------------------------------
--Otm1_sel : ������� � �������� ���������� � ���������  1-��  ������
--------------------------------------------------------------------
  procedure Otm1_sel (p_NPP    IN  cc_trans.NPP%type    ,
                      p_SZ     IN  cc_trans.SZ%type     ,
                      p_REFP   IN  cc_trans.REFP%type   ,
                      p_D_FAKT OUT cc_trans.D_FAKT%type ) ;


--------------------------------------------------------------------
--Otm1 : ������� � ���������  1-��  ������
--------------------------------------------------------------------
  procedure Otm1 (p_NPP  cc_trans.NPP%type  ,
                  p_SZ   cc_trans.SZ%type   ,
                  p_REFP cc_trans.REFP%type );


--------------------------------------------------------------------
--Otm : ������� ��������� � ������� �������.
--------------------------------------------------------------------
  procedure Otm    (p_mode int, -- 0=��� ���� �� , >0 - ��� ������ ND  ��(��)
                    p_notisg int default 0 );

--------------------------------------------------------------------
--Otm_Back : ������ ������� ��������� ��� ������������� �������
--------------------------------------------------------------------
  procedure Otm_Back  (p_REFP oper.ref%type );

--------------------------------------------------------------------
--Start0 : ��������� ����������� ���������� ������� �������
--------------------------------------------------------------------
  procedure Start0 (p_mode int, -- 0=��� ���� �� , >0 - ��� ������ ND  ��(��)
                    p_notisg int default 0 -- �� ���������(0)/��-������� ���������(1) �������� ISG ��� ��������� ����������
                    );


--------------------------------------------------------------------
--P2067  ����� �� ���������
--------------------------------------------------------------------
  procedure P2067  (p_mode int );


--------------------------------------------------------------------
--StartI ��������� �� ������ ���
--------------------------------------------------------------------
  procedure StartI (p_mode int );

--******************************
--StartIO ��������� �� ������ ���
--------------------------------
procedure StartIO (p_mode int );

--------------------------------------------------------------------

-----------------------------------------------------------------------------------------------

 -- header_version - ���������� ������ ��������� ������

 function header_version return varchar2;

-----------------------------------------------------------------------------------------------

 -- body_version - ���������� ������ ���� ������

 function body_version return varchar2;

-----------------------------------------------------------------------------------------------

END CCT;
/
CREATE OR REPLACE PACKAGE BODY BARS.CCT IS

  G_BODY_VERSION CONSTANT VARCHAR2(64) := 'version 14.2 12/02/2016';

  -- ���������� ���� � ���������� ��� ������ ���������� ��������
  G_startdat date := to_date(nvl(GetGlobalOption('CCT_DAT'), '01/01/2008'),
                             'dd/mm/yyyy');

  /*
    27.03.2015 STA ��������� ���������  CC_TRANS.ID0  = 'I�.���.������' � ��������� ������ �� ���������
    28.01.2015 DAV ������� � ��������� p2067 ������������ �������� �� ��������� ������� ����������� ��� ���� �� ������� �������� �� ��������� ���������� ����.
    04.07.2014 Dav ����������� ������������ ������� �� �������������� ��������� ���  ��������� p2067 (������������ � ������� ��� �� 04/07/2014)
    03.06.2013 Sta �� ���������� ������ �.
                   ������ ���.  ������������� ���� ��������� ������ � ����� ����� = ���� ���������� ��      procedure tranSh1
    05.06.2013 Sta ���� ������ � ���.����
  */

  --------------------------------------------------------------------
  -- chk_term : �������� ����� ������ �� ������ ��������
  --------------------------------------------------------------------
  procedure chk_term(p_npp    cc_trans.npp%TYPE,
                     p_acc    cc_trans.ACC%TYPE,
                     P_d_plan cc_trans.d_plan%type) is
    l_nd    cc_deal.nd%type;
    l_wdate cc_deal.wdate%type;
  begin
    select nd into l_nd from nd_acc where acc = p_acc;
    select wdate into l_wdate from cc_deal where nd = l_nd;
    if l_wdate < p_d_plan then
      raise_application_error(- (20000 + 555),
                              ' ����� � ' || p_npp ||
                              ', ����� �� �i����i�� �������� ������ �������� ' ||
                              to_char(l_wdate, 'dd/mm/yyyy'));
    end if;
  end chk_term;

  --------------------------------------------------------------------
  -- chk_nbs : �����i��� ������ ������ � ���������� ��������.
  --------------------------------------------------------------------
  procedure chk_nbs(p_npp    cc_trans.npp%TYPE,
                    p_acc    cc_trans.ACC%TYPE,
                    P_FDAT   cc_trans.FDAT%type,
                    P_d_plan cc_trans.d_plan%type) IS
    srok_ number(10, 3);
    nbs_  accounts.nbs%type;
  BEGIN
    srok_ := months_between(p_d_plan, p_fdat);
    If srok_ > 12 then
      select nbs into nbs_ from accounts where acc = p_acc;
      If nbs_ like '___2' then
        raise_application_error(- (20000 + 444),
                                ' ����� � ' || p_npp ||
                                ', ����� �� �i����i�� ���.���.' || nbs_);
      end if;
    end if;
  
  end chk_nbs;

  --------------------------------------------------------------------
  -- Del_TRANSH : ����i��� ��������� ������
  --------------------------------------------------------------------
  procedure Del_TRANSH(p_npp cc_trans.npp%TYPE) is
    l_trans cc_trans%rowtype;
    s_Err   varchar2(20) := ' ����� � ' || p_npp || ' ';
    n_Err   int := - (20000 + 444);
  begin
    --������ ��������
    begin
      select * into l_trans from cc_trans where npp = p_NPP;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        raise_application_error(n_Err,
                                s_Err ||
                                '�� �������� � ������i �����i� CC_TRANS');
    end;
  
    If l_Trans.D_FAKT is not null then
      raise_application_error(n_Err,
                              s_Err || '��� �������� ' ||
                              to_char(l_Trans.D_FAKT, 'dd.mm.yyyy'));
    end if;
  
    delete from cc_trans where npp = p_npp;
  
  end Del_TRANSH;

  --------------------------------------------------------------------
  -- Upd_TRANSH : ����i��� ������  ������
  --------------------------------------------------------------------
  procedure Upd_TRANSH(p_npp  cc_trans.npp%TYPE,
                       p_SV   cc_trans.sv%TYPE,
                       p_Sz   cc_trans.sz%TYPE,
                       p_comm cc_trans.comm%TYPE) IS
  
    l_trans cc_trans%rowtype;
    s_Err   varchar2(20) := ' ����� � ' || p_npp || ' ';
    n_Err   int := - (20000 + 444);
  
  begin
    --������ ��������
    begin
      select * into l_trans from cc_trans where npp = p_NPP;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        raise_application_error(n_Err,
                                s_Err ||
                                '�� �������� � ������i �����i� CC_TRANS');
    end;
  
    If l_Trans.D_FAKT is not null then
      raise_application_error(n_Err,
                              s_Err || '��� �������� ' ||
                              to_char(l_Trans.D_FAKT, 'dd.mm.yyyy'));
    end if;
  
    update cc_trans
       set SV = p_SV, SZ = p_Sz, comm = p_comm
     where npp = p_npp;
  
  end Upd_TRANSH;

  --------------------------------------------------------------------
  -- tranSh1 : ������ � ������� �������
  --------------------------------------------------------------------
  procedure tranSh1(p_nbs   accounts.nbs%type,
                    p_acc   OPLDOK.ACC%TYPE,
                    P_S     OPLDOK.S%TYPE,
                    P_FDAT  OPLDOK.FDAT%type,
                    P_ref   OPLDOK.ref%type,
                    P_ost   accounts.ostc%type,
                    P_tip   accounts.tip%type,
                    p_mdate accounts.mdate%type,
                    p_accc  accounts.accc%type) IS
  
    l_dat1 CC_TRANS.d_plan%type; --\
    l_dat2 CC_TRANS.d_plan%type; --/ ����������� ���� ���������
    l_fdat CC_TRANS.fdat%type;
    l_sv1  CC_TRANS.sv%type;
    l_lim1 CC_lim.lim2%type;
    l_sv   CC_TRANS.sv%type;
    l_s    CC_TRANS.sv%type;
    l_Id0  CC_TRANS.ID0%type;
  
    srok_ number(10, 3);
  
  BEGIN
    begin
      --���������� ���� ��� ���������. ���� ��������� �� ���������.
    
      select CASE
               WHEN p_tip = 'SP ' THEN
                p_fdat - 1
               WHEN p_nbs like '2__2' or gl.amfo not in ('380764') THEN
                least(p_mdate, p_fdat + 365)
               ELSE
                p_mdate
             END
        into l_dat1
        from cc_deal d, nd_acc n
       where d.vidd in (2, 3)
         and nvl(to_number(cck_app.get_nd_txt_ex(d.nd, 'PR_TR', bankdate)),
                 0) = 1
         and n.acc = p_acc
         and n.nd = d.nd;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        return;
    end;
  
    If p_tip = 'SS ' then
      begin
        select to_date(value, 'dd.mm.yyyy')
          into l_dat2
          from operw
         where ref = p_ref
           and tag = 'MDATE'; -- ����?� ����� ����� ����� ���� ����
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          null;
      end;
    end if;
  
    If P_tip = 'SP ' then
      begin
        select to_number(value)
          into l_Id0
          from operw
         where ref = p_ref
           and tag = 'REF92'; -- I�.���.������ � ��������� ������ �� ���������
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          null;
      end;
    end if;
  
    l_dat2 := nvl(l_dat2, l_dat1);
    srok_  := months_between(l_dat2, p_fdat);
  
    If srok_ > 12 then
      If p_nbs like '___2' then
        raise_application_error(- (20000 + 444),
                                'C���� ������ ���=' || p_ref || ':
       ' || to_char(p_fdat, 'dd.mm.yyyy') ||
                                ' - ' || to_char(l_dat2, 'dd.mm.yyyy') || '
       �� �i����i�� ���.���.' || p_nbs);
      end if;
    end if;
  
    l_s    := p_s;
    l_lim1 := 0;
  
    If p_tip = 'SS ' then
      --��������� ��� ������
      for k in (select *
                  from cc_lim
                 where acc = p_ACCC
                   and fdat > p_FDAT
                   and fdat < l_dat2
                 order by fdat) loop
        -- ��������� ����� � ���� ����
        select Nvl(sum(sv), 0)
          into l_sv1
          from cc_trans
         where acc = p_acc
           and fdat = p_fdat;
        l_sv := p_ost - l_sv1 - k.lim2 + l_lim1;
        If l_sv > 0 and l_s > 0 then
          l_sv := least(l_sv, l_s);
          INSERT INTO CC_TRANS
            (ref, acc, fdat, sv, sz, D_PLAN)
          values
            (p_ref, p_acc, p_fdat, l_sv, 0, k.fdat);
          l_s := l_s - l_sv;
        end if;
      end loop;
    end if;
  
    If l_s > 0 then
      INSERT INTO CC_TRANS
        (id0, ref, acc, fdat, sv, sz, D_PLAN)
      values
        (l_Id0, p_ref, p_acc, p_fdat, l_s, 0, l_dat2);
    end if;
  
  end tranSh1;

  --------------------------------------------------------------------
  -- UPD_SZ ����������� �������i ���� ��������
  --------------------------------------------------------------------
  procedure UPD_SZ(p_NPP    IN cc_trans.NPP%type,
                   p_SZ_OLD IN cc_trans.SZ%type,
                   p_SZ_NEW IN cc_trans.SZ%type) IS
    s_Err varchar2(20) := ' ����� � ' || p_npp || ' ';
    n_Err int := - (20000 + 444);
  begin
    If nvl(p_SZ_OLD, 0) <> nvl(p_SZ_NEW, 0) then
      -- ��������������� �����
      update cc_trans
         set sz = p_SZ_NEW
       where nvl(sz, 0) = nvl(p_SZ_OLD, 0)
         and npp = P_NPP;
      if SQL%rowcount = 0 then
        raise_application_error(n_Err,
                                s_Err ||
                                '��������� ������ ����������i� � ������� ! ');
      end if;
    end if;
  
  end UPD_SZ;

  --------------------------------------------------------------------
  -- UPD_POG ��������� � ������������ �������
  --------------------------------------------------------------------
  procedure UPD_POG(p_NPP     IN cc_trans.NPP%type,
                    p_D_PLAN  IN cc_trans.D_PLAN%type,
                    p_SV1     IN cc_trans.SV%type,
                    p_D_PLAN1 IN cc_trans.D_PLAN%type,
                    p_SZ1     IN cc_trans.SZ%type,
                    p_COMM    IN cc_trans.COMM%type) IS
  
    l_trans cc_trans%rowtype;
    s_Err   varchar2(20) := ' ����� � ' || p_npp || ' ';
    n_Err   int := - (20000 + 444);
  
    l_sv  cc_trans.SV%type;
    l_sv1 cc_trans.SV%type := nvl(p_sv1, 0);
  
    l_sz  cc_trans.SZ%type;
    l_sz1 cc_trans.SZ%type := nvl(p_sz1, 0);
  
  begin
  
    --������ ��������
    begin
      select * into l_trans from cc_trans where npp = p_NPP;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        raise_application_error(n_Err,
                                s_Err ||
                                '�� �������� � ������i �����i� CC_TRANS');
    end;
  
    If l_Trans.D_FAKT is not null then
      raise_application_error(n_Err,
                              s_Err || '��� �������� ' ||
                              to_char(l_Trans.D_FAKT, 'dd.mm.yyyy'));
    end if;
  
    l_sv := nvl(l_trans.SV, 0);
    If l_sv1 > 0 and l_sv1 >= l_sv then
      raise_application_error(n_Err,
                              s_Err || '���� �����i �i������������ ������ ' ||
                              to_char(l_sv1) || '
 >= ���� �����i ��������� ������ ' ||
                              to_char(l_sv));
    end if;
  
    l_sz := nvl(l_trans.Sz, 0);
    If l_sz1 > 0 and l_sz1 >= l_SZ then
      raise_application_error(n_Err,
                              s_Err ||
                              '���� ��������� �i������������ ������ ' ||
                              to_char(l_sz1) || '
 >= ���� �����. ��������� ������ ' ||
                              to_char(l_Sz));
    end if;
  
    If l_sv1 > 0 and p_D_plan1 is null or
       l_sv1 <= 0 and p_D_plan1 is NOT null OR l_sv1 < l_sz1 then
      raise_application_error(n_Err,
                              s_Err || '������� �i������������ ������ :
 ���� �����i=' || to_char(l_sv1) || '
 ���� �����.=' || to_char(l_sz1) || '
 ���� ���   =' ||
                              to_char(p_D_plan1, 'dd.mm.yyyy'));
    
    end if;
  
    update cc_trans set comm = p_COMM where npp = p_NPP;
  
    If p_d_PLAN <> l_trans.D_PLAN or l_sv1 > 0 or l_sz1 > 0 then
      -- ��������� ���.������
      update cc_trans
         set d_PLAN = p_D_PLAN,
             sv     = sv - l_sv1 * 100,
             sz     = sz - l_sz1 * 100
       where npp = p_NPP;
    
      -- �������� �i������������ ������
      If l_sv1 > 0 then
      
        INSERT INTO CC_TRANS
          (ref, acc, fdat, sv, sz, D_PLAN)
        values
          (l_trans.ref,
           l_trans.acc,
           l_trans.fdat,
           l_sv1 * 100,
           l_sz1 * 100,
           p_D_PLAN1);
      end if;
    
    end if;
  
  end UPD_POG;

  --**********************************************************************************
  --Otm1_UPD : ���������� ���������� �� ������� ���������  1-��  ������
  procedure Otm1_UPD(p_NPP    IN cc_trans.NPP%type,
                     p_SZ     IN cc_trans.SZ%type,
                     p_REFP   IN cc_trans.REFP%type,
                     p_D_FAKT IN cc_trans.D_FAKT%type) IS
  begin
    update CC_TRANS
       set sz = nvl(sz, 0) + p_SZ, d_fakt = p_D_FAKT, refp = p_REFP
     where npp = p_NPP;
    insert into cc_trans_ref
      (npp, ref, s_ref)
    values
      (p_NPP, p_REFP, p_SZ);
  end otm1_UPD;
  --------------------------------------------------------------------
  --Otm1_sel : ������� � �������� ���������� � ���������  1-��  ������
  --------------------------------------------------------------------
  procedure Otm1_sel(p_NPP    IN cc_trans.NPP%type,
                     p_SZ     IN cc_trans.SZ%type,
                     p_REFP   IN cc_trans.REFP%type,
                     p_D_FAKT OUT cc_trans.D_FAKT%type) IS
    l_Trans cc_trans%rowtype;
    l_s1    cc_trans.SZ%type; --  = sv - nvl(sz,0)  ; -- ������� ����
    s_Err   varchar2(20) := ' ����� � ' || p_npp || ' ';
    n_Err   int := - (20000 + 444);
  begin
  
    If nvl(p_SZ, 0) <= 0 then
      raise_application_error(n_Err,
                              s_Err || '���. � ���i ��������� =' ||
                              to_char(p_SZ / 100));
    end if;
  
    If p_refp is null then
      raise_application_error(n_Err,
                              s_Err || '�� ������� ���.��������� ');
    end if;
    ---------------------------------------------
    begin
    
      select * into l_Trans from cc_trans where npp = p_NPP;
    
      If l_Trans.D_FAKT is not null then
        raise_application_error(n_Err,
                                s_Err || '��� �������� ' ||
                                to_char(l_Trans.D_FAKT, 'dd.mm.yyyy'));
      end if;
    
      l_s1 := l_Trans.SV - Nvl(l_Trans.SZ, 0); -- ������� ����
    
      If l_s1 < p_SZ then
        raise_application_error(n_Err,
                                s_Err || '����������� ������� ������=' ||
                                to_char(l_s1 / 100) || '
               ����� ���� ����= ' ||
                                to_char(p_SZ / 100));
      end if;
    
      If l_s1 = p_SZ then
        p_D_FAKT := gl.BDATE;
      else
        p_D_FAKT := null;
      end if;
    
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        raise_application_error(n_Err,
                                s_Err ||
                                '�� �������� � ������i �����i� CC_TRANS');
    end;
  
  end otm1_Sel;

  ----------------------------------------------
  --Otm1 : ������� � ���������  1-��  ������
  ----------------------------------------------
  procedure Otm1(p_NPP  cc_trans.NPP%type,
                 p_SZ   cc_trans.SZ%type,
                 p_REFP cc_trans.REFP%type) IS
    l_dfakt cc_trans.D_FAKT%type; -- ���� ������� ��������� ��� null
  begin
    CCT.Otm1_SEL(p_NPP, p_SZ, p_REFP, l_dfakt);
    CCT.Otm1_UPD(p_NPP, p_SZ, p_REFP, l_dfakt);
  end otm1;

  --***********************************************
  -- Otm : ������� ��������� � ������� �������. ---
  -------------------------------------------------
  procedure Otm(p_mode   int, -- 0=��� ���� �� , >0 - ��� ������ ND  ��(��)
                p_notisg int default 0) is
  
    l_s     opldok.s%type;
    l_s1    opldok.s%type;
    l_s2    opldok.s%type;
    l_dfakt CC_TRANS.D_fakt%type;
    l_dapp  CC_TRANS.Dapp%type;
  
  BEGIN
  
    -- ������� ��������� � ������� �������.
    for p in (select acc, nvl(max(dapp), min(fdat) - 1) DAPP
                from CC_TRANS
               where d_fakt is null
                 and (p_mode = 0 or
                     acc in (select acc from nd_acc where nd = p_mode))
               group by acc) loop
      for k in (select *
                  from opldok o
                 where acc = p.acc
                   and dk = 1
                   and sos = 5
                   and fdat > p.dapp
                   and fdat >= G_startdat
                      --and fdat < gl.BDATE
                   and tt <> decode(p_notisg, 1, 'ISG', ' ')
                   and ref not in (select c.ref
                                     from cc_trans_ref c, cc_trans t
                                    where c.npp = t.npp
                                      and t.acc = p.acc
                                    group by c.ref
                                   having sum(s_ref) = o.s)
                 order by ref) loop
        l_s := k.S; -- ������� ����
        for m in (select *
                    from CC_TRANS
                   where acc = p.acc
                     and (d_fakt is null or sv > nvl(sz, 0))
                   order by d_plan, fdat, ref) loop
          l_s1 := m.sv - nvl(m.sz, 0); -- ������� ����
          l_s2 := least(l_s, l_s1); -- ������� ����� ����
        
          If l_s1 = l_s2 then
            l_dfakt := k.fdat;
          else
            l_dfakt := null;
          end if;
        
          CCT.Otm1_UPD(m.npp, l_s2, k.ref, l_dfakt);
        
          l_s := l_s - l_s2;
          If l_s = 0 then
            EXIT;
          end if;
        end loop; -- m
      end loop; -- k
    
      update CC_TRANS
         set dapp = dat_next_u(gl.BDATE, -1)
       where acc = p.acc;
    
    end loop; --p
  
  END OTM;

  --------------------------------------------------------------------
  --Otm_Back : ������ ������� ��������� ��� ������������� �������
  --------------------------------------------------------------------
  procedure Otm_Back(p_REFP oper.ref%type) is
    l_refp number;
  begin
    -- ������ ��� ������, ���������� ���� ����������, �� ����� � ����� ��� ����� ���������
    for k in (select t.npp, t.sv, t.sz, c.s_ref, t.sz - c.s_ref sz_old
                from cc_trans_ref c, cc_trans t
               where c.ref = p_REFP
                 and c.npp = t.npp) loop
      -- ���� ����� ��� ��������� ������� ����� ���������� - � ����� ������ ������� ���� ������������ �������
      if k.sv = k.sz then
        update cc_trans set d_fakt = null where npp = k.npp;
      end if;
    
      -- ������� ������������ ������ �������� �� ����� ������, ����� ���������� ��� � cc_trans � �������� ���������
      begin
        select nvl(max(ref), null)
          into l_refp
          from cc_trans_ref
         where npp = k.npp
           and ref <> p_REFP;
      exception
        when no_data_found then
          l_refp := null;
      end;
    
      -- ����������� ������ ������ �����
      update cc_trans set sz = k.sz_old, refp = l_refp where npp = k.npp;
      -- ������� �� cc_trans_ref "�������������" ����������� ������� ���������:)
      delete from cc_trans_ref
       where npp = k.npp
         and ref = p_REFP;
    end loop;
  
    -- ���� ��� ��� ����� �� ��������� - ������� �����������
    delete from cc_trans where ref = p_REFP;
  
  end Otm_Back;

  ---***********************************************************
  -- Start0 : ��������� ����������� ���������� ������� �������
  -------------------------------------------------------------
  procedure Start0(p_mode   int, -- 0=��� ���� �� , >0 - ��� ������ ND  ��(��)
                   p_notisg int default 0 -- �� ���������(0)/��-������� ���������(1) �������� ISG ��� ��������� ����������
                   ) is
    l_fdat saldoa.fdat%type;
    l_ostf saldoa.ostf%type;
  BEGIN
  
    -- ��������� ����������� ���������� ������� ������� �����
    If p_mode = 0 then
      delete from CC_TRANS;
    else
      delete from CC_TRANS_REF
       where npp in
             (select npp
                from CC_TRANS
               where acc in (select acc from nd_acc where nd = p_MODE));
      delete from CC_TRANS
       where acc in (select acc from nd_acc where nd = p_MODE);
    end if;
  
    -- ������� ��� ������ ������� ����� - ���� ��������� �����
    for k in (select a.acc,
                     a.daos,
                     n.nd,
                     a.ostc,
                     a.mdate,
                     a.tip,
                     a.accc,
                     a.nbs
                from accounts a, nd_acc n, cc_deal d
               where d.vidd in (2, 3)
                 and d.sos < 15
                 and nvl(to_number(cck_app.get_nd_txt_ex(d.nd,
                                                         'PR_TR',
                                                         bankdate)),
                         0) = 1
                 and a.acc = n.acc
                 and tip = 'SS '
                 and n.nd = d.nd
                 and d.nd = decode(p_MODE, 0, d.nd, p_mode))
    
     loop
      -- �������� ������� ��� �������� ��
      select min(fdat) into l_fdat from saldoa where acc = k.acc;
      If l_fdat is not null then
        select ostf
          into l_ostf
          from saldoa
         where acc = k.acc
           and fdat = l_fdat;
      
        If l_ostf < 0 then
          CCT.tranSh1(p_nbs   => k.nbs,
                      p_acc   => k.acc,
                      P_S     => -l_ostf,
                      P_FDAT  => l_fdat,
                      P_ref   => 0,
                      P_ost   => -l_ostf,
                      P_tip   => k.tip,
                      p_mdate => k.mdate,
                      p_accc  => k.accc);
        end if;
      end if;
    
      -- �������� ������ - � ������� ��� ����� �������� �� ��������
      for r in (select *
                  from opldok o
                 where dk = 0
                   and acc = K.ACC
                   and fdat >= k.daos
                   and o.sos = 5
                   and not exists (select 1
                          from CC_TRANS
                         where ref = o.REF
                           and acc = o.ACC)
                   and o.fdat >= G_startdat
                 order by o.ref) loop
        CCT.tranSh1(p_nbs   => k.nbs,
                    p_acc   => k.acc,
                    P_S     => r.s,
                    P_FDAT  => r.fdat,
                    P_ref   => r.ref,
                    P_ost   => -fost(k.acc, r.fdat),
                    P_tip   => k.tip,
                    p_mdate => k.mdate,
                    p_accc  => k.accc);
      end loop; -- r
    
      --������-������ (������ �� ���������) - � ������� ��� ����� ����������� ���������� ��� ������ �� ���������
      for p in (select *
                  from accounts a
                 where tip = 'SP '
                   and dazs is null
                   and exists (select 1
                          from nd_acc
                         where nd = k.ND
                           and acc = A.acc)) loop
        INSERT INTO CC_TRANS
          (ref, acc, fdat, sv, D_PLAN)
          select ref, acc, fdat, s, fdat - 1
            from opldok o
           where dk = 0
             and acc = P.ACC
             and fdat >= p.daos
             and o.sos = 5
             and o.fdat >= G_startdat
             and not exists (select 1
                    from CC_TRANS
                   where ref = o.REF
                     and acc = o.ACC);
      end loop; -- p
    
    end loop; -- k
  
    CCT.OTM(p_mode, p_notisg);
  
  end Start0;

  ---******************************
  -- P2067  ����� �� ���������
  --------------------------------
  procedure P2067(p_mode int) is
    l_acc    accounts.acc%type := 0;
    l_acc8   accounts.accc%type;
    l_kv     accounts.kv%type;
    l_isp    accounts.isp%type;
    l_grp    accounts.grp%type;
    l_mdate  accounts.mdate%type;
    l_nms    accounts.nms%type;
    l_nls    accounts.nls%type;
    l_s080   specparam.s080%type;
    l_nd     cc_deal.nd%type;
    l_cc_id  cc_deal.cc_id%type;
    l_sdate  cc_deal.sdate%type;
    CC_KVSD8 char(1) := NVL(GetGlobalOption('CC_KVSD8'), '0');
    l_KOL    int := 0;
    n_Commit int := 100;
    i_Commit int := 0;
  
  BEGIN
    -- ����� �� ���������
    for m in (select Npp, t.acc, (t.sv - nvl(t.sz, 0)) S
                from CC_TRANS t
               where fdat < d_plan
                 and d_fakt is null
                 and cck_app.correctDate2(980, d_plan, 1) < gl.bdate
                 and (sv - nvl(sz, 0)) > 0
              ----and acc = 294827
               order by acc) loop
      --������ ����������
      If l_acc <> m.acc then
        begin
          select a.accc,
                 a.kv,
                 a.isp,
                 a.grp,
                 nvl(s.s080, '2') s080,
                 a.mdate,
                 d.cc_id,
                 d.nd,
                 d.sdate,
                 a.nls,
                 substr(a.nms, 1, 38)
            into l_acc8,
                 l_kv,
                 l_isp,
                 l_grp,
                 l_s080,
                 l_mdate,
                 l_CC_ID,
                 l_nd,
                 l_sdate,
                 l_nls,
                 l_nms
            from accounts a, nd_acc n, cc_deal d, specparam s
           where a.ostc = a.ostb
             and d.sos<15
             and a.acc = m.acc
             and a.acc = n.acc
             and n.nd = d.nd
             and a.acc = s.acc(+);
          l_acc := m.acc;
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            goto KIN7_;
        end;
      end if;
      cck.CC_ASP111(CC_KVSD8,
                    gl.BDATE,
                    46,
                    l_ND,
                    l_acc8,
                    l_KV,
                    l_ISP,
                    l_GRP,
                    l_S080,
                    l_mdate,
                    l_nms,
                    l_nls,
                    l_CC_ID,
                    l_sdate,
                    m.s);
    
      if nvl(cck.G_REPORTS, 0) = 0 then
        insert into operw
          (ref, tag, value)
        values
          (gl.aRef, 'REF92', to_char(m.Npp));
      end if;
    
      If i_Commit >= n_Commit and nvl(cck.G_REPORTS, 0) = 0 then
        COMMIT;
        l_KOL    := l_KOL + i_Commit;
        i_Commit := 0;
      end if;
    
      <<KIN7_>>
      NULL;
    end loop;
    If i_Commit >= n_Commit and nvl(cck.G_REPORTS, 0) = 0 then
      COMMIT;
      l_KOL    := l_KOL + i_Commit;
      i_Commit := 0;
    end if;
    l_KOL := l_KOL + i_Commit;
    if nvl(cck.G_REPORTS, 0) = 0 then
      COMMIT;
    end if;
    i_Commit := 0;
  
  end p2067;

  --******************************
  --StartI ��������� �� ������ ���
  --------------------------------
  procedure StartI(p_mode int) is
    -- ���� ���� ����� ��������� ������������ ������� � ������ �� ���������. ��������� �� 2, ������ ��� ����� ������������ �� ����� (����� �� ���������) � �� ����� (������������ �������)
  begin
    --CCT.Otm   (p_mode );
    CCT.P2067(p_mode);
  end StartI;

  --******************************
  --StartIO ��������� �� ������ ���
  --------------------------------
  procedure StartIO(p_mode int) is
  begin
    CCT.Otm(p_mode);
  end StartIO;

  --------------------------------------------------------------
  /*
   header_version - ���������� ������ ��������� ������ CCK
  */

  function header_version return varchar2 is
  begin
    return 'Package header CCK ' || G_HEADER_VERSION;
  end header_version;

  --------------------------------------------------------------

  /*
   body_version - ���������� ������ ���� ������ CCK
  */
  function body_version return varchar2 is
  begin
    return 'Package body CCK ' || G_BODY_VERSION;
  end body_version;

--------------------------------------------------------------

END CCT;
/
 show err;
 
PROMPT *** Create  grants  CCT ***
grant EXECUTE                                                                on CCT             to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on CCT             to RCC_DEAL;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/cct.sql =========*** End *** =======
 PROMPT ===================================================================================== 
 