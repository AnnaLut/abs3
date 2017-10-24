

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/START_IRR1.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure START_IRR1 ***

  CREATE OR REPLACE PROCEDURE BARS.START_IRR1 (p_mode int ) is

 irr_  number;
 acc8_ number; ir_ number;
 serr_ varchar2( 250);
 dat_  date;
 begin
 tuda;
  -- ������ ��
 for d in (select * from cc_deal d where d.vidd in (11) and d.sos>=10 and d.sos<15  and d.wdate>gl.bd
 and not exists(select 1 from nd_acc n, accounts a where n.acc=a.acc and n.nd=d.nd and a.tip='SDI' and a.ostc<>0))
 loop

    begin
      -- �������, ��� ���, ���8
      select  a.acc into acc8_  from nd_acc n, accounts a
      where n.nd = d.nd  and n.acc = a.acc and a.tip='LIM'  and dazs is null;
    EXCEPTION WHEN NO_DATA_FOUND THEN
      logger.info  ('START_IRR_NO ���='|| d.nd || ' �� ������ 8999');
      goto RecNext;
    end ;
    ----------------------------

    -- ��� � ���. ������
    ir_  :=  acrn.fprocn(acc8_, 0,gl.bd);
    irr_ :=  acrn.fprocn(acc8_,-2,gl.bd);

    -- ���� ����� ��� ��.������- ������ ����� ����� ������� XIRR
    If not ( nvl(irr_,0) <=0 or irr_ < ir_   or abs(irr_-ir_)>5 ) then
       goto RecNext;
    end if;

        /*
   12/09/2012 ������� + ������

   4. ���� ������������ ������������� �������� ������� ������� ������ ��������� ��. ������ �� ������������ ��������� � ���� ��������� ����������� ��� � �������:
   - ��. ������ �� ����������,
   - ������ �����������
   - ��. ������ ����� 50%.
   ����� ������� �� ��� �� ����
       */

      serr_:= null;

      select max(fdat) into dat_ from cc_lim
      where nd = d.nd and fdat <= gl.bd  and sumo = 0    and lim2 > 0 ;

      If dat_ is null then serr_ := '�� ���� ���������� ���� ������ �� ���';
      else
         start_irr0 (p_nd =>d.nd,  p_dat =>dat_,  p_ir=>ir_,  s_err=> serr_);
      end if;

      if serr_ is not null then
         logger.info
           ('START_IRR_NO ���='|| d.nd || ' '|| to_char(dat_,'dd.mm.yyyy') ||' '|| serr_);
      end if;

    <<RecNext>> null;

  end loop;

end start_irr1 ;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/START_IRR1.sql =========*** End **
PROMPT ===================================================================================== 
