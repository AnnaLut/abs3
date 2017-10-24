

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/PAY_HPX.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure PAY_HPX ***

  CREATE OR REPLACE PROCEDURE BARS.PAY_HPX 
               (flg_ SMALLINT,  -- ���� ������
                ref_ INTEGER,   -- ����������
               VDAT_ DATE,      -- ���� ������������
                 tt_ CHAR,      -- ��� ����������
                dk_ NUMBER,    -- ������� �����-������
                kv_ SMALLINT,  -- ��� ������ �
               nlsm_ VARCHAR2,  -- ����� ����� �
                 sa_ DECIMAL,   -- ����� � ������ �
                kvk_ SMALLINT,  -- ��� ������ �
               nlsk_ VARCHAR2,  -- ����� ����� �
                 ss_ DECIMAL    -- ����� � ������ �
) IS
  l_NLS  accounts.NLS%type;
  l_NBS  accounts.NBS%type;
  l_NBSD accounts.NBS%type;
  l_NBSK accounts.NBS%type;
  l_OB22 specparam_int.OB22%type;
  l_TAR  tarif.kod%type;
  l_S  number;  l_S1 number; l_K number; l_K1 number;
begin
  l_NBSD  := substr(nlsm_,1,4);
  l_NBSK  := substr(nlsk_,1,4);

  -- 1) ���������� �� ����������� �i������
  IF    l_NBSD='2628' and l_NBSK='2620' OR
        l_NBSD='2638' and l_NBSK='2630' OR
        l_NBSD='2638' and l_NBSK='2635' then
        If    l_NBSK='2620' then l_NBS := '7040'; l_OB22:= '08';
           --��� 2620
           --����������� %% �� ������   7040 08   2628 05
           --������������ %% �� ������  2628 05   2620 08;09;11;12
        elsIf l_NBSK='2630' then l_NBS := '7041'; l_OB22:= '13';
           --���  2630
           --����������� %% �� ������   7041 13 2638 17
           --������������ %% �� ������  2638 17 2630 11;12;13;14
        else                     l_NBS := '7041'; l_OB22:= '03';
           --If l_NBSK='2635' then l_NBS := '7041'; l_OB22:= '03';
           --��� 2635
           --����������� %% �� ������   7041 03 2638 16
           --������������  %% �� ������ 2638 16 2635 13; 14
        end if;
        l_NLS := nbs_ob22( l_NBS, l_OB22);
        gl.payv(flg_,ref_, VDAT_, tt_,dk_,kv_,l_NLS,sa_,kvk_,nlsm_,ss_);
        update opldok set txt='����������� %% �� ������' where ref=REF_ and stmt=gl.aSTMT;

        gl.payv(flg_,ref_, VDAT_, tt_,dk_,kv_,nlsm_,sa_,kvk_,nlsk_,ss_);
        update opldok set txt='������������ %% �� ������' where ref=REF_ and stmt=gl.aSTMT;

  elsIf l_NBSD='2620' and l_NBSK='2620' OR
        l_NBSD='2630' and l_NBSK='2630' OR
        l_NBSD='2635' and l_NBSK='2635' then
        -- ���������� � �i��i
        gl.payv(flg_,ref_, VDAT_, tt_,dk_,kv_,nlsm_,sa_,kvk_,nlsk_,ss_);

  elsIf l_NBSD='2620' and l_NBSK='2909' OR
        l_NBSD='2630' and l_NBSK='2909' OR
        l_NBSD='2635' and l_NBSK='2909' then
        begin
           select to_number(value) into l_TAR  from operw
           where ref=REF_ and tag='TAROB' and value is not null;
           --�� (2620,2630,2635) - 6110/09 - ������� ���_�_���� ���_� �� ������� ������
           l_K1 :=-1; l_K:= -10000; l_S := sa_;

          WHILE abs(l_K1-l_K ) >1
          LOOP
             l_K1  := l_K;
             l_K   := f_tarif(l_TAR, kv_, nlsm_,l_S);
             l_S   := sa_ - l_K;
          end loop;

           l_K := greatest ( 0,round(l_K,0));
           If l_K >0 then
              l_NLS := nbs_ob22( '6110', '09');
              gl.payv(flg_,ref_, VDAT_, tt_,dk_,kv_,nlsm_,l_K, kvk_,l_NLS,l_K );
           end if;
           l_S := sa_ - l_K;
        EXCEPTION  WHEN no_data_found THEN l_S:= sa_;
        end;
        -- ������� ������� ������ (���ici� � �.�.)
        --�� ���������� (2620,2630,2635) - �� 2909/18 - ������� ������� ������

        --������� ���� ������ 500 ���, ��� ����� ���� 3%
        --���� �������� 500/1,03 = 485,44
        --���� ���_�_� 500 - 500/1,03= 14,56
        gl.payv(flg_,ref_, VDAT_, tt_,dk_,kv_,nlsm_,l_S,kvk_,nlsk_,l_S);
  end if;

  return;

END PAY_HPX;
/
show err;

PROMPT *** Create  grants  PAY_HPX ***
grant EXECUTE                                                                on PAY_HPX         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/PAY_HPX.sql =========*** End *** =
PROMPT ===================================================================================== 
