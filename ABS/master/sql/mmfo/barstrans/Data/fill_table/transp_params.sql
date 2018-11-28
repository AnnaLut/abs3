
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSTRANS/Data/patch_data_TRANSP_PARAMS.sql =====
PROMPT ===================================================================================== 

declare
l_TRANSP_PARAMS  TRANSP_PARAMS%rowtype;

procedure p_merge(p_TRANSP_PARAMS TRANSP_PARAMS%rowtype) 
as
Begin
   insert into TRANSP_PARAMS
      values p_TRANSP_PARAMS; 
 exception when dup_val_on_index then  
   update TRANSP_PARAMS
      set row = p_TRANSP_PARAMS
    where PARAM_NAME = p_TRANSP_PARAMS.PARAM_NAME;
End;
Begin

l_TRANSP_PARAMS.PARAM_NAME :='PROXY_URI';
l_TRANSP_PARAMS.PARAM_VALUE :='https://****/barsroot/api/transp/ProxyV1';

 p_merge( l_TRANSP_PARAMS);


l_TRANSP_PARAMS.PARAM_NAME :='WALLET_PATH';
l_TRANSP_PARAMS.PARAM_VALUE :='';

 p_merge( l_TRANSP_PARAMS);


l_TRANSP_PARAMS.PARAM_NAME :='WALLET_PASS';
l_TRANSP_PARAMS.PARAM_VALUE :='';

 p_merge( l_TRANSP_PARAMS);


commit;
END;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSTRANS/Data/patch_data_TRANSP_PARAMS.sql =====
PROMPT ===================================================================================== 

