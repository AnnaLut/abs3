begin
  Insert into BARS.DPU_NBS4CUST
    ( K013, NBS_DEP, IRVK )
  Values
    ( '1', '2525', '0' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.DPU_NBS4CUST
       set IRVK = '0'
     where K013 = '1'
       and NBS_DEP = '2525';
end;
/

begin
  Insert into BARS.DPU_NBS4CUST
    ( K013, NBS_DEP, IRVK )
  Values
    ( '1', '2546', '0' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.DPU_NBS4CUST
       set IRVK = '0'
     where K013 = '1'
       and NBS_DEP = '2541';
end;
/

begin
  Insert into BARS.DPU_NBS4CUST
    ( K013, NBS_DEP, IRVK )
  Values
    ( '1', '2546', '0' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.DPU_NBS4CUST
       set IRVK = '0'
     where K013 = '1'
       and NBS_DEP = '2546';
end;
/

begin
  Insert into BARS.DPU_NBS4CUST
    ( K013, NBS_DEP, IRVK )
  Values
    ( '2', '2650', '0' );
exception
  when DUP_VAL_ON_INDEX then
    update DPU_NBS4CUST
       set IRVK = '0'
     where K013 = '2'
       and NBS_DEP = '2650';
end;
/

begin
  Insert into DPU_NBS4CUST
    ( K013, NBS_DEP, IRVK )
  Values
    ( '2', '2651', '1' );
exception
  when DUP_VAL_ON_INDEX then
    update DPU_NBS4CUST
       set IRVK = '1'
     where K013 = '2'
       and NBS_DEP = '2651';
end;
/


begin
  Insert into BARS.DPU_NBS4CUST
    ( K013, NBS_DEP, IRVK )
  Values
    ( '3', '2600', '0' );
exception
  when DUP_VAL_ON_INDEX then
    update DPU_NBS4CUST
       set IRVK = '0'
     where K013 = '3'
       and NBS_DEP = '2600';
end;
/

begin
  Insert into BARS.DPU_NBS4CUST
    ( K013, NBS_DEP, IRVK )
  Values
    ( '3', '2610', '1');
exception
  when DUP_VAL_ON_INDEX then
    update DPU_NBS4CUST
       set IRVK = '1'
     where K013 = '3'
       and NBS_DEP = '2610';
end;
/

begin
  Insert into BARS.DPU_NBS4CUST
    ( K013, NBS_DEP, IRVK )
  Values
    ( '4', '2610', '1' );
exception
  when DUP_VAL_ON_INDEX then
    update DPU_NBS4CUST
       set IRVK = '1'
     where K013 = '4'
       and NBS_DEP = '2610';
end;
/

begin
  Insert into BARS.DPU_NBS4CUST
    ( K013, NBS_DEP, IRVK )
  Values
    ( '6', '2600', '0' );
exception
  when DUP_VAL_ON_INDEX then
    update DPU_NBS4CUST
       set IRVK = '0'
     where K013 = '6'
       and NBS_DEP = '2600';
end;
/

begin
  Insert into BARS.DPU_NBS4CUST
    ( K013, NBS_DEP, IRVK )
  Values
    ( '6', '2610', '1' );
exception
  when DUP_VAL_ON_INDEX then
    update DPU_NBS4CUST
       set IRVK = '1'
     where K013 = '6'
       and NBS_DEP = '2610';
end;
/

COMMIT;
