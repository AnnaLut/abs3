begin 
   execute immediate 'create index XIE_W4_ACC_dat_close on w4_acc(dat_close) tablespace brsmdld';
exception when others then
  if  sqlcode=-955 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/
    

begin 
   execute immediate 'create index XIE_bpk_ACC_dat_close on bpk_acc(dat_close) tablespace brsmdld';
exception when others then
  if  sqlcode=-955 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/
