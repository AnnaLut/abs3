begin 
    update operlist
    set   funcname='/barsroot/barsweb/dynform.aspx?form=frm_zay_sal_add'||chr(38)||'edb_KV_new=840'||chr(38)||'edb_KB_new=0'||chr(38)||'edb_DK_new=0'
    where funcname='/barsroot/barsweb/dynform.aspx?form=frm_zay_sal_add';
 exception when others then 
    if sqlcode = -00001 then null; else raise; 
    end if; 
end;
/
commit;
/