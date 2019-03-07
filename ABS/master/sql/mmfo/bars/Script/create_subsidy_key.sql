declare
  l_tmp number;
begin
  l_tmp := crypto_utl.create_keytype(p_name => 'Монетизація субсидій',
                            p_code => 'SUBSIDY');
  crypto_utl.create_key(p_key_value  => '4087F8CCCB706D49B04282A81B8570F95B53FF7DE1F228ABB3E7B0C9D4D4BA82',
                        p_start_date => trunc(sysdate),
                        p_end_date   => trunc(sysdate) + 365,
                        p_code       => 'SUBSIDY');
end;
/

update ow_keys ok
   set KEY_VALUE = '4087F8CCCB706D49B04282A81B8570F95B53FF7DE1F228ABB3E7B0C9D4D4BA82'
 where ok.type in (select kt.id from keytypes kt where kt.code = 'SUBSIDY');

commit;
