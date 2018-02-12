BEGIN 
        execute immediate  
          'begin  
               bpa.remove_policies( p_table_name => ''CUSTOMER_ADDRESS'');
               null;
           end; 
          '; 
END; 
/
BEGIN 
execute immediate 'alter trigger BARS.TAIUD_CUSTOMERADDRESS_UPDATE disable';
END; 
/
update CUSTOMER_ADDRESS t
set t.kf =  (select kf from regions where code = substr (t.rnk,-2,2))
where t.kf is null;

/
BEGIN 
execute immediate 'alter trigger BARS.TAIUD_CUSTOMERADDRESS_UPDATE ENABLE';
END; 
/

BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CUSTOMER_ADDRESS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CUSTOMER_ADDRESS'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''CUSTOMER_ADDRESS'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/


PROMPT *** ALTER_POLICIES to CUSTOMER_ADDRESS ***
 exec bpa.alter_policies('CUSTOMER_ADDRESS');