
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_rez_s031.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_REZ_S031 (dat_ in date,
                                           id_  in number,
                                           acc_ in number) return number
IS
-------------------------------------------------------------------------------
-- version 22/02/2012 (--)
-------------------------------------------------------------------------------
    s_v        number;
    s_25       number;
    s_26       number;
    s_29       number;
    s_31       number;
    pawn_      number;
    curacc_    number;
    rownumber_ number;

begin
   curacc_:=acc_;
   begin
      select nvl(sum (Sall),0) into s_V
      from tmp_rez_risk2
      where accs=acc_ and dat=dat_ and userid=id_;
      EXCEPTION WHEN NO_DATA_FOUND THEN
        s_v:=0;
   end;

   begin
      select nvl(sum (Sall),0) into s_25
      from tmp_rez_risk2
      where accs=acc_ and dat=dat_ and userid=id_ and
            pawn in (select pawn from cc_pawn where s031='25');
      EXCEPTION WHEN NO_DATA_FOUND THEN
        s_25:=0;
   end;

   begin
      select nvl(sum (Sall),0) into s_26
      from tmp_rez_risk2
      where accs=acc_ and dat= dat_ and userid=id_ and
            pawn in (select pawn from cc_pawn where s031='26');
      EXCEPTION WHEN NO_DATA_FOUND THEN
        s_26:=0;
   end;

   begin
      select nvl(sum (Sall),0) into s_29
      from tmp_rez_risk2
      where accs=acc_ and dat= dat_ and userid=id_ and
            pawn in (select pawn from cc_pawn where s031='29');
      EXCEPTION WHEN NO_DATA_FOUND THEN
        s_29:=0;
   end;

   begin
      select nvl(sum (Sall),0) into s_31
      from tmp_rez_risk2
      where accs=acc_ and dat= dat_ and userid=id_ and
            pawn in (select pawn from cc_pawn where s031='31');
      EXCEPTION WHEN NO_DATA_FOUND THEN
        s_31:=0;
   end;

   IF s_v<>0 THEN
      IF s_25+s_26+s_29+s_31=0 THEN
         pawn_:=40;
      ELSIF s_25>s_v-s_25 THEN
         pawn_:=41;
      ELSIF s_26>s_v-s_26 THEN
         pawn_:=42;
      ELSIF s_31>s_v-s_31 THEN
         pawn_:=43;
      ELSIF s_29>s_v-s_29 THEN
         pawn_:=44;
      ELSIF s_25+s_26+s_29+s_31< s_v-(s_25+s_26+s_29+s_31) THEN
         pawn_:=45;
      ELSE
         pawn_:=33;
      END IF;
   ELSE
      pawn_:=90;
   END IF;

   RETURN NVL(pawn_,0);
END;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_rez_s031.sql =========*** End ***
 PROMPT ===================================================================================== 
 