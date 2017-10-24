
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/doc_valid.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.DOC_VALID (REF_ NUMBER, COND_ VARCHAR2, OREC_ OPER%ROWTYPE DEFAULT NULL)
RETURN NUMBER
IS
    NRES    NUMBER;

    C       NUMBER;
    SQLSTMT VARCHAR2(4096);
    RET     NUMBER;
BEGIN

    NRES := 1;

    IF COND_ IS NOT NULL THEN

        C := DBMS_SQL.OPEN_CURSOR;

        IF REF_ IS NOT NULL THEN
            SQLSTMT := '
               SELECT COUNT(*)
                 FROM OPER O
                WHERE O.REF=:bind2 AND (' || COND_ || ')';
            DBMS_SQL.PARSE( C, SQLSTMT, 1 );
            DBMS_SQL.BIND_VARIABLE( C, ':bind2', REF_ );
            DBMS_SQL.DEFINE_COLUMN( C, 1, NRES );
            RET := DBMS_SQL.EXECUTE( C );
            IF DBMS_SQL.FETCH_ROWS( C ) > 0 THEN
                DBMS_SQL.COLUMN_VALUE( C, 1, NRES );
            ELSE
                NRES := 0;
            END IF;
        ELSE
            IF OREC_.REF IS NOT NULL THEN
                SQLSTMT := '
                    DECLARE
                        O OPER%ROWTYPE;
                        R NUMBER;
                    BEGIN
                        O.REF       := :bind1;
                        O.DEAL_TAG  := :bind2;
                        O.TT        := :bind3;
                        O.VOB       := :bind4;
                        O.ND        := :bind5;
                        O.DK        := :bind6;
                        O.S         := :bind7;
                        O.KV        := :bind8;
                        O.SQ        := :bind9;
                        O.SK        := :bind10;
                        O.S2        := :bind11;
                        O.KV2       := :bind12;
                        O.KVQ       := :bind13;
                        O.PDAT      := :bind15;
                        O.VDAT      := :bind16;
                        O.DATD      := :bind17;
                        O.DATP      := :bind18;
                        O.NAM_A     := :bind19;
                        O.NLSA      := :bind20;
                        O.MFOA      := :bind21;
                        O.NAM_B     := :bind22;
                        O.NLSB      := :bind23;
                        O.MFOB      := :bind24;
                        O.NAZN      := :bind25;
                        O.D_REC     := :bind26;
                        O.ID_A      := :bind27;
                        O.ID_B      := :bind28;
                        O.ID_O      := :bind29;
                        O.VP        := :bind30;
                        O.REFL      := :bind31;
                        O.PRTY      := :bind32;
                        O.REF_A     := :bind33;
                        O.USERID    := :bind34;
                        R:=1;
                        IF NOT (' || COND_ || ') THEN
                           R:=0;
                        END IF;
                        :retres := R;
                    END;';
                DBMS_SQL.PARSE( C, SQLSTMT, 1 );
                DBMS_SQL.BIND_VARIABLE( C, ':bind1',OREC_.REF );
                DBMS_SQL.BIND_VARIABLE( C, ':bind2',OREC_.DEAL_TAG );
                DBMS_SQL.BIND_VARIABLE( C, ':bind3',OREC_.TT );
                DBMS_SQL.BIND_VARIABLE( C, ':bind4',OREC_.VOB );
                DBMS_SQL.BIND_VARIABLE( C, ':bind5',OREC_.ND );
                DBMS_SQL.BIND_VARIABLE( C, ':bind6',OREC_.DK );
                DBMS_SQL.BIND_VARIABLE( C, ':bind7',OREC_.S );
                DBMS_SQL.BIND_VARIABLE( C, ':bind8',OREC_.KV );
                DBMS_SQL.BIND_VARIABLE( C, ':bind9',OREC_.SQ );
                DBMS_SQL.BIND_VARIABLE( C, ':bind10',OREC_.SK );
                DBMS_SQL.BIND_VARIABLE( C, ':bind11',OREC_.S2 );
                DBMS_SQL.BIND_VARIABLE( C, ':bind12',OREC_.KV2 );
                DBMS_SQL.BIND_VARIABLE( C, ':bind13',OREC_.KVQ );
                DBMS_SQL.BIND_VARIABLE( C, ':bind15',OREC_.PDAT );
                DBMS_SQL.BIND_VARIABLE( C, ':bind16',OREC_.VDAT );
                DBMS_SQL.BIND_VARIABLE( C, ':bind17',OREC_.DATD );
                DBMS_SQL.BIND_VARIABLE( C, ':bind18',OREC_.DATP );
                DBMS_SQL.BIND_VARIABLE( C, ':bind19',OREC_.NAM_A );
                DBMS_SQL.BIND_VARIABLE( C, ':bind20',OREC_.NLSA );
                DBMS_SQL.BIND_VARIABLE( C, ':bind21',OREC_.MFOA );
                DBMS_SQL.BIND_VARIABLE( C, ':bind22',OREC_.NAM_B );
                DBMS_SQL.BIND_VARIABLE( C, ':bind23',OREC_.NLSB );
                DBMS_SQL.BIND_VARIABLE( C, ':bind24',OREC_.MFOB );
                DBMS_SQL.BIND_VARIABLE( C, ':bind25',OREC_.NAZN );
                DBMS_SQL.BIND_VARIABLE( C, ':bind26',OREC_.D_REC );
                DBMS_SQL.BIND_VARIABLE( C, ':bind27',OREC_.ID_A );
                DBMS_SQL.BIND_VARIABLE( C, ':bind28',OREC_.ID_B );
                DBMS_SQL.BIND_VARIABLE( C, ':bind29',OREC_.ID_O );
                DBMS_SQL.BIND_VARIABLE( C, ':bind30',OREC_.VP );
                DBMS_SQL.BIND_VARIABLE( C, ':bind31',OREC_.REFL );
                DBMS_SQL.BIND_VARIABLE( C, ':bind32',OREC_.PRTY );
                DBMS_SQL.BIND_VARIABLE( C, ':bind33',OREC_.REF_A );
                DBMS_SQL.BIND_VARIABLE( C, ':bind34',OREC_.USERID );
                DBMS_SQL.BIND_VARIABLE( C, ':retres',NRES );
                RET := DBMS_SQL.EXECUTE( C );
                DBMS_SQL.VARIABLE_VALUE( C, ':retres', NRES );
            ELSE
                NRES := 0;
            END IF;
        END IF;

        DBMS_SQL.CLOSE_CURSOR( C );
    END IF;

    RETURN NRES;
END;
/
 show err;
 
PROMPT *** Create  grants  DOC_VALID ***
grant EXECUTE                                                                on DOC_VALID       to ABS_ADMIN;
grant EXECUTE                                                                on DOC_VALID       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on DOC_VALID       to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/doc_valid.sql =========*** End *** 
 PROMPT ===================================================================================== 
 