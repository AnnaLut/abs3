begin
   tuda;
    update ACCOUNTSW set value='FVTPL/Other' where value = 'FVTPL' and tag='IFRS';
    commit;
end;
/