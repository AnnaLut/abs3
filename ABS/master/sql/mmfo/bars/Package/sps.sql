PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/package/sps.sql =========*** Run *** =======
PROMPT ===================================================================================== 



  CREATE OR REPLACE PACKAGE BARS.SPS is

  --
  -- �����  : yurii.hrytsenia, sergey.gorobets
  -- ������ : 09.07.2016
  --
  -- Purpose : ������ � ������� ����������
  --

  -- Public constant declarations
  g_header_version constant varchar2(64) := 'version 1.0.2 20/02/2018';

  --------------------------------------------------------------------------------
  -- header_version - ���������� ������ ��������� ������
  --
  function header_version return varchar2;

  --------------------------------------------------------------------------------
  -- body_version - ���������� ������ ���� ������
  --
  function body_version return varchar2;

  ------------------------------------------------------------------------------
  -- delete_scheme_side_b - �������� ����� �� ����� ���������� (perekr_b)
  --
  procedure delete_scheme_side_b(p_id in perekr_b.id%type);

  ------------------------------------------------------------------------------
  -- delete_scheme_account - �������� ������� � ����� ���������� (������� � specparam)
  --
  procedure delete_scheme_account(p_acc in specparam.acc%type);

  ------------------------------------------------------------------------------
  -- add_scheme_account - �������� ������� �� ����� ����������
  --
  procedure add_scheme_account(p_acc       in specparam.acc%type,
                               p_group_id  in specparam.idg%type,
                               p_scheme_id in specparam.ids%type,
                               p_sps       in specparam.sps%type default 1);

  ------------------------------------------------------------------------------
  -- add_scheme_side_b - �������� ����� � ������� ���������� �� ���� ����������
  --
  procedure add_scheme_side_b(p_id        in perekr_b.id%type,
                              p_scheme_id in perekr_b.ids%type,
                              p_op_type   in perekr_b.vob%type,
                              p_op_code   in perekr_b.tt%type,
                              p_mfob      in perekr_b.mfob%type,
                              p_nlsb      in perekr_b.nlsb%type,
                              p_kv        in perekr_b.kv%type,
                              p_koef      in perekr_b.koef%type,
                              p_polu      in perekr_b.polu%type,
                              p_nazn      in perekr_b.nazn%type,
                              p_okpo      in perekr_b.okpo%type,
                              p_idr       in perekr_b.idr%type,
                              p_kod       in perekr_b.kod%type default null,
                              p_formula   in perekr_b.formula%type default null);

  ------------------------------------------------------------------------------
  -- sel015 --��������� ������ ������� � ���������� ����������

  procedure SEL015(mode_ int,
                   grp   int,
                   ssps  varchar2 default '',
                   spars varchar2 default 'A',
                   isp number default 0);

  procedure PAY_PEREKR(tt_    char, --��� ��������
                       vob_   number, --��� ���������
                       nd_    varchar2, --ID ������ nd_  => substr(B.id,1,10) � ������� perekr_b --����� ������� �� ���� � �������
                       pdat_  date default sysdate, --pdat_=> SYSDATE
                       vdat_  date default sysdate, --vdat_=> gl.BDATE
                       dk_    number, --dk ��������
                       kv_    number, ---KVA
                       s_     number, --SUMA
                       kv2_   number, ---KVB
                       s2_    number, ---��������� SUMA, ������� ��� ������� ����, �������� ������ SUMA
                       sk_    number, --����� ��� ����� NULL
                       mfoa_  varchar2, --MFOA
                       nam_a_ varchar2, --����� ������� NMS
                       nlsa_  varchar2, --NLSA
                       nam_b_ varchar2, --NMKB
                       nlsb_  varchar2, --NLSB
                       mfob_  varchar2, --MFOB
                       nazn_  varchar2, --NAZN
                       id_a_  varchar2, --OKPOA
                       id_b_  varchar2, --OKPOB
                       id_o_  varchar2, --id_o_ => null
                       sign_  raw, --sign_=> null
                       sos_   number, -- Doc status sos_=> 1
                       prty_  number, -- Doc priority prty_=> null
                       uid_   number default null,
                       koef_  number);

-- sel023 --��������� ������ ������� � ���������� ����������
PROCEDURE SEL023 (Mode_  INT,
                  Grp    INT,
                  �nview VARCHAR2);

PROCEDURE PAY_PEREKR023(
               tt_     CHAR,   --��� ��������
               vob_    NUMBER, --��� ���������
               nd_     VARCHAR2, --ID ������ nd_
               pdat_   DATE DEFAULT SYSDATE, --pdat_=> SYSDATE
               vdat_   DATE DEFAULT SYSDATE, --vdat_=> gl.BDATE
               dk_     NUMBER, --dk ��������
               kv_     NUMBER,  ---KVA
               s_      NUMBER, --SUMA
               kv2_    NUMBER, ---KVB
               s2_     NUMBER, ---��������� SUMA, ������� ��� ������� ����, �������� ������ SUMA
               sk_     NUMBER, --����� ��� ����� NULL
               nam_a_  VARCHAR2, --����� ������� NMS
               nlsa_   VARCHAR2, --NLSA
               nam_b_  VARCHAR2, --NMKB
               nlsb_   VARCHAR2, --NLSB
               mfob_   VARCHAR2, --MFOB
               nazn_   VARCHAR2, --NAZN
               id_a_   VARCHAR2, --OKPOA
               id_b_   VARCHAR2, --OKPOB
               id_o_   VARCHAR2, --id_o_ => null
               sign_   RAW,      --sign_=> null
               sos_    NUMBER,     -- Doc status sos_=> 1
               prty_   NUMBER,     -- Doc priority prty_=> null
               uid_    NUMBER DEFAULT NULL,
               d_rec_  VARCHAR2,
               id_     NUMBER,
               tabn_   VARCHAR2
);

--��������� ������ ���� ������� (��� ���������)
procedure pay_some_perekr (p_union_id number);

end sps;
/

CREATE OR REPLACE PACKAGE BODY BARS.sps is

  ------------------------------------------------------------------------------
  --  Author : yurii.hrytsenia, sergey.gorobets
  --  Created : 27.06.2016
  --  Purpose: ����� ��� ������ ������� ����������
  ------------------------------------------------------------------------------

  -- Private constant declarations
  g_body_version constant varchar2(64) := 'version 1.0.2 20/02/2018';
  g_log_prefix   constant varchar2(20) := 'sps:: ';

  ------------------------------------------------------------------------------
  -- header_version - ���������� ������ ��������� ������
  --
  function header_version return varchar2 is
  begin
    return 'Package header sps ' || g_header_version;
  end header_version;

  ------------------------------------------------------------------------------
  -- body_version - ���������� ������ ���� ������
  --
  function body_version return varchar2 is
  begin
    return 'Package body sps ' || g_body_version;
  end body_version;

  ------------------------------------------------------------------------------
  -- delete_scheme_side_b - �������� ����� �� ����� ���������� (perekr_b)
  --
  procedure delete_scheme_side_b(p_id in perekr_b.id%type) is
  begin
    delete from perekr_b p where p.id = p_id;
    if (sql%rowcount = 0) then
      logger.info(g_log_prefix || '�� ������� �������� ������� ���������� � ����� ���������� (perekr_b) � id=' || p_id);
    else
      logger.info(g_log_prefix || '�������� ' || sql%rowcount || ' ����� � �����������(���) (perekr_b) � ����� ���������� � id=' || p_id);
    end if;
  end;

  ------------------------------------------------------------------------------
  -- delete_scheme_account - �������� ������� � ����� ���������� (������� � specparam)
  --
  procedure delete_scheme_account(p_acc in specparam.acc%type) is
  begin
    update specparam set idg = null, ids = null, sps = null where acc = p_acc;
    if (sql%rowcount = 0) then
      logger.info(g_log_prefix || '�� ������� ���`����� ������� �� ����� ����������, acc=' || p_acc);
    else
      logger.info(g_log_prefix || '³��`����� ������� �� ����� ����������, acc=' || p_acc);
    end if;
  end;

  ------------------------------------------------------------------------------
  -- add_scheme_account - �������� ������� �� ����� ����������
  --
  procedure add_scheme_account(p_acc       in specparam.acc%type,
                               p_group_id  in specparam.idg%type,
                               p_scheme_id in specparam.ids%type,
                               p_sps       in specparam.sps%type default 1) is
  begin
    update specparam set idg = p_group_id, ids = p_scheme_id, sps = p_sps where acc = p_acc;
    if (sql%rowcount = 0) then
      insert into specparam (acc, idg, ids, sps) values (p_acc, p_group_id, p_scheme_id, p_sps);
      logger.info(g_log_prefix || '������� acc=' || p_acc || ' ��������� �� ����� ���������� (idg=' || p_group_id || ', ids=' || p_scheme_id || ').');
    else
      logger.info(g_log_prefix || '������� acc=' || p_acc || ' ������ � ���� ���������� (idg=' || p_group_id || ', ids=' || p_scheme_id || ').');
    end if;
  end;

  ------------------------------------------------------------------------------
  -- add_scheme_side_b - �������� ����� � ������� ���������� �� ���� ����������
  --
  procedure add_scheme_side_b(p_id        in perekr_b.id%type,
                              p_scheme_id in perekr_b.ids%type,
                              p_op_type   in perekr_b.vob%type,
                              p_op_code   in perekr_b.tt%type,
                              p_mfob      in perekr_b.mfob%type,
                              p_nlsb      in perekr_b.nlsb%type,
                              p_kv        in perekr_b.kv%type,
                              p_koef      in perekr_b.koef%type,
                              p_polu      in perekr_b.polu%type,
                              p_nazn      in perekr_b.nazn%type,
                              p_okpo      in perekr_b.okpo%type,
                              p_idr       in perekr_b.idr%type,
                              p_kod       in perekr_b.kod%type default null,
                              p_formula   in perekr_b.formula%type default null) is
  /*
  29.01.2018 ������ ��������� �������� ������� ����� ��������� ��������:
                              p_kod       in perekr_b.kod%type default null, - ������� ���������� (������� ���������) �������
                              p_formula   in perekr_b.formula%type default null); - �������
  */
  begin
    if p_id is null then
      insert into perekr_b (ids, vob, tt, mfob, nlsb, kv, koef, polu, nazn, okpo, idr, kod, formula) values (p_scheme_id, p_op_type, p_op_code, p_mfob, p_nlsb, p_kv, p_koef, p_polu, p_nazn, p_okpo, p_idr, p_kod, p_formula);
      logger.info(g_log_prefix || '������� ������ ���������� �� ���� ���������� ids=' || p_scheme_id);
    else
      update perekr_b p
         set p.vob = p_op_type, p.tt = p_op_code, p.mfob = p_mfob, p.nlsb = p_nlsb, p.kv = p_kv, p.koef = p_koef, p.polu = p_polu, p.nazn = p_nazn, p.okpo = p_okpo, p.idr = p_idr, p.kod = p_kod, p.formula = p_formula
       where id = p_id;
      logger.info(g_log_prefix || '��������� ���������� perekr_b.id=' || p_id || ' �� ���� ���������� ids=' || p_scheme_id);
    end if;
  end;
  ------------------------------------------------------------------------------
  -- sel015 -
PROCEDURE SEL015
( Mode_ int, Grp  int, sSps varchar2 default '', sParS varchar2 default 'A', isp number default 0)
is
/****************************************************************************
24.03.2017 ������ ���������� ���������� �������. ����� ����� � ���������� ������� ����������������
���� �������� � ������ �������:
 #(S)', - ��������� ������� �������
 #(S2)', -   ���� �������
 #(NLSA)',  - ������� �
 #(NLSB)',  - ������� �
 #(MFOA)', -  ��� �
 #(MFOB)',  - ��� �
 #(KV)',   -  ���. �
 #(KV2)',  -  ���. �
 #(TT)',   -  ��� ��������
 #(KOEF)',' -  ����������
����� � ���������� ����� ��������������� ������ ����:  #{F_DOG_PER (1)}
������� F_DOG_PER (1) ������ �������� � ������� perekr_dog �������� �� ID (� ������ ������� �� 1)
����� ������������� �� �����������. ��� �� ����������� ����� ������� ���� �� ����
������������ � ����������� � ����������� �� �, ����� ���������� ����� �������.
19.01.2017 ������� ���������� �������� "isp number default 0" � ���������, ���� ���� ���������
�� ��������� �� �������� ������� �������� ����� ������ ������� �� ���������. ������� ���
��������� ������� ����: Sel015(hWndMDI,1,2, 'S','a.isp='||Str(GetUserId()))
���� ��������� ������ �����, ��������� ����� ��������� �������� 1
17.01.2017 ������ ��� ����� ������ ����� �� KF ��� ������� saldo ��� accounts �� perekr_b
(a.kf=sys_context('bars_context','user_mfo'), pb.kf=sys_context('bars_context','user_mfo'))
29.07.2016 ��� � ������� ���������� � ����������� � sys_context('bars_global','user_id')
07.07.2016 ������ ������� ������ ��� ���������� SEL015.
18.06.2016 ���� � ����������� % ������������� ����� (�-� 33%)
17.06.2016 ��������� �������� �� �������� ������� �� ��������� ���
(select dazs from accounts where nls=pb.nlsb and kv=pb.kv and PB.MFOB=bars.f_ourmfo()) is null
16.06.2016
������� ���� ID NUMBER (38),
(� ������� perekr_b), ������� ���� MFOA (� ������� accounts or saldo)
����� ��� ��������
Mode_ - ��������, ���� � ������� ������� �� �� �� �������� ������� �
��������������� �������� ������� (�������� �������� = ���������� Mode_= 1)
��� ��� �������������� (�������� ������� �� ������� ���������� Mode_= 1)
GRP - ����� ����� ����������
sParS - �������� ���� ���� �� ���� ������� �������� � ������� saldo (�� ��
������ ������� �� ������� saldo) ������ accounts (
�� ��� ������ �� ������� �� ������� ������)
sSps - �������� ���� ���� ����� ���������� ���� ��������� ��� �������������
(01,29,763)
������� ���������� � ������� ������ (���, perekr_b ���� formula)
(pb.formula - �������,pb.kod - ������� ���������� (���� ������ �����������
� �������� ���� � ������������))
/*****************************************************************/
/*����� ��� ���������� ��� ������ ��������� ��� ���������
��� ����������� ������.
06.07.2016 �������� �������� ����������� �� ������� NLSA. ���� � �����������
� ������� � ���������� KOD (������� ����������� ������) �� �������� �������������
������ � ��������� � ���� ��������� KOD, ���� ����������� ��� ������ � ���������
������������� ����� � �������������, ��������� � ���������� �� ���������� �����������.
������� ����� ������ ���� �����  �������� �� ������� �� ������� ��� ���� ������������� ���.
02.07.2016
--�������: ��� ����������� � ������� ������ ���� F_TARIF(46,980,#(NLSA), #(S))
��������� ����'������ �������� ��� ���� ����������� ��� �����
������� ������� ���� KOD. KOD - ���� ������� (�����������) ��������� ��� �� ��������.
KOD=1,2,3...
*/
/*****************************************************************/
  sSql        varchar2(4000); --��������� �����
  l_mfo       char(6);        --������� ���
  strTabN     varchar2(30);   --� ��������� �� ��������� saldo or accounts
  sSps1       varchar2(2);   --����� ���������� ����
  l_sSps      varchar2 (25);
  s1          number;
  l_U_ID      number;
  l_str       varchar2(255 BYTE); --����� ��� ������ �������
  l_sf        number; -- �������� ����� ��� ���� �������
  s2          number; -- ����� ��� ��������� ���� ���� �������� �������
  s3          number; --��������� ����
  B_sum       number;
  num    number;
 -------------���� ��� ���������� ����������� �������
 l_nazn     varchar2(4000); --�������������� �����������
 l_s        varchar2(4000); -- ������ �������� ������
 s_nazn     varchar2(4000); --�������� �������
 l_s1       varchar2(4000); -- ������ �������� ������
 n1         number; --������� ������� ��������� �������
 n2         number;--������� ���� ��������� �������
 n3         number; --������� ������� ��������� �������
 n4         number; --������� ���� ��������� �������
-----------------------------------

begin
  if  Grp is null then

        RAISE_APPLICATION_ERROR(-20000,'�� ����� ����� ����� ����������');

   end if;

  --������ ������� ���
  l_mfo:=bars.f_ourmfo();

  --�������� �������� �� ������� ������������ saldo �� accounts
IF SUBSTR(sParS,1,1)='S'THEN strTabN:='saldo'; ELSE strTabN:='accounts'; END IF;

 --�������� �������� ����� ���������� ���� sSps varchar2
 --���� ���� ������� sSps ��� ���������� ���� ��������� �����
 --������� KAZ, ���� �� ������ ���� - ���������� ����� KAZ �
 --� �������� SPS (SPECPARAM ���� SPS)
 IF  sSps IS NULL THEN l_ssps:='KAZ(pa.sps, pa.acc)';
                  ELSE l_ssps:='KAZ('||sSps||', pa.acc)';
                  END IF;

-------------------------
IF ( Mode_ = 11 ) THEN

  sSql:=q'[SELECT a.nls as NLSA,
       a.kv as KVA,
       pb.mfob as MFOB,
       SUBSTR (VKRZN (SUBSTR (pb.mfob, 1, 5),TRIM (SUBSTR (DECODE (SUBSTR (pb.nlsb, 5, 1),'*', SUBSTR (pb.nlsb, 1, 4) || SUBSTR (a.nls, 5),pb.nlsb),1,14))),1,14) as NLSB,
       pb.kv as KVB,
       pb.tt as TT,
       pb.vob as VOB,
       ABS(%sSps) as SUMA_SPS,
       pb.koef as KOEF,
       SUBSTR (DECODE (pb.mfob, %mfo, a.nms, NVL (k.nmkk, k.nmk)), 1, 38) as NMK,
       SUBSTR (a.nms, 1, 38) as NMS,
       DECODE (SUBSTR (pb.nlsb, 5, 1), '*', NVL (k.nmkk, k.nmk), pb.polu) as NMKB,
       pb.nazn as NAZN,
       a.acc as ACC,
       k.okpo as OKPOA,
       DECODE (SUBSTR (pb.nlsb, 5, 1), '*', k.okpo, pb.okpo) as OKPOB,
       pb.idr as IDR,
       t.dig as DIG,
       pa.sps as sps,
       CASE WHEN KAZ (pa.sps, pa.acc) < 0 THEN 0 ELSE 1 END as DK,
       ABS(%sSps*pb.koef) as SUMA,
       pb.KOD as KOD,
       pb.FORMULA as FORMULA,
       pb.id as ID,
       a.KF as MFOA,
       rownum as U_ID,
       (select sys_context('bars_global','user_id') from dual) as US_ID
  from SPECPARAM pa,
       PEREKR_B  pb,
       %STRTABN  a,
       TABVAL    t,
       CUSTOMER  k,
       CUST_ACC  c
 WHERE pa.ids = pb.ids
   AND pa.acc = a.acc
   AND a.kv = t.kv
   AND c.acc = a.acc
   AND c.rnk = k.rnk
   AND pa.idg = %GRP
   AND pb.koef > 0
   AND %sSps <> 0
   AND a.kf=sys_context('bars_context','user_mfo')
   AND pb.kf=sys_context('bars_context','user_mfo')]';


  sSql := REPLACE( sSql, '%sSps', l_sSps );
  sSql := REPLACE( sSql, '%mfo', l_mfo );
  sSql := REPLACE( sSql, '%STRTABN', strTabN );
  sSql := REPLACE( sSql, '%GRP', TO_CHAR(Grp) );

 ELSE

  sSql:=q'[SELECT a.nls as NLSA,
       a.kv as KVA,
       pb.mfob as MFOB,
       SUBSTR (VKRZN (SUBSTR (pb.mfob, 1, 5),TRIM (SUBSTR (DECODE (SUBSTR (pb.nlsb, 5, 1),'*', SUBSTR (pb.nlsb, 1, 4) || SUBSTR (a.nls, 5),pb.nlsb),1,14))),1,14) as NLSB,
       pb.kv as KVB,
       pb.tt as TT,
       pb.vob as VOB,
       ABS(%sSps) as SUMA_SPS,
       pb.koef as KOEF,
       SUBSTR (DECODE (pb.mfob, %mfo, a.nms, NVL (k.nmkk, k.nmk)), 1, 38) as NMK,
       SUBSTR (a.nms, 1, 38) as NMS,
       DECODE (SUBSTR (pb.nlsb, 5, 1), '*', NVL (k.nmkk, k.nmk), pb.polu) as NMKB,
       pb.nazn as NAZN,
       a.acc as ACC,
       k.okpo as OKPOA,
       DECODE (SUBSTR (pb.nlsb, 5, 1), '*', k.okpo, pb.okpo) as OKPOB,
       pb.idr as IDR,
       t.dig as DIG,
       pa.sps as sps,
       CASE WHEN KAZ (pa.sps, pa.acc) < 0 THEN 0 ELSE 1 END as DK,
       ABS(%sSps*pb.koef) as SUMA,
       pb.KOD as KOD,
       pb.FORMULA as FORMULA,
       pb.id as ID,
       a.KF as MFOA,
       rownum as U_ID,
       (select sys_context('bars_global','user_id') from dual) as US_ID
  from SPECPARAM pa,
       PEREKR_B  pb,
       %STRTABN  a,
       TABVAL    t,
       CUSTOMER  k,
       CUST_ACC  c
 WHERE pa.ids = pb.ids
   AND pa.acc = a.acc
   AND a.kv = t.kv
   AND c.acc = a.acc
   AND c.rnk = k.rnk
   AND pa.idg = %GRP
   AND pb.koef > 0
   AND %sSps <> 0
   AND KAZ(763, pa.acc)<>0
   AND a.kf=sys_context('bars_context','user_mfo')
   AND pb.kf=sys_context('bars_context','user_mfo')]';

  sSql := REPLACE( sSql, '%sSps', l_sSps );
  sSql := REPLACE( sSql, '%mfo', l_mfo );
  sSql := REPLACE( sSql, '%STRTABN', strTabN );
  sSql := REPLACE( sSql, '%GRP', TO_CHAR(Grp) );

end if;

   -- ��������� ����� � ������� �� USER_ID
BEGIN
   DELETE FROM tsel015
         WHERE US_ID =
                  (SELECT SYS_CONTEXT ('bars_global', 'user_id') FROM DUAL);
COMMIT;
END;

   --�������� ������� �������� ISP. ���� �������� =1 �� ������ �� �������� �������
   --����� ������ �� ���������.
  CASE isp
        WHEN 1 THEN sSql:=sSql||'and a.isp = '||SYS_CONTEXT('bars_global','user_id');
            ELSE NULL;
  END CASE;

BEGIN
   logger.info('SPS: '||ssql);
   EXECUTE IMMEDIATE 'insert into TSEL015 ' || sSql;
   COMMIT;
    --������������� ���  ������������, ���������� ���������� �� �������

       --���� ������� �
        for A in (select distinct NLSA, KVA, suma_sps from TSEL015 where US_ID  = sys_context('bars_global','user_id'))
            loop
                  s2:=A.suma_sps;
                           for B in (  SELECT
                                           NLSA,
                                           NLSB,
                                           KVB,
                                           KOEF,
                                           SUMA_SPS,
                                           SUMA,
                                           U_ID,
                                           ROUND (SUMA_SPS * KOEF, 0) AS ROUND_SUMA,
                                           FORMULA,
                                           KOD,
                                           TT,
                                           sum (suma) over (partition by NLSA) as all_suma,   --���� ��� ����������� ���, ��������������� ��� �������� � ���������� �������� �� �������
                                           ROW_NUMBER () OVER (PARTITION BY nlsa ORDER BY formula, kod, koef) AS ROW_NUMBER,   --���������� ����� ����� � �����,  ��������������� ��� ���������
                                           COUNT (*) OVER (PARTITION BY nlsa ORDER BY formula, kod, koef ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS total_count --�-�� ����� � �����, ��������������� ��� ���������
                                         from tsel015
                                         where NLSA   =  A.NLSA
                                          and  KVA = A.KVA
                                          and  US_ID  =  sys_context('bars_global','user_id')
                                         order by kod, koef, row_number) -- ���������� �������� �� ������ ���� ��� � ����������, ������� ��� ����������
                        loop
                             select count(1) into num from tsel015 where NLSA=A.NLSA  and  US_ID  =  sys_context('bars_global','user_id') and formula is not null; -- ���� ���������� ������� � ���������
                              l_str:=B.formula;
                              --���������� ���� ���������� ������� � �����
                        IF B.formula is not null THEN
                            BEGIN
                                if instr (l_str,'#(NLSA)')>0
                                    then l_str:=replace (l_str,'#(NLSA)', to_char(A.NLSA));
                                    end if; --������� �
                                if instr (l_str,'#(NLSB)')>0
                                    then l_str:=replace (l_str,'#(NLSB)', to_char(B.NLSB));
                                    end if; --������� B
                                if instr (l_str,'#(S0)')>0
                                    then l_str:=replace (l_str,'#(S0)', to_char(S2)); --- ��������� ����
                                    end if; -- �������� �������
                                if instr (l_str,'#(TT)')>0
                                    then l_str:=replace (l_str,'#(TT)', to_char(B.TT));
                                    end if; --��� ��������
                                if instr (l_str,'#(S)')>0
                                    then l_str:=replace (l_str,'#(S)', to_char(round(A.suma_sps*B.koef,0)));
                                    end if; --����: ��������� ������� �� ������� � * �� ����������
                               begin
                                execute immediate 'select '||l_str||' from dual' into l_sf; --����������� �� ������
                                  exception when others then
                                                          begin
                                                          RAISE_APPLICATION_ERROR (-20004,'������� ��� �������� ��������� �������: '||l_str) ;
                                                          end;
                              end;
                                -- �������� ���������� ���� �� ������, ���������� ��������� ���������, ���� ����
                                --��� ���������� �� ������ �������� ������� �� �������
                                if l_sf>S2
                                    then
                                    RAISE_APPLICATION_ERROR (-20000,'���� ���������� �������� ����� ��� ��������� ���� �� ������� - '||A.NLSA) ;
                                    end if;
                                -- ���� �������� ����� ����� ������� �������� �-� ����� (����� ������� �����)
                                --���� ��� ������ ������� ����������� ����� ���� ������� � �������� � �� �������
                                --���� ��� ����� ��� ������ ������� �� �������.
                                if b.total_count <>1 then --���� ��� ������ ������� ����������� ����� ��� ���� ������� ����������
                                          if b.row_number = b.total_count then null; --03.02.2017 ��� ���������� ������ �� ������   --- old l_sf:=s2; --���������� ��� ���� ��� ��������
                                                                                    --���������� ��� ���� �� ������� ���. (������)
                                                   else
                                                   s2:=s2-l_sf; --���� ����� �� ������� ������� �� ��������� ������� ���������� �� ������ ����
                                                   s3:=s2;
                                                   end if;
                                       --else s2:=s2-l_sf;
                                end if;
                                -- �������� ���������� ���� �� ������, ���������� ��������� ���������, ���� ����
                                --�������� �� ���� �� ����� �� 0
                                IF l_sf<0
                                    THEN
                                    RAISE_APPLICATION_ERROR (-20001,'���� ��� ������������� � ������� '|| A.NLSA ||' �� ������� '||B.NLSB || ' ����� �� 0');
                                    END IF;

                                update tsel015 --��������� ���� ��������� (�����)
                                set suma=l_sf
                                where NLSA=A.NLSA and
                                      NLSB=B.NLSB and
                                      koef=B.koef and
                                      U_ID=B.U_ID;

                            END;
                        end if; -- ��� �������
                        -- ��� ����� �� ������������� �� �� ������
                        IF B.formula is null THEN
                            --���� ��������� �������� �� CASE
                            update tsel015
                            set suma =  case
                                        when b.row_number = b.total_count then --s2, s3 --���� ����� ������� ���� ��������� ���� �������
                                                                              case when num=0 then s2
                                                                                              else s3
                                                                              end

                                                              else case when num=0 then round(B.suma_sps * b.koef,0) --���� ����� �� ������� ���� ��������� = �������� �������� �� ������� * �� ����������
                                                                                   else round(s2 * b.koef,0) end
                                        end
                               where NLSA=A.NLSA and
                               NLSB=B.NLSB and
                               koef=B.koef and
                               U_ID=B.U_ID;
                          s3:=s3-round(s2 * b.koef,0); --��������� ����, ���� ��������. ������ + �������.
                        --�������� �� ���� �� ����� �� 0
                          /*logger.info('SPS debug A.NLSA: '    ||A.NLSA);
                          logger.info('SPS debug A.KVA: '     ||A.KVA);
                          logger.info('SPS debug A.suma_sps: '||A.suma_sps);
                          logger.info('SPS debug s2: '        ||s2);
                          logger.info('SPS debug s2 B.NLSB: ' ||B.NLSB);
                          logger.info('SPS debug s2 B.NLSA: ' ||B.NLSA);
                          logger.info('SPS debug s2 B.KVB: '  ||B.KVB);*/
                          IF s2<0
                             THEN
                             RAISE_APPLICATION_ERROR (-20002,'���� ��� ������������� � ������� '|| A.NLSA ||' �� ������� '||B.NLSB || ' ����� �� 0');
                          END IF;

                          --��������, ���� ����� �� ������� �� �� ��������� ������� ������� ���������� ���� (�������� ������� * �� ����������)
                          IF b.row_number <> b.total_count THEN --s2:=s2-round(B.suma_sps * B.koef,0);
                                                                 case num
                                                                      when 0 then s2:=s2-round(B.suma_sps * B.koef,0);
                                                                      else null;
                                                                 end case;


                          end if;

                        END IF;
       end loop;   --����� ����� �

/*        SELECT SUM (suma)
          INTO B_sum
          FROM TSEL015
         WHERE NLSA = A.NLSA and US_ID  =  sys_context('bars_global','user_id');
*/

--        IF B_sum <> A.suma_sps
--           THEN
--              RAISE_APPLICATION_ERROR (-20003,'���� ��� ���������� �� ������� '|| A.NLSA|| ' �� ���� ������� �� ������� '|| A.NLSA);
--           END IF;

      end loop; --����� ����� �
    COMMIT;

-------------------------------------- �������ֲ� ����������
begin
for k in (select * from TSEL015 where US_ID=SYS_CONTEXT('bars_global','user_id'))
 loop
  l_nazn:=k.nazn;
  --����� ������ ���� #{F_DOG_PER (1)}
  if regexp_like(l_nazn, '#') then

    begin
        --��#(MFOA)--#(MFOB)--#(KV)--#(KV2)--#(TT)--#(KOEF) ���.�.���� #{F_DOG_PER(1)}, � �.�.���--#{F_DOG_PER (1)}--#(S), #(NLSA)--#(NLSb)
       --����� ��� ��
       if regexp_like(l_nazn,'F_DOG_PER') then
                                               begin
                                               -- ����� �������, ��������� �� ����������� ����� ���� ���.
                                                -- while regexp_like(l_nazn,'(#{)')
                                                -- loop
                                               --������� ����� ������� ��� replace
                                               n1:=regexp_instr(l_nazn,'(#{)',1);-- ������� ������� ��������� #
                                               --DBMS_OUTPUT.PUT_LINE('N1: '||n1);
                                                --#{F_DOG_PER (1)}
                                               n2:=regexp_instr(l_nazn,'\)}',1); --������� ������� ��������� }
                                               --DBMS_OUTPUT.PUT_LINE('N2: '||n2);
                                               --s1:=substr(l_nazn, regexp_instr(l_nazn,'#',1), 16);
                                               l_s1:=substr(l_nazn, n1,n2-n1+2); --������� ����� ����� �������
                                               --DBMS_OUTPUT.PUT_LINE('������� -1: '||s1);
                                               -------------------------------------------------
                                               --� ������ ������� ���� ������� ��� ���������
                                               n3:= regexp_instr(l_s1,'#',1)+2;
                                               --DBMS_OUTPUT.PUT_LINE('N3: '||n3);
                                               --DBMS_OUTPUT.PUT_LINE('S1: '||s1);
                                               n4:=regexp_instr(l_s1,'\)}',1)-2;
                                               --DBMS_OUTPUT.PUT_LINE('N4: '||n4);

                                               l_s:=substr(l_s1, n3, n4);
                                               --DBMS_OUTPUT.PUT_LINE('�������: '||s);
                                               --��������� �������� �� ������
                                               begin
                                               execute immediate 'select '||l_s||' from dual' into s_nazn ; --���������� �������
                                               --DBMS_OUTPUT.PUT_LINE('������� 0: '||s_nazn);
                                               exception when others then
                                                          begin
                                                          RAISE_APPLICATION_ERROR (-20004,'������� ��� �������� ��������� ������� � ����������: '||l_s||'NLSB: '||k.NLSB||'�����������: '||k.NAZN) ;
                                                          end;
                                               end;
                                               --����� ������� �� �������� ������� � ����������
                                               l_nazn:= replace(l_nazn, l_s1 , s_nazn);
                                               --DBMS_OUTPUT.PUT_LINE('������� 1: '||l_nazn);
                                               --end loop;

                                               end;

       end if; --��������� IF  �� ������ #{F_DOG_PER (1)}

       -----------------------����� ������ �������� ���������
     if regexp_like(l_nazn, '#') then
       begin
      -- while regexp_like(l_nazn,'#')
      --loop

      IF SUBSTR(l_nazn, regexp_instr(l_nazn,'#',1), 2)='#(' THEN
         BEGIN
           l_nazn := REPLACE(UPPER(l_nazn),'#(S)',                    TO_CHAR(k.suma_sps));
           l_nazn := REPLACE(UPPER(l_nazn),'#(S2)',                       TO_CHAR(k.suma));
           l_nazn := REPLACE(UPPER(l_nazn),'#(NLSA)',                  ''''||k.nlsa||'''');
           l_nazn := REPLACE(UPPER(l_nazn),'#(NLSB)',                  ''''||k.nlsb||'''');
           l_nazn := REPLACE(UPPER(l_nazn),'#(MFOA)',                  ''''||k.mfoa||'''');
           l_nazn := REPLACE(UPPER(l_nazn),'#(MFOB)',                  ''''||k.mfob||'''');
           l_nazn := REPLACE(UPPER(l_nazn),'#(KV)',                        TO_CHAR(k.kva));
           l_nazn := REPLACE(UPPER(l_nazn),'#(KV2)',                       TO_CHAR(k.kvb));
           l_nazn := REPLACE(UPPER(l_nazn),'#(TT)',                      ''''||k.tt||'''');
           l_nazn := REPLACE(UPPER(l_nazn),'#(KOEF)',''''||TO_CHAR(k.koef,'0D0000')||'''');

         END;

      end if;

    --end loop;

   end;
     end if;

     --DBMS_OUTPUT.PUT_LINE('����������� full:     '||l_nazn);
      l_nazn:= substr(l_nazn,1,160); --������� ����������� ����������� ������� �� 160 �������
     --DBMS_OUTPUT.PUT_LINE('����������� shot:  '||l_nazn);
     --��������� ����������� ��� ������
       update TSEL015
       set nazn= l_nazn
       where US_ID=SYS_CONTEXT('bars_global','user_id')
             and U_ID=k.U_ID;
       commit;

     end;

    end if;  --��������� IF

 end loop;
end;
--------------------------------


end;
end SEL015;
procedure pay_perekr  (
                       tt_     CHAR,   --��� ��������
                       vob_    NUMBER, --��� ���������
                       nd_     VARCHAR2, --ID ������ nd_  => substr(B.id,1,10) � ������� perekr_b
                       pdat_   DATE DEFAULT SYSDATE, --pdat_=> SYSDATE
                       vdat_   DATE DEFAULT SYSDATE, --vdat_=> gl.BDATE
                       dk_     NUMBER, --dk ��������
                       kv_     NUMBER,  ---KVA
                       s_      NUMBER, --SUMA
                       kv2_    NUMBER, ---KVB
                       s2_     NUMBER, ---��������� SUMA, ������� ��� ������� ����, �������� ������ SUMA
                       sk_     NUMBER, --����� ��� ����� NULL
                       mfoa_   VARCHAR2, --MFOA
                       nam_a_  VARCHAR2, --����� ������� NMS
                       nlsa_   VARCHAR2, --NLSA
                       nam_b_  VARCHAR2, --NMKB
                       nlsb_   VARCHAR2, --NLSB
                       mfob_   VARCHAR2, --MFOB
                       nazn_   VARCHAR2, --NAZN
                       id_a_   VARCHAR2, --OKPOA
                       id_b_   VARCHAR2, --OKPOB
                       id_o_   VARCHAR2, --id_o_ => null
                       sign_   RAW,      --sign_=> null
                       sos_    NUMBER,     -- Doc status sos_=> 1
                       prty_   NUMBER,     -- Doc priority prty_=> null
                       uid_    NUMBER DEFAULT NULL,
                       koef_   NUMBER)
IS
 REF_  number ; --��������
 data_   DATE ; --data_=> gl.BDATE,
 datp_   DATE ; --datp_=> gl.bdate,
 l_d_rec varchar2(60) ;
 l_nazn varchar2(160);
 l_flag number;

begin
l_d_rec:='';
data_:=gl.BDATE;
datp_:=gl.bdate;
l_nazn:=nazn_;

--���������� �����������
--IF length (nazn_)<=148 then l_NAZN:=l_NAZN||' ('||KOEF_*100||'%)';
--else l_d_rec:='#� ('||KOEF_*100||'%)'||'#'; end if;

        BEGIN
           SELECT SUBSTR (flags, 38, 1)
             INTO l_flag
             FROM tts
            WHERE tt = tt_;
        EXCEPTION
           WHEN NO_DATA_FOUND
           THEN
              l_flag := 0;
        END;
    --������ ���������
    IF S_> 0 THEN
             gl.REF(REF_);
             gl.in_doc3
              (ref_  => REF_,   tt_   => tt_  , vob_ => vob_  , nd_  => TO_CHAR (REF_),  pdat_=> pdat_ , vdat_=> gl.BDATE,  dk_=> dk_,
               kv_   => kv_,   s_    => S_   , kv2_ => kv2_, s2_  => S_,   sk_ => sk_, data_=> data_ , datp_=> datp_ ,
               nam_a_=> nam_a_,  nlsa_ => nlsa_ , mfoa_=> mfoa_,
               nam_b_=> nam_b_, nlsb_ => nlsb_, mfob_=> mfob_ , nazn_ => l_nazn,
               d_rec_=> l_d_rec  , id_a_ => id_a_, id_b_=> id_b_ , id_o_ => id_o_, sign_=> sign_, sos_=> sos_, prty_=> prty_, uid_=> uid_);

             paytt (l_flag, REF_,  gl.bDATE, TT_, DK_, kv_, nlsa_, S_, kv2_, nlsb_, S_  );
    end if;

    if ref_ is not null then

                           begin
                           logger.info ('SPS015: ' || ref_);
                           --logger.info ('SPS: ' ||nlsa_||' '||mfoa_||' '||id_a_||' '||sys_context('bars_global','user_id')||'suma '||S_);
                           delete from tsel015 t
                           where  T.NLSA=nlsa_
                              and T.MFOA=mfoa_
                              and T.OKPOA = id_a_
                              and T.KVA= kv_

                              and T.NLSB=nlsb_
                              and T.MFOB=mfob_
                              and T.OKPOB=id_b_
                              and T.KVB=kv2_

                              and t.tt=tt_
                              and t.dk=dk_

                              and T.SUMA=S_
                              and t.nazn like l_nazn

                              and t.us_id=sys_context('bars_global','user_id');
                              ----------------------------
                           commit;
                           end;

    end if;
END;

PROCEDURE SEL023
( Mode_ int, Grp  int, �nview varchar2)
IS

/*******************************************/
/*
17.01.2017 ������ ��������� �� ����������� ��� ��������� �����:
WHERE US_ID = (SELECT SYS_CONTEXT ('bars_global', 'user_id') FROM DUAL)
06.07.2016
Mode_ - ���������� ����� �������, ��� ����� ����������
���� ����� 7, ������� ���� ����� ���� ���������
Grp  - ����� ����������
Inview  - �������� � ����� ��������� ��� VIEW ��������������� ���
����������: PER_KRM, PER_INK_N, PER_INK

������� ���� DREC VARCHAR2(60) ��� ������� �������
���������� ���� �� ������ ����, ���� ����� ���� ���������
�������� ��������� ������ � ��� ��������� "���������� ����".

*/
/*******************************************/
sSql varchar2 (4000);
l_tabn varchar2(10);
begin

 --�������� �� ���������� mode
 IF MODE_ <> 7
    THEN
        RAISE_APPLICATION_ERROR(-20000,'�� ����� �������� Mode_');
 END IF;
  --�������� �� ��������� view
 IF TRIM (�nview) NOT IN ('PER_KRM','PER_INK_N','PER_INK')
    THEN
        RAISE_APPLICATION_ERROR(-20001, '�� ����� �������� �nview');
 END IF;

  --���������� ���������� ������ ������ �������
    IF Mode_= 7
      THEN
       BEGIN
                 sSql:=q'[
                 SELECT
                 nlsa,
                 kva,
                 mfob,
                 nlsb,
                 NVL (kvb, kva) as KVB,
                 tt,
                 vob,
                 SUBSTR (a.nd, 1, 10) as ND,
                 datd,
                 s,
                 nam_a,
                 nam_b,
                 SUBSTR (a.nazn, 1, 217) NAZN,
                 okpoa,
                 okpob,
                 grp,
                 ref,
                 sos,
                 id,
                 CASE WHEN s < 0 THEN 0 ELSE 1 END as DK,
                 CASE
                    WHEN kva <> NVL (kvb, kva) AND (kva = 980 OR NVL (kvb, kva) = 980)
                    THEN
                       DECODE (kva,
                               980, gl.p_ncurval (NVL (kvb, kva), s, gl.bd),
                               gl.p_icurval (kva, s, gl.bd))
                    ELSE
                       s
                 END as s2,
                 null as DREC,
                 null as Tabn,
                 (select sys_context('bars_global','user_id') from dual) as US_ID
            FROM %VIEW a
           WHERE NVL (a.sos, 0) = 0 AND a.grp = '%Grp'
        ORDER BY a.grp,
                 SUBSTR (a.nlsa, 1, 4),
                 SUBSTR (a.nlsa, -3),
                 a.kva,
                 a.id]';
        END;
       --������ � ����� �������� �� ��� ������ ����� ���������
       sSql := REPLACE( sSql, '%Grp', TO_CHAR(Grp) );
       sSql := REPLACE( sSql, '%VIEW', TO_CHAR(�nview));

       -- ��������� ����� � ������� �� USER_ID
    BEGIN
       DELETE FROM TSEL023
             WHERE US_ID =
                      (SELECT SYS_CONTEXT ('bars_global', 'user_id') FROM DUAL);
       COMMIT;
    END;

    BEGIN
       EXECUTE IMMEDIATE 'insert into TSEL023 ' || sSql;
    END;
      COMMIT;

     l_tabn:=�nview;

     FOR T IN (SELECT tabn FROM TSEL023  WHERE US_ID = (SELECT SYS_CONTEXT ('bars_global', 'user_id') FROM DUAL))
        LOOP
            UPDATE TSEL023
               SET tabn = l_tabn;
        END LOOP;
     COMMIT;
    END IF;

end;
PROCEDURE PAY_PEREKR023(
               tt_     CHAR,   --��� ��������
               vob_    NUMBER, --��� ���������
               nd_     VARCHAR2, --ID ������ nd_
               pdat_   DATE DEFAULT SYSDATE, --pdat_=> SYSDATE
               vdat_   DATE DEFAULT SYSDATE, --vdat_=> gl.BDATE
               dk_     NUMBER, --dk ��������
               kv_     NUMBER,  ---KVA
               s_      NUMBER, --SUMA
               kv2_    NUMBER, ---KVB
               s2_     NUMBER, ---��������� SUMA, ������� ��� ������� ����, �������� ������ SUMA
               sk_     NUMBER, --����� ��� ����� NULL
               nam_a_  VARCHAR2, --����� ������� NMS
               nlsa_   VARCHAR2, --NLSA
               nam_b_  VARCHAR2, --NMKB
               nlsb_   VARCHAR2, --NLSB
               mfob_   VARCHAR2, --MFOB
               nazn_   VARCHAR2, --NAZN
               id_a_   VARCHAR2, --OKPOA
               id_b_   VARCHAR2, --OKPOB
               id_o_   VARCHAR2, --id_o_ => null
               sign_   RAW,      --sign_=> null
               sos_    NUMBER,     -- Doc status sos_=> 1
               prty_   NUMBER,     -- Doc priority prty_=> null
               uid_    NUMBER DEFAULT NULL,
               d_rec_  VARCHAR2,
               id_     NUMBER,
               Tabn_   VARCHAR2
               )

IS
/*****************
--01.03.2017 ������ ��������� ������ � ������� TSEL023, �� ���� �������.
*********************/
REF_    number ; --��������
data_   DATE ; --data_=> gl.BDATE,
datp_   DATE ; --datp_=> gl.bdate,
mfoa    number;
l_tabn  varchar2(10);

BEGIN
data_:=gl.BDATE;
datp_:=gl.bdate;
mfoa:=gl.amfo;

            IF S_> 0 THEN
                     gl.REF(REF_);
                     gl.in_doc3
                      (ref_  => REF_,   tt_   => tt_  , vob_ => vob_  , nd_  => TO_CHAR (REF_),  pdat_=> pdat_ , vdat_=> gl.BDATE,  dk_=> dk_,
                       kv_   => kv_,   s_    => S_*100   , kv2_ => kv2_, s2_  => S_*100,   sk_ => sk_, data_=> data_ , datp_=> datp_ ,
                       nam_a_=> nam_a_,  nlsa_ => nlsa_ , mfoa_=> mfoa,
                       nam_b_=> nam_b_, nlsb_ => nlsb_, mfob_=> mfob_ , nazn_ => nazn_,
                       d_rec_=> d_rec_  , id_a_ => id_a_, id_b_=> id_b_ , id_o_ => id_o_, sign_=> sign_, sos_=> sos_, prty_=> prty_, uid_=> uid_);

                     paytt (0, REF_,  gl.bDATE, TT_, DK_, kv_, nlsa_, S_*100, kv2_, nlsb_, S_*100  );
            end if;

            execute immediate '
            UPDATE '||tabn_||'
             SET (ref,sos)=(SELECT ref,(CASE
                                            WHEN dk IN (0,1) THEN sos
                                            ELSE 1
                                            END) FROM oper
                            WHERE ref='||ref_||') WHERE id= '||id_;

          -- ��������� ������ �� �������
          if ref_ is not null then
                           begin
                           logger.info ('SPS023: ' || ref_);

                           delete from TSEL023 t
                           where  T.NLSA=nlsa_
                              and T.OKPOA = id_a_
                              and T.KVA= kv_

                              and T.NLSB=nlsb_
                              and T.MFOB=mfob_
                              and T.OKPOB=id_b_
                              and T.KVB=kv2_

                              and t.tt=tt_
                              and t.dk=dk_

                              and T.S=S_*100
                              and t.nazn like nazn_

                              and t.us_id=sys_context('bars_global','user_id');
                              -----------------------
                              if sql%rowcount=0 then  begin
                                                          logger.info ('SPS023 ������ �� ��������, ���: '||ref_);
                                                          logger.info ('SPS023: NLSA:  ' ||nlsa_||' NLSB: '||nlsb_||' ���� �: '||id_a_||' ID �����������: '||sys_context('bars_global','user_id')||'����:  '||S_||'��������: '||tt_||'NAZN: '||nazn_);
                                                      end;
                              end if;
                           commit;
                           end;

    end if;

END;

--��������� ������ ���� ������� (��� ���������)
procedure pay_some_perekr (p_union_id number)
is
/*
02.04.2018 - ��� ������� SPS_GROUP_RU ������ ������� ID
��� ��������� ��������� ���������� ���������� �� ������
(�-�: ����� ��� �������� ���������� ���������� �� 104 ����, 
� ���� �� 105 ���� � ����� ������ ���. � ������� ��������� ��������:
1/104/322669/1
2/105/322669/1)
21.02.2018:
� ������� SPS_GROUP_RU ������� ���������
���� UNION_ID (����� ��'������� ����) ��� ���������
���� �� ������ ��'������� ���� ���������� ��������
�� ������. ����� ������ ��������������� ��� ��������
��'������� ���� 1 � 2, ��� ��������� ���������
��������� �� ����� ������� 1 ���� ������������ �����
�������� ��� ���� �����. (������� �������: sps.pay_some_perekr(1),
sps.pay_some_perekr(2))
20.02.2018:
http://jira.unity-bars.com:11000/browse/COBUMMFO-5368
��������� ���������� ����������� � ���� �������� ���
��� ����� ���������� ���� ������� �� �� (SPS_GROUP_RU)
��������������� ������ �� � �������� - ��������� ����������
��� ��� ��������� ���� - ������ ���������.
� ������ ��������� ��������� �������� ��� ������, ����������
� SPS_GR_PROTOCOL, ��� ����������� ����� 7 ���
----exec bars_login.login_user('******',1,'','');
*/
l_branch    varchar2(8);
l           number;
l_date      date;
l_err       varchar2(4000);
l_union_id  number;

begin
 --bc.home; --�������� ��� �������� � ����
 l_branch:= sys_context('bars_context', 'user_branch');
 -- �������� �� ������� ����������� � ���� /
  if l_branch <> '/' then  RAISE_APPLICATION_ERROR (-20000,' �������� �� ����� /  '); end if ;
 l_union_id:=p_union_id;
 for c in (select distinct ru from SPS_GROUP_RU) --���� �� ��, �� �������� � ��������
  loop
    bc.go( c.ru ); --������������� ���������
     --������ �� ��� ������ �������� �� ��� ��
     for k in (select group_sps from SPS_GROUP_RU where ru = c.ru and union_id = l_union_id order by id )
       loop
        insert into SPS_GR_PROTOCOL (RU, GROUP_SPS, MESSAGE) values (c.ru, k.group_sps, 'SPS: ���������� ��� RU: ' ||c.ru||' �� GROUP_RU: '|| k.group_sps); --log
        --DBMS_OUTPUT.PUT_LINE('SPS: ���������� ��� RU: ' ||c.ru||' �� GROUP_RU: '|| k.group_sps);
        logger.info('SPS: ���������� ��� RU: ' ||c.ru||' �� GROUP_RU: '|| k.group_sps);
        --�������� �� ���� ����� �� ��� ��, ��� ��������� � ��������
        begin
        select 1 into l from PEREKR_G where idg = k.group_sps;
         exception when no_data_found then begin
                                            logger.info ('SPS: ������ �����: '||k.group_sps||' �� ���� �� ��� ���: '||c.ru);
                                            insert into SPS_GR_PROTOCOL (RU, GROUP_SPS, MESSAGE) values (c.ru, k.group_sps, 'SPS: ������ �����: '||k.group_sps||' �� ���� �� ��� ���: '||c.ru); --log
                                            end;
          continue; --���� ����� �� ��, ������ ����� � sec_audit � ���������� ��������
        end;
        --���������� ����������
        SPS.SEL015(11,k.group_sps,01,'A');
        --������ ����� ������ ����������
        for p in (select * from TSEL015 where us_id = sys_context('bars_global','user_id') )
          loop

              p.TT:= case when p.MFOA=p.MFOB  then 'PSG'
                          when p.MFOA<>p.MFOB then 'PS5'
                          else p.TT
                     end;
              --������
              begin
               SPS.PAY_PEREKR (p.TT,p.VOB,p.ID,SYSDATE,SYSDATE,p.DK,p.KVA,p.SUMA,p.KVB,p.SUMA,NULL,p.MFOA,p.NMS,p.NLSA,p.NMKB,p.NLSB,p.MFOB,p.NAZN,p.OKPOA,p.OKPOB,NULL,NULL,1,NULL,NULL,p.KOEF);
                if sqlcode = 0 then
                         insert into SPS_GR_PROTOCOL (RU, GROUP_SPS, MESSAGE) values (c.ru, k.group_sps, 'SPS: ���������� ��� RU: ' ||c.ru||' �� GROUP_RU: '|| k.group_sps||' - OK!');
                end if;
               exception when others then
                l_err:=sqlerrm;
                insert into SPS_GR_PROTOCOL (RU, GROUP_SPS, MESSAGE) values (c.ru, k.group_sps, 'SPS: '||l_err); --log
                l_err:='SPS: NLSA: '||p.NLSA||' MFOA: '||p.MFOA||' KVA: '||p.KVA||' SUMA: '||p.SUMA/100||' NLSB: '||p.NLSB||' MFOB: '||p.MFOB||' KVB: '||p.KVB;
                insert into SPS_GR_PROTOCOL (RU, GROUP_SPS, MESSAGE) values (c.ru, k.group_sps,l_err ); --log
              end;
          end loop; --���� �� ��������
       end loop; --���� �� ������ �������
  end loop; --���� �� ���
  bc.home; --�������� �� "/"
  --��������� ��������� ������ ������� ������� 7 ���
  select max(trunc(time_sps)) into l_date from SPS_GR_PROTOCOL;
  delete SPS_GR_PROTOCOL where trunc(time_sps) < l_date -7;
  commit;
  -----
end;

end sps;
/

show err;
 
PROMPT *** Create  grants  SPS ***

grant EXECUTE                                                                on SPS             to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on SPS             to START1;

 
 
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/package/sps.sql =========*** End *** =======
PROMPT ===================================================================================== 
 