update ow_keys ok
   set KEY_VALUE = '4087F8CCCB706D49B04282A81B8570F95B53FF7DE1F228ABB3E7B0C9D4D4BA82'
 where ok.type in (select kt.id from keytypes kt where kt.code = 'SUBSIDY');

commit;
