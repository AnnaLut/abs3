

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/MAKE_CP_INT.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  procedure MAKE_CP_INT ***

CREATE OR REPLACE PROCEDURE BARS.make_cp_int (p_acc    IN accounts.acc%TYPE,
                                              p_tdat   IN DATE,
                                              p_tt     IN oper.tt%type,
                                              p_id_a   IN oper.id_a%TYPE,
                                              p_id_b   IN oper.id_b%TYPE,
                                              p_nlsa   IN oper.nlsa%TYPE,
                                              p_nlsb   IN oper.nlsb%TYPE,
                                              p_nmsa   IN oper.nam_a%TYPE,
                                              p_nmsb   IN oper.nam_b%TYPE,
                                              p_kva    IN oper.kv%TYPE,
                                              p_kvb    IN oper.kv2%TYPE,
                                              p_s      IN oper.s%TYPE,
                                              p_nazn   IN oper.nazn%TYPE)
is
  oo oper%rowtype;
begin
 bars_audit.info('make_cp_int starts');
      gl.ref (oo.REF);
      oo.nd    := trim (Substr( '          '||to_char(oo.ref) , -10));
      oo.s     := p_s*100;
      oo.s2    := gl.p_icurval(p_kva, p_s*100, gl.bd);
      oo.dk    := 1;
      oo.tt    := p_tt;
      oo.id_a  := p_id_a;
      oo.id_b  := p_id_b;
      oo.nlsa  := p_nlsa;
      oo.nlsb  := p_nlsb;
      oo.NAM_A := substr(p_nmsa,1,38);
      oo.NAM_B := substr(p_nmsb,1,38);
      oo.kv    := p_kva;
      oo.kv2   := p_kvb;
      oo.nazn  := substr(p_nazn,1,160);

      gl.in_doc3 (oo.REF, oo.tt, 6, oo.nd, SYSDATE, gl.bdate, oo.dk,  oo.kv, oo.S , oo.kv2 ,oo.S2, null, gl.BDATE, gl.bdate,
                  substr(oo.nam_a,1,38) , oo.nlsa,  gl.aMfo,
                  substr(oo.nam_b,1,38) , oo.nlsb,  gl.amfo,
                  oo.nazn ,null,oo.id_a, gl.Aokpo, null, null, 1, null, null);
      gl.payv(0, oo.ref, gl.bdate, oo.tt, oo.dk, oo.kv, oo.nlsa, oo.s, oo.kv2, oo.nlsb, oo.s2);
      update int_accn set acr_dat = p_tdat where acc = p_acc and id = 0;
      --------------------
      -- Вставка записи-истории о начислении процентов, если, в будущем будет необходимость СТОРНО или персчета процентов.
      ACRN.acr_dati ( p_ACC, 0, oo.REF, p_tdat, 0);  

end make_cp_int;
/
show err;

PROMPT *** Create  grants  MAKE_CP_INT ***
grant EXECUTE                                                                on MAKE_CP_INT     to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/MAKE_CP_INT.sql =========*** End *
PROMPT ===================================================================================== 
