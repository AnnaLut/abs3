begin
UMU.ADD_REFERENCE2ARM_BYTABNAME('VIP_MGR_USR_LST', '$RM_WRM', 2,1);
UMU.ADD_REFERENCE2ARM_BYTABNAME('VIP_NBS_GRP_LST', '$RM_WRM', 2,1);
end;

/
commit;

show err;

