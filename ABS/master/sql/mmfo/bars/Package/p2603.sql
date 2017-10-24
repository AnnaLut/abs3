
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/p2603.sql =========*** Run *** =====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.P2603 IS
/*  04.02.2016 Sta COBUSUPABS-4180 ����.���������� ��� 2603
               18.12.2015�. �1086 ���� �������� ��� �� ��������� ���.̳�.���. �� 18 ������ 2014�. �217� (��� � ��������� �1086),
*/


 procedure UPD  (p_acc number, p_sa number) ;
 procedure PREV (p_IDG int) ;
end p2603;
/
CREATE OR REPLACE PACKAGE BODY BARS.P2603 IS
/*
   21-04-2016 ������ - ��������� ��������� �� ������� ����-����� ������� �������������, � ���
�    �������� ����� ������� ������������� ������� �� ������ �� ��.����������� (��� ���� ������),  �� � �� ���������� � 1 (��� ����)
�    ����������� ����� ������� ������������� ���� ������� �� ���������� � 1, �� ��� ����������� ����������� � �����)

   17.02.2016 ������ - ��� Sel023
   ------------------------------------------------------------------------------------------------------
   09.02.2016 Sta COBUSUPABS-4180 ����.���������� ��� 2603
   18.12.2015�. �1086 ���� �������� ��� �� ��������� ���.̳�.���. �� 18 ������ 2014�. �217� (��� � ��������� �1086),
*/

 -------------------------------------------
 procedure UPD (p_acc number, p_sa number)  is
 begin update T2603 set sr = nvl(sr, 0), sa = nvl(p_sa,0) *100 where acc = p_acc;
       if SQL%rowcount = 0 then insert into t2603 (acc, sr, sa) values ( p_acc, 0, p_sa *100 ) ;  end if;
 end ;
 -------------------------------------------
 procedure PREV (p_IDG int) is
    l_IDG int    ;
    S_    number ;
    Del_  number ;
    PLN_  number ;
    FKT_  number ;
    REF_  number ;
 begin
    logger.info ('P2603 IDG'||to_char(p_IDG));
    If p_idg is null then   l_IDG := to_number ( pul.Get_Mas_Ini_Val('IDG') );
    else                    l_IDG := p_IDG ;
    end if;

    EXECUTE IMMEDIATE ' truncate  table   KRYM_GAZT ';

    --- ������ �� ����� -� - ��������
    For A in ( select s.ACC, s.IDS, KAZ(s.sps,s.acc) OST, u.nls, u.kv, substr(u.nms,1,38) nms, c.okpo
               from specparam s, accounts u , customer c
               where c.rnk = u.rnk  and u.acc = s.acc and s.idg = l_IDG
                 and U.OSTB > 0     and KAZ(s.sps,s.acc) > 0
                 and u.OSTB >= KAZ(s.sps,s.acc)
              )

    loop

       --������ ����������
       select A.OST - sum ( round ( ( A.ost * nvl(koef,0) ) , 0) ) into Del_ from perekr_b where ids = A.ids ;

       FKT_ := 0 ;  -- ����������� ����� ���� ����
       PLN_ := 0 ;  -- �������� ����� ������� �������������
       --- ������ �� ����� -� - ����������
       For B in (select * from perekr_b where ids = A.ids  order by Nvl(ord,3), koef )
       loop
          S_ := round( nvl(B.koef,0) * A.OST ,0 ) ; ---- ����� � ������ ��� ������� �������������

          If    B.ORD  = 1 then                     ---- ���� � 1, �� ���� ����� ����� ������� �������������

                -- �������� ����� ������� �������������
                begin  select nvl(sa,0)*( 1-B.koef) + nvl(sr,0) into PLN_ from T2603 where acc = A.acc;
                exception when no_data_found then        PLN_ := 0 ;
                end ;

                FKT_  := least ( S_, PLN_ ) ;       ---- ����������-���������  ����� ���� ����
                S_    := S_ - FKT_ ;

          elsIf B.ORD  = 2 then                     ---- ���� � 2, �� ���� �������� ����� ������� �������������
                S_    := S_ + FKT_ ;
                update t2603 set sr = PLN_ - FKT_, sa = 0 where acc = A.acc ;  ---- ������� ����� ��a� � ���� ��������� "�� ������"
                FKT_  := 0;                         ---- � ���������� �������� ������ �� ���� ���������
          end if;
----------------------
          If S_ <> 0 and Del_ <> 0 then             ---- �������� ������ ���������� ������� ����������
             S_  := S_ + Del_;
             Del_:= 0 ;
          End if;
            
          If S_ > 0 then                            ---- �������� ��������
             gl.REF(REF_);
             gl.in_doc3
              (ref_  => REF_,   tt_   => B.tt  , vob_ => 6   , nd_  => substr(B.id,1,10), pdat_=> SYSDATE , vdat_=> gl.BDATE,  dk_=> 1,
               kv_   => a.KV,   s_    => S_    , kv2_ => a.KV, s2_  => s_,   sk_ => null, data_=> gl.BDATE, datp_=> gl.bdate,
               nam_a_=> a.nms,  nlsa_ => a.nls , mfoa_=> gl.aMfo,
               nam_b_=> B.polu, nlsb_ => B.nlsb, mfob_=> B.mfob , nazn_ => B.nazn,
               d_rec_=> null  , id_a_ => A.okpo, id_b_=> B.okpo , id_o_ => null, sign_=> null, sos_=> 1, prty_=> null, uid_=> null);
             paytt (0, REF_,  gl.bDATE, B.TT,  1, a.kv, a.nls, s_, a.kv, B.nlsb, s_  );
          end if;
          logger.info ('P2603 REF: '||to_char(REF_));  
       end loop; -- ������ B
    end loop; -- ������ A

end PREV;
------------------------------------

end p2603;
/
 show err;
 
PROMPT *** Create  grants  P2603 ***
grant EXECUTE                                                                on P2603           to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/p2603.sql =========*** End *** =====
 PROMPT ===================================================================================== 
 