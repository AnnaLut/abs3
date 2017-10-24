
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_customer_address.sql =========***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_CUSTOMER_ADDRESS (p_rnk NUMBER, p_type NUMBER)
RETURN VARCHAR2
IS
 l_adrrow customer_address%rowtype;
 l_adr VARCHAR2(180);
BEGIN
  BEGIN
    SELECT * INTO l_adrrow 
      FROM customer_address
     WHERE rnk = p_rnk AND type_id = p_type;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
	  RETURN '';
  END;	  

  l_adr := l_adrrow.address;

  IF l_adrrow.locality IS NOT NULL THEN 
     l_adr := l_adrrow.locality||', '||l_adr;
  END IF;
  	 
  IF l_adrrow.region IS NOT NULL THEN 
     l_adr := l_adrrow.region||', '||l_adr;
  END IF;
  
  IF l_adrrow.domain IS NOT NULL THEN 
     l_adr := l_adrrow.domain||', '||l_adr;
  END IF;

  RETURN l_adr;

END;
/
 show err;
 
PROMPT *** Create  grants  F_CUSTOMER_ADDRESS ***
grant EXECUTE                                                                on F_CUSTOMER_ADDRESS to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_CUSTOMER_ADDRESS to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_customer_address.sql =========***
 PROMPT ===================================================================================== 
 