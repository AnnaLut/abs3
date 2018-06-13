
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/cck_new.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.CCK_NEW is

  G_HEADER_VERSION  CONSTANT VARCHAR2(64)  := 'version 1 13-06-2018';


  tobo_ varchar2(12);     -- ��� ������������
  CC_TOBO_ char(1) :='0'; -- 0 ��������� ��; 1- ��������� ����
  SUMO_CF number; -- ��������� ����� ������������ �������
  G_CC_KOM_ int;  -- ������������ ��� �� �����

  FL38_ASP int; --���� ������ ��� ��������  "ASP"
  SPN_BRI_ int; -- ������� ������ ����;

  CC_KVSD8 char(1); -- 1=���� ���� ��������� � ��� ��, ����� � ���.���.
  CC_DAYNP number;  -- ���������� ���� ��������� �� 0 - ������� 1 - �����
  CC_SLSTP number;  -- ��� ���� ��� SL ����������� �����-�� (0) �� ������������ ����� - 1
  G_CCK_MIGR number;  -- 1- ������� ����� ��������
  ern CONSTANT POSITIVE := 203;  erm VARCHAR2(250);  err EXCEPTION;

  PROCEDURE cc_gpk_msg(nd_ INT);

  -- ����� ���� ���������� ���
  PROCEDURE cc_gpk
  (
    mode_  INT,
    nd_    INT,
    ds_pog  NUMBER,
    flag   INT DEFAULT 0
  );


  PROCEDURE cc_gpk_ann
  ( nd_    INT,
    acc_   INT,
    Pl_    NUMBER,
    T_     INT,
    S_     NUMBER,
    Ostf   NUMBER,
    P_ir   NUMBER,
    nday_  NUMBER,
    d_sdate DATE,
    d_wdate DATE,
    d_apl_dat DATE,
    basey_ INT,
    dog_st INT,
    flag   INT DEFAULT 0
  );


  PROCEDURE cc_gpk_classic
  (
    nd_    INT,
    acc_   INT,
    Pl_    NUMBER,
    T_     INT,
    S_     NUMBER,
    Ostf   NUMBER,
    P_ir   NUMBER,
    nday_  NUMBER,
    d_sdate DATE,
    d_wdate DATE,
    d_apl_dat DATE,
    basey_ INT,
    flag_r INT,
    day_np INT,
    dog_st INT,
    freq   INT,
    flag   INT DEFAULT 0
  );

  PROCEDURE cc_gpk_freq
   (
    nd_    INT,
    acc_   INT,
    Pl_    NUMBER,
    T_     INT,
    S_     NUMBER,
    Ostf   NUMBER,
    P_ir   NUMBER,
    nday_  NUMBER,
    d_sdate DATE,
    d_wdate DATE,
    d_apl_dat DATE,
    basey_ INT,
    flag_r INT,
    day_np INT,
    dog_st INT,
    freq   INT,
    flag   INT DEFAULT 0
  );

  FUNCTION plan_rep_gpk(nd_ INT, d_rep DATE) return varchar2;
  FUNCTION prepayment_gpk(nd_ INT, d_rep DATE) return varchar2;
  FUNCTION billing_date(dd_n INT, d_rep DATE) RETURN DATE;
  FUNCTION CorrectDay( p_KV int, p_OldDate date, p_Direct number:=1) RETURN DATE;

  function header_version return varchar2;
  function body_version return varchar2;

end CCK_NEW;


/
CREATE OR REPLACE PACKAGE BODY BARS.CCK_NEW is

 G_BODY_VERSION  CONSTANT VARCHAR2(64)  := 'ver.1  25/05/2018 ';

 G_REPORTS number:=0;  -- (1) - �������� ����� ���������� ��� ������
 -- ������ ���� ���������� ���

 -- �������� ������ ���  ��� ���������� ����
 --  cck.cc_gpk(:GPK,
 --              pul.Get_Mas_Ini_Val ('ND'),
 --              null,null,null,null,null,null,null ,
 --              :TYPE,1)
 -- :GPK(SEM=����� ��������,TYPE=N,REF=CC_V_GPK),
 -- :TYPE(SEM=����� ������������,TYPE=N,REF=VW_GPK_ROUND_TYPE)
 --18006440001
  PROCEDURE cc_gpk_msg(nd_ INT) IS
    d_vidd     int;
    a_acc      number;
    a_vid      int;
    ia_basey   int;
    r_bdat     date;
    r_ir       number;
    err        int;
    txt        varchar2(1000);
    tt         varchar2(10);
    ts         varchar2(100);
  BEGIN
    tt:='
';
    err:=0;
    BEGIN
      select cd.vidd,
             a.acc,
             a.vid,            -- ��� ���� �����
             ia.basey          -- ����� ���������� %
        into d_vidd, a_acc, a_vid, ia_basey
        from cc_deal cd,
             nd_acc na,
             accounts a,
             int_accn ia,
             freq q,
             basey b
       where cd.nd = nd_
         and cd.nd = na.nd
         and na.acc = a.acc
         and a.tip = 'LIM'
         and ia.acc = a.acc
         and ia.id = 0
         and b.basey = ia.basey
         and q.freq = ia.freq;

      select r.bdat, r.ir  -- ���� ���������, �������������� % ������
        into r_bdat, r_ir
        from INT_RATN r
       where acc = a_acc
         and id = 0
         and rownum=1
       order by bdat asc;
    EXCEPTION
       WHEN no_data_found THEN
         err:=err+1;
         raise_application_error(-20001, '��� �� (' || nd_ || ' ) �� ������� ������ ��������� �������� ��� �������� ���!');
       WHEN OTHERS THEN
         err:=err+1;
         --DBMS_OUTPUT.PUT_LINE(err);
         raise_application_error(-20002, '��� �� (' || nd_ || ' ) ������� ���������� �������� ��������� �������� ��� �������� ���! '||SQLERRM );
    END;
    txt:='';
    ts:=null;
    if err=0 then  --20000
      txt:= '³�������� ������: '||r_ir||tt;
      if nvl(ia_basey, -1) not in(0,1,2,3) then
        err:=err+1;
        raise_application_error(-20003, '��� �� (' || nd_ || ' ) ������� ���������� ������ ����������� % ��� �������� ���!');
      else
        select decode(ia_basey, '0', '�% ����/����  ACT/ACT',
                              '1', '�% ����/365  AFI/365',
                              '2', '�% SIA 30/360  SIA 30/360',
                              '3', '�% ����/360  ACT/360')
          into ts
          from dual;
          txt:=txt||'����� �����������: '||ts||tt;
          ts:=null;
      end if;

      select decode(a_vid, '1', '��������� ��� ������� ������ ������',
                           '2', '��������� ��� ������� � ���� ������',
                           '3', '���������� ������� ������ ������ � %% ( ������ )')
         into ts
         from dual;
         txt:=txt||'          ��� ���: '||ts||tt;
         ts:=null;

    end if;
    DBMS_OUTPUT.PUT_LINE(txt);
    -- ����� ��� ���� ��������?
  END;


  PROCEDURE cc_gpk(mode_  INT, --������ �������� 1-���� ������� �������; 2-���� � ����� �����; 3- �������
                   nd_    INT,
                   ds_pog  NUMBER, -- 1-����� ��������, 0-��� ��������, ������ �������� �������
                   flag   INT DEFAULT 0) IS  --0 - ������ �� ������, 1- ���� �� ������
    d_vidd     int;
    d_sdate    date;
    d_wdate    date;
    d_sdog     number;
    a_acc      number;
    a_vid      int;
    a_ostb     number;
    a_ostc     number;
    ia_apl_dat date;
    ia_basem   int;
    ia_basey   int;
    ia_s       int;
    ia_freq    int;
    r_bdat     date;
    r_ir       number;
    flag_s     CHAR(2);
    flag_r     int;
    flag_p     int;
    day_np     int;
    day_sn     int;
    dat_sn     date;
    date_plan  date;
    date_v     date;
    date_os    date;
    date_n     date;
    date_ch    TIMESTAMP;
    dog_st     int;     -- 0-�����; 1-�����������;
    s_ostf     number;
    s_pog      number;
    n          number DEFAULT 0; -- ���������� ��� ������������� ��������, �� �������� �������
    dd_n       date;  -- ���������� ��� ������������� ��������, ���� ����
    T          int;
    is_Pog     int;
    s_Plan     number;
    is_GPK     int DEFAULT 0;  -- ���������� ������ ���������, � ����������� ����� 0 ��� ��� 1
    err        int;


    S          number;
    Pl         number;
    d_start    date;
    flag_d     int;


  BEGIN
    /* bars_audit.info('CC_GPK.MODE_=' || mode_ || ', ND_=' || nd_ ||
    ' ,ACC_=' || acc_ || ' ,BDAT_1=' || bdat_1 ||
    ' ,DATN_=' || datn_ || ' ,DAT4_=' || dat4_ ||
    ' ,SUM1_=' || sum1_ || ' ,FREQ_=' || l_freq_ ||
    ',DIG_=' || dig_);*/
    --nd_:= 19166342701;--7362901; --9229101;  --7362901; --19169861311;  --19169861611; --7362901; --19169979711; ��������
    --nd_:= 19166177701; --19167325701; --19169621301; --19161938401;  -- ��������
    --dig_:=0;
    is_Pog:=0;
    s_Plan:=0;
    err:=0;
    -- ����������� ���������, ����������� �� ������� ����
      BEGIN
        select cd.vidd,
               cd.sdate,         -- ���� ���������� ��������
               cd.wdate,         -- ���� ����������
               cd.sdog,          -- ����� �� ��������
               a.acc,
               a.vid,            -- ��� ���� �����
              -a.ostb,           -- �������� �������
              -a.ostc,           -- ����������� �������
               ia.apl_dat,       -- ���� ��������� �������(������ ��������� ����)
               ia.basem,         -- 0 - ����������� (28-31 ����); 1 - ���������� (30)
               ia.basey,         -- ����� ���������� %
               ia.s,             -- ���� ������
               ia.freq           -- ������������� ������
          into d_vidd, d_sdate, d_wdate, d_sdog, a_acc, a_vid, a_ostb, a_ostc, ia_apl_dat, ia_basem, ia_basey, ia_s, ia_freq
          from cc_deal cd,
               nd_acc na,
               accounts a,
               int_accn ia,
               freq q,
               basey b
         where cd.nd = nd_
           and cd.nd = na.nd
           and na.acc = a.acc
           and a.tip = 'LIM'
           and ia.acc = a.acc
           and ia.id = 0
           and b.basey = ia.basey
           and q.freq = ia.freq;

       select r.bdat, r.ir  -- ���� ���������, �������������� % ������
         into r_bdat, r_ir
         from INT_RATN r
        where acc = a_acc
          and id = 0
          and rownum=1
        order by bdat asc;
      EXCEPTION
         WHEN no_data_found THEN
           err:=err+1;
           raise_application_error(-20001, '��� �� (' || nd_ || ' ) �� ������� ������ ��������� �������� ��� �������� ���!');
         WHEN OTHERS THEN
           err:=err+1;
           --DBMS_OUTPUT.PUT_LINE(err);
           raise_application_error(-20002, '��� �� (' || nd_ || ' ) ������� ���������� �������� ��������� �������� ��� �������� ���! '||SQLERRM );
      END;

      -- ��������� ��������� ��������
      if err=0 then  --20000
        -- ����� ���������� %
          --0 �% ����/����  ACT/ACT
          --1 �% ����/365  AFI/365
          --2 �% SIA 30/360  SIA 30/360
          --3 �% ����/360  ACT/360
        if nvl(ia_basey, -1) not in(0,1,2,3) then
          err:=err+1;
          raise_application_error(-20003, '��� �� (' || nd_ || ' ) ������� ���������� ������ ����������� % ��� �������� ���!');
        end if;

        -- �������� ��� ��������� ������ ��������
        if ia_basey=2 then a_vid:=4; end if;
        ------------------------------------------

        -- ����� ������������ - ��. �������� dig_
          -- 0  0.��� 1123.45
          -- 1  1.10 "���" 1123.50
          -- 2  2.100 "���" 1124.00

        -- ��� ������� - ��. �������� mode_, ������ ����� � ���������� a_vid
          --  1.��������� ��� ������� ������ ������
          --  2.��������� ��� ������� � ���� ������
          --  3.���������� ������� ������ ������ � %% ( ������ )

        if d_sdate is null then
          err:=err+1;
          raise_application_error(-20004, '��� �� (' || nd_ || ' ) ������� ���������� ���� ������� ��������!');
        end if;

        if nvl(ia_s, 0) = 0 then
          err:=err+1;
          raise_application_error(-20005, '��� �� (' || nd_ || ' ) ������� ���������� ��� ������� ���� ��������� ����� ��� �������� ���!');
        end if;

        if ia_apl_dat is null then
          err:=err+1;
          raise_application_error(-20006, '��� �� (' || nd_ || ' ) ������� ���������� ������� ���� ��������� ����� ��� �������� ���!');
        end if;

        -- ����������� ������ ��������� �����, �������
        if nvl(ia_freq,0) not in(360,180, 120, 40, 30, 12, 7, 5 ) then
          err:=err+1;
          raise_application_error(-20007, '��� �� (' || nd_ || ' ) ����������� ������ �� �� ���������� ��������!');
          if a_vid=4 and nvl(ia_freq,0)<>5 then
            raise_application_error(-20007, '��� �� (' || nd_ || ' ) ����������� ������ ��� ������� �� � ��������!');
          end if;
        end if;

        -- ����� �� ��������
        if nvl(d_sdog,0) = 0 then
          err:=err+1;
          raise_application_error(-20008, '��� �� (' || nd_ || ' ) �� ��������� ���� ��������!');
        end if;

        -- ³�������� ������
        if nvl(r_ir, 0) = 0 then
          err:=err+1;
          raise_application_error(-20009, '��� �� (' || nd_ || ' ) ������� ���������� ��������� ������ ��� �������� ���!');
        end if;

        dat_sn:=null; day_sn:=null;
        flag_s := cck_app.get_nd_txt(nd_, 'FLAGS');                         -- �������� � ����������, ��� �������
        day_np := cck_app.to_number2(cck_app.get_nd_txt(nd_, 'DAYNP'));     -- ��� ������������ ��� ���������
        day_sn := cck_app.to_number2(cck_app.get_nd_txt(nd_, 'DAYSN'));     -- ���� ��������� ���������
        dat_sn := to_date(cck_app.get_nd_txt(nd_, 'DATSN'), 'dd.mm.yyyy');  -- ���� ������� ��������� ���������

        if day_np is null then
          day_np:=-2;  --��� �������������, 0-���������, 1-����������
        end if;

        if flag_s is null then
          flag_r:=1;  --% 1=�����, 0=����
          flag_p:=0;  --�������� �� ����������
        else
          if flag_s in('00','01','02','10','11','12','90','91') then
            flag_r:=to_number(substr(flag_s,2,1));
            flag_p:=to_number(substr(flag_s,1,1));
          else
            flag_r:=1;
            flag_p:=0;
          end if;
        end if;

        --if a_vid=4 and flag_r=0 then
        --  raise_application_error(-20009, '��� �� (' || nd_ || ' ) ��� ������� �������� ''�� ���������'' ��� ��������� �������, ������� ���������� ''̳����''!');
        --end if;

        --if a_vid=4 and day_np<>-2 then
        --  raise_application_error(-20009, '��� �� (' || nd_ || ' ) ��� ������� �������� ''��� ������������ ��� ���������'' ��� ��������� ��������� �����, ������� ���������� ''��� ������������''!');
        --end if;

        if dat_sn is null then
          dat_sn:=ia_apl_dat; --������ ��������� � ��������� ����� ���������
          day_sn:=ia_s;
        else
          if day_sn is null then
            err:=err+1;
            raise_application_error(-20005, '��� �� (' || nd_ || ' ) ������� ���������� ��� ������� ���� ������� ��� �������� ���!');
          end if;
        end if;
      end if;
      ------------------------------
      dog_st:=0;
      is_Pog:=0;
      if err=0 then
        -- ���� ��������� �� �������, ��������� �������� �� ����� SS
        date_os:=null;
        begin
          select max(s.FDAT)
            into date_os
            from nd_acc n, accounts a, SALDOA s
           where n.ND = nd_
             and a.acc= n.acc
             and a.tip = 'SS'
             and s.acc=a.acc
             and s.kos<>0;
        EXCEPTION
          WHEN no_data_found THEN
            date_os:= null;
        end;

        if date_os is not null then
          select -(s.ostf+s.kos)/100, -s.ostf/100
            into s_pog, s_ostf                          --����������� � �������� ������� �� ������� ��� ���������
            from nd_acc n, accounts a, SALDOA s
           where n.ND = nd_
             and a.acc= n.acc
             and a.tip = 'SS'
             and s.acc=a.acc
             and s.kos<>0
             and s.FDAT = date_os;

          -- ����� ���������, ���������� ����� �������� ���� � ������ ����� ������������� ������
          date_v:=billing_date(ia_s, date_os);  --to_date(ia_s||substr (to_char(date_os, 'dd.mm.rrrr'), 3, 8),'dd.mm.rrrr' );
          dog_st:=1; -- ��� �� ����� ������, �� ��� ����� ������������� ���� ����������
        else
          date_v:=d_sdate;
          dog_st:=0; -- ����� ������
          s_pog:=d_sdog;
          s_ostf:=d_sdog;
        end if;

        --DBMS_OUTPUT.PUT_LINE('date_v1='||to_char(date_v, 'dd.mm.yyyy'));

        -- ����������� ������ ���������, �� ������ ���������� ������ ��������� �����
        if dat_sn < ia_apl_dat then -- ���� ������ % � ��������� ���� �� ���������, ���� �������� �� ������ %
          date_os:=null;            -- �� ������ ������ ��������� ���� �������� �� ������ ���������
          begin
            select max(s.FDAT)
              into date_os
              from nd_acc n, accounts a, SALDOA s
             where n.ND = nd_
               and a.acc= n.acc
               and a.tip = 'SN'
               and s.acc=a.acc
               and s.kos<>0;
          EXCEPTION
            WHEN no_data_found THEN
              date_os:= null;
          end;

          --DBMS_OUTPUT.PUT_LINE('date_os2='||to_char(date_os, 'dd.mm.yyyy'));

          -- ���� ��������, ��� ���� ��������� �������� �� ������ % ������ ���� ���� �������� �� ������ �����, ��
          -- �������� ���� � ������� ����� ������������� ������ �� ���� �������� �� %

          if date_os is not null and (date_os>date_v or dog_st=0) then
            date_v:=billing_date(ia_s, date_os);
            dog_st:=1; -- ��� �� ����� ������, �� ��� ����� ������������� ���� ����������
            --DBMS_OUTPUT.PUT_LINE('date_v3='||to_char(date_v, 'dd.mm.yyyy'));
          end if;
        end if;

        --DBMS_OUTPUT.PUT_LINE('date_v2='||to_char(date_v, 'dd.mm.yyyy'));

        -- ���������� ���������� ���������� �������� �������� �� ��������, �� ����� ����������� ��������
        T:=0;
        BEGIN
          select months_between(trunc(d_wdate, 'month'), trunc(date_v, 'month') )
            into T
            from dual;
          --DBMS_OUTPUT.PUT_LINE(T);
        EXCEPTION
          WHEN OTHERS THEN
            T:=0;
        END;

        -- ��������� ������� ������� � CC_LIM
        n:=0;
        select count(acc)
          into n
          from cc_lim
         where acc=a_acc;

        -- ��� ��� ������� -----------
        if n>0 then  -- ���� ������ � CC_LIM
          --raise_application_error( err, '��� �� (' || nd_ || ' ) ��� ��� �����������, ��� ���������� ��� ��������� �������� ������ ���� ���������� ���������!');
          DBMS_OUTPUT.PUT_LINE('��� ��� �����������, ��� ���������� ��� ��������� �������� ������ ���� ���������� ���������!');
        end if;
        -----------------------------------------------

        if n>0 and dog_st=1 then --���� ������� ������ � cc_lim � ������ �����������, ���� ��������
          n:=0;
          dd_n:=null;
          -- �������� ���������� ����� ��������� �������
          select max(fdat)
           into dd_n
           from cc_lim
          where acc=a_acc;

          if a_vid = 4 then
            select sumo/100
             into s_Plan  --����� ��������� �������
             from cc_lim
            where acc=a_acc
              and fdat>=ADD_MONTHS(dd_n,-2)
              and fdat<dd_n
              and rownum = 1;
          else
             select sumg/100
             into s_Plan  --����� ��������� �������
             from cc_lim
            where acc=a_acc
              and fdat>=ADD_MONTHS(dd_n,-2)
              and fdat<dd_n
              and rownum = 1;
          end if;
          --DBMS_OUTPUT.PUT_LINE('s_Plan='||s_Plan);
          --DBMS_OUTPUT.PUT_LINE('dd_n='||to_char(dd_n, 'dd.mm.yyyy'));
        end if;
      end if;

      /*    if date_ch is not null and date_n >=trunc(sysdate) then --���� % ������ � ������� ����� ������ ��������
            if n<>r_ir then --% ������ ���������� �� �������
              -- ��� ����� ��������� � �������� ��� �������� ���������� ������� ����
              is_Pog:=1;
              date_v:=billing_date(ia_s, date_n);
              r_ir:=n;
              dog_st:=1;
              --����� ������������� ������ ��� ����� % ������ � ���� ��������, ��������� ������ �� �������
              --������ ������� ������ �� ��������� ����� % ������
            end if;
          end if; */
          ------------------------------
/*
      -- ��� ��� ����� ������������ ��� �������
      --DBMS_OUTPUT.PUT_LINE('d_vidd='|| d_vidd);
      --DBMS_OUTPUT.PUT_LINE('d_sdate='||to_char(d_sdate,'dd.mm.yyyy'));
      DBMS_OUTPUT.PUT_LINE('date_plan='||to_char(date_plan,'dd.mm.yyyy'));
      DBMS_OUTPUT.PUT_LINE('date_v='||to_char(date_v,'dd.mm.yyyy'));
      DBMS_OUTPUT.PUT_LINE('d_wdate='||to_char(d_wdate,'dd.mm.yyyy'));
      DBMS_OUTPUT.PUT_LINE('s_Plan='||s_Plan);
      DBMS_OUTPUT.PUT_LINE('d_sdog='||d_sdog);
      DBMS_OUTPUT.PUT_LINE('a_acc='||a_acc);
      DBMS_OUTPUT.PUT_LINE('a_vid='||a_vid);
      --DBMS_OUTPUT.PUT_LINE('a_ostb='||a_ostb);
      --DBMS_OUTPUT.PUT_LINE('a_ostc='||a_ostc);
      DBMS_OUTPUT.PUT_LINE('ia_apl_dat='||to_char(ia_apl_dat,'dd.mm.yyyy'));
      --DBMS_OUTPUT.PUT_LINE('ia_basem='||ia_basem);
      --DBMS_OUTPUT.PUT_LINE('ia_basey='||ia_basey);
      --DBMS_OUTPUT.PUT_LINE('ia_s='||ia_s);
      --DBMS_OUTPUT.PUT_LINE('ia_freq='||ia_freq);
      --DBMS_OUTPUT.PUT_LINE('r_ir='||r_ir);
      --DBMS_OUTPUT.PUT_LINE('r_bdat='||to_char(r_bdat,'dd.mm.yyyy'));
      --DBMS_OUTPUT.PUT_LINE('s_ostf='||s_ostf);
      DBMS_OUTPUT.PUT_LINE('T='||T);
      DBMS_OUTPUT.PUT_LINE('n='||n);
      DBMS_OUTPUT.PUT_LINE('dog_st='||dog_st);
      --DBMS_OUTPUT.PUT_LINE('is_Pog='||is_Pog);

      DBMS_OUTPUT.PUT_LINE(' ����� - �������� �������!!!!');
      DBMS_OUTPUT.PUT_LINE('                   ');
*/
      -- ��������� ������ � ����������� �� ���� ������� � ����������� �������
        --ia_basey; -- ����� �����������
        --r_ir;  -- % ������
        --ia_s;  -- ���� ������
        --d_wdate;
        --a_acc;
        --day_np;
        --T;  --���������� ��������
      if a_vid = 4 then --��������
        Pl:=s_Plan;
        if dog_st=0 then -- ��������� �� ����, ����� ������
          S:=d_sdog;
          d_start:=d_sdate;
        else  -- ��������� ����
          S:=s_pog;  -- ������ ����� ����� �������
          d_start:=date_v;
        end if;
        cc_gpk_ann(nd_,
                   a_acc,
                   Pl,
                   T,
                   S,
                   s_ostf,
                   r_ir,
                   ia_s,
                   d_start,
                   d_wdate,
                   ia_apl_dat,
                   ia_basey,
                   dog_st,
                   flag);
      end if;

      if a_vid = 2 then --��������
        if dog_st=0 then -- ��������� �� ����, ����� ������
          S:=d_sdog;
          d_start:=d_sdate;
          Pl:=0;
        else  -- ��������� ����
          --DBMS_OUTPUT.PUT_LINE('�����  s_pog='||s_pog||';  s_Plan='||s_Plan);
          S:=s_pog;  -- ������ ����� ����� �������
          d_start:=date_v;
          Pl:=s_Plan;
        end if;
--day_np:=1;
        if ia_freq=5 then
          cc_gpk_classic(nd_,
                        a_acc,
                        Pl,
                        T,
                        S,
                        s_ostf,
                        r_ir,
                        ia_s,
                        d_start,
                        d_wdate,
                        ia_apl_dat,
                        ia_basey,
                        flag_r,
                        day_np,
                        dog_st,
                        ia_freq,
                        flag);
        else
          cc_gpk_freq(nd_,
                        a_acc,
                        Pl,
                        T,
                        S,
                        s_ostf,
                        r_ir,
                        ia_s,
                        d_start,
                        d_wdate,
                        ia_apl_dat,
                        ia_basey,
                        flag_r,
                        day_np,
                        dog_st,
                        ia_freq,
                        flag);
        end if;
      end if;

  END cc_gpk;

  PROCEDURE cc_gpk_ann(
                   nd_    INT,         --�������
                   acc_   INT,         --���� 8999
                   Pl_    NUMBER,      --�������� ������
                   T_     INT,         --���������� ��������
                   S_     NUMBER,      --����� �������
                   Ostf   NUMBER,      --�������� ������� �� ������� ��� ���������
                   P_ir   NUMBER,      --% ������
                   nday_    NUMBER,      --���� ������ ��� �����
                   d_sdate DATE,       --���� ������
                   d_wdate DATE,       --���� ���������
                   d_apl_dat DATE,     --������ ��������� ���� ��� ����
                   basey_ INT,         --����� ���������� %
                   dog_st INT,         -- 0- ����� �����, 1 - ������ ������
                   flag   INT DEFAULT 0--0 - ������ �� ������, 1- ���� �� ������
                   ) IS

    Pl       number;
    T        int;
    P        number;
    txt      varchar2(1000);
    S        number;

    P_ratn    number;      -- ������� ���������� ������
    s_b       number;      -- ��������� ��������� �����
    s_s       number;      -- ������� �� ������� �� ���������
    s_Ostf    number;      -- ������� �� ���������� ������ �� ���� ���������
    s_m       number;      -- ������� �� ������� ����� ���������
    s_i       number;      -- ��������� ���������
    date_plan date;        -- ���� ��������� �������
    date_fact date;        -- ���� ��������� ����������
    date_pog  date;        -- ���� ���������
    n_day     int;         -- ���������� ���� � �������
    n_yy      int;         -- ���������� ���� � ����
    bm int;                -- ����� ����������
    Dp  int;               -- ���� ���������
    s1  number;            -- ������������� ������
    d_start date;          -- ���� ������, ����
    d_end   date;          -- ���� ��������, ����
    last_d  date;          -- ��������� ���� ������
--    flag_d int;            -- ���� ��� ���������� ���������; 0-����� ������; 1-���� ��������, ����� ��������� �� ������, ��������� ����; 2-���� ��������, ����� ��������� �������������, ���� ���������� ��������� �� ������
    acc_n  int;
    n      number DEFAULT 0; -- ���������� ��� ������������� ��������, �� �������� �������
    P_ratn_old number;
    d_rate date;

  BEGIN

  ------------------------------------
  -- ��������� ��� ���������, � ���� ������������� �������� �����������
  ------------------------------------

  -- ������ ����� ���������
  Pl:=Pl_;
  T:=T_;
  S:=S_;
  P:=P_ir;
  bm:=basey_; -- ����� �����������
  Dp:=nday_;  -- ���� ������
  d_start:=d_sdate;
  d_end:=d_wdate;
  acc_n:=acc_;

  if dog_st=0 and nvl(Pl,0)=0 then
                                     -- ����� ������, �������� ������ ����������
    s1:= P/(12*100);
--    DBMS_OUTPUT.PUT_LINE('S='||S||'  s1='||s1);
    Pl:= S*s1/( 1-POWER( (1+s1), -T) );
    Pl:=ROUND(Pl,2);
    --Pl:=ROUND(Pl,0);
    --Pl:=ceil(Pl*100)/100;
    --date_plan:=d_start;
    --DBMS_OUTPUT.PUT_LINE('Pl=!!'||Pl||'  T='||T);
    --DBMS_OUTPUT.PUT_LINE('----------------');
  else
    if flag=1 then -- ���� ���������� ��������� �� ������
      -- ����������� ����� ���������� ��������
      BEGIN
        select months_between(trunc(d_end, 'month'), trunc(d_sdate, 'month') )
          into T
         from dual;
      EXCEPTION
        WHEN OTHERS THEN
        T:=0;
      END;

      if T>0 then
        s1:= P/(12*100);
        --DBMS_OUTPUT.PUT_LINE(s1);
        Pl:= S*s1/( 1-POWER( (1+s1), -T) );
      else
        Pl:=0;
      end if;
      Pl:=ROUND(Pl,2);
      --Pl:=ceil(Pl*100)/100;
      
    end if;

  end if;

  date_plan:=billing_date(Dp, d_start);
  --select  billing_date(Dp, d_start)
  --  into date_plan
  --  from dual;

  ------------------- ������ ������ �� �������
  BEGIN
    delete from cc_lim
     where nd=nd_
       and acc=acc_
       and fdat>d_start;
    commit;
  EXCEPTION
        WHEN OTHERS THEN
    rollback;
    raise_application_error(-20203, '������� ��������� ���!'||sqlerrm);
  END;
  -------------------
--DBMS_OUTPUT.PUT_LINE('T=!!'||T);
--DBMS_OUTPUT.PUT_LINE('Pl=!!'||Pl);

  P_ratn:=P;
  n:=1;
  s_s:=S; -- ������� �� ������� �� ���������
  s_Ostf:=S;


  WHILE n<=T LOOP
    txt:=null;

    if n=1 then
      date_fact := d_start;
    else
      date_fact := date_plan;
    end if;

    P_ratn_old:=0;

    if n>1 then
      P_ratn_old:=P_ratn;

      select max(r.bdat)
        into d_rate
        from INT_RATN r
       where acc = acc_
         and id = 0
         and r.bdat <= date_plan;

      select r.ir
        into P_ratn
       from INT_RATN r
      where acc = acc_
        and id = 0
        and r.bdat = d_rate;


      if P_ratn_old<>P_ratn then
        --����������� ����� ���������� ��������
        --����� ����������� ����� ��������
        BEGIN
          select months_between(trunc(d_end, 'month'), trunc(date_plan, 'month') )
            into T
           from dual;
        EXCEPTION
          WHEN OTHERS THEN
          T:=0;
        END;

        if T>0 then
          s1:= P_ratn/(12*100);
          --DBMS_OUTPUT.PUT_LINE(s1);
          Pl:= S*s1/( 1-POWER( (1+s1), -T) );
        else
          Pl:=0;
        end if;
        Pl:=ROUND(Pl,2);
        --Pl:=ceil(Pl*100)/100;
        --DBMS_OUTPUT.PUT_LINE(Pl);

      end if;
    end if;

    if nvl(bm, 0) = 0 then bm:=1; end if;

    select add_months(trunc(date_plan,'yyyy'),12)-trunc(date_plan,'yyyy') into n_yy from dual;
    s_i:=0; s_b:=0; s_m:=0;

    select LAST_DAY( date_fact ) into last_d from dual;
    if n=1 then
      select last_d-date_fact into n_day from dual;
      n_day:=n_day+1;
    else
      select date_plan-trunc(date_fact, 'month') into n_day from dual;  -- �������� ���� ����� ������ �����
    end if;

    if bm=0 then --------------------------------------------------------------------

      s_i:=s_i+ROUND(s_Ostf*P_ratn*n_day/100/n_yy, 2); -- ����� % � ���������
      if n>1 then
        select last_d-date_plan into n_day from dual;  -- ��������� ���� ������ ����� �������� ����, ���� �� ��������� �.�. �� ���� �� �������� �� ���� ������
        n_day:=n_day+1;
        s_i:=s_i+ROUND(s_s*P_ratn*n_day/100/n_yy, 2); -- ����� % � ���������
      end if;
      --txt:= n_day||'     '||s_i||'    '||to_char(date_plan, 'dd.mm.yyyy')||'    '||to_char(last_d, 'dd.mm.yyyy');
      --DBMS_OUTPUT.PUT_LINE(txt);

    elsif bm=1 then  --------------------------------------------------------------

      s_i:=s_i+ROUND(s_Ostf*P_ratn*n_day/100/365, 2); -- ����� % � ���������
      if n>1 then
        select last_d-date_plan into n_day from dual;  -- ��������� ���� ������ ����� �������� ����, ���� �� ��������� �.�. �� ���� �� �������� �� ���� ������
        n_day:=n_day+1;
        s_i:=s_i+ROUND(s_s*P_ratn*n_day/100/365, 2); -- ����� % � ���������
      end if;
      --txt:= n_day||'     '||s_i||'    '||to_char(date_plan, 'dd.mm.yyyy')||'    '||to_char(last_d, 'dd.mm.yyyy');
      --DBMS_OUTPUT.PUT_LINE(txt);

    elsif bm=2 then  --------------------------------------------------------------------

      select ADD_MONTHS(date_plan,1) into date_plan from dual;
      if Dp>28 then
        date_plan:=billing_date(Dp, date_plan);
      end if;
      s_i:=ROUND(s_s*P_ratn*30/100/360, 2); -- ����� % � ���������

    elsif bm=3 then  --------------------------------------------------------------------

      s_i:=s_i+ROUND(s_Ostf*P_ratn*n_day/100/360, 2); -- ����� % � ���������
      if n>1 then
        select last_d-date_plan into n_day from dual;  -- ��������� ���� ������ ����� �������� ����, ���� �� ��������� �.�. �� ���� �� �������� �� ���� ������
        n_day:=n_day+1;
        s_i:=s_i+ROUND(s_s*P_ratn*n_day/100/360, 2); -- ����� % � ���������
      end if;
      --txt:= n_day||'     '||s_i||'    '||to_char(date_plan, 'dd.mm.yyyy')||'    '||to_char(last_d, 'dd.mm.yyyy');
      --DBMS_OUTPUT.PUT_LINE(txt);

    end if;

    s_b:=ROUND( Pl-s_i, 2); --����� ��� ����� � ���������

    if s_s<Pl or n=T-1 then
      s_b:=s_s;
      s_m:=0;
      Pl:=s_s+s_i;
      if last_day(date_plan)=last_day(d_wdate) then
        date_plan:=d_wdate;
      end if;
      n:=T;
    else
      s_m:=ROUND( s_s-s_b, 2); -- ������� �� ������� ����� ���������
    end if;

    --txt:= n||';   '||to_char(date_plan, 'dd.mm.rrrr')||';         '||s_s||';         '||s_b||';         '||s_m||';         '||s_i||';         '||Pl||';         '||P_ratn||';      '||bm;
                                         -- ||';         '||to_char(trunc(date_fact, 'month'), 'dd.mm.yyyy')||';         '||to_char(date_plan, 'dd.mm.yyyy')
                                         -- ||';         '||to_char(last_d, 'dd.mm.yyyy')||';           '||to_char(date_fact, 'dd.mm.yyyy');
    --DBMS_OUTPUT.PUT_LINE(txt);

    -------------------
    BEGIN
      insert into cc_lim (nd, fdat, lim2, acc, sumg, sumo, otm, sumk)
      values (nd_,
              date_plan,
              s_m*100,
              acc_,
              (Pl-s_i)*100,
              Pl*100,
              1,
              0);
      commit;
    EXCEPTION
          WHEN OTHERS THEN
      rollback;
      raise_application_error(-20203, '������� ���������� ���!'||sqlerrm);
    END;
    -------------------

    n:=n+1;
    if bm<>2 then
      select ADD_MONTHS(date_plan,1)
        into date_plan
        from dual;
      if Dp>28 then
        date_plan:=billing_date(Dp, date_plan);
      end if;
    end if;
    s_Ostf:=s_s; -- ������ ���� ���������� ��� ���������� �������, �� ���������
    s_s:=ROUND( s_s-s_b, 2); --����� ���� ���������� ��� ���������� �������
  END LOOP;

  END  cc_gpk_ann;

 --����� ������ % �����, ��� ������������� - ��������
 --����� ������ % ����, ��� ������������� - ��������
 --����� ������ % ����, � �������������� ������ - ��������
 --����� ������ % ����, � �������������� ����� - ��������

 --������ ������ % �����, ��� ������������� - ��������
 --������ ������ % ����, ��� ������������� - ��������
 --������ ������ % ����, � �������������� ������ - ��������
 --������ ������ % ����, � �������������� ����� - ��������

 PROCEDURE cc_gpk_classic(
                   nd_    INT,            --�������
                   acc_   INT,            --���� 8999
                   Pl_    NUMBER,         --�������� ������
                   T_     INT,            --���������� ��������
                   S_     NUMBER,         --����� �������, ���������
                   Ostf   NUMBER,         --�������� ������� �� �������
                   P_ir  NUMBER,          --% ������
                   nday_  NUMBER,          --���� ������ ��� �����
                   d_sdate DATE,           --���� ������ ��� ���� ��������� �������� ��������� ��� �����
                   d_wdate DATE,           --���� ���������
                   d_apl_dat DATE,         --������ ��������� ���� ��� ����
                   basey_ INT,             --����� ���������� %
                   flag_r INT,             --% 1=�����, 0=����
                   day_np INT,             --��� ������������ ��� ��������� -2 - ��� ���
                   dog_st INT,             -- 0-����� ������, 1-������ ������
                   freq   INT,             --������������� ���������
                   flag   INT DEFAULT 0--0 - ������ �� ������, 1- ���� �� ������
                   ) IS

    Pl       number;
    T        number;
    P        number;
    txt      varchar2(1000);
    S        number;

    P_ratn    number;      -- ������� ���������� ������
    D_ratn    date;        -- ���� ��������� �������� ���������� ������
    s_s       number;      -- ������� �� ������� �� ���������
    s_Ostf     number;      -- ������� �� ���������� ������ �� ���� ���������
    s_m       number;      -- ������� �� ������� ����� ���������
    s_i       number;      -- ��������� ���������
    date_plan date;        -- ���� ��������� �������
    date_fact date;        -- ���� ��������� ����������
    date_pog  date;        -- ���� ���������
    n_day     int;         -- ���������� ���� � �������
    n_yy      int;         -- ���������� ���� � ����
    bm        int;                -- ����� ����������
    Dp        int;               -- ���� ���������
    s1        number;            -- ������������� ������
    d_start   date;          -- ���� ������, ����
    d_end     date;          -- ���� ��������, ����
    last_d    date;          -- ��������� ���� ������
    flag_d    int;            -- ���� ��� ���������� ���������; 0-����� ������; 1-���� ��������, ����� ��������� �� ������, ��������� ����; 2-���� ��������, ����� ��������� �������������, ���� ���������� ��������� �� ������
    acc_n     int;
    n         number DEFAULT 0; -- ���������� ��� ������������� ��������, �� �������� �������
    d1        date;
    d2        date;
    d3        date;
    n_rate    number;
    d_rate    date;
    P_ratn_old number;
    vv        number;
    acc_k     number;
    k_metr    int;
    k_basey   int;
    k_bdat    date;
    k_ir      number;
    s_kommis  number;

  BEGIN

    Pl:=Pl_;
    T:=T_;
    S:=S_;
    P:=P_ir;
    bm:=basey_; -- ����� �����������
    Dp:=nday_;  -- ���� ������
    d_start:=d_sdate;
    d_end:=d_wdate;
    acc_n:=acc_;

 ------------------------------------
 -- ��� ��������, � ���� ������������� �������� �����������
 ------------------------------------
 /*
  DBMS_OUTPUT.PUT_LINE('S='||S);
  DBMS_OUTPUT.PUT_LINE('Ostf='||Ostf);
  DBMS_OUTPUT.PUT_LINE('T='||T);
  DBMS_OUTPUT.PUT_LINE('Pl='||Pl);
  DBMS_OUTPUT.PUT_LINE('bm='||bm);
  DBMS_OUTPUT.PUT_LINE('d_start='||to_char(d_start, 'dd.mm.yyyy'));
  DBMS_OUTPUT.PUT_LINE('dog_st='||dog_st);
  DBMS_OUTPUT.PUT_LINE('d_apl_dat='||to_char(d_apl_dat, 'dd.mm.yyyy'));
  DBMS_OUTPUT.PUT_LINE('d_sdate='||to_char(d_sdate, 'dd.mm.yyyy'));
  DBMS_OUTPUT.PUT_LINE('flag_r='||flag_r);
  DBMS_OUTPUT.PUT_LINE('day_np='||day_np);
  DBMS_OUTPUT.PUT_LINE('freq='||freq);
  */---------------------------------------

  ------------------- ������ ������ �� �������
  BEGIN
    delete from cc_lim
     where nd=nd_
       and acc=acc_
       and fdat>d_start;
    commit;
  EXCEPTION
        WHEN OTHERS THEN
    rollback;
    raise_application_error(-20203, '������� ��������� ���!'||sqlerrm);
  END;
  -------------------

  if dog_st=0 and nvl(Pl,0)=0 then
    Pl:=S/T;                                   -- ����� ������, �������� ������ ����������
    Pl:=round(Pl,0);
  else
    if flag=1 then -- ���� ��������� �� �������, ������������� ������
      Pl:=S/T;
      Pl:=round(Pl,2);
     -- DBMS_OUTPUT.PUT_LINE('!!!!Pl='||Pl);
    end if;
  end if;
  --DBMS_OUTPUT.PUT_LINE('T_1='||T);
  --DBMS_OUTPUT.PUT_LINE('----------------------------');

  s_m:=S;
  --txt:= '0;   '||to_char(d_start, 'dd.mm.rrrr')||';     '||S||';     '||s_m||';     '||s_i||';     '||Pl||';    '||P_ratn||';     '||bm;
  --DBMS_OUTPUT.PUT_LINE(txt);

  select to_date(Dp||'.'||to_char(d_start, 'mm.rrrr'), 'dd.mm.rrrr' )
    into date_plan
    from dual;

  --DBMS_OUTPUT.PUT_LINE('date_plan_1='||to_char(date_plan, 'dd.mm.yyyy'));
  --DBMS_OUTPUT.PUT_LINE('d_start_1='||to_char(d_start, 'dd.mm.yyyy'));

  P_ratn:=P_ir;
  n:=1;
  s_s:=S; -- kbvbn �� ������� �� ���������

  -- ��������� ��������
  acc_k:=0; k_metr:=0; k_basey:=0; k_bdat:=null; k_ir:=0;
  BEGIN
    select a.acc, aa.metr, aa.basey, ir.bdat, ir.ir
      into acc_k, k_metr, k_basey, k_bdat, k_ir
       from nd_acc n, accounts a, INT_ACCN aa, INT_RATN ir
     where n.nd=nd_
       and a.acc=n.acc
       and a.dazs is null
       and a.TIP in('SK0', 'SK9')
       and a.nbs in(2238, 2208)
       and aa.acc=a.acc
       and ir.acc=aa.acc
       and ir.id=2;
  EXCEPTION
      WHEN OTHERS THEN
    k_ir:=0;
  END;
  --k_metr:=0; k_basey:=0; k_ir:=10;

  --DBMS_OUTPUT.PUT_LINE('s_o='||s_o||';  S_p='||S_p||';  S='||S);
  --date_fact - ����, ������� ������������ � ������� �� ����� ��������, ���� ��� ����
  --date_plan - ����� �������� ���� ��� ������������� ����������� ����
  --d1 - ��������� ���� ������ ������
  --d2 - ���� ������������ ���������
  --d3 - ��������� ���� ����� ������
  -- ���� ������ ���� ��� % �����, �� d1,d2,d3 ����� �� ������� �����
  -- ���� ������ ���� ��� % ����, �� d1 � d2 ����� ������ �������� � �������� ������� � ��������������, � d3=0
  WHILE n<=T LOOP
    txt:=null;
    s_i:=0; s_m:=S;

    if n=1 then --��� ������� �������

      if dog_st=0 then --��� ������ ������� ��� ���� ����� ���������� �� �������
        s_Ostf:=s_s;
        d2 := d_start;
        date_fact:=add_months(date_plan,1);
        date_plan:=add_months(date_plan,1);
        if flag_r=1 then
          d3:=LAST_DAY(d2); --����� ������
          n_day:=d3-d2+1;
        else
          d3:=null;
          n_day:=0;
        end if;
      else -- ���� ������� � �����������

        if flag_r=1 then --% �����, ��������� ���� �� �������, � ���� ������� ������� �� ����� ������
          s_Ostf:=Ostf;
          d1:=trunc(date_plan, 'month');
          d2 := date_plan;
          d3:=LAST_DAY(d2);
          date_fact:=add_months(date_plan,1);
        else  -- ���� % ����, ������������ ���� ��� ������� � ��� �������
          s_Ostf:=s_s;
          d1:=cck_app.correctdate2(gl.baseval,date_plan, day_np);
          d2 := cck_app.correctdate2(gl.baseval, add_months(date_plan,1), day_np);
          date_fact:=d2;
          d3:=null;
        end if;
        n_day:=d2-d1;
         -- �������� ���� ������ ������� �� ����� ������
         date_plan:=ADD_MONTHS(date_plan,1);
      end if;
    else -- ��� ���� ����������� �������� ������������ ��������� ���� ��� % ����
         -- � ������ �� ������ ��� % �����
      if flag_r=1 then
        d2:=add_months(date_plan,-1);
        d1:=trunc(d2, 'month');
        d3:=LAST_DAY(d2);
      else
        d1:=cck_app.correctdate2(gl.baseval, add_months(date_plan,-1), day_np);
        d2 := cck_app.correctdate2(gl.baseval, date_plan, day_np);
        d3:=null;
      end if;
      n_day:=d2-d1;
    end if;

    n_rate:=0;
    P_ratn_old:=0;

    if n>1 then
      P_ratn_old:=P_ratn;

      select max(r.bdat)
        into d_rate
        from INT_RATN r
       where acc = acc_
         and id = 0
         and r.bdat <= d2;

      select r.ir
        into P_ratn
       from INT_RATN r
      where acc = acc_
        and id = 0
        and r.bdat = d_rate;

      select count(*)
        into n_rate
        from INT_RATN r
       where r.acc = acc_
         and r.id = 0
         and r.bdat=d_rate
         and r.bdat between d1 and d2;

      if n_rate=1 and d_rate=d1 then n_rate:=2; end if;

      if d3 is not null and n_rate=0 then
        select count(*)
          into n_rate
          from INT_RATN r
         where r.acc = acc_
           and r.id = 0
           and r.bdat=d_rate
           and r.bdat between d1 and d2;
        if n_rate=1 then n_rate:=2; end if; -- ������ �������� �������
      end if;
    end if;

    --txt:=n||'!1!    s_o='||s_o||';   n_day='||n_day||';     s_i='||s_i||';    d1='||to_char(d1, 'dd.mm.yyyy')||'     d2='||to_char(d2, 'dd.mm.yyyy')||'    d3='||to_char(d3, 'dd.mm.yyyy');
    --DBMS_OUTPUT.PUT_LINE(txt);

    select add_months(trunc(d2,'yyyy'),12)-trunc(d2,'yyyy') into n_yy from dual;

    if nvl(k_metr,0)=0 and nvl(k_basey,0)=0 and nvl(k_ir,0)<>0 and k_bdat<=date_plan then
      s_kommis:=ROUND(nvl(s_Ostf,0)*k_ir*n_day/100/n_yy, 2);
      if n>1 then
        s_kommis:=nvl(s_kommis,0)+ROUND(s_s*k_ir*(LAST_DAY(d2)-d2+1)/100/n_yy, 2);
      end if;
    end if;

    if bm=0 then --------------------------------------------------------------------
      if n_rate = 0 then
        s_i:=ROUND(nvl(s_Ostf,0)*P_ratn*n_day/100/n_yy, 2); -- ����� % � ���������
      elsif n_rate = 1 then
        s_i:=ROUND(nvl(s_Ostf,0)*P_ratn_old*(d_rate-d1)/100/n_yy, 2); -- ����� % � ���������
        s_i:=nvl(s_i,0)+ROUND(nvl(s_Ostf,0)*P_ratn*(d2-d_rate)/100/n_yy, 2);

        --DBMS_OUTPUT.PUT_LINE( 'd1='||to_char(d1,'dd.mm.yyyy')||'  d_rate='||to_char(d_rate,'dd.mm.yyyy')||'   d2='||to_char(d2,'dd.mm.yyyy'));
      end if;

      --DBMS_OUTPUT.PUT_LINE(n||'  s_o='||s_o||'  s_s='||s_s||'   n_day='||n_day||'   date_fact!!='||to_char(date_fact,'dd.mm.yyyy')||' - '||to_char(cck_app.correctdate2(gl.baseval, ADD_MONTHS(date_fact,-1), day_np),'dd.mm.yyyy'));

      if flag_r=1 then
        if n>1 or dog_st<>0 then
          d3:=LAST_DAY(d2);
          n_day:=d3-d2+1;

          if n_rate = 0 then
            s_i:=nvl(s_i,0)+ROUND(s_s*P_ratn*n_day/100/n_yy, 2); -- ����� % � ���������
          elsif n_rate = 2 then
            s_i:=ROUND(nvl(s_Ostf,0)*P_ratn_old*(d_rate-d2)/100/n_yy, 2); -- ����� % � ���������
            s_i:=nvl(s_i,0)+ROUND(nvl(s_Ostf,0)*P_ratn*(d3-d_rate)/100/n_yy, 2);
          end if;

          --txt:=n||'!2!    s_s='||s_s||';   n_day='||n_day||';     s_i='||s_i||';    P_ratn='||P_ratn||';    n_yy='||n_yy||';   '||to_char(d1, 'dd.mm.yyyy')||'    '||to_char(d2, 'dd.mm.yyyy')||'    '||to_char(d3, 'dd.mm.yyyy');
          --DBMS_OUTPUT.PUT_LINE(txt);
        end if;
      end if;

      --txt:=n||'    s_o='||s_o||';   '||n_day||';     '||s_i||';    '||to_char(date_fact, 'dd.mm.yyyy')||'    '||to_char(last_d, 'dd.mm.yyyy')||'    '||to_char(date_fact, 'dd.mm.yyyy');
      --DBMS_OUTPUT.PUT_LINE(txt);

    elsif bm=1 then  --------------------------------------------------------------
      if n_rate = 0 then
        s_i:=ROUND(nvl(s_Ostf,0)*P_ratn*n_day/100/365, 2); -- ����� % � ���������
      elsif n_rate = 1 then
        s_i:=ROUND(nvl(s_Ostf,0)*P_ratn_old*(d_rate-d1)/100/365, 2); -- ����� % � ���������
        s_i:=nvl(s_i,0)+ROUND(nvl(s_Ostf,0)*P_ratn*(d2-d_rate)/100/365, 2);
        --DBMS_OUTPUT.PUT_LINE( d_rate-d1);
        --DBMS_OUTPUT.PUT_LINE( d2-d_rate);
        --DBMS_OUTPUT.PUT_LINE( 'd1='||to_char(d1,'dd.mm.yyyy')||'  d_rate='||to_char(d_rate,'dd.mm.yyyy')||'   d2='||to_char(d2,'dd.mm.yyyy'));
      end if;

      --DBMS_OUTPUT.PUT_LINE(n||'  s_o='||s_o||'  s_i='||s_i||'   n_day='||n_day||'   date_fact!!='||to_char(date_fact,'dd.mm.yyyy')||' - '||to_char(cck_app.correctdate2(gl.baseval, ADD_MONTHS(date_fact,-1), day_np),'dd.mm.yyyy'));

      if flag_r=1 then
        if n>1 or dog_st<>0 then
          d3:=LAST_DAY(d2);
          n_day:=d3-d2+1;

          if n_rate = 0 then
            s_i:=nvl(s_i,0)+ROUND(s_s*P_ratn*n_day/100/365, 2); -- ����� % � ���������
          elsif n_rate = 2 then
            s_i:=ROUND(nvl(s_Ostf,0)*P_ratn_old*(d_rate-d2)/100/365, 2); -- ����� % � ���������
            s_i:=nvl(s_i,0)+ROUND(nvl(s_Ostf,0)*P_ratn*(d3-d_rate)/100/365, 2);
          end if;

          --txt:=n||'!2!    s_s='||s_s||';   n_day='||n_day||';     s_i='||s_i||';    P_ratn='||P_ratn||';    n_yy='||n_yy||';   '||to_char(d1, 'dd.mm.yyyy')||'    '||to_char(d2, 'dd.mm.yyyy')||'    '||to_char(d3, 'dd.mm.yyyy');
          --DBMS_OUTPUT.PUT_LINE(txt);
        end if;
      end if;
    elsif bm=2 then  --------------------------------------------------------------------
      select ADD_MONTHS(date_plan,1) into date_plan from dual;
      if Dp>28 then
        date_plan:=billing_date(Dp, date_plan);
      end if;
      s_i:=ROUND(s_s*P_ratn*30/100/360, 2); -- ����� % � ���������
    elsif bm=3 then  --------------------------------------------------------------------
      if n_rate = 0 then
        s_i:=ROUND(nvl(s_Ostf,0)*P_ratn*n_day/100/360, 2); -- ����� % � ���������
      elsif n_rate = 1 then
        s_i:=ROUND(nvl(s_Ostf,0)*P_ratn_old*(d_rate-d1)/100/360, 2); -- ����� % � ���������
        s_i:=nvl(s_i,0)+ROUND(nvl(s_Ostf,0)*P_ratn*(d2-d_rate)/100/360, 2);

        --DBMS_OUTPUT.PUT_LINE( 'd1='||to_char(d1,'dd.mm.yyyy')||'  d_rate='||to_char(d_rate,'dd.mm.yyyy')||'   d2='||to_char(d2,'dd.mm.yyyy'));
      end if;

      --DBMS_OUTPUT.PUT_LINE(n||'  s_o='||s_o||'  s_i='||s_i||'   n_day='||n_day||'   date_fact!!='||to_char(date_fact,'dd.mm.yyyy')||' - '||to_char(cck_app.correctdate2(gl.baseval, ADD_MONTHS(date_fact,-1), day_np),'dd.mm.yyyy'));

      if flag_r=1 then
        if n>1 or dog_st<>0 then
          d3:=LAST_DAY(d2);
          n_day:=d3-d2+1;

          if n_rate = 0 then
            s_i:=nvl(s_i,0)+ROUND(s_s*P_ratn*n_day/100/360, 2); -- ����� % � ���������
          elsif n_rate = 2 then
            s_i:=ROUND(nvl(s_Ostf,0)*P_ratn_old*(d_rate-d2)/100/360, 2); -- ����� % � ���������
            s_i:=nvl(s_i,0)+ROUND(nvl(s_Ostf,0)*P_ratn*(d3-d_rate)/100/360, 2);
          end if;

          --txt:=n||'!2!    s_s='||s_s||';   n_day='||n_day||';     s_i='||s_i||';    P_ratn='||P_ratn||';    n_yy='||n_yy||';   '||to_char(d1, 'dd.mm.yyyy')||'    '||to_char(d2, 'dd.mm.yyyy')||'    '||to_char(d3, 'dd.mm.yyyy');
          --DBMS_OUTPUT.PUT_LINE(txt);
        end if;
      end if;
    end if;

    if s_s<Pl then
      s_m:=0;
      Pl:=s_s;
      n:=T;
      --DBMS_OUTPUT.PUT_LINE('�����='||s_m);
    else
      s_m:=s_s-Pl; -- ������� �� ������� ����� ���������
      --DBMS_OUTPUT.PUT_LINE('�����_s_m='||s_m);
    end if;

    --txt:= n||'='||T||';   '||to_char(date_fact, 'dd.mm.rrrr');
    --DBMS_OUTPUT.PUT_LINE(txt);
    if n=T and bm<>2 then
      if bm<>2 then
        date_fact:=d_wdate;
        select date_fact-trunc(date_fact, 'month') into n_day from dual;  -- �������� ���� ����� ������ �����
        s_i:=s_i+ROUND(s_s*P_ratn*n_day/100/n_yy, 2); -- ����� % � ���������
        if s_m<>0 then
          Pl:=Pl+s_m;
          s_s:=s_s-Pl;
        end if;
        --DBMS_OUTPUT.PUT_LINE('�����='||n||';  '||T||';  '||s_i);
      end if;
    end if;

    vv:=0;
    vv:=s_i+Pl;
    --if n<11 then
    --  txt:= n||';   '||to_char(date_fact, 'dd.mm.rrrr')||';     '||s_s||';    '||s_m||';     '||s_i||';     '||Pl||';   '||vv||';    '||s_kommis||';    '||P_ratn||';   '||bm;
                                         -- ||';         '||to_char(trunc(date_fact, 'month'), 'dd.mm.yyyy')||';         '||to_char(date_plan, 'dd.mm.yyyy')
                                         -- ||';         '||to_char(last_d, 'dd.mm.yyyy')||';           '||to_char(date_fact, 'dd.mm.yyyy');
    --  DBMS_OUTPUT.PUT_LINE(txt);
    --end if;

    -------------------
    BEGIN
      insert into cc_lim (nd, fdat, lim2, acc, sumg, sumo, otm, sumk)
      values (nd_,
              date_plan,
              s_m*100,
              acc_,
              Pl*100,
              (Pl+s_i)*100,
              1,
              nvl(s_kommis,0)*100);
      commit;
    EXCEPTION
          WHEN OTHERS THEN
      rollback;
      raise_application_error(-20203, '������� ���������� ���!'||sqlerrm);
    END;
    -------------------


    n:=n+1;
    if bm<>2 then
      select ADD_MONTHS(to_date(Dp||'.'||to_char(date_fact, 'mm.rrrr'),'dd.mm.rrrr' ),1), ADD_MONTHS(date_plan,1)
        into date_fact, date_plan
        from dual;
      if Dp>28 then
        date_fact:=billing_date(Dp, date_fact);
        date_plan:=billing_date(Dp, date_plan);
      end if;

      if flag_r<>1 then
        date_fact:=cck_app.correctdate2(gl.baseval, date_plan, day_np);
      end if;
      --DBMS_OUTPUT.PUT_LINE(n||'---'||to_char(date_plan, 'dd.mm.yyyy'));
    end if;

    s_Ostf:=s_s; -- ������ ���� ���������� ��� ���������� �������, �� ���������
    if date_fact>d_apl_dat then
      s_s:=s_s-Pl; --����� ���� ���������� ��� ���������� �������
      if flag_r<>1 then
        s_Ostf:=s_s;
      end if;
      --DBMS_OUTPUT.PUT_LINE(n-1||'  s_s='||s_s||'  Pl='||Pl||'  s_o='||s_o);
    end if;
  END LOOP;

  END cc_gpk_classic;
  -------------------------
PROCEDURE cc_gpk_freq(
                   nd_    INT,            --�������
                   acc_   INT,            --���� 8999
                   Pl_    NUMBER,         --�������� ������
                   T_     INT,            --���������� ��������
                   S_     NUMBER,         --����� �������, ���������
                   Ostf   NUMBER,         --�������� ������� �� �������
                   P_ir  NUMBER,          --% ������
                   nday_  NUMBER,          --���� ������ ��� �����
                   d_sdate DATE,           --���� ������ ��� ���� ��������� �������� ��������� ��� �����
                   d_wdate DATE,           --���� ���������
                   d_apl_dat DATE,         --������ ��������� ���� ��� ����
                   basey_ INT,             --����� ���������� %
                   flag_r INT,             --% 1=�����, 0=����
                   day_np INT,             --��� ������������ ��� ��������� -2 - ��� ���
                   dog_st INT,             -- 0-����� ������, 1-������ ������
                   freq   INT,             --������������� ���������
                   flag   INT DEFAULT 0--0 - ������ �� ������, 1- ���� �� ������
                   ) IS

    Pl       number;
    T        number;
    P        number;
    txt      varchar2(1000);
    S        number;

    P_ratn    number;      -- ������� ���������� ������
    D_ratn    date;        -- ���� ��������� �������� ���������� ������
    s_s       number;      -- ������� �� ������� �� ���������
    s_Ostf    number;      -- ������� �� ���������� ������ �� ���� ���������
    s_m       number;      -- ������� �� ������� ����� ���������
    s_i       number;      -- ��������� ���������
    date_plan date;        -- ���� ��������� �������
    date_fact date;        -- ���� ��������� ����������
    date_pog  date;        -- ���� ���������
    n_day     int;         -- ���������� ���� � �������
    n_yy      int;         -- ���������� ���� � ����
    bm int;                -- ����� ����������
    Dp  int;               -- ���� ���������
    s1  number;            -- ������������� ������;
    d_start date;          -- ���� ������, ����
    d_end   date;          -- ���� ��������, ����
    last_d  date;          -- ��������� ���� ������
    flag_d int;            -- ���� ��� ���������� ���������; 0-����� ������; 1-���� ��������, ����� ��������� �� ������, ��������� ����; 2-���� ��������, ����� ��������� �������������, ���� ���������� ��������� �� ������
    acc_n  int;
    n      number DEFAULT 0; -- ���������� ��� ������������� ��������, �� �������� �������
    d1     date;
    d2     date;
    d3     date;
    n_rate number;
    d_rate date;
    P_ratn_old number;
    vv   number;

  BEGIN

    Pl:=Pl_;
    T:=T_;
    S:=S_;
    P:=P_ir;
    bm:=basey_; -- ����� �����������
    Dp:=nday_;  -- ���� ������
    d_start:=d_sdate;
    d_end:=d_wdate;
    acc_n:=acc_;

 ------------------------------------
 -- ��� ��������, � ���� ������������� �������� �����������
 ------------------------------------
  /*DBMS_OUTPUT.PUT_LINE('S='||S);
  DBMS_OUTPUT.PUT_LINE('Ostf='||Ostf);
  DBMS_OUTPUT.PUT_LINE('T='||T);
  DBMS_OUTPUT.PUT_LINE('Pl='||Pl);
  DBMS_OUTPUT.PUT_LINE('bm='||bm);
  DBMS_OUTPUT.PUT_LINE('dog_st='||dog_st);
  DBMS_OUTPUT.PUT_LINE('d_apl_dat='||to_char(d_apl_dat, 'dd.mm.yyyy'));
  DBMS_OUTPUT.PUT_LINE('d_sdate='||to_char(d_sdate, 'dd.mm.yyyy'));
  DBMS_OUTPUT.PUT_LINE('flag_r='||flag_r);
  DBMS_OUTPUT.PUT_LINE('day_np='||day_np);
  DBMS_OUTPUT.PUT_LINE('freq='||freq);*/
  ---------------------------------------

  ------------------- ������ ������ �� �������
  BEGIN
    delete from cc_lim
     where nd=nd_
       and acc=acc_
       and fdat>d_start;
    commit;
  EXCEPTION
        WHEN OTHERS THEN
    rollback;
    raise_application_error(-20203, '������� ��������� ���!'||sqlerrm);
  END;
  -------------------

  if dog_st=0 and nvl(Pl,0)=0 then
    Pl:=S/T;                                   -- ����� ������, �������� ������ ����������
    Pl:=round(Pl,0);
  else
    if flag=1 then -- ���� ��������� �� �������, ������������� ������
      Pl:=S/T;
      Pl:=round(Pl,2);
     -- DBMS_OUTPUT.PUT_LINE('!!!!Pl='||Pl);
    end if;
  end if;
  --DBMS_OUTPUT.PUT_LINE('T_1='||T);
  --DBMS_OUTPUT.PUT_LINE('----------------------------');

  s_m:=S;
  txt:= '0;   '||to_char(d_start, 'dd.mm.rrrr')||';     '||S||';     '||s_m||';     '||s_i||';     '||Pl||';    '||P_ratn||';     '||bm;
  DBMS_OUTPUT.PUT_LINE(txt);

  select to_date(Dp||'.'||to_char(d_start, 'mm.rrrr'), 'dd.mm.rrrr' )
    into date_plan
    from dual;

  --DBMS_OUTPUT.PUT_LINE('date_plan_1='||to_char(date_plan, 'dd.mm.yyyy'));
  --DBMS_OUTPUT.PUT_LINE('d_start_1='||to_char(d_start, 'dd.mm.yyyy'));

  P_ratn:=P_ir;
  n:=1;
  s_s:=S; -- kbvbn �� ������� �� ���������

  --DBMS_OUTPUT.PUT_LINE('s_o='||s_o||';  S_p='||S_p||';  S='||S);
  --date_fact - ����, ������� ������������ � ������� �� ����� ��������, ���� ��� ����
  --date_plan - ����� �������� ���� ��� ������������� ����������� ����
  --d1 - ��������� ���� ������ ������
  --d2 - ���� ������������ ���������
  --d3 - ��������� ���� ����� ������
  -- ���� ������ ���� ��� % �����, �� d1,d2,d3 ����� �� ������� �����
  -- ���� ������ ���� ��� % ����, �� d1 � d2 ����� ������ �������� � �������� ������� � ��������������, � d3=0
  WHILE n<=T LOOP
    txt:=null;
    s_i:=0; s_m:=S;

    if n=1 then --��� ������� �������

      if dog_st=0 then --��� ������ ������� ��� ���� ����� ���������� �� �������
        s_Ostf:=s_s;
        d2 := d_start;
        date_fact:=add_months(date_plan,1);
        date_plan:=add_months(date_plan,1);
        if flag_r=1 then
          d3:=LAST_DAY(d2); --����� ������
          n_day:=d3-d2+1;
        else
          d3:=null;
          n_day:=0;
        end if;
      else -- ���� ������� � �����������

        if flag_r=1 then --% �����, ��������� ���� �� �������, � ���� ������� ������� �� ����� ������
          s_Ostf:=Ostf;
          d1:=trunc(date_plan, 'month');
          d2 := date_plan;
          d3:=LAST_DAY(d2);
          date_fact:=add_months(date_plan,1);
        else  -- ���� % ����, ������������ ���� ��� ������� � ��� �������
          s_Ostf:=s_s;
          d1:=cck_app.correctdate2(gl.baseval,date_plan, day_np);
          d2 := cck_app.correctdate2(gl.baseval, add_months(date_plan,1), day_np);
          date_fact:=d2;
          d3:=null;
        end if;
        n_day:=d2-d1;
         -- �������� ���� ������ ������� �� ����� ������
         date_plan:=ADD_MONTHS(date_plan,1);
      end if;
      date_pog:=date_fact;
    else -- ��� ���� ����������� �������� ������������ ��������� ���� ��� % ����
         -- � ������ �� ������ ��� % �����
      if flag_r=1 then
        d2:=add_months(date_plan,-1);
        d1:=trunc(d2, 'month');
        d3:=LAST_DAY(d2);
      else
        d1:=cck_app.correctdate2(gl.baseval, add_months(date_plan,-1), day_np);
        d2 := cck_app.correctdate2(gl.baseval, date_plan, day_np);
        d3:=null;
      end if;
      n_day:=d2-d1;
    end if;

    n_rate:=0;
    P_ratn_old:=0;
    if n>1 then
      P_ratn_old:=P_ratn;

      select max(r.bdat)
        into d_rate
        from INT_RATN r
       where acc = acc_
         and id = 0
         and r.bdat <= d2;

      select r.ir
        into P_ratn
       from INT_RATN r
      where acc = acc_
        and id = 0
        and r.bdat = d_rate;

      select count(*)
        into n_rate
        from INT_RATN r
       where r.acc = acc_
         and r.id = 0
         and r.bdat=d_rate
         and r.bdat between d1 and d2;

      if n_rate=1 and d_rate=d1 then n_rate:=2; end if;

      if d3 is not null and n_rate=0 then
        select count(*)
          into n_rate
          from INT_RATN r
         where r.acc = acc_
           and r.id = 0
           and r.bdat=d_rate
           and r.bdat between d1 and d2;
        if n_rate=1 then n_rate:=2; end if; -- ������ �������� �������
      end if;
    end if;
    --txt:=n||'!1!    s_o='||s_o||';   n_day='||n_day||';     s_i='||s_i||';    d1='||to_char(d1, 'dd.mm.yyyy')||'     d2='||to_char(d2, 'dd.mm.yyyy')||'    d3='||to_char(d3, 'dd.mm.yyyy');
    --DBMS_OUTPUT.PUT_LINE(txt);

    select add_months(trunc(d2,'yyyy'),12)-trunc(d2,'yyyy') into n_yy from dual;

    if bm=0 then --------------------------------------------------------------------
      if n_rate = 0 then
        s_i:=ROUND(nvl(s_Ostf,0)*P_ratn*n_day/100/n_yy, 2); -- ����� % � ���������
      elsif n_rate = 1 then
        s_i:=ROUND(nvl(s_Ostf,0)*P_ratn_old*(d_rate-d1)/100/n_yy, 2); -- ����� % � ���������
        s_i:=nvl(s_i,0)+ROUND(nvl(s_Ostf,0)*P_ratn*(d2-d_rate)/100/n_yy, 2);
        --DBMS_OUTPUT.PUT_LINE( 'd1='||to_char(d1,'dd.mm.yyyy')||'  d_rate='||to_char(d_rate,'dd.mm.yyyy')||'   d2='||to_char(d2,'dd.mm.yyyy'));
      end if;

      --DBMS_OUTPUT.PUT_LINE(n||'  s_o='||s_o||'  s_i='||s_i||'   n_day='||n_day||'   date_fact!!='||to_char(date_fact,'dd.mm.yyyy')||' - '||to_char(cck_app.correctdate2(gl.baseval, ADD_MONTHS(date_fact,-1), day_np),'dd.mm.yyyy'));

      if flag_r=1 then
        if n>1 or dog_st<>0 then
          d3:=LAST_DAY(d2);
          n_day:=d3-d2+1;

          if n_rate = 0 then
            s_i:=nvl(s_i,0)+ROUND(s_s*P_ratn*n_day/100/n_yy, 2); -- ����� % � ���������
          elsif n_rate = 2 then
            s_i:=ROUND(nvl(s_Ostf,0)*P_ratn_old*(d_rate-d2)/100/n_yy, 2); -- ����� % � ���������
            s_i:=nvl(s_i,0)+ROUND(nvl(s_Ostf,0)*P_ratn*(d3-d_rate)/100/n_yy, 2);
          end if;

          --txt:=n||'!2!    s_s='||s_s||';   n_day='||n_day||';     s_i='||s_i||';    P_ratn='||P_ratn||';    n_yy='||n_yy||';   '||to_char(d1, 'dd.mm.yyyy')||'    '||to_char(d2, 'dd.mm.yyyy')||'    '||to_char(d3, 'dd.mm.yyyy');
          --DBMS_OUTPUT.PUT_LINE(txt);
        end if;
      end if;

      --txt:=n||'    s_o='||s_o||';   '||n_day||';     '||s_i||';    '||to_char(date_fact, 'dd.mm.yyyy')||'    '||to_char(last_d, 'dd.mm.yyyy')||'    '||to_char(date_fact, 'dd.mm.yyyy');
      --DBMS_OUTPUT.PUT_LINE(txt);

    elsif bm=1 then  --------------------------------------------------------------
      if n_rate = 0 then
        s_i:=ROUND(nvl(s_Ostf,0)*P_ratn*n_day/100/365, 2); -- ����� % � ���������
      elsif n_rate = 1 then
        s_i:=ROUND(nvl(s_Ostf,0)*P_ratn_old*(d_rate-d1)/100/365, 2); -- ����� % � ���������
        s_i:=nvl(s_i,0)+ROUND(nvl(s_Ostf,0)*P_ratn*(d2-d_rate)/100/365, 2);
        --DBMS_OUTPUT.PUT_LINE( d_rate-d1);
        --DBMS_OUTPUT.PUT_LINE( d2-d_rate);
        --DBMS_OUTPUT.PUT_LINE( 'd1='||to_char(d1,'dd.mm.yyyy')||'  d_rate='||to_char(d_rate,'dd.mm.yyyy')||'   d2='||to_char(d2,'dd.mm.yyyy'));
      end if;

      --DBMS_OUTPUT.PUT_LINE(n||'  s_o='||s_o||'  s_i='||s_i||'   n_day='||n_day||'   date_fact!!='||to_char(date_fact,'dd.mm.yyyy')||' - '||to_char(cck_app.correctdate2(gl.baseval, ADD_MONTHS(date_fact,-1), day_np),'dd.mm.yyyy'));

      if flag_r=1 then
        if n>1 or dog_st<>0 then
          d3:=LAST_DAY(d2);
          n_day:=d3-d2+1;

          if n_rate = 0 then
            s_i:=nvl(s_i,0)+ROUND(s_s*P_ratn*n_day/100/365, 2); -- ����� % � ���������
          elsif n_rate = 2 then
            s_i:=ROUND(nvl(s_Ostf,0)*P_ratn_old*(d_rate-d2)/100/365, 2); -- ����� % � ���������
            s_i:=nvl(s_i,0)+ROUND(nvl(s_Ostf,0)*P_ratn*(d3-d_rate)/100/365, 2);
          end if;

          --txt:=n||'!2!    s_s='||s_s||';   n_day='||n_day||';     s_i='||s_i||';    P_ratn='||P_ratn||';    n_yy='||n_yy||';   '||to_char(d1, 'dd.mm.yyyy')||'    '||to_char(d2, 'dd.mm.yyyy')||'    '||to_char(d3, 'dd.mm.yyyy');
          --DBMS_OUTPUT.PUT_LINE(txt);
        end if;
      end if;
    elsif bm=2 then  --------------------------------------------------------------------
      select ADD_MONTHS(date_plan,1) into date_plan from dual;
      if Dp>28 then
        date_plan:=billing_date(Dp, date_plan);
      end if;
      s_i:=ROUND(s_s*P_ratn*30/100/360, 2); -- ����� % � ���������
    elsif bm=3 then  --------------------------------------------------------------------
      if n_rate = 0 then
        s_i:=ROUND(nvl(s_Ostf,0)*P_ratn*n_day/100/360, 2); -- ����� % � ���������
      elsif n_rate = 1 then
        s_i:=ROUND(nvl(s_Ostf,0)*P_ratn_old*(d_rate-d1)/100/360, 2); -- ����� % � ���������
        s_i:=nvl(s_i,0)+ROUND(nvl(s_Ostf,0)*P_ratn*(d2-d_rate)/100/360, 2);
        --DBMS_OUTPUT.PUT_LINE( d_rate-d1);
        --DBMS_OUTPUT.PUT_LINE( d2-d_rate);
        --DBMS_OUTPUT.PUT_LINE( 'd1='||to_char(d1,'dd.mm.yyyy')||'  d_rate='||to_char(d_rate,'dd.mm.yyyy')||'   d2='||to_char(d2,'dd.mm.yyyy'));
      end if;

      --DBMS_OUTPUT.PUT_LINE(n||'  s_Ostf='||s_Ostf||'  s_i='||s_i||'   n_day='||n_day||'   date_fact!!='||to_char(date_fact,'dd.mm.yyyy')||' - '||to_char(cck_app.correctdate2(gl.baseval, ADD_MONTHS(date_fact,-1), day_np),'dd.mm.yyyy'));

      if flag_r=1 then
        if n>1 or dog_st<>0 then
          d3:=LAST_DAY(d2);
          n_day:=d3-d2+1;

          if n_rate = 0 then
            s_i:=nvl(s_i,0)+ROUND(s_s*P_ratn*n_day/100/360, 2); -- ����� % � ���������
          elsif n_rate = 2 then
            s_i:=ROUND(nvl(s_Ostf,0)*P_ratn_old*(d_rate-d2)/100/360, 2); -- ����� % � ���������
            s_i:=nvl(s_i,0)+ROUND(nvl(s_Ostf,0)*P_ratn*(d3-d_rate)/100/360, 2);
          end if;

          --txt:=n||'!2!    s_s='||s_s||';   n_day='||n_day||';     s_i='||s_i||';    P_ratn='||P_ratn||';    n_yy='||n_yy||';   '||to_char(d1, 'dd.mm.yyyy')||'    '||to_char(d2, 'dd.mm.yyyy')||'    '||to_char(d3, 'dd.mm.yyyy');
          --DBMS_OUTPUT.PUT_LINE(txt);
        end if;
      end if;
    end if;

    if s_s<Pl then
      s_m:=0;
      Pl:=s_s;
      n:=T;
      --DBMS_OUTPUT.PUT_LINE('�����='||s_m);
    else
      s_m:=s_s-Pl; -- ������� �� ������� ����� ���������
      --DBMS_OUTPUT.PUT_LINE('�����_s_m='||s_m);
    end if;

    --txt:= n||'='||T||';   '||to_char(date_fact, 'dd.mm.rrrr');
    --DBMS_OUTPUT.PUT_LINE(txt);
    if n=T and bm<>2 then
      if bm<>2 then
        date_fact:=d_wdate;
        select date_fact-trunc(date_fact, 'month') into n_day from dual;  -- �������� ���� ����� ������ �����
        s_i:=s_i+ROUND(s_s*P_ratn*n_day/100/n_yy, 2); -- ����� % � ���������
        if s_m<>0 then
          Pl:=Pl+s_m;
          s_s:=s_s-Pl;
        end if;
        --DBMS_OUTPUT.PUT_LINE('�����='||n||';  '||T||';  '||s_i);
      end if;
    end if;

    vv:=0;
    vv:=s_i+Pl;
    --if n<11 then
    --  txt:= n||';   '||to_char(date_fact, 'dd.mm.rrrr')||';     '||s_s||';    '||s_m||';     '||s_i||';     '||Pl||';   '||vv||';    '||P_ratn||';   '||bm;
                                         -- ||';         '||to_char(trunc(date_fact, 'month'), 'dd.mm.yyyy')||';         '||to_char(date_plan, 'dd.mm.yyyy')
                                         -- ||';         '||to_char(last_d, 'dd.mm.yyyy')||';           '||to_char(date_fact, 'dd.mm.yyyy');
    --  DBMS_OUTPUT.PUT_LINE(txt);
    --end if;

    -------------------
    BEGIN
      insert into cc_lim (nd, fdat, lim2, acc, sumg, sumo, otm, sumk)
      values (nd_,
              date_plan,
              s_m*100,
              acc_,
              Pl*100,
              (Pl+s_i)*100,
              1,
              0);
      commit;
    EXCEPTION
          WHEN OTHERS THEN
      rollback;
      raise_application_error(-20203, '������� ���������� ���!'||sqlerrm);
    END;
    -------------------

    if freq=7 and date_fact>=date_pog then --�������
      SELECT TO_CHAR(date_fact, 'Q') INTO s1 FROM dual;

      if s1=1 then date_pog:=to_date( Dp||'.03.'||to_char(date_fact, 'rrrr') ,'dd.mm.rrrr' ); end if;
      if s1=2 then date_pog:=to_date( Dp||'.06.'||to_char(date_fact, 'rrrr') ,'dd.mm.rrrr' ); end if;
      if s1=3 then date_pog:=to_date( Dp||'.09.'||to_char(date_fact, 'rrrr') ,'dd.mm.rrrr' ); end if;
      if s1=4 then date_pog:=to_date( Dp||'.12.'||to_char(date_fact, 'rrrr') ,'dd.mm.rrrr' ); end if;
      --DBMS_OUTPUT.PUT_LINE(s1||'---'||to_char(date_pog, 'dd.mm.yyyy'));
    elsif freq=12 then
      date_pog:=to_date( Dp||'.12.'||to_char(date_fact, 'rrrr') ,'dd.mm.rrrr' );
    elsif freq=120 then
      date_pog:=ADD_MONTHS(date_fact, 4);
    end if;

    n:=n+1;
    if bm<>2 then
      select ADD_MONTHS(to_date(Dp||substr (to_char(date_fact, 'dd.mm.rrrr'), 3, 8)  ,'dd.mm.rrrr' ),1), ADD_MONTHS(date_plan,1)
        into date_fact, date_plan
        from dual;
      if Dp>28 then
        date_fact:=billing_date(Dp, date_fact);
        date_plan:=billing_date(Dp, date_plan);
      end if;

      if flag_r<>1 then
        date_fact:=cck_app.correctdate2(gl.baseval, date_plan, day_np);
      end if;
      --DBMS_OUTPUT.PUT_LINE(n||'---'||to_char(date_plan, 'dd.mm.yyyy'));
    end if;

    s_Ostf:=s_s; -- ������ ���� ���������� ��� ���������� �������, �� ���������
    if date_fact>d_apl_dat then
      if date_fact=date_pog then
        s_s:=s_s-Pl; --����� ���� ���������� ��� ���������� �������
      end if;
      if flag_r<>1 then
        s_Ostf:=s_s;
      end if;
      --DBMS_OUTPUT.PUT_LINE(n-1||'  s_s='||s_s||'  Pl='||Pl||'  s_o='||s_o);
    end if;
  END LOOP;

  END cc_gpk_freq;
  -------------------------
  --������� �������� ���������
  --������ ��������� �������, � ������:
  --���� �� ���� ��������� ���������� % ������
  --��� ����� ���������� ��� ���� �������, � ����� �� ����������,
  --�������� ���������� ����������� ������
  FUNCTION plan_rep_gpk(nd_ INT, d_rep DATE) RETURN VARCHAR2 IS
      n INT;
      txt varchar2(100);
  BEGIN
    n:=0;
    return txt;
  END plan_rep_gpk;

  --������� �������� ��� ��������� ���������
  -- �������� �������� ������
  -- �������� ���������
  -- �������� ������������� ������� ��� ���������
  FUNCTION prepayment_gpk(nd_ INT, d_rep DATE) RETURN VARCHAR2 IS
      n INT;
      txt varchar2(100);
  BEGIN
    n:=0;
    return txt;
  END prepayment_gpk;

  FUNCTION billing_date(dd_n INT, d_rep DATE) RETURN DATE IS
      n INT;
      nn INT;
      date_v DATE;
      txt varchar2(100);
  BEGIN
    date_v:=null;
    if dd_n>28 then
      nn:=to_number(to_char( last_day(d_rep), 'dd'));
      if dd_n>nn then
        n:=nn;
      else
        n:=dd_n;
      end if;
    else
      n:=dd_n;
    end if;
    date_v:=to_date(n||'.'||to_char(d_rep, 'mm.rrrr'),'dd.mm.rrrr' );

    return date_v;
  END billing_date;

  --------------------------------------------------------------

 -- ������ FUNCTION CorrectDate2, ����� CorrectDay
 --
 -- ������������� ���� ��������� ��� ������� ����� ���� ��������� ����������� �� �������� ����
 -- ���������� ����������������� ����
 -- p_KV   - ������ (������ ������)
 -- p_OldDate - ���� ���������
 -- p_Direct -- ��� ����������� �������������
 --  null - �� �����������
 --   -2  - �� ���������� ������������
 --    0  - �������� �����
 --    1  - �������� ������
 --    -1 - �������� ����� �� ������ �� ��� �����
 --    2  - �������� ������ �� ������ �� ��� �����

FUNCTION CorrectDay( p_KV int, p_OldDate date, p_Direct number:=1) RETURN DATE is
  l_dDat date    ;
  l_n1 Number    ;
  l_nn Number    := 1;
  l_ed Number    ;
  l_Direct number;

 begin

   l_Direct := NVL ( nvl( p_Direct, -2 ), 1) ;

   if l_Direct = -2 then Return p_OldDate; end if;

   l_dDat   := p_OldDate;

   If l_Direct in (1,2) then  l_ed :=  1 ;
   else                       l_ed := -1 ;
   end if ;
   ----------------------------------------------------------
   While l_nn = 1
   loop
      begin
         SELECT count(kv) INTO l_nn FROM holiday
         WHERE kv = NVL(p_KV,gl.baseval) and holiday=l_dDat;
         l_dDat  := l_dDat + l_ed*l_nn;
      end;
   end loop;

   if l_Direct in (-1,2) and to_char(p_OldDate,'mmyyyy') != to_char(l_dDat,'mmyyyy') then

      l_nn    := 1;
      l_dDat  := p_OldDate;

       While l_nn = 1
       loop
             SELECT count(kv) INTO l_nn FROM holiday
             WHERE kv= NVL(p_KV,gl.baseval) and holiday=l_dDat;
             l_dDat:= l_dDat - l_ed*l_nn;
       end loop;

   end if;


  Return l_dDat;

 end CorrectDay;
  --
  -- header_version - ���������� ������ ��������� ������ CCK
  --
  function header_version return varchar2 is
  begin
    return 'Package header CCK '||G_HEADER_VERSION;
  end header_version;

  --
  -- body_version - ���������� ������ ���� ������ CCK
  --
  function body_version return varchar2 is
  begin
    return 'Package body CCK '||G_BODY_VERSION;
  end body_version;
  --------------

end CCK_NEW;


/
 show err;
 
PROMPT *** Create  grants  CCK_NEW ***
grant EXECUTE                                                                on CCK_NEW         to BARS009;
grant EXECUTE                                                                on CCK_NEW         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on CCK_NEW         to RCC_DEAL;
grant EXECUTE                                                                on CCK_NEW         to WR_ALL_RIGHTS;
grant EXECUTE                                                                on CCK_NEW         to WR_CREDIT;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/cck_new.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 