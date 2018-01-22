begin execute immediate ' drop TRIGGER BARS.TBI_VPLIST_SPOT '; exception when others then if SQLCODE = - 04080 then null; else raise; end if; ----ORA-04080: trigger does not exist      
end;
/
begin execute immediate ' drop TRIGGER BARS.TIU_VP '; exception when others then if SQLCODE = - 04080 then null; else raise; end if; ----ORA-04080: trigger does not exist      
end;
/
begin execute immediate ' drop TRIGGER BARS.TIU_VPR '; exception when others then if SQLCODE = - 04080 then null; else raise; end if; ----ORA-04080: trigger does not exist      
end;
/
