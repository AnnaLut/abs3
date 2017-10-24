exec tuda;
UPDATE dwh_log SET package_status = 'PARSED', package_error = 'According to COBUSUPABS-5470' WHERE package_status = 'DELIVERED';
COMMIT;