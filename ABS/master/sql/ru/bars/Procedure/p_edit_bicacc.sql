CREATE OR REPLACE PROCEDURE BARS.p_edit_bicacc (p_par number,
                                           p_kv in number,
                                           p_nls in varchar,
                                           p_bic in bic_acc.bic%type,
                                           p_acc in bic_acc.acc%type,
                                           p_transit in bic_acc.transit%type,
                                           p_their_acc in bic_acc.their_acc%type)
                                           AS
 l_acc accounts.acc%type;

BEGIN
 IF p_par=0 THEN
       UPDATE  bic_acc SET
               transit = p_transit,
               their_acc= p_their_acc
       WHERE bic=p_bic and acc=p_acc;

 ELSIF p_par=1 THEN
       SELECT acc INTO l_acc
       FROM accounts WHERE nls=p_nls AND kv=p_kv;

       INSERT INTO bic_acc (bic, acc, transit, their_acc)
       VALUES (p_bic, l_acc, p_transit, p_their_acc);

 ELSIF p_par=2 THEN
       DELETE FROM bic_acc
       WHERE bic = p_bic AND acc = p_acc;
 END IF;
END;
/

grant execute on p_edit_bicacc to bars_access_defrole;