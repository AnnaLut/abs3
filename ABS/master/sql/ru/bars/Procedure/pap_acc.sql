CREATE OR REPLACE PROCEDURE BARS.PAP_ACC (p_acc  INT,p_pap INT)  IS

 begin
    update accounts set pap = p_pap where acc= p_acc;
    EXCEPTION WHEN NO_DATA_FOUND THEN  NULL;
 end ;
/
show error;

grant EXECUTE   on PAP_ACC          to BARS_ACCESS_DEFROLE;
grant EXECUTE   on PAP_ACC          to RCC_DEAL;
grant EXECUTE   on PAP_ACC          to START1;

