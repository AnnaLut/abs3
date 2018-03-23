-- ======================================================================================
-- Module : GL
-- Author : BAA
-- Date   : 17.10.2016
-- ======================================================================================
-- create additional parameters (COBUSUPABS-4876)
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET ECHO         OFF
SET LINES        500
SET PAGES        500

begin
  Insert
    into BARS.OP_FIELD
       ( TAG, NAME, TYPE, USE_IN_ARCH )
  Values
       ( 'TRMNL', 'Код терміналу', 'C', 0 );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.OP_FIELD
       set NAME = 'Код терміналу'
         , TYPE = 'C'
         , USE_IN_ARCH = 0
     where TAG = 'TRMNL';
end;
/

COMMIT;
