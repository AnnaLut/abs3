CREATE OR REPLACE PACKAGE BARS.BARS_LOSS_EVENTS
is
/*
  28.10.2015 Sta ������������� �������  �������� ��� ��� = ������ -- �� ������������ � ��
  08-10-2015 ������  �������� "��� ����=0.  � ������  ����= 1.   ��� ����� ��� ����������� ���-�� ���� ���������
  22.09.2015 ������ - ����� �� ���
  ���������� ���������� ���� ���� ������� (loss events)
*/
  g_header_version  constant varchar2(64)  := 'version 1.3 15/03/2016';
  g_awk_header_defs constant varchar2(512) := '';
  g_receivables     constant boolean       := true;
  --------------------------------------------------------------------------------
  function header_version return varchar2;
  function body_version return varchar2;
  ---------------------------------------------------------------------------------
  -- loss_delay - ���������� ����� �������� ������� �� ����� ���� �� ��������
  --              �������� � ������ ���������
  --
  procedure loss_delay( p_object_type in     varchar2,
                        p_nd          in     number,
                        p_sos         in     varchar2,
                        p_sdate       in     date,
                        p_accr        in     number,
                        p_accr2       in     number,
                        p_date        in     date,
                        p_event_type     out number,
                        p_event_date     out date  ,
                        p_status         out number,
                        p_days           out number,
                        p_days_corr      out number,
                        p_ZO          in     int,
                        p_MDATe       in     date );
  --------------------------------------------------------------------------------
  -- loss_events - ���������� �������� ������� �� ��� ��������� (��, ��, ���, ���)
  --
  procedure loss_events( p_date date, p_ZO int );

end BARS_LOSS_EVENTS;
/

show err

----------------------------------------------------------------------------------------------------

create or replace package body BARS_LOSS_EVENTS
is
  g_body_version  constant varchar2(64) := 'version 5.7  05.01.2018';
/*
  12.12.2017 KVA - COBUMMFO-5385 - ����� � ����� lossdays (�������� ��) �� 31.11.2017
  02.10.2017 KVA - COBUSUPABS-6451 - ... �� ��� ���� ����� ��������� ����������� ������� �������������� ��������
  11.07.2017 LSO - COBUPRVNIX-30 - ���������� ���� ������� ��� ���.���������
  14.03.2017 BAA - COBUPRVNIX-7 - "��������� �� ��� �� ������ ������ �� ������� ������� ������ �������"
  26.09.2016 BAA - ������ ���������� �-� ��� ���������� ��� OVR
  18.09.2016 LSO - ���������� ������ ����������� � ������ ���� ������� ����� �� ���
  20.07.2016 KVA - "����������� ������� ������� ��� ������� ������������� ������������� � 91 ����." ���������� loss_delay.
  21.06.2016 LSO - ���������� ���� ��������� � ��������� loss_delay ��������� + 1 � p_date, ��� �� �� �������� ������ �����.
  24.05.2016 LSO - ��������������  ���������� ������ 1508 ��� �� ��� � 1509 �� ������
  05.05.2016 BAA - ������ ���������� ������ ��� �� ��������� �������� ���������� (COBUPRVN-269)
  15.04.2016 BAA - �������� �������� ��������� ������� �� ������� ���������� ��� ���. Գ�.���.
  08.04.2016 BAA - ������� ���� � ���������� ���� ������� �� ��������� ��� (� ������ ������ ���)
  24.02.2016 BAA - ������ ����� ������ �������� ��� ��� ���������� ����� �������� ������� � ����. LOSS_EVENTS
  15.02.2016 Sta - COBUPRVN-232 -
                  Ͳ =  ��������� � ���������� ������� ������ ��������� ��� ���� ����� ������� �������� �������� �����.
                        ��� ����� ���������, �� ������� ����� �������� �� ���� ����, �� �� �� � ���� ����� �������� �� ���� �����.

                 ��� = ������ ���� � ����������� ������� ���������� ���� ������� � ������ ������ ���, � ����,
                       ���� ��� �������� ����� ���������� �������� �������� ����� � ���������� ��������� ��������� ��� �� ���� ���� � ��������� ��� �� �������� ����.


  25.01.2016 Sta f_del_pv ������� �� �������
  18.12.2015 BAA - ��� ���������� ���� ������� � ����������� ������ �������� ��������, � �� � ����� �� ����� ����
  04.12.2015 Sta ���.�������� EVENT - ��� �������, ������ ������� � ����������
  23.11.2015 ���� ��� ��䳿 ������� �� ���������������� � � ���������� � �������� ������.- loss_restructuring
  19.11.2015 BAA - ������ ���������� ���������� ��� Գ�.���. (��������� � ���������� �� ������ ������� �������)
  06.11.2015 STA - ���������+ ��� ��� ���.��� � ������
  05.11.2015 BAA - ����������� ���������� ��䳿 ������� �������� ����� ������������    - �������� ����. loss_death
  29.10.2015 prvn_automatic_event.vidd = ��� ������
  28.10.2015 Sta ������������� �������  �������� ��� ��� = ������ -- �� ������������ � �� - ���������� ���������� �� �� "������" +  �������� ���������� �������� �� ����� ��� - ��� �� "������"
  27.10.2015 Sta ������  PV � ����.���������
  21.10.2015 ����� - � loss_delay ������� ���������� ���� �����. ��� ������������� ������� (� ������ �.2.2 ��������� �� 08.10.2015 ��.����) .
  13.10.2015 ������ ����������� ������� ������������������ loss_restructuring
  08.10.2015 ����� - 1) ������� ��������� loss_rating
                        -  ������� ��������� �������� p_event_date - ���� ������������� ������� (���� ���������� ���� �� update ������)
                        -  ��������� VNCRR � VNCRP ��� ���� ���� ���������� �������� �� ��������
                        -  ��� ����������� �������� VNCRR � VNCRP �� ��������� cck_app.Get_ND_TXT_ex.
                                 ��� ��� ��� �������� ������ �� ��������� ���� ���������, � ���� ��  effectdate (��������� ���������� ���� ���������)
                        -  ��� ��� ������� ������ �� bpk_parameters_update ������ bpk_parameters
                        -  ��� �� ����� ��������� ������� �� update ������� (���� ������ ��� VNCRR, ��� ��� VNCRP ��� ��� � cp_kod_update )
                     2) ��������� � ��������� loss_events
                        - ����� loss_rating  � ���������� l_dat31 ������ p_date
                        - ����� loss_delay  � ���������� l_dat31 ������ p_date !�����
                        - ����� set_event  � ���������� l_event_date ������ p_date

  08-10-2015 ������  �������� "��� ����=0.  � ������  ����= 1.   ��� ����� ��� ����������� ���-�� ���� ���������

  07.10.2015 ������ �.�. -1) ����������� ������������ ��������� p_report_date, p_event_date � ��������� save_loss_delay_days, ����� ����� ����� ���� ������������ �������� ����-��������
                          2) ϳ������� ����� � ������
                          select g_CP  TIP, c.id GND, x.ND, c.RNK, c.DAT_EM, null  from cp_kod c,
                        (select ID, max(ref) ND from cp_deal where fost(acc,l_dat31)<0 or fost(accexpr,l_dat31)<0 or fost(accexpr,l_dat31)<0  group by id) x
                         where x.id = c.ID
                         2-���� ������������ ����� fost(accexpr,l_dat31)<0 ����� �� -> fost( accexpn,l_dat31)<0

  05.10.2015 ������ - ����� ��� �� �� ��� ���� �� (�� ��������) ��� ������� ���� �� ����� �������� ������
                    ������ �  ...\SVN\Products\Bars\Modules\CCK\Sql\Function\DAT_SPZ.fnc
                               -- 05.10.2015 Sta ��� ������ ���������, ��� ���������� ��������� � ��� � �������� , ��������, ��� ��������. ��� �� ��

  28.09.2015 ������ �� ������ ��������� ������ �� ���� ������ ���
  24.09.2015 ������ ����������� ���� ������� ������� = 2 (��������� 91 ����-��� ��, ��� 8 ��� ���)
  23.09.2015 ������ ���������� �������� ����
  22.09.2015 ������ ����� �� ���
             ����������� ���� ������� ��������� :
             �������� �����  ��� = 'SP' �� 'SP ',
             ���� ��������� = MIN ( ���� MAX)  �� ������ ������

  06.08.2015 ������ loss_events. ���� ��.��� ���� = �����, �� ������ �����

  Author  : VITALIY.LEBEDINSKIY
  Created : 17/04/2015 15:34:25
  Purpose : ���������� ���������� ���� ���� ������� (loss events)
*/

  --
  -- Private constant declarations
  --
  g_CCK        constant varchar2(3) := 'CCK';
  g_BPK        constant varchar2(3) := 'BPK';
  g_CP         constant varchar2(2) := 'CP';
  g_MBK        constant varchar2(3) := 'MBK';
  g_DEB        constant varchar2(3) := 'DEB';
  g_OVR        constant varchar2(3) := 'OVR';
  g_XOZ        constant varchar2(3) := 'XOZ';

  g_TAG_VNCRP  constant varchar2(5) := 'VNCRP';
  g_TAG_VNCRR  constant varchar2(5) := 'VNCRR';

  g_proc_lanch constant number(1)   := 1; --������ �������� �����������
  --------------------------------------------------------------------------------
  function header_version return varchar2 is
  begin
    return 'Package header bars_loss_events '||g_header_version||'.';
  end header_version;

  function body_version return varchar2 is
  begin
    return 'Package body bars_loss_events '||g_body_version||'.';
  end body_version;

  function IS_MMFO
    return boolean
    result_cache relies_on ( BRANCH )
  is
    l_qty   number(2);
  begin

    select count(1)
      into l_qty
      from BRANCH
     where BRANCH like '/______/'
       and DATE_OPENED < trunc(sysdate)
       and DATE_CLOSED Is Null;

    return case when ( l_qty > 1 ) then TRUE else FALSE end;

  end IS_MMFO;

  --------------------------------------------------------------------------------
  -- set_event - ����� ��䳿 �������
  --
  procedure set_event(p_report_date date,     -- p_date,
                      p_ref_agr number,       -- nd
                      p_rnk number,           -- rnk,
                      p_event_type number,    -- KOD,
                      p_event_date date,      -- FDAT
                      p_object_type varchar2, -- g_CCK
                      p_restr_end_dat date,   -- fdat_end
                      p_create_date date,     -- create_date
                      p_ZO int,
                      p_vidd number
  ) is
    l_ZO int := nvl(p_ZO,1) ;
  begin
    insert
      into PRVN_AUTOMATIC_EVENT
      ( ID, REPORTING_DATE, REF_AGR, RNK, EVENT_TYPE, EVENT_DATE, OBJECT_TYPE, RESTR_END_DAT
      , CREATE_DATE, ZO, VIDD )
    values
      ( bars_sqnc.get_nextval('S_AUTOMATIC_EVENT_ID')
      , p_report_date, p_ref_agr, p_rnk, p_event_type, p_event_date, p_object_type, p_restr_end_dat
      , p_create_date, l_ZO , p_vidd );

    If ( p_object_type = g_CCK )
    then
       CCK_APP.Set_ND_TXT ( p_ref_agr, 'EVENT' , to_char(p_event_type) );
    end if;

   end set_event;

  --------------------------------------------------------------------------------
  -- loss_rating
  --
  procedure loss_rating
  ( p_object_type in  varchar2,
    p_nd          in  number,
    p_date        in  date,
    p_zo          in  integer,
    p_event_type  out number,
    p_status      out number,
    p_event_date  out date
  ) is
    l_NDI     number;
    -- ���������� ����� �������� ������� �� ����� ���� �� �������� �������� � ������ ���
    l_vkrn_p  number;
    l_vkrn_r  number;
    l_bb      number;
    l_ggg     number;
    l_rnk     number;
    l_date    date;
    l_zo      integer;
    --
    procedure get_status
    (p_vkrn_p number,  p_vkrn_r number,  p_bb number,  p_ggg number,   p_event_type out number,  p_status out number)
    is
    begin
      if ( ( p_vkrn_r -  p_vkrn_p ) >= 4 and p_vkrn_r >= p_bb  ) or
         ( ( p_vkrn_r >= p_vkrn_p )      and p_vkrn_r >= p_ggg ) or
           (p_vkrn_r >= p_ggg)
      then p_event_type := 1; p_status := 1;
      else p_event_type := 0; p_status := 0;
      end if;
    end;

  BEGIN

    l_zo   := nvl(p_zo,0);
    l_date := p_date; -- ???

    select num into l_bb  from v_prvn_rating where code = '��';
    select num into l_ggg from v_prvn_rating where code = '���';

    If ( p_object_type = g_CCK OR -- �������
         p_object_type = g_MBK OR -- ����
         p_object_type = g_OVR )  -- ����������
    then

      if (  p_object_type = g_OVR )
      then
        l_ndi := p_nd;
      else
/*      WHILE 1 < 2
        loop
          begin
            select ndi
              into l_NDI
              from cc_deal
             where nd = l_NDI
               and ndi is not null
               and ndi < nd;
          exception
            when NO_DATA_FOUND then EXIT;
          end;
        end loop;
*/

        -- ���� ��� �� ���������� �������� �������� ����� NDI � ���������� ��������� ��������� ��� �� ���� � ��������� ��� �� �������� ����.
        select min(ND)
          into l_ndi
          from ( SELECT ND, NDI
                   -- , LEVEL
                   FROM BARS.CC_DEAL
                  START WITH ND = p_nd
                CONNECT BY NOCYCLE ND = PRIOR NDI );

        l_ndi := nvl(l_ndi,p_nd);

      end if;

      -- ��������� ��� ������ � ���������� �������
      begin
        select v.NUM
          into l_vkrn_p
          from BARS.ND_TXT p
          join BARS.V_PRVN_RATING v
            on ( v.CODE = p.TXT )
         where p.ND = l_ndi
           and p.TAG = g_TAG_VNCRP;
      exception
        when NO_DATA_FOUND then
          l_vkrn_p := null;
      end;

      if ( l_zo = 0 )
      then -- ��� ���������� �� �²��� ����
        begin
          select v.NUM, p.EFFECTDATE
            into l_vkrn_r, p_event_date
            from BARS.ND_TXT_UPDATE p
            join BARS.V_PRVN_RATING v
              on ( v.CODE = p.TXT )
           where p.IDUPD = ( select MAX(u.idupd)
                               from ND_TXT_UPDATE u
                              where u.tag = g_TAG_VNCRR
                                and u.nd  = p_nd
                                and u.effectdate <= p_date )
             and p.CHGACTION <> 3; -- ���� � ���� ���� �������� ��� ������ - ������ ��� ���!
        exception
          when NO_DATA_FOUND then
            l_vkrn_r     := null;
            p_event_date := null;
        end;
      else -- � ����������� �������Ͳ ��������
        begin
          select v.NUM, l_date
            into l_vkrn_r, p_event_date
            from BARS.ND_TXT        p
            join BARS.V_PRVN_RATING v
              on ( v.CODE = p.TXT )
           where p.ND = p_nd
             and p.TAG = g_TAG_VNCRR;
        exception
          when NO_DATA_FOUND then
            l_vkrn_r     := null;
            p_event_date := null;
        end;
      end if;

    ElsIf ( p_object_type = g_BPK )
    then -- ���

      begin
        -- ��������� ��� ������ � ���������� �������
        select v.num
          into l_vkrn_p
          from BARS.BPK_PARAMETERS p
          join BARS.V_PRVN_RATING  v
            on ( v.code = p.value )
        where p.ND = p_nd
          and p.TAG = g_TAG_VNCRP;
      exception
        when NO_DATA_FOUND then
          l_vkrn_p := null;
      end;

      if ( l_zo = 0 )
      then -- ��� ���������� �� �²��� ����
        begin
          select v.num, p.EFFECTDATE
            into l_vkrn_r, p_event_date
            from BPK_PARAMETERS_UPDATE p
               , V_PRVN_RATING v
           where p.VALUE = v.CODE
             and p.CHGACTION <> 'D'  -- ���� � ���� ���� �������� ��� ������ - ������ ��� ���!  �� ���������� ����� �� �����. V.Kharin
             and p.IDUPD = ( select MAX(u.idupd)
                               from BPK_PARAMETERS_UPDATE u
                              where u.TAG = g_TAG_VNCRR
                                and u.ND  = p_nd
                                and u.EFFECTDATE <= p_date );
        exception
          when NO_DATA_FOUND then
            l_vkrn_r     := null;
            p_event_date := null;
        end;
      else -- � ����������� �������Ͳ ��������
        begin
          select v.num, l_date
            into l_vkrn_r, p_event_date
            from BARS.BPK_PARAMETERS p
            join BARS.V_PRVN_RATING  v
              on ( v.code = p.value )
           where p.ND = p_nd
             and p.TAG = g_TAG_VNCRR;
        exception
          when no_data_found then
            l_vkrn_r     := null;
            p_event_date := null;
        end;
      end if;

    ElsIf ( p_object_type = g_CP )
    then -- ��

      begin
        -- ��������� ��� ������ � ���������� �������
        select v.num
          into l_vkrn_p
          from BARS.CP_KOD        k
          join BARS.V_PRVN_RATING v
            on ( v.CODE = k.VNCRP )
         where k.ID = p_nd;
      exception
        when NO_DATA_FOUND then
          l_vkrn_p := null;
      end;

      if ( l_zo = 0 )
      then -- ��� ���������� �� �²��� ����
        begin
          select v.num, k.effectdate
            into l_vkrn_r, p_event_date
            from cp_kod_update k, v_prvn_rating v
           where k.vncrr = v.code
             and k.idupd = (select max(u.idupd) from cp_kod_update u where u.id = p_nd and u.effectdate <= p_date and u.chgaction <> 'D');
        exception
          when NO_DATA_FOUND then
            l_vkrn_r     := null;
            p_event_date := null;
        end;
      else -- � ����������� �������Ͳ ��������
        begin
          select v.num, l_date
            into l_vkrn_r, p_event_date
            from bars.CP_KOD        k
            join bars.V_PRVN_RATING v
              on ( v.CODE = k.VNCRR )
           where k.ID = p_nd;
        exception
          when NO_DATA_FOUND then
            l_vkrn_r     := null;
            p_event_date := null;
        end;
      end if;

    else
      p_event_type := null;
      p_status     := null;
    end IF;

    if ( l_vkrn_p is not null AND l_vkrn_r is not null )
    then
      get_status( l_vkrn_p, l_vkrn_r, l_bb, l_ggg, p_event_type, p_status );
    end if;

  END LOSS_RATING;

  --------------------------------------------------------------------------------
  --
  --
  procedure loss_delay
  ( p_object_type in varchar2,
    p_nd    in number,
    p_sos   in varchar2,
    p_sdate in date,  -- ���� ������ ��������
    p_accr  in number,
    p_accr2 in number,
    p_date  in date,  -- ��������� �� ����
    p_event_type out number,
    -- 11.09.2015 Irina Ivanova - ������� ���� �������
    p_event_date out date  ,
    p_status     out number,
    p_days       out number,
    p_days_corr  out number,
    p_ZO         IN  int   ,
    p_MDATe      in  date
  ) is
    -- ���������� ����� �������� ������� �� ����� ���� �� �������� �������� � ������ ���������  --
    l_D1 date ;
    l_D2 date ;
    x_event_date date := null ;
    n_Const int;
    l_ZO int := nvl(p_ZO,1) ;
  begin

    p_event_type := 0;
    p_status     := 0;
    p_days       := 0;
    p_days_corr  := 0;
    p_event_date := null;

    case p_object_type
      when g_CCK
      then -- CCK - ��������� ����� 90 ����

        if ( p_date >= p_sdate )
        then

          if ( g_receivables )
          then -- ��� ���������� ���. ���.���.
            select min(DAT_SPZ(a.ACC, p_date, l_ZO))
              into x_event_date
              from BARS.ACCOUNTS a
              join BARS.ND_ACC   n
                on ( n.ACC = a.ACC )
             where n.nd = p_nd
               and a.TIP in ( 'SP ', 'SPN' );
          else -- � ����������� ���. ���.���.
            select min(DAT_SPZ(a.ACC, p_date, l_ZO))
              into x_event_date
              from BARS.ACCOUNTS a
              join BARS.ND_ACC   n
                on ( n.ACC = a.ACC )
             where n.nd = p_nd
               and  a.TIP in ( 'SP ', 'SPN', 'SK9',  'OFR' );
          end if;

        end if;

      when g_MBK
      then -- MBK - ��������� ����� 7 ����

        if ( p_date >= p_sdate )
        then
          select min(DAT_SPZ(a.ACC, p_date, l_ZO))
            into x_event_date
            from ACCOUNTS a
            join ND_ACC   n
              on ( n.ACC = a.ACC )
           where n.ND = p_nd
             and a.NBS like '15__'
             and a.TIP in ( 'SP ', 'SPN' );
        end if;

      when g_OVR
      then -- OVR -

        if ( p_date >= p_sdate )
        then
          select min(DAT_SPZ(a.ACC, p_date, l_ZO))
            into x_event_date
            from ACCOUNTS a
            join ND_ACC   n
              on ( n.ACC = a.ACC )
            where n.nd = p_nd
             and ( a.nbs = '2063' and a.TIP = 'SP ' or
                   a.nbs = '2068' and a.TIP = 'SPN' );
        end if;

      when g_CP
      then -- ��, ��������� ����� 30 ����

        begin

          select dat_spz(accEXPN, p_date, l_ZO), dat_spz(accEXPR, p_date, l_ZO)
            into l_D1, l_D2
            from cp_deal
           where ref = p_nd ;

          If ( l_D1 is NOT null and l_D2 is NOT null )
          then x_event_date := least( l_D1, l_D2 );
          Else x_event_date := NVL  ( l_D1, l_D2 );
          end if;

          If p_MDATe is not null and p_MDATe < p_date
          then
            If   x_event_date is Null
            then x_event_date := p_MDATE;
            else x_event_date := least( x_event_date, p_MDATE );
            end if;
          end if;

        exception
          when no_data_found then null;
        end;

      when g_DEB
      then -- Գ�.���.

        x_event_date := dat_spz(p_accr, p_date, l_ZO);

      when g_XOZ
      then -- ����.���.
         begin
             SELECT nvl(x.mdate, xoz_mdate(a.acc, x.fdat, a.nbs, a.ob22, a.MDATE )) mdate
              into x_event_date
                from   xoz_ref x
                join accounts a
                on (x.acc=a.acc)
                where   x.fdat <p_date and (x.datz >= p_date or x.datz is null) and x.s0<>0 and x.s<>0
                       and  a.tip in ('W4X', 'XOZ')
                       AND id = p_nd;

              if x_event_date > p_date then
                    x_event_date := null;
              end if;

         exception
            when no_data_found then null;
         end;
      else
        null;
    end case;

    case p_object_type
      when g_CCK then n_Const := 90;
      when g_OVR then n_Const := 90;
      when g_DEB then n_Const := 90; -- Գ�.���. ????
      when g_MBK then n_Const := 07;
      when g_CP  then n_Const := 30;
      when g_XOZ then n_Const := 90; -- ����.���.
      else            n_Const := 00;
    end case;

    p_days       := p_date - x_event_date + 1;
    p_days_corr  := p_days;
    x_event_date := x_event_date + n_Const;

    if ( p_days > n_Const and x_event_date <= p_date )
    then
      p_event_date := x_event_date ;
      p_event_type := 2;
      p_status     := 1;
    end if;

  end loss_delay;

--------------------------------------------------------------------------------
procedure loss_restructuring( p_date in date, p_create_date in date, p_ZO int ) is
  -- ���������� ����� �������� ������� �� ����� ���� �� �������� �������� � ������ ����������������
  l_DAT31 date   ;
  l_ZO    int    := nvl(p_ZO,1) ;
  k_Dat   date   ;
  l_datSP date   ;
  l_dat90 date   ;
  l_kol90 int    := 91 ;
  l_SP    number ;
  l_DOS   number ;
  l_vidd  number ;
  l_id    number ;
/* �������� �� ��� �������� 12/10/2015
   23.11.2015 �������� ��-������.
�������� ��� ��� ������ ������� ������� �������� � ��� � ��� ������ � ����������� � ��������� ������ :�����������
oDAT = �������� ���� = 01.��.����
rDAT  = ���� ����������������
kDAT = ����������� ����
vDAT = ���� ������ �� ���������
cDAT = ���� ������ �������  ������������������

1) ����  cDAT �� ������ � ��� ���� ������ ������  �������� oDAT, �� ���� �� �� �� ������������� ( ������� ���). �����.
2) ���� ��� �������  PV , �� ���� �� �� �� ������������� ( ������� ���).                                        �����.
3) ���� ��� �� ������� 90 ���� ����� ����������������. kDAT = rDAT.
   oDAT  - kDAT  <= 91  ���� ������ �� ����������� � ������ ����������� ������� = 90 ����.                      �����.
4) ���� �� �������  �� ��������� �� ���.���� ? ��, ���� ������ �� �������� ����������.
   ����������� ���� ���� �� ���������.                                                                          �����.
5) � ����� ��� ��������� ����� �� ��������� ����� ����������������  (���� ������ ���) ?
   5.1) ���� �����/������ �� ��������� �� ���� �����, ���������� ����������� kDAT = fDAT \
   5.2) ���� ����/�����   �� ��������� ���-���� ��� , ���������� ����������� kDAT = sDAT /
   � ���� ����� �������� � ����������� ����� �� 90����
   oDAT  - kDAT  <= 91 ���� ������   �������������, ��� �� ����� ������������� ���� ���������.                 �����.
6) ��������� �������  ������� ������� ������� ������������������  - ������ ��������� ����,
   ����� �������� � ����.������� �� ������������� ( ��. �.1) cDAT   = DAT  + 91                                 �����.
*/

begin
   select max(fdat) into l_dat31  from fdat where fdat < p_DATE; -- ��������� ����-���� � �������� ������

   for x in (select FDAT, nd, del_pv, fdat_end, rowid RI, RNK, CC_ID, SDATE, WDATE, NMK, CUSTTYPE
             from cck_restr
             where l_dat31 between fdat and nvl(fdat_end, l_dat31)
---            and ( DEL_PV is null  or  DEL_PV < 0  or abs (DEL_PV ) > 100       )  ----- ���� �������� PV ����� ������  ������ ���
-- 1) ����  cDAT �� ������ � ��� ���� ������ ������  �������� oDAT, �� ���� �� �� �� ������������� ( ������� ���). �����.
            )
   loop

      If x.rnk is null OR x.CC_ID is null then
         begin select d.RNK, d.CC_ID, d.SDATE, d.WDATE, c.NMK, c.CUSTTYPE
               into   x.RNK, x.CC_ID, x.SDATE, x.WDATE, x.NMK, x.CUSTTYPE
               from cc_deal d, customer c        where d.nd    = x.ND and d.rnk = c.rnk ;
               update cck_restr set rnk=x.RNK, cc_id=x.CC_ID, sdate=x.SDATE, wdate=x.WDATE, nmk=x.NMK, custtype=x.CUSTTYPE  where rowid = x.RI ;
         exception when no_data_found then x.rnk := gl.aRnk;
         end;
      end if;

      --if x.del_PV is null OR abs(x.DEL_PV ) > 100 then      -- 1) ������ ����� ��������� PV � ����.��������� ��� ����� ����������������
      -- ���� �������� PV ����� ������  ������ ���

      --25.01.2016 �� ��������� ��� ���������
      select  min(id)  into l_id  from prvn_flow_deals_const  where nd = x.nd  and ( DATE_CLOSE is null or DATE_CLOSE > l_dat31) ;
      x.del_pv := NVL( prvn_flow.f_del_pv( l_id, x.FDAT ), 0)   ;
      update cck_restr set DEL_PV = x.DEL_PV where rowid = x.RI ;

      --end if;

-- 2) ���� ��� �������  PV , �� ���� �� �� �� ������������� ( ������� ���).                   �����.
      If x.del_PV >= 0             then GOTO RecNext_   ; end if;

-- 3) ���� ��� �� ������� 90 ���� ����� ����������������. kDAT = rDAT. ���� ������ �� �����������. �����.
      If p_DATE- x.FDAT <= l_kol90 then GOTO Defolt_YES ; end if;

--    �� ���.���� ������ ��� ��� ������. ����������� ��-������:
      select nvl(-sum ( prvn_flow.qst_12( a.acc, p_date, a.nbs, l_zo ) ), 0) into l_SP
      from accounts a, nd_acc n    where n.nd = x.nd and n.acc = a.acc and a.tip in ('SP ','SPN', 'SK9') and a.nbs < '4' ;

-- 4) ���� �� �������  �� ��������� �� ���.���� ? ��, ���� ������ �� �������� ����������.     �����.
      if l_SP > 0                  then GOTO Defolt_YES ; end if;

-- 5) � ����� ��� ��������� ����� �� ��������� ����� ����������������  (���� ������ ���) ?
      select max(s.fdat) into l_datSP from saldoa s, accounts a, nd_acc n
      where s.fdat >= x.fdat and s.fdat < p_date
        and s.ostF-s.dos +s.kos >= 0  and s.ostF < 0
        and n.nd = x.nd and n.acc = a.acc and a.tip in ('SP ','SPN', 'SK9') and a.nbs < '4' ;

      If l_datSP is null then ---- 5.1) ���� �����/������ �� ��������� �� ���� �����, ���������� ����������� kDAT = fDAT \
         k_Dat := x.FDAT ;
      else                    ---- 5.2) ���� ����/�����   �� ��������� ���-���� ��� , ���������� ����������� kDAT = sDAT /
         k_Dat := l_DatSP;
      end if;

--    � ���� ����� �������� � ����������� ����� �� 90���� E��� ������   �������������, ��� �� ����� ������������� ���� ���������. �����.
      If p_date - k_Dat <= l_KOl90 then GOTO Defolt_YES ; end if;

-- 6) ��������� �������  ������� ������� ������� ������������������  - ������ ��������� ����,      �����.
   <<Defolt_NO>>
    ------------------------------------------------------------
      If x.fdat_end is null then x.fdat_end := nvl( l_datSP, x.fdat) + l_kol90;
         update cck_restr set fdat_end  = x.fdat_end where rowid = x.RI ;
      end if;
      GoTO RecNext_;


   <<Defolt_YES>>   -- ���� ������� ������� ������������������
    ------------------------------------------------------------
        select vidd into l_vidd from cc_deal where nd = x.nd ;
        set_event ( p_date, x.nd, x.rnk, 3, x.FDAT, g_CCK, x.fdat_end, p_create_date, l_ZO , l_vidd );

   <<RecNext_>> null;
   ------------------

end loop   ; --- x

end loss_restructuring;

  --------------------------------------------------------------------------------
  --
  --
  procedure SAVE_LOSS_DELAY_DAYS
  ( p_object_type  in   varchar2,
    p_nd           in   number,
    p_report_date  in   date,
    p_event_date   in   date,
    p_days         in   number,
    p_days_corr    in   number,
    p_zo           in   int
  ) is
    l_ZO int := nvl(p_ZO,1);
  begin
    insert into PRVN_LOSS_DELAY_DAYS
      ( REPORTING_DATE, REF_AGR, DAYS, DAYS_CORR, EVENT_DATE, OBJECT_TYPE, LANCH_MONTHLY, ZO )
    values
      ( p_report_date, p_nd, p_days, p_days_corr, p_event_date, p_object_type, g_proc_lanch, l_ZO );
  end SAVE_LOSS_DELAY_DAYS;

  --------------------------------------------------------------------------------
  --
  --
  procedure LOSS_RATING_BPK
  ( p_report_dt     in     date -- first date of month
  , p_adjustment    in     pls_integer default 0
  ) is
    /*
    ����� �������� �������� ������������/�������. ������������ ��:
    a) ������ ����������� ���������� �������� ������������/������� (��� ����, ��, ���),
       ��� ����� (��� ��) �������� � ���� ��������� ��������� �� 4 ������� �� �����,
       ��� ����� ���������� �������� ��» ��� �����;
    b) ������ ����������� ���������� �������� ������������ �� �������� ���û.
    */
    c_title      constant  varchar2(60) := 'bars_loss_events.loss_rating_bpk';
    c_event_tp   constant  prvn_automatic_event.event_type%type  := 1;
    c_object_tp  constant  prvn_automatic_event.object_type%type := 'BPK';
    c_vidd       constant  prvn_automatic_event.vidd%type        := 4;

    l_kf                   prvn_automatic_event.kf%type;
    l_mplr                 number(3);
    l_ru_code              number(2);
    l_create_dt            prvn_automatic_event.create_date%type;
    l_last_bdt             date;
    l_fall_limit           number(3); -- �-�� ������� ������ ���, �� ����������� �� ����� �������� ��������
    l_bad                  number(3); -- number value for ICR '��'  (08)
    l_worst                number(3); -- number value for ICR '���' (10)
  begin

    l_kf := sys_context('bars_context','user_mfo');

    if ( l_kf Is Null )
    then

      raise_application_error( -20666, '�� ������� ����� ��� ����������!', true );

    else

      if ( IS_MMFO )
      then
        l_mplr    := 100;
        l_ru_code := to_number(bars_sqnc.get_ru(l_kf));
      else
        l_mplr    := 1;
        l_ru_code := 0;
      end if;

    end if;

    l_create_dt  := sysdate;
    l_fall_limit := 4;

    select BB, GGG
      into l_bad, l_worst
      from ( select CODE, NUM
               from BARS.V_PRVN_RATING
              where CODE in ('���','��') )
     pivot ( max(NUM) for CODE in ( '��' as BB, '���' as GGG ) );

    if ( p_adjustment = 0 )
    then -- ��� ���������� �� �²��� ����

      -- ������� ���� �� ������ ����� ���
      l_last_bdt := DAT_NEXT_U(p_report_dt,-1);

      insert
        into BARS.PRVN_AUTOMATIC_EVENT
        ( ID, REPORTING_DATE, REF_AGR, RNK
        , EVENT_TYPE, EVENT_DATE, OBJECT_TYPE, CREATE_DATE, ZO, VIDD )
      select S_AUTOMATIC_EVENT_ID.NextVal * l_mplr + l_ru_code -- BARS_SQNC.GET_NEXTVAL( 'S_AUTOMATIC_EVENT_ID' )
           , p_report_dt, p.ND, a.RNK
           , c_event_tp, p.EFFECTDATE, c_object_tp, l_create_dt, p_adjustment, c_vidd
        from ( select p.ND
                    , max(case when p.tag = 'VNCRR' then p.EFFECTDATE else null end) as EFFECTDATE
                 from BARS.BPK_PARAMETERS_UPDATE p
                 join BARS.V_PRVN_RATING  r
                   on ( r.CODE = p.VALUE )
                where p.IDUPD in ( select max(IDUPD)
                                     from BPK_PARAMETERS_UPDATE
                                    where TAG in ('VNCRR','VNCRP')
                                      and EFFECTDATE <= l_last_bdt
                                    group by ND, TAG )
                  and p.CHGACTION <> 'D' -- ���� �������� ��� ��������� - ������� ���� ���� (��������� ����� �� ������)!
                group by p.ND
               having count(1) = 2
                  and sum( case when p.tag = 'VNCRR' then -r.NUM else r.NUM end ) < -3
             ) p
        join ( select ND, ACC_PK
                 from BARS.BPK_ACC
                where DAT_CLOSE is Null      -- ���� ��������
                   or DAT_CLOSE > l_last_bdt -- ������� ������
                UNION ALL
               select ND, ACC_PK
                 from BARS.W4_ACC
                where DAT_CLOSE is Null      -- ���� ��������
                   or DAT_CLOSE > l_last_bdt -- ������� ������
             ) bpk
          on ( bpk.ND = p.ND )
        join BARS.ACCOUNTS a
          on ( a.ACC = bpk.ACC_PK )
        join BARS.CUSTOMER c
          on ( c.RNK = a.RNK and c.CUSTTYPE = 3 ) -- ���� ���.�����
       where a.DAOS <= l_last_bdt
      -- and ( a.dazs is null or a.dazs > :l_dat31 )
      ;

    else -- � ����������� �������Ͳ ��������

      -- ������� ������� ���� � ������� �����
      l_last_bdt := DAT_NEXT_U(trunc(p_report_dt,'MM'),-1);

      insert
        into BARS.PRVN_AUTOMATIC_EVENT
        ( ID, REPORTING_DATE, REF_AGR, RNK
        , EVENT_TYPE, EVENT_DATE, OBJECT_TYPE, CREATE_DATE, ZO, VIDD )
      select S_AUTOMATIC_EVENT_ID.NextVal * l_mplr + l_ru_code -- BARS_SQNC.GET_NEXTVAL( 'S_AUTOMATIC_EVENT_ID' )
           , p_report_dt, p.ND, a.RNK
           , c_event_tp, p_report_dt, c_object_tp, l_create_dt, p_adjustment, c_vidd
        from ( select p.ND
                 from BARS.BPK_PARAMETERS p
                 join bars.V_PRVN_RATING  r
                   on ( r.code = p.value )
                where p.TAG in ('VNCRR','VNCRP')
                group by p.ND
               having ( -- ��� >= ���û (��� ������ ���� ���������� ��������)
                        sum( case when p.tag = 'VNCRR' then r.NUM else 0 end ) >= l_worst
                      )
                   or ( count(1) = 2
                        and -- ������ ��� �������� � ���� ��������� ��������� �� 4 ������� �� �����
                        sum( case when p.tag = 'VNCRR' then r.NUM else -r.NUM end ) >= l_fall_limit
                        and -- �� ����� �� ������� �������� ��� ����� ���������� �������� ��» ��� �����
                        sum( case when p.tag = 'VNCRR' then r.NUM else 0      end ) >= l_bad
                      )
             ) p
        join ( select ND, ACC_PK
                 from BARS.BPK_ACC
                where DAT_CLOSE is Null
                   or DAT_CLOSE > l_last_bdt
                UNION ALL
               select ND, ACC_PK
                 from BARS.W4_ACC
                where DAT_CLOSE is Null
                   or DAT_CLOSE > l_last_bdt
             ) bpk
          on ( bpk.ND = p.ND )
        join BARS.ACCOUNTS a
          on ( a.ACC = bpk.ACC_PK )
        join BARS.CUSTOMER c
          on ( c.RNK = a.RNK and c.CUSTTYPE = 3 ) -- ���� ���.�����
       where a.DAOS <= l_last_bdt
      -- and ( a.dazs is null or a.dazs > l_last_bdt )
      ;

    end if;

  end LOSS_RATING_BPK;

--------------------------------------------------------------------------------
procedure loss_events( p_date date, p_ZO int )
is
  -- ���������� �������� ������� �� ��� ��������� (��, ��, ���, ���)
  -- p_date - ����� ���� ���� 01-09-2015 = ��� �� 08.2015
    l_event_type  number(1 );
    l_event_date  date;
    l_status      number(1 );
    l_days        number(10);
    l_days_corr   number(10);
    l_create_date date  := trunc(sysdate);
    l_dat31       date  := p_date - 1;
    l_RNK         number;
    l_ZO          int   := nvl(p_ZO,1);
begin

  dbms_application_info.set_action( 'LOSS_EVENTS' );
  dbms_application_info.set_client_info( 'Start at '||to_char(sysdate,'dd/mm/yyyy hh24:mi:ss') || 'with p_ZO=' || to_char(p_ZO) );

  ---------------------------------------
  If p_date is null then RETURN; end if ; -- 06.08.2015 ������. ���� ��.��� ���� = �����, �� ������ �����
  ---------------------------------------
  delete from PRVN_AUTOEVENT_ARC
   where REPORTING_DATE = p_date
     and ZO = l_zo;

  insert
    into PRVN_AUTOEVENT_ARC
       ( REPORTING_DATE, REF_AGR, RNK, EVENT_TYPE, EVENT_DATE, OBJECT_TYPE
       , RESTR_END_DAT, CREATE_DATE, ZO, VIDD, CREATE_USER, KF )
  select REPORTING_DATE, REF_AGR, RNK, EVENT_TYPE, EVENT_DATE, OBJECT_TYPE
       , RESTR_END_DAT, CREATE_DATE, ZO, VIDD, BARS.GL.AUID, KF
    from PRVN_AUTOMATIC_EVENT
   where REPORTING_DATE = p_date
     and ZO = l_zo;

  delete from PRVN_AUTOMATIC_EVENT where REPORTING_DATE = p_date and ZO = l_zo;
  delete from PRVN_LOSS_DELAY_DAYS where REPORTING_DATE = p_date and ZO = l_zo;

  -- ���� ��-�������� ������ ������ %% �� ������
  insert
    into ND_ACC ( ACC, ND )
  select a9.acc,  min(n.ND)
    from accounts a9, nd_acc n, accounts a0, cc_deal d
   where a9.nbs = '1508' and a9.dazs is null and not exists ( select 1 from nd_acc where acc = a9.acc)
     and a0.nbs = '1500' and a0.dazs is null and a0.kv = a9.kv and a0.rnk = a9.rnk
     and a0.acc = n.acc  and n.nd = d.nd and d.vidd = 150
   group by a9.acc;

  -- ���� ��-�������� ������ ������ �� FIN/DEB
  dbms_application_info.set_client_info( 'PRVN_FLOW.ADD_FIN_DEB: start at '||to_char(sysdate,'dd/mm/yyyy hh24:mi:ss') );
  PRVN_FLOW.ADD_FIN_DEB( l_dat31 );

  -- ���������� ����� �������� ������� �� ����� ����
  for K in ( select -- 1) ��������� ��������
                    g_CCK as TIP, d.nd GND, d.ND, d.RNK, d.sdate, d.vidd, a.MDATE
               from cc_deal d, nd_acc n, accounts a
              where d.vidd in ( 1,2,3,11,12,13 )
                and d.nd = n.nd and n.acc = a.acc
                and d.sdate <= l_dat31 and a.tip ='LIM'
                and ( a.dazs is null or a.dazs > l_dat31 )
              UNION ALL
             select -- 2) ��� (�������� �������� W4)
                    G_BPK as TIP, w.ND as GND, w.ND, a.RNK, w.DAT_BEGIN, 4 as VIDD, w.DAT_END
               from W4_ACC   w
               join ACCOUNTS a
                 on ( a.ACC = w.ACC_PK )
              where a.DAOS <= l_dat31
                and ( w.DAT_CLOSE is Null OR w.DAT_CLOSE > l_dat31 )
              UNION ALL
             select -- 3) ��� + NOSTRO
                    g_MBK as TIP, d.nd GND, d.ND, d.RNK, d.SDATE, d.vidd, d.WDATE
               from cc_deal d
              where (d.vidd > 1500 and d.vidd < 1600 or d.vidd in (150) )
                and exists (select 1 from nd_acc n, accounts a where n.nd = d.nd and n.acc = a.acc and a.nbs like '15__'
                and fost(a.acc, l_dat31) < 0 ) -- ���� ������ ����� !!
              UNION ALL
             select -- 4) �� ��������
                    g_CP as TIP, d.REF, d.REF, c.RNK, c.DAT_EM, d.id, c.DATP
               from cp_kod c, cp_deal d
              where d.id = c.ID and ( fost(d.acc,l_dat31) < 0 or fost(d.accexpr,l_dat31) < 0 or fost(d.accexpn,l_dat31) < 0 )
              UNION ALL
             select -- 5) FIN_DEB
                    g_DEB as TIP, a.ACC as GND, f.ACC_SP as ND, a.RNK, a.DAOS, 37, a.MDATE
               from BARS.ACCOUNTS a, BARS.PRVN_FIN_DEB f
              where a.ACC = f.ACC_SS and a.DAOS <= l_dat31 and (a.dazs is null or a.dazs > l_dat31)
                and fost(f.ACC_SP, l_dat31) < 0 -- ���� ������ ����� !!
              UNION ALL
             select -- 6) ���������� (����)
                    g_OVR as TIP, o.ND as GND, o.ND, a.RNK, o.DATD, o.VIDD, a.MDATE
               from BARS.ACC_OVER o
               join BARS.ACCOUNTS a
                 on ( a.ACC = o.ACC )
              where o.ACC = o.ACCO
                and o.DATD <= l_dat31
                and ( a.DAZS is null or a.DAZS > l_dat31 )
                and coalesce(sos, 0) <> 110
              UNION ALL
             select -- 6) ���������� (���)
                    g_OVR as TIP, d.ND as GND, d.ND, d.RNK, d.SDATE, d.VIDD, nvl(a.MDATE, d.WDATE)
               from CC_DEAL d
               join ND_ACC n
                 on ( n.ND = d.ND )
               join ACCOUNTS a
                 on ( a.ACC = n.ACC )
              where d.VIDD = 110
                and d.SDATE <= l_dat31
                and a.NBS = '2600'
                and ( a.DAZS is null or a.DAZS > l_dat31 )
              UNION ALL
              select -- 7) ����.���������
                     g_XOZ as TIP, x.id as GND, x.id as ND, a.RNK, x.FDAT, 21 as VIDD, x.MDATE
               from XOZ_REF  x
               join ACCOUNTS a
                 on(x.acc = a.acc)
           )
    loop

      -- ������ ���
      If ( k.TIP = G_DEB OR k.TIP = G_BPK OR k.TIP = g_XOZ)  --VVV
--      If ( k.TIP = G_DEB OR k.TIP = G_BPK)   --VVV
      then
        -- ���. Գ�.���. �� ����� ���. �����. ���
        -- ���. ��� ������������ ����. LOSS_RATING_BPK
        -- ���. ����.���. �� ����� ���. �����. ���
        null;
      else

        If ( k.TIP = g_CP )
        then loss_rating( k.TIP, k.vidd, l_dat31, l_ZO, l_event_type, l_status, l_event_date);
        else loss_rating( k.TIP, k.GND , l_dat31, l_ZO, l_event_type, l_status, l_event_date);
        end if;

        if ( l_status = 1 )
        then SET_EVENT( p_date, k.GND, k.RNK, l_event_type, l_event_date, k.TIP, Null, l_create_date, l_ZO, k.vidd );
        end if;

      end if;

      -- ���������
      If ( k.TIP = g_BPK )
      then -- ��� ���
        null;
      else

        If k.TIP = g_DEB
           then loss_delay(k.TIP, k.GND, null, k.sdate, k.ND, null, l_dat31, l_event_type, l_event_date, l_status, l_days, l_days_corr, l_ZO, k.mdate);
        elsif  k.TIP = g_XOZ
           then loss_delay(k.TIP, k.GND, null, k.sdate, null, null, l_dat31, l_event_type, l_event_date, l_status, l_days, l_days_corr, l_ZO, k.mdate);   --VVV  ��� ��� ��� ������ ��������?
           --then loss_delay(k.TIP, k.GND, null, k.sdate, null, null, p_date, l_event_type, l_event_date, l_status, l_days, l_days_corr, l_ZO, k.mdate);  --VVV
        else loss_delay(k.TIP, k.GND, null, k.sdate, null, null, l_dat31, l_event_type, l_event_date, l_status, l_days, l_days_corr, l_ZO, k.mdate);
        end if;

        if l_status = 1
        then
          SET_EVENT(p_date, k.GND, k.RNK, l_event_type, l_event_date, k.TIP, null, l_create_date, l_ZO, k.vidd);
        end if;

        if l_days <> 0 or l_days_corr <> 0
        then
          SAVE_LOSS_DELAY_days(k.TIP, k.GND, p_date, l_event_date, l_days, l_days_corr, l_ZO );
        end if;

      end if;

    end loop;

    -- ������ ��� �� ���. ���
    dbms_application_info.set_client_info( 'FALLING_RATING: start at '||to_char(sysdate,'dd/mm/yyyy hh24:mi:ss') );

    LOSS_RATING_BPK( p_report_dt  => p_date
                   , p_adjustment => l_ZO );

    -- ������ ������������
    dbms_application_info.set_client_info( 'DEATH: start at '||to_char(sysdate,'dd/mm/yyyy hh24:mi:ss') );

    for c_dth in ( select d.ND, d.RNK, d.VIDD, d.OBJ, w.VALUE
                     from ( select ND, RNK, VIDD,
                                   g_CCK as OBJ
                              from BARS.CC_DEAL
                             where SOS in (0,10,11,13)
                             union all
                            select wa.ND, a.RNK,
                                   4 as VIDD,
                                   g_BPK as OBJ
                              from BARS.W4_ACC wa,
                                   BARS.ACCOUNTS a
                             where wa.ACC_PK = a.acc
                               and a.DAZS is Null
                          ) d
                     join BARS.CUSTOMERW w
                       on ( w.rnk = d.rnk AND w.tag = 'DEATH' )
                    where w.value is Not Null )
    loop
      set_event( p_date, c_dth.ND, c_dth.RNK, 4, p_date, c_dth.OBJ, null, l_create_date, l_ZO, c_dth.VIDD );
    end loop;

    -- ���������� ����. ���.
    dbms_application_info.set_client_info( 'FRAUD: start at '||to_char(sysdate,'dd/mm/yyyy hh24:mi:ss') );
-- �� ����������� ������� "����������" ��������� � ������ ������� ������� �� �����
--   ��, ���� ��������������� ����� xoz_ref � ��������� �� ������ ���� �� ������
--   ��, �������� ����������� ������� (ost_korr ��� FOST) ����� �������� �� �������� ����� xoz_ref (s � s0)
--   ��� �������� �������. �� ���� ���������.
    FOR c_f IN ( SELECT x.id, A.RNK, g_XOZ as OBJ, 21 as vidd
                  FROM xoz_ref x 
                  JOIN accounts a 
                    ON (a.acc = x.acc)
                 WHERE ( ( a.NBS = '3552' AND a.ob22 IN ('01','02','03','13') ) or
                         ( a.NBS = '3559' AND a.ob22 IN ('06','07','08')      ) )
                       AND (a.dazs IS NULL or a.dazs > l_dat31)                   -- ��������� ��� ������� �����, �� �������� �� �������� ����
                       AND a.daos <= l_dat31
                       AND decode(l_ZO, 1,                                        -- ����� ������� �� ����� ���
                               OST_KORR(a.acc, l_dat31, 0, a.nbs),        -- c ������ �������������� �� AGG_MONBALS
                               FOST(a.acc, l_dat31) ) <> 0                -- ���� ��� �������������� �� SALDOA
                       AND (x.datz is null or x.datz > l_dat31)                   -- ���������� ��������� �� ������� ��������, �������� �� �������� ����
                       AND x.fdat <= l_dat31
                )
     LOOP
       set_event( p_date, c_f.id, c_f.RNK, 5, p_date, c_f.OBJ, null, l_create_date, l_ZO, c_f.VIDD );
     END LOOP;

    -- � ������ ����������������
    dbms_application_info.set_client_info( 'LOSS_RESTRUCTURING: start at '||to_char(sysdate,'dd/mm/yyyy hh24:mi:ss') );
    loss_restructuring( p_date, l_create_date , l_ZO );

    dbms_application_info.set_action(NULL);
    dbms_application_info.set_client_info(NULL);

end loss_events;

end bars_loss_events;
/

show err;