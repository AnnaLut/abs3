begin
 branch_attribute_utl.add_new_attribute( p_attr_code =>'STP_AUTO',
                            p_attr_desc =>'Ïëàòåæ³ ÑÅÏ ğîçáëîêîâóşòüñÿ ç ïàğàìåòğîì prty =1/0',
                            p_attr_datatype =>'N',
                            p_attr_format   => null,
                            p_attr_module   => null
						  );
/*
  for rec in(select * from mv_kf )              
    loop    
      branch_attribute_utl.set_attribute_value(p_branch_code     =>'/'||rec.kf||'/',
                             p_attribute_code  => 'STP_AUTO',
                             p_attribute_value => 0);
    end loop;*/
          branch_attribute_utl.set_attribute_value(p_branch_code     =>'/300465/',
                             p_attribute_code  => 'STP_AUTO',
                             p_attribute_value => 0);
  
end;
/
