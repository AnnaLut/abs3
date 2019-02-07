declare
  l_tmp number;
begin
  l_tmp := crypto_utl.create_keytype(p_name => 'Монетизація субсидій',
                            p_code => 'SUBSIDY');
  crypto_utl.create_key(p_key_value  => 'A99ABD080526524302684AF6418C4DB50E9BC6A31A80F046C0B04345259D655B',
                        p_start_date => trunc(sysdate),
                        p_end_date   => trunc(sysdate) + 365,
                        p_code       => 'SUBSIDY');
end;
/
