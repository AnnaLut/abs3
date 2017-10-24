

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_REV_OB.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_REV_OB ***

  CREATE OR REPLACE PROCEDURE BARS.P_REV_OB (p_dat DATE DEFAULT null) IS

/*

28.01.2014 Sta ��������� ��������� 6204.10

15-06-2012 -- ���� ���������� dbms_stats.gather_table_stats('bars', '...');
25-11-2011 SERG ������ ��������� ������� SALDOB, �.�. ��� ����� �������� �� saldob
                ��������� ������������ accounts.*q �����.

10-11-2011 Sta  ���-���� �������� �� SALDOB "������" � - �� �����

28-03-2011 SERG.   ������ ������ � SALDOB �������� �� ������ �������� �� GL.
                   ������� ��� ����������� ��������� ����� dappq, ostq, dosq, kosq � ACCOUNTS
                   ����� �� ����������� � SALDOB.
                   ���������: patchy46.sql
                              gl_head.sql   version 6.00  28/03/2011
                              gl_pack.sql   version 6.07  28/03/2011
01-02-2011 ������. ����-���� ��� ���������� ����� �� FDAT,
                   ����� ����� �� SALDOA.
                   �� ������ ��� ���� ���-�������� ����
                   �� ������.������ ���� 0000_* - �� ����� ��������.
                   ��������� � �����

21-01-2011 ������. ���� ���� ������� �� ����.��������.
31-12-2010 ������. ����� ����.���������� !

  1) �������� ������� �������  - ������� ����������� �� ��
  2) ������������� ��� �������� �� �� ����� ���.���� (01-01-2011), �.�. ��� ����
     �������� ������������������ ��.��� ������� � ����� ������� ����
                               - ������� ����.
  3) �������� 9 �� �� 2 ������ - ������� ��������

  ���������� 2 ����� ����.
GLOBAL TEMPORARY TABLE TMP_rev1 (NBS CHAR(4),KV INT,ACC INT) ON COMMIT PRESERVE ROWS;
GLOBAL TEMPORARY TABLE TMP_rev2 (ACC INT, KV INT, VXQ NUMBER,
                            KOS NUMBER, DOS NUMBER, tv INT ) ON COMMIT PRESERVE ROWS;
  ���������� �� ����������� p_rev.prc
*/

  DAT_  date ;
  DATV_ date ; -- ��� ��������� ������������� ���������� ����
               -- ��� ������. � ����=DATV_ �� ������� �� ��� ���
  dat1_ DATE ; -- ���������� �� ���������������� ����
  ------------------------------
  NLS_9900  accounts.NLS%type  ; --\  �������   ��� 9000-9599
  NLS_9910  accounts.NLS%type  ; --/  �������   ��� 9600-9999
  NLS_3800  accounts.NLS%type  ; --   �������   ��� 1001-7999
  NLS_3801  accounts.NLS%type  ; --   �����.���.��� 1001-7999
  n980      accounts.KV%type   ;
  ACC_      accounts.ACC%type  ;
  nbs_      accounts.NBS%type  ;
  dazs_     accounts.dazs%type ;
  daos_     accounts.daos%type ;
  ------------------------------
  -- �� ������  �����
  ostf_ NUMBER; -- ����.����� � ��������
  dos_  NUMBER; -- ��� ������ � ��������
  kos_  NUMBER; -- ��� ������ � ��������
  VXQ_  NUMBER; -- ����.����� � ��������
  IXQ_  NUMBER; -- ���. ����� � ��������
  dosq_ NUMBER; -- ���.������ � ��������
  kosq_ NUMBER; -- ���.������ � ��������
  dlta_ NUMBER; -- ������ ��� ������ ��.
  TV_   int   ; -- � ���: 1-��� 1000-7999, 2-��� 9000-9599, 3-��� 9600-9999
  ----------------------------------
  tt_      oper.tt%type    := 'REV';
  nms_6204 oper.NAM_A%type ;
  NLS_6204 oper.nlsA%type  ;
  nms_3801 oper.NAM_B%type ;
  REF_     oper.REF%type   ;
  P4_      int             ;
  S_       oper.S%type     ;
  DK_      oper.DK%type    ;
  --------------------------
  l_qv     saldob%rowtype;
BEGIN

--������������� ����������� ��� ���������
--  gl.paysos0_full;
-- tuda;
  DATV_ := gl.BDATE;
  DAT_  := nvl( p_DAT, gl.BDATe);
  n980  := gl.baseval;

  NLS_9900  := vkrzn(substr(gl.AMFO,1,5),'99000999999999'); --- ���. 9000-9599
  NLS_9910  := vkrzn(substr(gl.AMFO,1,5),'99100999999999'); --- ���. 9600-9999
  NLS_3800  := vkrzn(substr(gl.AMFO,1,5),'38000000000000'); --- ���. 1000-7999
  NLS_3801  := vkrzn(substr(gl.AMFO,1,5),'38010000000000'); --|
  -------------------------------

  --(��)�������� ������ �������
  for k in (select * from tabval where d_close is null and kv<> gl.baseval)
  loop

    If nvl(k.s0009,'9') not like NLS_9900 then
       op_reg(99,0,0,310, P4_, gl.Arnk, NLS_9900, k.kv,
              substr('000'|| k.kv,-3)||'/ ����.������.��� 9000-9599','ODB', 20094, acc_);
       op_reg(99,0,0,310, P4_, gl.aRnk, NLS_9910, k.kv,
              substr('000'|| k.kv,-3)||'/ ����.������.��� 9600-9999','ODB', 20094, acc_);
       update tabval set s0009 = NLS_9900 where kv = k.kv;
    end if;

    begin

       -- ������� �� ����� ������� 3800 ?
       select nbs ,acc ,dazs ,daos
       into   nbs_,acc_,dazs_,daos_
       from accounts
       where nls=NLS_3800 and kv=k.KV ;

       if dazs_ is not null then
          -- ������� �������������, ���� ����, �� �������
          update accounts set dazs = null where acc=acc_ ;
       end if;

       if nbs_ is not null  OR  to_char(daos_,'MMDD')<>'0101'  then
          update accounts set nbs = null, daos=trunc(daos,'Y') where acc=acc_ ;
       end if;

    EXCEPTION WHEN NO_DATA_FOUND THEN
       -- ���, ��������� ����� ������� 3800
       op_reg(99,0,0,310, P4_, gl.aRnk, NLS_3800, k.kv,
              substr('000'|| k.kv,-3)||'/ ����.������.��� 1000-5999','ODB', 20094, acc_);
       update accounts set nbs=null where acc=ACC_ ;
    end;

  end loop;

  -- ��������� �� ���� ���� 1(TMP_REV1) ��� �����, ��� ����� �������������
  EXECUTE IMMEDIATE 'TRUNCATE TABLE TMP_REV1 ';
     insert into TMP_REV1 ( NBS,KV,ACC)
     select nbs,kv,acc from accounts
     where nbs is  not  null  and nbs  NOT like '8%'
        and kv<>n980          and nls  not in ( NLS_3800,NLS_9900,NLS_9910)
        AND pos = 1           and (dazs is null or dazs > DAT_ -20 );

  -- ��������� �� ���� ���� 2(TMP_rev2) ��� �����, �� ��� ����� �������������
  EXECUTE IMMEDIATE 'TRUNCATE TABLE TMP_rev2 ';
     insert into TMP_rev2(ACC,KV,VXQ,DOS,KOS, tv)
     select acc, kv, 0,0,0, decode (nls, nls_3800,1, nls_9900,2, 3)
     from accounts where kv<> n980 and nls in ( NLS_3800,NLS_9900,NLS_9910);

  -- �������� �� saldob ��� ���� ��������� ����������
  -- � ����� ������������ ����� ostq, dosq, kosq, dappq � accounts �� ������� saldob
--gl.clear_equivalents(DAT_);

  --����-1 d �� �����
  FOR d IN (SELECT fdat FROM fdat  WHERE fdat>=DAT_  ORDER BY fdat )
  LOOP
     -- ���������� ����
     SELECT nvl( MAX(fdat), d.fdat) INTO dat1_ FROM fdat WHERE fdat<d.fdat;

     logger.info('P_REV_OB: ����=' || d.fdat||', ����.����='|| dat1_ );

     -- ��������� ���������� ��� ������ (������� ���� �����)
     update TMP_rev2 set VXQ=0, DOS=0, KOS=0;

     FOR c IN (SELECT 1 PR, s.acc, s.fdat, s.ostf, s.dos, s.kos, a.NBS, a.KV
                 FROM TMP_REV1 a, saldoa s
                WHERE a.acc= s.acc
                  AND s.fdat = (SELECT MAX(fdat)
                                  FROM saldoa
                                 WHERE acc=A.acc
                                   AND fdat<=d.fdat
                               )
                union all
               SELECT 9, a.acc, d.fdat, 0, 0, 0, a.NBS, a.KV
                 FROM TMP_REV1 a
                WHERE a.nbs in   ('9910','9900')
                  and FOST  (acc, dat1_ ) =  0
                  and FOSTQ (acc, dat1_ ) <> 0
--���� ���� ������� �� ����.��������.
---------------- and not exists (select 1 from saldoa where acc=a.ACC)
               )
     LOOP
        -- ��������� 1-�� �����
        If c.PR = 9 then
           -- ��������� � �������� ������ ������� �� 9 ��
           VXQ_  := fostq (c.acc, dat1_ );
           dosq_ := 0 ;
           kosq_ := 0 ;
           IXQ_  := 0 ;
           update accounts set dazs = d.fdat where acc= c.acc and dazs is null;
        else
           -------  ��� ��� � ������� � ��������
           IF c.fdat=d.fdat THEN OSTF_:= c.ostf;           dos_:=c.dos;kos_:=c.kos;
           ELSE                  OSTF_:=c.ostf-c.dos+c.kos;dos_:=0;    kos_:=0;
           END IF;
           -------  ��� ��� � ���
           VXQ_  := gl.p_icurval(c.kv, ostf_, dat1_  );
           -------  �������� �� � ���
           dosq_ := gl.p_icurval(c.kv, dos_ , d.fdat );
           kosq_ := gl.p_icurval(c.kv, kos_ , d.fdat );
           -------  ��� ��� � ���
           IXQ_  := gl.p_icurval(c.kv, ostf_-dos_+kos_,d.fdat  );
        end if;

        -------  ������ ��� ������ ��
        dlta_ := IXQ_ - (VXQ_ - dosq_ + kosq_);
        -----    �������  ������ ������ � ������
        IF       dlta_< 0 THEN dosq_:=dosq_-dlta_;
        ELSIf    dlta_> 0 THEN kosq_:=kosq_+dlta_;
        END IF;

        -- �.�.�� ������ ����
        --
        -- ��������� ��������� ������ saldob
        l_qv.acc  := c.acc;
        l_qv.fdat := d.fdat;
        l_qv.ostf := VXQ_;
        l_qv.dos  := dosq_;
        l_qv.kos  := kosq_;
        select max(fdat)
          into l_qv.pdat
          from saldob
         where acc = c.acc
           and fdat < d.fdat;
        -- ������������� ����������
--        gl.set_equivalent(l_qv);

        -- ����������� ���� �������
        IF    c.nbs  >='1000' and c.nbs <='7999'                  then TV_:= 1;
        elsIf c.nbs  >='9000' and c.nbs <='9599' or c.nbs ='9900' then TV_:= 2;
        elsIf c.nbs  >='9600' and c.nbs <='9999'                  then TV_:= 3;
        else                                                           TV_:= 0;
        end if;

        -- ���� �������� � ����.�������� (��� �������� ����������� �� �������)
        -- VXQ = ����� ���.���, \
        -- DOS = ����� ���.��,  | ���, �����������, � ����������� !
        -- KOS = ����� ���.��   /
        -- �������� ! � ������� ��� �������� :  ���� �������,  dos <-> kos

        update TMP_rev2 set  VXQ = VXQ - VXQ_ ,
                             DOS = DOS + kosq_,
                             KOS = KOS + dosq_
               where kv=c.KV and TV = TV_;

     END LOOP; -- ����� ���� 2 c �� ������

     ---========= ��������� ������� =========-----

     ------ 1) �������� (������� ��������) ������� �� ��������
     update TMP_rev2 set DOS = greatest(DOS-KOS,0), KOS = greatest(KOS-DOS,0) ;

     ------ 2) ������������ saldob �� ��������
     -- �������� !!
     for c in (select *
                 from tmp_rev2
              )
     loop
        l_qv.acc  := c.acc;
        l_qv.fdat := d.fdat;
        l_qv.ostf := c.vxq;
        l_qv.dos  := c.dos;
        l_qv.kos  := c.kos;
        select max(fdat)
          into l_qv.pdat
          from saldob
         where acc = c.acc
           and fdat < d.fdat;
        -- ������������� ����������
    --    gl.set_equivalent(l_qv);
        --
     end loop;

     ----- 3) ����� ������ ������� � 1 �� ������ 6204/���
     gl.BDATE := d.FDAT;

     -- 3-1) ��� ����.������ ������.
     FOR x IN (SELECT ref FROM oper WHERE tt=tt_ AND nd like tt_||'%' AND vdat=d.fdat AND sos>0)
     LOOP
        gl.bck( x.ref, 9);
     END LOOP;

     -- 3-2) �����/������� ������������ NLS_3801
     begin
        select substr(nms,1,38), nbs , acc , dazs , daos
        into   nms_3801        , nbs_, acc_, dazs_, daos_
        from accounts where kv=n980 and nls = NLS_3801;

        if dazs_ is not null then
           -- ������� �������������, ���� ����, �� �������
           update accounts set dazs = null where acc=acc_ ;
        end if;

        if nbs_ is not null  OR  to_char(daos_,'MMDD')<>'0101'  then
           update accounts set nbs = null, daos=trunc(daos,'Y') where acc=acc_;
        end if;

     EXCEPTION WHEN NO_DATA_FOUND THEN
        op_reg(99,0,0,310, P4_, gl.aRnk, NLS_3801, n980,
              '�����.����.������.��� 1000-5999','ODB', 20094, acc_);
        update accounts set nbs=null where acc=ACC_ ;
     end;

     -- 3-3) ��������� ����� ���������� ������� NLS_3800
     select Nvl(sum(KOS-DOS),0) into s_ from TMP_rev2 where TV = 1;

     If S_ <> 0 then

        -- 3-4) ����� ����� ���� 6204
        SELECT nls, substr(nms,1,38) INTO NLS_6204, nms_6204  FROM accounts
        WHERE nbs='6204' and kv= n980 and dazs is null  and acc in (select acc6204 from vp_list) and rownum = 1;

        If   S_< 0 then DK_:=0; S_:=-S_;
        else            DK_:=1;
        end if;

        -- 3-5) ������� ��������
        GL.ref (ref_);
        INSERT INTO oper (ref,tt,vob,nd,dk,pdat,vdat,datd,
                          userid,nam_a,nlsa,mfoa,nam_b,nlsb,mfob,kv,s,nazn)
        VALUES (ref_,tt_,6,tt_,DK_,SYSDATE,gl.bDATE,gl.bDATE,
                gl.aUID, nms_3801 ,NLS_3801,gl.aMFO, NMS_6204, nls_6204,
                gl.aMFO, n980,S_,  nms_3801 );
        GL.payv(1,ref_,gl.BDATE,tt_,DK_,n980,NLS_3801,S_,n980,nls_6204,S_);

        -- 3-6) �����, �������� �������� ������ �����.��� 38010000000001,
        -- ������� ��� � ���������� ��� �� ����� ����� , ��
        -- ��� ���� �����, ����� ��� ������� ���� ����������� 3800/3801(�+�)
        begin

          NLS_6204 := vkrzn( substr(gl.AMFO,1,5), '38010000000001' );

          select FOST (acc,gl.BDATE), nbs,acc
          into S_, nbs_, acc_
          from accounts
          where nls = NLS_6204 and kv = n980 and fost(acc,gl.BDATE)<>0;

          if nbs_ is not null  then
             update accounts set nbs = null  where acc=acc_ and dazs is null;
          end if;

          If S_< 0 then DK_:=0;  S_:=-S_;  else DK_:=1 ;  end if;
          GL.payv (1,ref_,gl.BDATE,tt_,DK_,n980,nls_6204,S_,n980,NLS_3801,S_);
        EXCEPTION WHEN NO_DATA_FOUND THEN  null;
        end;

     end if;

     commit;

     logger.info('P_REV_OB: ����=' || d.fdat||' ��������' );
     dbms_application_info.set_client_info('���� '||to_char(d.fdat,'DD/MM/YYYY')||' ��������');

  END LOOP; --����� �����-1 d �� �����

  dbms_application_info.set_client_info(' ');

  gl.bdate:=DATV_;

 -- ���� ����������
-- dbms_stats.gather_table_stats('bars', 'TMP_REV1');
-- dbms_stats.gather_table_stats('bars', 'TMP_rev2');
-- dbms_stats.gather_table_stats('bars', 'saldob');

-----------------
EXCEPTION
    WHEN OTHERS THEN
        -- ���������� ���������� ���� �����
        gl.bdate:=DATV_;
        -- ����������� ������ � ������ ������
        raise_application_error(-20212, dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace());
        --
END p_rev_OB;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_REV_OB.sql =========*** End *** 
PROMPT ===================================================================================== 
